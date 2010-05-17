From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 18 May 2010 01:39:47 +0200
Subject: [PATCH] RFC: PL08X DMA driver and signal muxing
Message-ID: <1274139588-12934-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a non-working code in progress. It does memcpy() back and
forth happily, it runs the dmaengine test client with several
competing threads and fires interrupts all the time. It requires
the previously posted PrimeCell DMA patches.

Slave mode does not work, I don't know why and need help in sorting
that out. It would be super for me to know how some other OS or
test code sets up DMAPSR, CCTRL and CCFG for device RX/TX requests.
I want to know if DMA has been verified to work with the PB11MPCore
before, the experiment with the PB1176JZF-S scared me a bit...
(That part is still in the patch, as you'll notice.)

I've been testing this on the RealView PB11MPcore so far.
Conceptually I cannot see any problem with this approach, other than
the hardcoded first-come-first-served policy for the physical DMA
channels, which people will be free to expand upon e.g. for channel
reservations.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Peter Pearse <peter.pearse@arm.com>
Cc: Colin Tuckley <colin.tuckley@arm.com>
Cc: Bahadir Balban <bahadir.balban@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-realview/core.c                      |  374 ++++-
 arch/arm/mach-realview/core.h                      |    2 +
 arch/arm/mach-realview/include/mach/board-pb1176.h |    1 +
 arch/arm/mach-realview/include/mach/platform.h     |    2 +
 arch/arm/mach-realview/realview_eb.c               |    2 +-
 arch/arm/mach-realview/realview_pb1176.c           |    7 +-
 arch/arm/mach-realview/realview_pb11mp.c           |   33 +-
 arch/arm/mach-realview/realview_pba8.c             |    2 +-
 arch/arm/mach-realview/realview_pbx.c              |    2 +-
 arch/arm/mach-versatile/core.c                     |  526 +++++-
 arch/arm/mach-versatile/include/mach/platform.h    |    6 +
 arch/arm/mach-versatile/versatile_pb.c             |   17 +-
 drivers/dma/Kconfig                                |    9 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/pl08x.c                                | 1992 ++++++++++++++++++++
 include/linux/amba/pl08x.h                         |  242 +++
 16 files changed, 3205 insertions(+), 13 deletions(-)
 create mode 100644 drivers/dma/pl08x.c
 create mode 100644 include/linux/amba/pl08x.h

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 595be19..81976ad 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -25,6 +25,8 @@
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/amba/pl08x.h>
+#include <linux/amba/serial.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 #include <linux/ata_platform.h>
@@ -232,6 +234,19 @@ static unsigned int realview_mmc_status(struct device *dev)
 	struct amba_device *adev = container_of(dev, struct amba_device, dev);
 	u32 mask;
 
+	if (machine_is_realview_pb1176()) {
+		bool inserted = false;
+
+		/*
+		 * The PB1176 does not have the status register,
+		 * assume it is inserted at startup, then invert
+		 * for each call, assuming the call is done whenever
+		 * the card status changes.
+		 */
+		inserted = !inserted;
+		return inserted ? 0 : 1;
+	}
+
 	if (adev->res.start == REALVIEW_MMCI0_BASE)
 		mask = 1;
 	else
@@ -242,9 +257,14 @@ static unsigned int realview_mmc_status(struct device *dev)
 
 struct mmci_platform_data realview_mmc0_plat_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.status		= realview_mmc_status,
+	.status		= realview_mmc_status, /* Not on the PB1176! */
 	.gpio_wp	= 17,
 	.gpio_cd	= 16,
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "mci0",
+	/* Don't specify a TX channel, this RX channel is bidirectional */
+#endif
 };
 
 struct mmci_platform_data realview_mmc1_plat_data = {
@@ -252,6 +272,11 @@ struct mmci_platform_data realview_mmc1_plat_data = {
 	.status		= realview_mmc_status,
 	.gpio_wp	= 19,
 	.gpio_cd	= 18,
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "mci1",
+	/* Don't specify a TX channel, this RX channel is bidirectional */
+#endif
 };
 
 /*
@@ -589,6 +614,352 @@ struct clcd_board clcd_plat_data = {
 	.remove		= realview_clcd_remove,
 };
 
+
+/*
+ * DMA config
+ */
+#ifdef CONFIG_AMBA_PL08X
+
+
+/* State of the big DMA mux */
+static u32 current_mux = 0x00;
+static u32 mux_users = 0x00;
+static spinlock_t current_mux_lock = SPIN_LOCK_UNLOCKED;
+
+static int pl081_get_signal(struct pl08x_dma_chan *ch)
+{
+	struct pl08x_channel_data *cd = ch->cd;
+	unsigned long flags;
+	u32 val;
+
+	printk(KERN_INFO "requesting DMA signal on channel %s\n", ch->name);
+
+	/* This one has statically assigned channels */
+	if (machine_is_realview_pb1176())
+		return cd->min_signal;
+
+	spin_lock_irqsave(&current_mux_lock, flags);
+	/*
+	 * We're on the same mux so fine, go ahead!
+	 */
+	if (cd->muxval == current_mux) {
+		mux_users ++;
+		spin_unlock_irqrestore(&current_mux_lock, flags);
+		/* We still have to write it since it's OFF  by default */
+		val = readl(__io_address(REALVIEW_SYS_DMAPSR));
+		val &= 0xFFFFFFC0U;
+		val |= current_mux;
+		val |= 0x80; /* That's how they do it on the Versatile */
+		writel(val, __io_address(REALVIEW_SYS_DMAPSR));
+		return cd->min_signal;
+	}
+	/*
+	 * If we're not on the same mux and there are already
+	 * users on the other mux setting, tough luck, the client
+	 * can come back and retry or give up and fall back to
+	 * PIO mode.
+	 */
+	if (mux_users) {
+		spin_unlock_irqrestore(&current_mux_lock, flags);
+		return -EBUSY;
+	}
+
+	/* Switch mux setting */
+	current_mux = cd->muxval;
+
+	val = readl(__io_address(REALVIEW_SYS_DMAPSR));
+	val &= 0xFFFFFFC0U;
+	val |= cd->muxval;
+	val |= 0x80; /* That's how they do it on the Versatile */
+	writel(val, __io_address(REALVIEW_SYS_DMAPSR));
+
+	printk(KERN_INFO "%s: muxing in %s in bank %d writing value "
+	       "%08x to register %08x\n",
+	       __func__, ch->name, cd->muxval,
+	       val, REALVIEW_SYS_DMAPSR);
+
+	spin_unlock_irqrestore(&current_mux_lock, flags);
+
+	return cd->min_signal;
+}
+
+static void pl081_put_signal(struct pl08x_dma_chan *ch)
+{
+	unsigned long flags;
+
+	printk(KERN_INFO "release DMA signal on channel %s\n", ch->name);
+
+	/* This one has statically assigned channels */
+	if (machine_is_realview_pb1176())
+		return 0;
+
+	spin_lock_irqsave(&current_mux_lock, flags);
+	mux_users--;
+	spin_unlock_irqrestore(&current_mux_lock, flags);
+}
+
+#define PRIMECELL_DEFAULT_CCTL (PL08X_CCTL_BSIZE_8 << 12 | \
+				PL08X_CCTL_BSIZE_8 << 15 | \
+				PL08X_CCTL_WIDTH_32 << 18 | \
+				PL08X_CCTL_WIDTH_32 << 21 | \
+				PL08X_CCTL_PROT_PRI << 28 | \
+				PL08X_CCTL_PROT_UNBUFF << 29 | \
+				PL08X_CCTL_PROT_NON_CACHE << 30)
+
+/* The PB1176 has static channel assignments */
+struct pl08x_channel_data pb1176_chan_data[] = {
+	/* Muxed on signal bank 0 */
+	[0] = {
+		.bus_id = "aacirx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[1] = {
+		.bus_id = "aacitx",
+		.min_signal = 1,
+		.max_signal = 1,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[2] = {
+		.bus_id = "mci0",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[3] = {
+		.bus_id = "uart4rx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[4] = {
+		.bus_id = "uart4tx",
+		.min_signal = 4,
+		.max_signal = 4,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[5] = {
+		.bus_id = "scirx",
+		.min_signal = 5,
+		.max_signal = 5,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[6] = {
+		.bus_id = "scitx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[7] = {
+		.bus_id = "usbdc",
+		.min_signal = 7,
+		.max_signal = 7,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[8] = {
+		.bus_id = "usbhc",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[9] = {
+		.bus_id = "pismo",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+};
+
+/* Muxed channels as found in most RealViews */
+struct pl08x_channel_data realview_chan_data[] = {
+	/* Muxed on signal bank 0 */
+	[0] = {
+		.bus_id = "usb0",
+		.min_signal = 0,
+		.max_signal = 0,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[1] = {
+		.bus_id = "usb1",
+		.min_signal = 1,
+		.max_signal = 1,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[2] = {
+		.bus_id = "t1dmac0",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[3] = {
+		.bus_id = "mci0",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[4] = {
+		.bus_id = "aacitx",
+		.min_signal = 4,
+		.max_signal = 4,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[5] = {
+		.bus_id = "aacirx",
+		.min_signal = 5,
+		.max_signal = 5,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[6] = {
+		.bus_id = "scirx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[7] = {
+		.bus_id = "scitx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	/* Muxed on signal bank 1 */
+	[8] = {
+		.bus_id = "ssprx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.muxval = 0x01,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[9] = {
+		.bus_id = "ssptx",
+		.min_signal = 1,
+		.max_signal = 1,
+		.muxval = 0x01,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[10] = {
+		.bus_id = "uart2rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 0x01,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[11] = {
+		.bus_id = "uart2tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 0x01,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[12] = {
+		.bus_id = "uart1rx",
+		.min_signal = 4,
+		.max_signal = 4,
+		.muxval = 0x01,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[13] = {
+		.bus_id = "uart1tx",
+		.min_signal = 5,
+		.max_signal = 5,
+		.muxval = 0x01,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[14] = {
+		.bus_id = "uart0rx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.muxval = 0x01,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[15] = {
+		.bus_id = "uart0tx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.muxval = 0x01,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+};
+
+struct pl08x_platform_data pl081_plat_data = {
+	.memcpy_channel = {
+		.bus_id = "memcpy",
+		/*
+		 * We pass in some optimal memcpy config, the
+		 * driver will augment it if need be. 256 byte
+		 * bursts and 32bit bus width.
+		 */
+		.cctl =
+		PL08X_CCTL_BSIZE_256 << 12 |
+		PL08X_CCTL_BSIZE_256 << 15 |
+		PL08X_CCTL_WIDTH_32 << 18 |
+		PL08X_CCTL_WIDTH_32 << 21 |
+		(PL08X_CCTL_PROT_CACHE | PL08X_CCTL_PROT_BUFF | PL08X_CCTL_PROT_PRI) << 28,
+		/* Flow control: DMAC controls this */
+		.ccfg = PL08X_CCFG_MEM2MEM_DMAC,
+	},
+	.get_signal = pl081_get_signal,
+	.put_signal = pl081_put_signal,
+	.bus_bit_lli = 0,
+};
+
+void __init pl081_fixup(void)
+{
+	if (machine_is_realview_pb1176()) {
+		pl081_plat_data.slave_channels = pb1176_chan_data;
+		pl081_plat_data.num_slave_channels = ARRAY_SIZE(pb1176_chan_data);
+	} else {
+		pl081_plat_data.slave_channels = realview_chan_data;
+		pl081_plat_data.num_slave_channels = ARRAY_SIZE(realview_chan_data);
+	}
+}
+
+#else
+struct pl08x_platform_data pl081_plat_data = {
+};
+
+void __init pl081_fixup(void)
+{
+}
+#endif
+
+
 #ifdef CONFIG_LEDS
 #define VA_LEDS_BASE (__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_LED_OFFSET)
 
@@ -685,4 +1056,5 @@ void realview_fixup(struct machine_desc *mdesc, struct tag *tags, char **from,
 	meminfo->bank[0].size = SZ_256M;
 	meminfo->nr_banks = 1;
 #endif
+	pl081_fixup();
 }
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 781bca6..af8427f 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -53,12 +53,14 @@ extern struct platform_device realview_i2c_device;
 extern struct mmci_platform_data realview_mmc0_plat_data;
 extern struct mmci_platform_data realview_mmc1_plat_data;
 extern struct clcd_board clcd_plat_data;
+extern struct pl08x_platform_data pl081_plat_data;
 extern void __iomem *gic_cpu_base_addr;
 extern void __iomem *timer0_va_base;
 extern void __iomem *timer1_va_base;
 extern void __iomem *timer2_va_base;
 extern void __iomem *timer3_va_base;
 
+extern void pl081_fixup(void);
 extern void realview_leds_event(led_event_t ledevt);
 extern void realview_timer_init(unsigned int timer_irq);
 extern int realview_flash_register(struct resource *res, u32 num);
diff --git a/arch/arm/mach-realview/include/mach/board-pb1176.h b/arch/arm/mach-realview/include/mach/board-pb1176.h
index 2f5ccb2..73f37b9 100644
--- a/arch/arm/mach-realview/include/mach/board-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/board-pb1176.h
@@ -26,6 +26,7 @@
 /*
  * Peripheral addresses
  */
+#define REALVIEW_PB1176_DMAC_BASE		0x10030000 /* DMAC */
 #define REALVIEW_PB1176_SCTL_BASE		0x10100000 /* System controller */
 #define REALVIEW_PB1176_SMC_BASE		0x10111000 /* SMC */
 #define REALVIEW_PB1176_DMC_BASE		0x10109000 /* DMC configuration */
diff --git a/arch/arm/mach-realview/include/mach/platform.h b/arch/arm/mach-realview/include/mach/platform.h
index 1b77a27..934c5c2 100644
--- a/arch/arm/mach-realview/include/mach/platform.h
+++ b/arch/arm/mach-realview/include/mach/platform.h
@@ -77,6 +77,7 @@
 #define REALVIEW_SYS_BOOTCS_OFFSET           0x58
 #define REALVIEW_SYS_24MHz_OFFSET            0x5C
 #define REALVIEW_SYS_MISC_OFFSET             0x60
+#define REALVIEW_SYS_DMAPSR_OFFSET           0x64
 #define REALVIEW_SYS_IOSEL_OFFSET            0x70
 #define REALVIEW_SYS_PROCID_OFFSET           0x84
 #define REALVIEW_SYS_TEST_OSC0_OFFSET        0xC0
@@ -111,6 +112,7 @@
 #define REALVIEW_SYS_BOOTCS                  (REALVIEW_SYS_BASE + REALVIEW_SYS_BOOTCS_OFFSET)
 #define REALVIEW_SYS_24MHz                   (REALVIEW_SYS_BASE + REALVIEW_SYS_24MHz_OFFSET)
 #define REALVIEW_SYS_MISC                    (REALVIEW_SYS_BASE + REALVIEW_SYS_MISC_OFFSET)
+#define REALVIEW_SYS_DMAPSR                  (REALVIEW_SYS_BASE + REALVIEW_SYS_DMAPSR_OFFSET)
 #define REALVIEW_SYS_IOSEL                   (REALVIEW_SYS_BASE + REALVIEW_SYS_IOSEL_OFFSET)
 #define REALVIEW_SYS_PROCID                  (REALVIEW_SYS_BASE + REALVIEW_SYS_PROCID_OFFSET)
 #define REALVIEW_SYS_TEST_OSC0               (REALVIEW_SYS_BASE + REALVIEW_SYS_TEST_OSC0_OFFSET)
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 422ccd7..87d43cb 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -201,7 +201,7 @@ AMBA_DEVICE(uart3, "fpga:uart3", EB_UART3, NULL);
 /* DevChip Primecells */
 AMBA_DEVICE(smc,   "dev:smc",   EB_SMC,   NULL);
 AMBA_DEVICE(clcd,  "dev:clcd",  EB_CLCD,  &clcd_plat_data);
-AMBA_DEVICE(dmac,  "dev:dmac",  DMAC,     NULL);
+AMBA_DEVICE(dmac,  "dev:dmac",  DMAC,     &pl081_plat_data);
 AMBA_DEVICE(sctl,  "dev:sctl",  SCTL,     NULL);
 AMBA_DEVICE(wdog,  "dev:wdog",  EB_WATCHDOG, NULL);
 AMBA_DEVICE(gpio0, "dev:gpio0", EB_GPIO0, &gpio0_plat_data);
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 96568eb..d190f1e 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -143,7 +143,7 @@ static struct pl061_platform_data gpio2_plat_data = {
 #define MPMC_DMA	{ 0, 0 }
 #define PB1176_CLCD_IRQ	{ IRQ_DC1176_CLCD, NO_IRQ }
 #define PB1176_CLCD_DMA	{ 0, 0 }
-#define DMAC_IRQ	{ IRQ_PB1176_DMAC, NO_IRQ }
+#define PB1176_DMAC_IRQ	{ IRQ_PB1176_DMAC, NO_IRQ }
 #define DMAC_DMA	{ 0, 0 }
 #define SCTL_IRQ	{ NO_IRQ, NO_IRQ }
 #define SCTL_DMA	{ 0, 0 }
@@ -191,10 +191,10 @@ AMBA_DEVICE(ssp0,	"dev:ssp0",	PB1176_SSP,	NULL);
 
 /* Primecells on the NEC ISSP chip */
 AMBA_DEVICE(clcd,	"issp:clcd",	PB1176_CLCD,	&clcd_plat_data);
-//AMBA_DEVICE(dmac,	"issp:dmac",	PB1176_DMAC,	NULL);
+AMBA_DEVICE(dmac,	"issp:dmac",	PB1176_DMAC,	&pl081_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
-//	&dmac_device,
+	&dmac_device,
 	&uart0_device,
 	&uart1_device,
 	&uart2_device,
@@ -320,6 +320,7 @@ static void realview_pb1176_fixup(struct machine_desc *mdesc,
 	meminfo->bank[0].start = 0;
 	meminfo->bank[0].size = SZ_128M;
 	meminfo->nr_banks = 1;
+	pl081_fixup();
 }
 
 static void __init realview_pb1176_init(void)
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 7fbefbb..813026a 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -25,6 +25,8 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/serial.h>
+#include <linux/amba/pl08x.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -123,6 +125,30 @@ static struct pl061_platform_data gpio2_plat_data = {
 	.irq_base	= -1,
 };
 
+static struct amba_pl011_data uart0_plat_data = {
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "uart0rx",
+	.dma_tx_param = (void *) "uart0tx",
+#endif
+};
+
+static struct amba_pl011_data uart1_plat_data = {
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "uart1rx",
+	.dma_tx_param = (void *) "uart1tx",
+#endif
+};
+
+static struct amba_pl011_data uart2_plat_data = {
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "uart2rx",
+	.dma_tx_param = (void *) "uart2tx",
+#endif
+};
+
 /*
  * RealView PB11MPCore AMBA devices
  */
@@ -189,11 +215,16 @@ AMBA_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
 AMBA_DEVICE(uart0,	"dev:uart0",	PB11MP_UART0,	NULL);
 AMBA_DEVICE(uart1,	"dev:uart1",	PB11MP_UART1,	NULL);
 AMBA_DEVICE(uart2,	"dev:uart2",	PB11MP_UART2,	NULL);
+#if 0
+AMBA_DEVICE(uart0,	"dev:uart0",	PB11MP_UART0,	&uart0_plat_data);
+AMBA_DEVICE(uart1,	"dev:uart1",	PB11MP_UART1,	&uart1_plat_data);
+AMBA_DEVICE(uart2,	"dev:uart2",	PB11MP_UART2,	&uart2_plat_data);
+#endif
 AMBA_DEVICE(ssp0,	"dev:ssp0",	PB11MP_SSP,	NULL);
 
 /* Primecells on the NEC ISSP chip */
 AMBA_DEVICE(clcd,	"issp:clcd",	PB11MP_CLCD,	&clcd_plat_data);
-AMBA_DEVICE(dmac,	"issp:dmac",	DMAC,		NULL);
+AMBA_DEVICE(dmac,	"issp:dmac",	DMAC,		&pl081_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index d3c113b..366969f 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -183,7 +183,7 @@ AMBA_DEVICE(ssp0,	"dev:ssp0",	PBA8_SSP,	NULL);
 
 /* Primecells on the NEC ISSP chip */
 AMBA_DEVICE(clcd,	"issp:clcd",	PBA8_CLCD,	&clcd_plat_data);
-AMBA_DEVICE(dmac,	"issp:dmac",	DMAC,		NULL);
+AMBA_DEVICE(dmac,	"issp:dmac",	DMAC,		&pl081_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index a235ba3..ca16948 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -205,7 +205,7 @@ AMBA_DEVICE(ssp0,	"dev:ssp0",	PBX_SSP,	NULL);
 
 /* Primecells on the NEC ISSP chip */
 AMBA_DEVICE(clcd,	"issp:clcd",	PBX_CLCD,	&clcd_plat_data);
-AMBA_DEVICE(dmac,	"issp:dmac",	DMAC,		NULL);
+AMBA_DEVICE(dmac,	"issp:dmac",	DMAC,		&pl081_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 3dff864..3ce5227 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -28,6 +28,8 @@
 #include <linux/amba/clcd.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/serial.h>
+#include <linux/amba/pl08x.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
 
@@ -352,6 +354,11 @@ static struct mmci_platform_data mmc0_plat_data = {
 	.status		= mmc_status,
 	.gpio_wp	= -1,
 	.gpio_cd	= -1,
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "mci0",
+	/* Don't specify a TX channel, this RX channel is bidirectional */
+#endif
 };
 
 /*
@@ -693,6 +700,492 @@ static struct clcd_board clcd_plat_data = {
 	.remove		= versatile_clcd_remove,
 };
 
+/*
+ * DMA config
+ * The DMA channel routing is static on the PA926EJ-S
+ * and dynamic on the PB926EJ-S using SYS_DMAPSR0..SYS_DMAPSR2
+ */
+#ifdef CONFIG_AMBA_PL08X
+
+struct pb926ejs_dma_signal {
+	unsigned int id;
+	struct pl08x_dma_chan *user;
+	u32 ctrlreg;
+};
+
+/*
+ * The three first channels on ARM926EJ-S are muxed,
+ * but to make things simple we enable all channels
+ * to be muxed, however most of the channels will just
+ * me muxed on top of themselves.
+ */
+static struct pb926ejs_dma_signal pl080_muxtab[] = {
+	[0] = {
+		.id = 0,
+		.ctrlreg = VERSATILE_SYS_DMAPSR0,
+	},
+	[1] = {
+		.id = 1,
+		.ctrlreg = VERSATILE_SYS_DMAPSR1,
+	},
+	[2] = {
+		.id = 2,
+		.ctrlreg = VERSATILE_SYS_DMAPSR2,
+	},
+	[3] = {
+		.id = 3,
+	},
+	[4] = {
+		.id = 4,
+	},
+	[5] = {
+		.id = 5,
+	},
+	[6] = {
+		.id = 6,
+	},
+	[7] = {
+		.id = 7,
+	},
+	[8] = {
+		.id = 8,
+	},
+	[9] = {
+		.id = 9,
+	},
+	[10] = {
+		.id = 10,
+	},
+	[11] = {
+		.id = 11,
+	},
+	[12] = {
+		.id = 12,
+	},
+	[13] = {
+		.id = 13,
+	},
+	[14] = {
+		.id = 14,
+	},
+	[15] = {
+		.id = 15,
+	},
+};
+
+/* This is a lock for the above muxing array */
+static spinlock_t muxlock = SPIN_LOCK_UNLOCKED;
+
+static int pl080_get_signal(struct pl08x_dma_chan *ch)
+{
+	struct pl08x_channel_data *cd = ch->cd;
+
+	printk(KERN_INFO "requesting DMA signal on channel %s\n", ch->name);
+
+	/*
+	 * The AB926EJ-S is simple - only static assignments
+	 * so the channel is already muxed in and ready to go.
+	 */
+	if (machine_is_versatile_ab())
+		return cd->min_signal;
+
+	/* The PB926EJ-S is hairier */
+	if (machine_is_versatile_pb()) {
+		unsigned long flags;
+		int i;
+
+		if (cd->min_signal > ARRAY_SIZE(pl080_muxtab) ||
+		    cd->max_signal > ARRAY_SIZE(pl080_muxtab) ||
+		    (cd->max_signal < cd->min_signal)) {
+			printk(KERN_ERR "%s: illegal muxing constraints for %s\n",
+			       __func__, ch->name);
+			return -EINVAL;
+		}
+		/* Try to find a signal to use */
+		spin_lock_irqsave(&muxlock, flags);
+		for (i = cd->min_signal; i <= cd->max_signal; i++) {
+			if (!pl080_muxtab[i].user) {
+				u32 val;
+
+				pl080_muxtab[i].user = ch;
+				/* If the channels need to be muxed in, mux them! */
+				if (pl080_muxtab[i].ctrlreg) {
+					val = readl(__io_address(pl080_muxtab[i].ctrlreg));
+					val &= 0xFFFFFF70U;
+					val |= 0x80; /* Turn on muxing */
+					val |= cd->muxval; /* Mux in the right peripheral */
+					writel(val, __io_address(pl080_muxtab[i].ctrlreg));
+					printk(KERN_INFO "%s: muxing in %s at channel %d writing value "
+					       "%08x to register %08x\n",
+					       __func__, ch->name, i,
+					       val, pl080_muxtab[i].ctrlreg);
+				}
+				spin_unlock_irqrestore(&muxlock, flags);
+				return pl080_muxtab[i].id;
+			}
+		}
+		spin_unlock_irqrestore(&muxlock, flags);
+	}
+
+	return -EBUSY;
+}
+
+static void pl080_put_signal(struct pl08x_dma_chan *ch)
+{
+	struct pl08x_channel_data *cd = ch->cd;
+	unsigned long flags;
+	int i;
+
+	printk(KERN_INFO "releasing DMA signal on channel %s\n", ch->name);
+	if (cd->min_signal > ARRAY_SIZE(pl080_muxtab) ||
+	    cd->max_signal > ARRAY_SIZE(pl080_muxtab) ||
+	    (cd->max_signal < cd->min_signal)) {
+		printk(KERN_INFO "%s: illegal muxing constraints for %s\n",
+		       __func__, ch->name);
+		return;
+	}
+	spin_lock_irqsave(&muxlock, flags);
+	for (i = cd->min_signal; i <= cd->max_signal; i++) {
+		if (pl080_muxtab[i].user == ch) {
+			pl080_muxtab[i].user = NULL;
+			if (pl080_muxtab[i].ctrlreg) {
+				u32 val;
+
+				val = readl(__io_address(pl080_muxtab[i].ctrlreg));
+				val &= 0xFFFFFF70U; /* Disable, select no channel */
+				writel(val, __io_address(pl080_muxtab[i].ctrlreg));
+				printk(KERN_INFO "%s: muxing out %s at channel %d writing value "
+				       "%08x to register %08x\n",
+				       __func__, ch->name, i,
+				       val, pl080_muxtab[i].ctrlreg);
+			}
+			spin_unlock_irqrestore(&muxlock, flags);
+			return;
+		}
+	}
+	spin_unlock_irqrestore(&muxlock, flags);
+	printk(KERN_INFO "%s: unable to release muxing on channel %s\n",
+	       __func__, ch->name);
+}
+
+struct pl08x_platform_data pl080_plat_data = {
+	.memcpy_channel = {
+		.bus_id = "memcpy",
+		/*
+		 * We pass in some optimal memcpy config, the
+		 * driver will augment it if need be. 256 byte
+		 * bursts and 32bit bus width.
+		 */
+		.cctl =
+		PL08X_CCTL_BSIZE_256 << 12 |
+		PL08X_CCTL_BSIZE_256 << 15 |
+		PL08X_CCTL_WIDTH_32 << 18 |
+		PL08X_CCTL_WIDTH_32 << 21 |
+		PL08X_CCTL_PROT_PRI << 28 |
+		PL08X_CCTL_PROT_UNBUFF << 29 |
+		PL08X_CCTL_PROT_NON_CACHE << 30,
+		/* Flow control: DMAC controls this */
+		.ccfg = PL08X_CCFG_MEM2MEM_DMAC,
+	},
+	.get_signal = pl080_get_signal,
+	.put_signal = pl080_put_signal,
+	.bus_bit_lli = 0,
+};
+
+#define PRIMECELL_DEFAULT_CCTL (PL08X_CCTL_BSIZE_8 << 12 | \
+				PL08X_CCTL_BSIZE_8 << 15 | \
+				PL08X_CCTL_WIDTH_32 << 18 | \
+				PL08X_CCTL_WIDTH_32 << 21 | \
+				PL08X_CCTL_PROT_PRI << 28 | \
+				PL08X_CCTL_PROT_UNBUFF << 29 | \
+				PL08X_CCTL_PROT_NON_CACHE << 30)
+
+static struct pl08x_channel_data ab926ejs_chan_data[] = {
+	[0] = {
+		.bus_id = "aacirx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[1] = {
+		.bus_id = "aacitx",
+		.min_signal = 1,
+		.max_signal = 1,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[2] = {
+		.bus_id = "mci0",
+		.min_signal = 2,
+		.max_signal = 2,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[3] = {
+		.bus_id = "reserved",
+		.min_signal = 3,
+		.max_signal = 3,
+	},
+	[4] = {
+		.bus_id = "reserved",
+		.min_signal = 4,
+		.max_signal = 4,
+	},
+	[5] = {
+		.bus_id = "reserved",
+		.min_signal = 5,
+		.max_signal = 5,
+	},
+	[6] = {
+		.bus_id = "scirx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[7] = {
+		.bus_id = "scitx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[8] = {
+		.bus_id = "ssprx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[9] = {
+		.bus_id = "ssptx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[10] = {
+		.bus_id = "uart2rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[11] = {
+		.bus_id = "uart2tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[12] = {
+		.bus_id = "uart1rx",
+		.min_signal = 12,
+		.max_signal = 12,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[13] = {
+		.bus_id = "uart1tx",
+		.min_signal = 13,
+		.max_signal = 13,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[14] = {
+		.bus_id = "uart0rx",
+		.min_signal = 14,
+		.max_signal = 14,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[15] = {
+		.bus_id = "uart0tx",
+		.min_signal = 15,
+		.max_signal = 15,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+};
+
+/* For the PB926EJ-S we define some extra virtual channels */
+static struct pl08x_channel_data pb926ejs_chan_data[] = {
+	[0] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "aacitx",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x00,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[1] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "aacirx",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x01,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[2] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "usba",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x02,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[3] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "usbb",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x03,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[4] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "mci0",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x04,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[5] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "mci1",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x05,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[6] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "uart3tx",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x06,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[7] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "uart3rx",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x07,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[8] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "sciinta",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x08,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[9] = {
+		/* Muxed on channel 0-3 */
+		.bus_id = "sciintb",
+		.min_signal = 0,
+		.max_signal = 2,
+		.muxval = 0x09,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+	},
+	[10] = {
+		.bus_id = "scirx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[11] = {
+		.bus_id = "scitx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[12] = {
+		.bus_id = "ssprx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[13] = {
+		.bus_id = "ssptx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[14] = {
+		.bus_id = "uart2rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[15] = {
+		.bus_id = "uart2tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[16] = {
+		.bus_id = "uart1rx",
+		.min_signal = 12,
+		.max_signal = 12,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[17] = {
+		.bus_id = "uart1tx",
+		.min_signal = 13,
+		.max_signal = 13,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+	[18] = {
+		.bus_id = "uart0rx",
+		.min_signal = 14,
+		.max_signal = 14,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_PER2MEM_DMAC,
+	},
+	[19] = {
+		.bus_id = "uart0tx",
+		.min_signal = 15,
+		.max_signal = 15,
+		.cctl = PRIMECELL_DEFAULT_CCTL,
+		.ccfg = PL08X_CCFG_MEM2PER_DMAC,
+	},
+};
+
+static void __init pl080_fixup(void)
+{
+	if (machine_is_versatile_ab()) {
+		pl080_plat_data.slave_channels = ab926ejs_chan_data;
+		pl080_plat_data.num_slave_channels = ARRAY_SIZE(ab926ejs_chan_data);
+	}
+	if (machine_is_versatile_pb()) {
+		pl080_plat_data.slave_channels = pb926ejs_chan_data;
+		pl080_plat_data.num_slave_channels = ARRAY_SIZE(pb926ejs_chan_data);
+	}
+}
+#else
+static struct pl08x_platform_data pl080_plat_data = {
+};
+
+static void __init pl080_fixup(void)
+{
+}
+#endif
+
 static struct pl061_platform_data gpio0_plat_data = {
 	.gpio_base	= 0,
 	.irq_base	= IRQ_GPIO0_START,
@@ -703,6 +1196,30 @@ static struct pl061_platform_data gpio1_plat_data = {
 	.irq_base	= IRQ_GPIO1_START,
 };
 
+static struct amba_pl011_data uart0_plat_data = {
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "uart0rx",
+	.dma_tx_param = (void *) "uart0tx",
+#endif
+};
+
+static struct amba_pl011_data uart1_plat_data = {
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "uart1rx",
+	.dma_tx_param = (void *) "uart1tx",
+#endif
+};
+
+static struct amba_pl011_data uart2_plat_data = {
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "uart2rx",
+	.dma_tx_param = (void *) "uart2tx",
+#endif
+};
+
 #define AACI_IRQ	{ IRQ_AACI, NO_IRQ }
 #define AACI_DMA	{ 0x80, 0x81 }
 #define MMCI0_IRQ	{ IRQ_MMCI0A,IRQ_SIC_MMCI0B }
@@ -762,16 +1279,16 @@ AMBA_DEVICE(kmi1,  "fpga:07", KMI1,     NULL);
 AMBA_DEVICE(smc,   "dev:00",  SMC,      NULL);
 AMBA_DEVICE(mpmc,  "dev:10",  MPMC,     NULL);
 AMBA_DEVICE(clcd,  "dev:20",  CLCD,     &clcd_plat_data);
-AMBA_DEVICE(dmac,  "dev:30",  DMAC,     NULL);
+AMBA_DEVICE(dmac,  "dev:30",  DMAC,     &pl080_plat_data);
 AMBA_DEVICE(sctl,  "dev:e0",  SCTL,     NULL);
 AMBA_DEVICE(wdog,  "dev:e1",  WATCHDOG, NULL);
 AMBA_DEVICE(gpio0, "dev:e4",  GPIO0,    &gpio0_plat_data);
 AMBA_DEVICE(gpio1, "dev:e5",  GPIO1,    &gpio1_plat_data);
 AMBA_DEVICE(rtc,   "dev:e8",  RTC,      NULL);
 AMBA_DEVICE(sci0,  "dev:f0",  SCI,      NULL);
-AMBA_DEVICE(uart0, "dev:f1",  UART0,    NULL);
-AMBA_DEVICE(uart1, "dev:f2",  UART1,    NULL);
-AMBA_DEVICE(uart2, "dev:f3",  UART2,    NULL);
+AMBA_DEVICE(uart0, "dev:f1",  UART0,    &uart0_plat_data);
+AMBA_DEVICE(uart1, "dev:f2",  UART1,    &uart1_plat_data);
+AMBA_DEVICE(uart2, "dev:f3",  UART2,    &uart2_plat_data);
 AMBA_DEVICE(ssp0,  "dev:f4",  SSP,      NULL);
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -843,6 +1360,7 @@ void __init versatile_init(void)
 	platform_device_register(&versatile_flash_device);
 	platform_device_register(&versatile_i2c_device);
 	platform_device_register(&smc91x_device);
+	pl080_fixup();
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-versatile/include/mach/platform.h b/arch/arm/mach-versatile/include/mach/platform.h
index ec08740..fa0907c 100644
--- a/arch/arm/mach-versatile/include/mach/platform.h
+++ b/arch/arm/mach-versatile/include/mach/platform.h
@@ -86,6 +86,9 @@
 #define VERSATILE_SYS_BOOTCS_OFFSET           0x58
 #define VERSATILE_SYS_24MHz_OFFSET            0x5C
 #define VERSATILE_SYS_MISC_OFFSET             0x60
+#define VERSATILE_SYS_DMAPSR0_OFFSET          0x64 /* Only on PB926EJ-S */
+#define VERSATILE_SYS_DMAPSR1_OFFSET          0x68 /* Only on PB926EJ-S */
+#define VERSATILE_SYS_DMAPSR2_OFFSET          0x6C /* Only on PB926EJ-S */
 #define VERSATILE_SYS_TEST_OSC0_OFFSET        0x80
 #define VERSATILE_SYS_TEST_OSC1_OFFSET        0x84
 #define VERSATILE_SYS_TEST_OSC2_OFFSET        0x88
@@ -124,6 +127,9 @@
 #define VERSATILE_SYS_BOOTCS                  (VERSATILE_SYS_BASE + VERSATILE_SYS_BOOTCS_OFFSET)
 #define VERSATILE_SYS_24MHz                   (VERSATILE_SYS_BASE + VERSATILE_SYS_24MHz_OFFSET)
 #define VERSATILE_SYS_MISC                    (VERSATILE_SYS_BASE + VERSATILE_SYS_MISC_OFFSET)
+#define VERSATILE_SYS_DMAPSR0                 (VERSATILE_SYS_BASE + VERSATILE_SYS_DMAPSR0_OFFSET) /* Only on PB926EJ-S */
+#define VERSATILE_SYS_DMAPSR1                 (VERSATILE_SYS_BASE + VERSATILE_SYS_DMAPSR1_OFFSET) /* Only on PB926EJ-S */
+#define VERSATILE_SYS_DMAPSR2                 (VERSATILE_SYS_BASE + VERSATILE_SYS_DMAPSR2_OFFSET) /* Only on PB926EJ-S */
 #define VERSATILE_SYS_TEST_OSC0               (VERSATILE_SYS_BASE + VERSATILE_SYS_TEST_OSC0_OFFSET)
 #define VERSATILE_SYS_TEST_OSC1               (VERSATILE_SYS_BASE + VERSATILE_SYS_TEST_OSC1_OFFSET)
 #define VERSATILE_SYS_TEST_OSC2               (VERSATILE_SYS_BASE + VERSATILE_SYS_TEST_OSC2_OFFSET)
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 239cd30..ecb6bf6 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -25,6 +25,8 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/serial.h>
+#include <linux/amba/pl08x.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -46,6 +48,11 @@ static struct mmci_platform_data mmc1_plat_data = {
 	.status		= mmc_status,
 	.gpio_wp	= -1,
 	.gpio_cd	= -1,
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "mci1",
+	/* Don't specify a TX channel, this RX channel is bidirectional */
+#endif
 };
 
 static struct pl061_platform_data gpio2_plat_data = {
@@ -58,6 +65,14 @@ static struct pl061_platform_data gpio3_plat_data = {
 	.irq_base	= IRQ_GPIO3_START,
 };
 
+static struct amba_pl011_data uart3_plat_data = {
+#ifdef CONFIG_AMBA_PL08X
+	.dma_filter = pl08x_filter_id,
+	.dma_rx_param = (void *) "uart3rx",
+	.dma_tx_param = (void *) "uart3tx",
+#endif
+};
+
 #define UART3_IRQ	{ IRQ_SIC_UART3, NO_IRQ }
 #define UART3_DMA	{ 0x86, 0x87 }
 #define SCI1_IRQ	{ IRQ_SIC_SCI3, NO_IRQ }
@@ -78,7 +93,7 @@ static struct pl061_platform_data gpio3_plat_data = {
  */
 
 /* FPGA Primecells */
-AMBA_DEVICE(uart3, "fpga:09", UART3,    NULL);
+AMBA_DEVICE(uart3, "fpga:09", UART3,    &uart3_plat_data);
 AMBA_DEVICE(sci1,  "fpga:0a", SCI1,     NULL);
 AMBA_DEVICE(mmc1,  "fpga:0b", MMCI1,    &mmc1_plat_data);
 
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index dab6f17..8bc203a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -36,6 +36,15 @@ comment "DMA Devices"
 config ASYNC_TX_DISABLE_CHANNEL_SWITCH
 	bool
 
+config AMBA_PL08X
+	bool "ARM PrimeCell PL080 or PL81 support"
+	depends on ARM_AMBA && EXPERIMENTAL
+	default y if ARCH_REALVIEW
+	select DMA_ENGINE
+	help
+	  Platform has a PL08x DMAC device
+	  which can provide DMA engine support
+
 config INTEL_IOATDMA
 	tristate "Intel I/OAT DMA support"
 	depends on PCI && X86
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 2088142..10cc25a 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
 obj-$(CONFIG_TIMB_DMA) += timb_dma.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
+obj-$(CONFIG_AMBA_PL08X) += pl08x.o
diff --git a/drivers/dma/pl08x.c b/drivers/dma/pl08x.c
new file mode 100644
index 0000000..880729e
--- /dev/null
+++ b/drivers/dma/pl08x.c
@@ -0,0 +1,1992 @@
+/* Copyright(c) 2006 ARM Ltd.
+ * Copyright (C) 2010 ST-Ericsson SA
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is iin this distribution in the
+ * file called COPYING.
+ *
+ * Documentation: ARM DDI 0196G == PL080
+ * Documentation: ARM DDI 0218E	== PL081
+ *
+ */
+/*
+ * The AMBA DMA API is modelled on the ISA DMA API and performs
+ * single asynchronous transfers between a device and memory
+ * i.e. some platform fixed device address and a driver defined memory address
+ *
+ * Memory to peripheral transfer may be visualized as
+ *	Get data from memory to DMAC
+ *	Until no data left
+ *		On burst request from peripheral
+ *			Destination burst from DMAC to peripheral
+ *			Clear burst request
+ *	Raise terminal count interrupt
+ *
+ * For peripherals with a FIFO:
+ * Source      burst size == half the depth of the peripheral FIFO
+ * Destination burst size == width of the peripheral FIFO
+ *
+ * (Bursts are irrelevant for mem to mem transfers - there are no burst signals)
+ *
+ * ASSUMES only one DMAC device exists in the system
+ * ASSUMES default (little) endianness for DMA transfers
+ *
+ * Only DMAC flow control is implemented
+ */
+
+/*
+ * Global TODO:
+ * - Use register definitions from
+ * arch/arm/include/asm/hardware/pl080.h
+ * - Break out common code from arch/arm/mach-s3c64xx and share
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/dmapool.h>
+#include <linux/amba/bus.h>
+#include <linux/dmaengine.h>
+#include <linux/amba/pl08x.h>
+#include <linux/amba/dma.h>
+
+#include <asm/dma.h>
+#include <asm/mach/dma.h>
+#include <asm/atomic.h>
+#include <asm/processor.h>
+#include <asm/cacheflush.h>
+
+
+#define DRIVER_NAME	"pl08xdmac"
+
+/**
+ * struct vendor_data - vendor-specific config parameters
+ * for PL08x derivates
+ * @name: the name of this specific variant
+ * @channels: the number of channels available in this variant
+ */
+struct vendor_data {
+	char *name;
+	u8 channels;
+};
+
+/*
+ * PL08X private data structures  ==== START
+ * This struct maps 1-1 to the bits in the Channel Control Register
+ * FIXME: can we change unsigned int:s for u32 here?
+ */
+struct _cctl_data{
+	unsigned int tsize:12;
+	unsigned int sbsize:3;
+	unsigned int dbsize:3;
+	unsigned int swidth:3;
+	unsigned int dwidth:3;
+	unsigned int smaster:1;
+	unsigned int dmaster:1;
+	unsigned int si:1;
+	unsigned int di:1;
+	unsigned int prot:3;
+	unsigned int intr:1;
+};
+
+union _cctl{
+	struct _cctl_data bits;
+	unsigned int val;
+};
+
+/*
+ * An LLI struct - see pl08x TRM
+ * Note that next uses bit[0] as a bus bit,
+ * start & end do not - their bus bit info
+ * is in cctl
+ */
+struct _lli{
+	dma_addr_t src;
+	dma_addr_t dst;
+	dma_addr_t next;
+	union _cctl cctl;
+};
+
+struct _chan_lli {
+	dma_addr_t bus_list;
+	void *va_list;
+};
+
+/**
+ * struct pl08x_driver_data - the local state holder for the PL08x
+ * @base: virtual memory base (remapped) for the PL08x
+ * @adev: the corresponding AMBA (PrimeCell) bus entry
+ * @vd: vendor data for this PL08x variant
+ * @pd: platform data passed in from the platform/machine
+ * @phy_chans: array of data for the physical channels
+ * @phy_chan_lock: a lock for the physical channel array
+ * @pool: a pool for the LLI descriptors
+ * @pool_ctr: counter of LLIs in the pool
+ * @max_num_llis: maximum number of LLIs, i.e. longest linked transfer
+ * length, submitted so far
+ * @chanllis: the LLIs for each virtual channel
+ * @lock: a spinlock for this struct
+ */
+struct pl08x_driver_data {
+	void __iomem *base;
+	struct amba_device *adev;
+	struct vendor_data *vd;
+	struct pl08x_platform_data *pd;
+	struct pl08x_phy_chan *phy_chans;
+	spinlock_t phy_chan_lock;
+	struct dma_pool *pool;
+	int pool_ctr;
+	int max_num_llis;
+	struct _chan_lli *chanllis;
+	spinlock_t lock;
+};
+
+#ifdef MODULE
+
+# error "AMBA PL08X DMA CANNOT BE COMPILED AS A LOADABLE MODULE AT PRESENT"
+
+/*
+	a) Some devices might make use of DMA during boot
+	   (esp true for DMAENGINE implementation)
+	b) Memory allocation will need much more attention
+	   before load/unload can be supported
+ */
+#endif
+
+/*
+ * Singleton holding driver data - there can be only one PL08X DMAC
+ * in the system.
+ */
+struct pl08x_driver_data pl08x;
+
+/*
+ * PL08X specific defines
+ */
+/* Minimum period between work queue runs */
+#define PL08X_WQ_PERIODMIN	20
+/* Size (bytes) of each LLI buffer allocated for one transfer */
+# define PL08X_LLI_TSFR_SIZE	0x2000
+/* Maximimum times we call dma_pool_alloc on this pool without freeing */
+# define PL08X_MAX_ALLOCS	0x40
+#define MAX_NUM_TSFR_LLIS	(PL08X_LLI_TSFR_SIZE/sizeof(struct _lli))
+#define PL08X_ALIGN		8
+#define PL08X_ALLOC		0
+
+/* Register offsets */
+#define	PL08X_OS_ISR		0x00
+#define	PL08X_OS_ISR_TC		0x04
+#define	PL08X_OS_ICLR_TC	0x08
+#define	PL08X_OS_ISR_ERR	0x0C
+#define	PL08X_OS_ICLR_ERR	0x10
+#define	PL08X_OS_CFG		0x30
+#define	PL08X_OS_ENCHNS		0x1C
+#define	PL08X_OS_CHAN		0x20
+#define	PL08X_OS_CHAN_BASE	0x100
+/* Channel registers */
+#define	PL08X_OS_CSRC		0x00
+#define	PL08X_OS_CDST		0x04
+#define	PL08X_OS_CLLI		0x08
+#define	PL08X_OS_CCTL		0x0C
+#define	PL08X_OS_CCFG		0x10
+/* register masks */
+#define	PL08X_MASK_CFG		0xFFFFFFF1
+#define	PL08X_MASK_EN		0x00000001
+#define	PL08X_MASK_CLLI		0x00000002
+#define	PL08X_MASK_TSFR_SIZE	0x00000FFF
+#define	PL08X_MASK_INTTC	0x00008000
+#define	PL08X_MASK_INTERR	0x00004000
+#define	PL08X_MASK_CCFG		0x00000000
+#define	PL08X_MASK_HALT		0x00040000
+#define	PL08X_MASK_ACTIVE	0x00020000
+#define	PL08X_MASK_CEN		0x00000001
+#define	PL08X_MASK_ENCHNS	0x000000FF
+#define PL08X_WIDTH_8BIT	0x00
+#define PL08X_WIDTH_16BIT	0x01
+#define PL08X_WIDTH_32BIT	0x02
+/*
+ * Transferring less than this number of bytes as bytes
+ * is faster than calculating the required LLIs....
+ * (8 is the real minimum
+ * >7 bytes must have a word alignable transfer somewhere)
+ */
+#define PL08X_BITESIZE		0x10
+/*
+ * Flow control bit masks
+ */
+#define PL08X_FCMASK_M2M_DMA	0x00000000
+#define PL08X_FCMASK_M2P_DMA	0x00000800
+#define PL08X_FCMASK_P2M_DMA	0x00001000
+#define PL08X_FCMASK_P2P_DMA	0x00001800
+#define PL08X_FCMASK_P2P_DST	0x00002000
+#define PL08X_FCMASK_M2P_PER	0x00002800
+#define PL08X_FCMASK_P2P_PER	0x00003000
+#define PL08X_FCMASK_P2P_SRC	0x00003800
+/* Max number of transfers which can be coded in the control register */
+#define PL08X_MAX_TSFRS		0xFFF
+
+#define PL08X_CODING_ERR	0xFFFFFFFF
+
+static inline struct pl08x_dma_chan *to_pl08x_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct pl08x_dma_chan, chan);
+}
+
+static inline void __iomem *pl08x_get_chanbase(struct pl08x_phy_chan *ch)
+{
+	void __iomem *chan_base = pl08x.base + PL08X_OS_CHAN_BASE;
+
+	if (ch == NULL)
+		return NULL;
+	chan_base += ch->id * PL08X_OS_CHAN;
+	return chan_base;
+}
+
+/*
+ * Physical channel handling
+ */
+
+/* Whether a certain channel is busy or not */
+static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
+{
+	unsigned int val;
+	void __iomem *chan_base = pl08x_get_chanbase(ch);
+
+	/*
+	 * Check channel is inactive
+	 */
+	val = readl(chan_base + PL08X_OS_CCFG);
+
+	return val & PL08X_MASK_ACTIVE;
+}
+
+/*
+ * Set the initial DMA register values i.e. those for the first LLI
+ * The next lli pointer and the configuration interrupt bit have
+ * been set when the LLIs were constructed
+ */
+static void pl08x_set_cregs(struct pl08x_phy_chan *ch)
+{
+	u32 val;
+	void __iomem *chan_base = pl08x_get_chanbase(ch);
+
+	/* Wait for channel inactive */
+	val = readl(chan_base + PL08X_OS_CCFG);
+	while (val & PL08X_MASK_ACTIVE)
+		val = readl(chan_base + PL08X_OS_CCFG);
+
+	dev_vdbg(&pl08x.adev->dev,
+		"WRITE channel %d: csrc=%08x, cdst=%08x, cctl=%08x, clli=%08x, ccfg=%08x\n",
+		ch->id,
+		ch->csrc,
+		ch->cdst,
+		ch->cctl,
+		ch->clli,
+		ch->ccfg);
+
+	writel(ch->csrc, chan_base + PL08X_OS_CSRC);
+	writel(ch->cdst, chan_base + PL08X_OS_CDST);
+	writel(ch->clli, chan_base + PL08X_OS_CLLI);
+	writel(ch->cctl, chan_base + PL08X_OS_CCTL);
+	writel(ch->ccfg, chan_base + PL08X_OS_CCFG);
+	mb();
+}
+
+static inline void pl08x_config_phychan_for_txd(struct pl08x_dma_chan *plchan)
+{
+	struct pl08x_channel_data *cd = plchan->cd;
+	struct pl08x_phy_chan *phychan = plchan->phychan;
+	struct pl08x_txd *txd = plchan->at;
+
+	/* Copy the basic control register calculated at transfer config */
+	phychan->csrc = txd->csrc;
+	phychan->cdst = txd->cdst;
+	phychan->clli = txd->clli;
+	phychan->cctl = txd->cctl;
+
+	/* Assign the signal to the proper control registers */
+	phychan->ccfg = cd->ccfg;
+	phychan->ccfg &= 0xFFFFF801;
+	/* If it wasn't set from AMBA, ignore it */
+	if (txd->direction == DMA_TO_DEVICE)
+		phychan->ccfg |= (phychan->signal << 6); /* Destination */
+	else if (txd->direction == DMA_FROM_DEVICE)
+		phychan->ccfg |= (phychan->signal << 1); /* Source */
+	/* Always enable error interrupts */
+	phychan->ccfg |= (1 << 14);
+	/* Always enable terminal interrupts */
+	phychan->ccfg |= (1 << 15);
+}
+
+/*
+ * Enable the DMA channel
+ * Assumes all other configuration bits have been set
+ * as desired before this code is called
+ */
+static void pl08x_enable_phy_chan(struct pl08x_phy_chan *ch)
+{
+	void __iomem *chan_base = pl08x_get_chanbase(ch);
+	u32 val;
+
+	dev_dbg(&pl08x.adev->dev,
+		"enable channel %d\n", ch->id);
+
+	/*
+	 * Do not access config register until channel shows as disabled
+	 */
+	while ((readl(pl08x.base + PL08X_OS_ENCHNS) & (1 << ch->id))
+			& PL08X_MASK_ENCHNS)
+		;
+
+	/*
+	 * Do not access config register until channel shows as inactive
+	 */
+	val = readl(chan_base + PL08X_OS_CCFG);
+	while ((val & PL08X_MASK_ACTIVE) || (val & PL08X_MASK_CEN))
+		val = readl(chan_base + PL08X_OS_CCFG);
+
+	writel(val | PL08X_MASK_CEN, chan_base + PL08X_OS_CCFG);
+	mb();
+}
+
+/*
+ * Overall DMAC remains enabled always.
+ *
+ * Disabling individual channels could lose data.
+ *
+ * Disable the peripheral DMA after disabling the DMAC
+ * in order to allow the DMAC FIFO to drain, and
+ * hence allow the channel to show inactive
+ *
+ */
+static void pl08x_pause_phy_chan(struct pl08x_phy_chan *ch)
+{
+	void __iomem *chan_base = pl08x_get_chanbase(ch);
+	u32 val;
+
+	/* Set the HALT bit and wait for the FIFO to drain */
+	val = readl(chan_base + PL08X_OS_CCFG);
+	val |= PL08X_MASK_HALT;
+	writel(val, chan_base + PL08X_OS_CCFG);
+
+	/* Wait for channel inactive */
+	val = readl(chan_base + PL08X_OS_CCFG);
+	while (val & PL08X_MASK_ACTIVE)
+		val = readl(chan_base + PL08X_OS_CCFG);
+
+	mb();
+
+	return;
+}
+
+static void pl08x_resume_phy_chan(struct pl08x_phy_chan *ch)
+{
+	void __iomem *chan_base = pl08x_get_chanbase(ch);
+	u32 val;
+
+	/* Clear the HALT bit */
+	val = readl(chan_base + PL08X_OS_CCFG);
+	val &= ~PL08X_MASK_HALT;
+	writel(val, chan_base + PL08X_OS_CCFG);
+	mb();
+
+	return;
+}
+
+
+/* Stops the channel */
+static void pl08x_stop_phy_chan(struct pl08x_phy_chan *ch)
+{
+	void __iomem *chan_base = pl08x_get_chanbase(ch);
+	u32 val;
+
+	pl08x_pause_phy_chan(ch);
+
+	/* Disable channel */
+	val = readl(chan_base + PL08X_OS_CCFG);
+	val &= ~PL08X_MASK_CEN;
+	writel(val, chan_base + PL08X_OS_CCFG);
+	mb();
+
+	return;
+}
+
+static inline u32 get_bytes_in_cctl(u32 cctl)
+{
+	/* The source width defines the number of bytes */
+	u32 bytes = cctl & PL08X_MASK_TSFR_SIZE;
+
+	switch ((cctl >> 18) & 3) {
+	case PL08X_WIDTH_8BIT:
+		break;
+	case PL08X_WIDTH_16BIT:
+		bytes *= 2;
+		break;
+	case PL08X_WIDTH_32BIT:
+		bytes *= 4;
+		break;
+	}
+	return bytes;
+}
+
+static u32 pl08x_getbytes_phy_chan(struct pl08x_phy_chan *ch)
+{
+	void __iomem *chan_base = pl08x_get_chanbase(ch);
+	u32 bytes;
+	
+	/* FIXME: follow all queued transactions */
+	bytes = get_bytes_in_cctl(readl(chan_base + PL08X_OS_CCTL));
+	/* TODO: follow the LLI to see the sum summarum */
+	return bytes;
+}
+
+/*
+ * Allocate a physical channel for a virtual channel
+ */
+static struct pl08x_phy_chan *
+pl08x_get_phy_channel(struct pl08x_dma_chan *virt_chan)
+{
+	struct pl08x_phy_chan *ch = NULL;
+	unsigned long flags;
+	int i;
+
+	/*
+	 * Try to locate a physical channel to be used for
+	 * this transfer. If all are taken return NULL and
+	 * the requester will have to cope by using some fallback
+	 * PIO mode or retrying later.
+	 */
+	spin_lock_irqsave(&pl08x.phy_chan_lock, flags);
+	for (i = 0; i < pl08x.vd->channels; i++) {
+		ch = &pl08x.phy_chans[i];
+
+		if (!ch->serving) {
+			ch->serving = virt_chan;
+			ch->signal = -1;
+			break;
+		}
+		dev_warn(&pl08x.adev->dev,
+			 "occupied physical channel %d is %s\n", ch->id,
+			 pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
+	}
+	spin_unlock_irqrestore(&pl08x.phy_chan_lock, flags);
+
+	if (i == pl08x.vd->channels) {
+		/* No physical channel available, cope with it */
+		return NULL;
+	}
+
+	return ch;
+}
+
+static inline void pl08x_put_phy_channel(struct pl08x_phy_chan *ch)
+{
+	unsigned long flags;
+
+	/* Stop the channel and clear its interrupts */
+	pl08x_stop_phy_chan(ch);
+	writel((1 << ch->id), pl08x.base + PL08X_OS_ICLR_ERR);
+	writel((1 << ch->id), pl08x.base + PL08X_OS_ICLR_TC);
+
+	/* Mark it as free */
+	spin_lock_irqsave(&pl08x.phy_chan_lock, flags);
+	ch->serving = NULL;
+	ch->signal = -1;
+	spin_unlock_irqrestore(&pl08x.phy_chan_lock, flags);
+}
+
+/*
+ * LLI handling
+ */
+
+static inline unsigned int pl08x_decode_widthbits(unsigned int coded)
+{
+	if (coded < 3)
+		return 1 << coded;
+
+	dev_err(&pl08x.adev->dev, "%s - illegal width bits 0x%08x\n", __func__,
+						coded);
+	return PL08X_CODING_ERR;
+}
+
+static inline unsigned int pl08x_encode_width(unsigned int unencoded)
+{
+	unsigned int retval = unencoded >> 1;
+
+	if (unencoded == (1 << retval))
+		return retval;
+
+	dev_err(&pl08x.adev->dev, "%s - illegal width 0x%08x\n", __func__,
+						unencoded);
+	return PL08X_CODING_ERR;
+}
+
+/*
+ * - prefers destination bus if both available
+ * - if fixed address on one bus chooses other
+ */
+void pl08x_choose_master_bus(struct pl08x_bus_data *src_bus,
+	struct pl08x_bus_data *dst_bus, struct pl08x_bus_data **mbus,
+	struct pl08x_bus_data **sbus, union _cctl *cctl_parm)
+{
+	if (!cctl_parm->bits.di) {
+		*mbus = src_bus;
+		*sbus = dst_bus;
+	} else if (!cctl_parm->bits.si)	{
+		*mbus = dst_bus;
+		*sbus = src_bus;
+	} else {
+		if (dst_bus->buswidth == 4) {
+			*mbus = dst_bus;
+			*sbus = src_bus;
+		} else if (src_bus->buswidth == 4) {
+			*mbus = src_bus;
+			*sbus = dst_bus;
+		} else if (dst_bus->buswidth == 2) {
+			*mbus = dst_bus;
+			*sbus = src_bus;
+		} else if (src_bus->buswidth == 2) {
+			*mbus = src_bus;
+			*sbus = dst_bus;
+		} else {
+			/* src_bus->buswidth == 1 */
+			*mbus = dst_bus;
+			*sbus = src_bus;
+		}
+	}
+}
+
+int pl08x_fill_lli_for_desc(struct pl08x_txd *txd, int num_llis, int len,
+				union _cctl *cctl, u32 *remainder)
+{
+	struct _lli *llis_va = (struct _lli *)(txd->llis_va);
+	struct _lli *llis_bus = (struct _lli *)(txd->llis_bus);
+
+	llis_va[num_llis].cctl.val	= cctl->val;
+	llis_va[num_llis].src		= txd->srcbus.addr;
+	llis_va[num_llis].dst		= txd->dstbus.addr;
+	/*
+	 * The bus bit is added to the next lli's address
+	 */
+	llis_va[num_llis].next =
+		(dma_addr_t)((u32) &(llis_bus[num_llis + 1])
+			     | pl08x.pd->bus_bit_lli);
+
+	if (cctl->bits.si)
+		txd->srcbus.addr += len;
+	if (cctl->bits.di)
+		txd->dstbus.addr += len;
+
+	*remainder -= len;
+
+	return num_llis + 1;
+}
+
+/*
+ * Return number of bytes to fill to boundary, or len
+ */
+static u32 pl08x_pre_boundary(u32 addr, u32 len)
+{
+	u32 boundary;
+
+	if (len == 0)
+		dev_err(&pl08x.adev->dev, "%s - zero length\n", __func__);
+
+	boundary = ((addr >> PL08X_BOUNDARY_SHIFT) + 1) << PL08X_BOUNDARY_SHIFT;
+
+	if (boundary < addr + len)
+		return boundary - addr;
+	else
+		return len;
+}
+
+/*
+ * Note that we assume we never have to change the burst sizes
+ * Return 0 for error
+ */
+static int fill_LLIS_for_desc(struct pl08x_txd *txd)
+{
+	struct pl08x_channel_data *cd = txd->cd;
+	struct pl08x_bus_data *mbus, *sbus;
+	u32 remainder;
+	int num_llis = 0;
+	union _cctl cctl_parm;
+	int max_bytes_per_lli;
+	int total_bytes = 0;
+	struct _lli *llis_va;
+	struct _lli *llis_bus;
+
+	if (!txd) {
+		dev_err(&pl08x.adev->dev, "%s - no descriptor\n", __func__);
+		return 0;
+	}
+
+	/*
+	 * Get some LLIs
+	 *  This alloc can wait if the pool is used up so we need to cleanup
+	 */
+	txd->llis_va = dma_pool_alloc(pl08x.pool, GFP_KERNEL,
+				      &txd->llis_bus);
+	if (!txd->llis_va) {
+		dev_err(&pl08x.adev->dev, "%s - no memory for llis\n", __func__);
+		return 0;
+	}
+
+	pl08x.pool_ctr++;
+
+	/*
+	 * Initialize bus values for this transfer
+	 * from the passed optimal values
+	 */
+	if (!cd) {
+		dev_err(&pl08x.adev->dev, "%s - no channel data\n", __func__);
+		return 0;
+	}
+
+	/* Assign a bit struct to the union config */
+	cctl_parm.val = cd->cctl;
+#if 0
+	dev_vdbg(&pl08x.adev->dev, "%s - cctl vs cctl_parm:\n", __func__);
+	dev_vdbg(&pl08x.adev->dev, "cd->cctl: %08x\n", cd->cctl);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.tsize: %02x\n", cctl_parm.bits.tsize);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.sbsize %02x\n", cctl_parm.bits.sbsize);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.dbsize %02x\n", cctl_parm.bits.dbsize);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.swidth %02x\n", cctl_parm.bits.swidth);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.dwidth %02x\n", cctl_parm.bits.dwidth);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.smaster %02x\n", cctl_parm.bits.smaster);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.dmaster %02x\n", cctl_parm.bits.dmaster);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.si %02x\n", cctl_parm.bits.si);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.di %02x\n", cctl_parm.bits.di);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.prot %02x\n", cctl_parm.bits.prot);
+	dev_vdbg(&pl08x.adev->dev, "cctl_parm.intr %02x\n", cctl_parm.bits.intr);
+#endif
+
+	/* Find maximum width of the source bus */
+	txd->srcbus.maxwidth =
+		pl08x_decode_widthbits(cctl_parm.bits.swidth);
+
+	if (txd->srcbus.maxwidth == PL08X_CODING_ERR) {
+		dev_err(&pl08x.adev->dev,
+			"%s - txd->srcbus.maxwidth codeing error cctl_parm.bits.swidth %d\n",
+				__func__, cctl_parm.bits.swidth);
+		return 0;
+	}
+
+
+	/* Find maximum width of the destination bus */
+	txd->dstbus.maxwidth =
+		pl08x_decode_widthbits(cctl_parm.bits.dwidth);
+
+	if (txd->dstbus.maxwidth == PL08X_CODING_ERR) {
+		dev_err(&pl08x.adev->dev,
+			"%s - txd->dstbus.maxwidth coding error - cctl_parm.bits.dwidth %d\n",
+				__func__, cctl_parm.bits.dwidth);
+		return 0;
+	}
+
+	/* Set up the bus widths to the maximum */
+	txd->srcbus.buswidth = txd->srcbus.maxwidth;
+	txd->dstbus.buswidth = txd->dstbus.maxwidth;
+	dev_vdbg(&pl08x.adev->dev,
+		 "%s - source bus is %d bytes wide, dest bus is %d bytes wide\n",
+		 __func__, txd->srcbus.buswidth, txd->dstbus.buswidth);
+	
+
+	/*
+	 * bytes transferred == tsize * MIN(buswidths), not max(buswidths)
+	 */
+	max_bytes_per_lli = min(txd->srcbus.buswidth, txd->dstbus.buswidth) *
+		PL08X_MAX_TSFRS;
+
+	/* We need to count this down to zero */
+	remainder = txd->len;
+
+	/*
+	 * Choose bus to align to
+	 * - prefers destination bus if both available
+	 * - if fixed address on one bus chooses other
+	 */
+	pl08x_choose_master_bus(&txd->srcbus,
+		&txd->dstbus, &mbus, &sbus, &cctl_parm);
+
+	if (txd->len < mbus->buswidth) {
+		/*
+		 * Less than a bus width available
+		 * - send as single bytes
+		 */
+		while (remainder) {
+			dev_vdbg(&pl08x.adev->dev,
+				 "%s - single byte LLIs for a transfer of less than a bus width (remain %08x)\n",
+				 __func__, remainder);
+			cctl_parm.bits.swidth = pl08x_encode_width(1);
+			cctl_parm.bits.dwidth = pl08x_encode_width(1);
+			cctl_parm.bits.tsize = 1;
+			num_llis =
+				pl08x_fill_lli_for_desc(txd, num_llis, 1,
+					&cctl_parm, &remainder);
+			total_bytes++;
+		}
+	} else {
+		/*
+		 *  Make one byte LLIs until master bus is aligned
+		 *  - slave will then be aligned also
+		 */
+		while ((mbus->addr) % (mbus->buswidth)) {
+			dev_vdbg(&pl08x.adev->dev,
+				"%s - adjustment lli for less than bus width (remain %08x)\n",
+				__func__, remainder);
+			cctl_parm.bits.swidth = pl08x_encode_width(1);
+			cctl_parm.bits.dwidth = pl08x_encode_width(1);
+			cctl_parm.bits.tsize = 1;
+			num_llis = pl08x_fill_lli_for_desc
+				(txd, num_llis, 1, &cctl_parm,
+					&remainder);
+			total_bytes++;
+		}
+
+		/*
+		 *  Master now aligned
+		 * - if slave is not then we must set its width down
+		 */
+		if (sbus->addr % sbus->buswidth)
+			sbus->buswidth = 1;
+
+		/*
+		 * Make largest possible LLIs until less than one bus width left
+		 */
+		while (remainder > (mbus->buswidth - 1)) {
+			int lli_len, target_len;
+			int tsize;
+			int odd_bytes;
+			/*
+			 * If enough left try to send max possible,
+			 * otherwise try to send the remainder
+			 */
+			target_len = remainder;
+			if (remainder > max_bytes_per_lli)
+				target_len = max_bytes_per_lli;
+
+			/*
+			 * Set bus lengths for incrementing busses
+			 * to number of bytes which fill to next memory
+			 * boundary
+			 */
+			if (cctl_parm.bits.si)
+				txd->srcbus.fill_bytes =
+					pl08x_pre_boundary(
+						txd->srcbus.addr,
+						remainder);
+			else
+				txd->srcbus.fill_bytes =
+					max_bytes_per_lli;
+
+			if (cctl_parm.bits.di)
+				txd->dstbus.fill_bytes =
+					pl08x_pre_boundary(
+						txd->dstbus.addr,
+						remainder);
+			else
+				txd->dstbus.fill_bytes =
+						max_bytes_per_lli;
+
+			/*
+			 *  Find the nearest
+			 */
+			lli_len	= min(txd->srcbus.fill_bytes,
+				txd->dstbus.fill_bytes);
+
+			if (lli_len <= 0) {
+				dev_err(&pl08x.adev->dev,
+					"%s - lli_len is %d, <= 0\n",
+						__func__, lli_len);
+				return 0;
+			}
+
+			if (lli_len == target_len) {
+				/*
+				 * Can send what we wanted
+				 */
+				/*
+				 *  Maintain alignment
+				 */
+				lli_len	= (lli_len/mbus->buswidth) *
+							mbus->buswidth;
+				odd_bytes = 0;
+			} else {
+				/*
+				 * So now we know how many bytes to transfer
+				 * to get to the nearest boundary
+				 * The next lli will past the boundary
+				 * - however we may be working to a boundary
+				 *   on the slave bus
+				 *   We need to ensure the master stays aligned
+				 */
+				odd_bytes = lli_len % mbus->buswidth;
+				/*
+				 * - and that we are working in multiples
+				 *   of the bus widths
+				 */
+				lli_len -= odd_bytes;
+
+			}
+
+			if (lli_len) {
+				/*
+				 * Check against minimum bus alignment:
+				 * Calculate actual transfer size in relation to bus
+				 * width an get a maximum remainder of the smallest
+				 * bus width - 1
+				 */
+				tsize = lli_len / min(mbus->buswidth, sbus->buswidth);
+				lli_len	= tsize * min(mbus->buswidth, sbus->buswidth);
+
+				if (target_len != lli_len) {
+					dev_vdbg(&pl08x.adev->dev,
+					"%s - can't send what we want. Desired %08x, lli of %08x bytes in txd of %08x\n",
+					__func__, target_len, lli_len, txd->len);
+				}
+
+				cctl_parm.bits.swidth = pl08x_encode_width
+					(txd->srcbus.buswidth);
+				cctl_parm.bits.dwidth = pl08x_encode_width
+					(txd->dstbus.buswidth);
+				if ((cctl_parm.bits.swidth == PL08X_CODING_ERR) ||
+					(cctl_parm.bits.dwidth == PL08X_CODING_ERR)) {
+					dev_err(&pl08x.adev->dev,
+					"%s - cctl_parm.bits.swidth or dwidth coding error - txd->dstbus.buswidth %d, txd->srcbus.buswidth %d\n",
+					__func__,
+					txd->dstbus.buswidth,
+					txd->srcbus.buswidth
+					);
+					return 0;
+				}
+				cctl_parm.bits.tsize = tsize;
+				dev_vdbg(&pl08x.adev->dev,
+					"%s - fill lli with single lli chunk of size %08x (remainder %08x)\n",
+					__func__, lli_len, remainder);
+				num_llis = pl08x_fill_lli_for_desc(txd,
+						num_llis, lli_len, &cctl_parm,
+						&remainder);
+				total_bytes += lli_len;
+			}
+
+
+			if (odd_bytes) {
+				/*
+				 * Creep past the boundary,
+				 * maintaining master alignment
+				 */
+				int j;
+				for (j = 0; (j < mbus->buswidth)
+						&& (remainder); j++) {
+					cctl_parm.bits.swidth =
+						pl08x_encode_width(1);
+					cctl_parm.bits.dwidth =
+						pl08x_encode_width(1);
+
+					cctl_parm.bits.tsize = 1;
+					dev_vdbg(&pl08x.adev->dev,
+						"%s - align with boundardy, single byte (remain %08x)\n",
+						__func__, remainder);
+					num_llis =
+						pl08x_fill_lli_for_desc(
+							txd, num_llis, 1,
+							&cctl_parm, &remainder);
+					total_bytes++;
+				}
+			}
+		}
+
+		/*
+		 * Send any odd bytes
+		 */
+		if (remainder < 0) {
+			dev_err(&pl08x.adev->dev, "%s - remainder not fitted 0x%08x bytes\n",
+					__func__, remainder);
+			return 0;
+		}
+
+		while (remainder) {
+			cctl_parm.bits.swidth = pl08x_encode_width(1);
+			cctl_parm.bits.dwidth = pl08x_encode_width(1);
+			cctl_parm.bits.tsize = 1;
+			dev_vdbg(&pl08x.adev->dev,
+				"%s - align with boundardy, single odd byte (remain %d)\n",
+				__func__, remainder);
+			num_llis = pl08x_fill_lli_for_desc(txd, num_llis,
+					1, &cctl_parm, &remainder);
+			total_bytes++;
+		}
+	}
+	if (total_bytes != txd->len) {
+		dev_err(&pl08x.adev->dev,
+			"%s - size of encoded lli:s don't match total txd, transferred 0x%08x from size 0x%08x\n",
+			__func__, total_bytes, txd->len);
+		return 0;
+	}
+
+	if (num_llis >= MAX_NUM_TSFR_LLIS) {
+		dev_err(&pl08x.adev->dev,
+			"%s - need to increase MAX_NUM_TSFR_LLIS from 0x%08x\n",
+			__func__, (u32) MAX_NUM_TSFR_LLIS);
+		return 0;
+	}
+	/*
+	 * Decide whether this is a loop or a terminated transfer
+	 */
+	llis_va = ((struct _lli *)txd->llis_va);
+	llis_bus = ((struct _lli *)txd->llis_bus);
+
+	if (cd->circular_buffer) {
+		/*
+		 * Loop the circular buffer so that the next element
+		 * points back to the beginning of the LLI.
+		 */
+		llis_va[num_llis - 1].next =
+			(dma_addr_t)((unsigned int)&(llis_bus[0]) +
+						pl08x.pd->bus_bit_lli);
+	} else {
+		/*
+		 * On non-circular buffers, the final LLI terminates
+		 * the LLI.
+		 */
+		llis_va[num_llis - 1].next = 0;
+		/*
+		 * The final LLI element shall also fire an interrupt
+		 */
+		llis_va[num_llis - 1].cctl.bits.intr = PL08X_CCTL_INTR_YES;
+	}
+       
+	/* Now store the channel register values */
+	txd->csrc = llis_va[0].src;
+	txd->cdst = llis_va[0].dst;
+	if (num_llis > 1)
+		txd->clli = llis_va[0].next;
+	else
+		txd->clli = 0;
+
+	txd->cctl = llis_va[0].cctl.val;
+	/* ccfg will be set at physical channel allocation time */
+
+	{
+		int i;
+
+		for (i = 0; i < num_llis; i++) {
+				dev_vdbg(&pl08x.adev->dev,
+					"lli %d @%p: csrc=%08x, cdst=%08x, cctl=%08x, clli=%08x\n",
+					i,
+					&llis_va[i],
+					llis_va[i].src,
+					llis_va[i].dst,
+					llis_va[i].cctl.val,
+					llis_va[i].next
+					);
+		}
+	}
+
+	/*
+	 * Reflects the longest lli submitted so far
+	 * TODO: Change to use /proc data
+	 */
+	if (pl08x.max_num_llis < num_llis)
+		pl08x.max_num_llis = num_llis;
+
+	return num_llis;
+}
+
+/*
+ * This single pool easier to manage than one pool per channel
+ */
+int pl08x_make_LLIs(void)
+{
+	int ret = 0;
+
+	/*
+	 * Make a pool of LLI buffers
+	 */
+	pl08x.pool = dma_pool_create(DRIVER_NAME, &pl08x.adev->dev,
+			PL08X_LLI_TSFR_SIZE, PL08X_ALIGN, PL08X_ALLOC);
+	if (!pl08x.pool) {
+		ret = -ENOMEM;
+		kfree(pl08x.chanllis);
+	}
+	pl08x.pool_ctr = 0;
+	return ret;
+}
+
+/* You should call this with the struct pl08x lock held */
+static void pl08x_free_txd(struct pl08x_txd *txd)
+{
+	if (!txd)
+		dev_err(&pl08x.adev->dev,
+			"%s - no descriptor to free\n",
+			__func__);
+
+	/* Free the LLI */
+	dma_pool_free(pl08x.pool, txd->llis_va,
+		      txd->llis_bus);
+
+	pl08x.pool_ctr--;
+
+	kfree(txd);
+}
+
+static void pl08x_free_txd_list(struct list_head *txdlist)
+{
+	struct pl08x_txd *txdi = NULL;
+	struct pl08x_txd *next;
+
+	if (!list_empty(txdlist)) {
+		dev_dbg(&pl08x.adev->dev,
+			"free some queued descriptors\n");
+
+		list_for_each_entry_safe(txdi,
+					 next, txdlist, node) {
+			list_del(&txdi->node);
+			pl08x_free_txd(txdi);
+		}
+
+	}
+}
+
+static void pl08x_tasklet(unsigned long data)
+{
+	struct pl08x_dma_chan *plchan = (struct pl08x_dma_chan *) data;
+	struct pl08x_phy_chan *phychan = plchan->phychan;
+	struct pl08x_txd *txdi = NULL;
+	struct pl08x_txd *next;
+	unsigned long flags;
+
+	if (!plchan)
+		BUG();
+
+	spin_lock_irqsave(&plchan->lock, flags);
+
+	if (plchan->at) {
+		dma_async_tx_callback callback =
+			plchan->at->tx.callback;
+		void *callback_param =
+			plchan->at->tx.callback_param;
+
+		/*
+		 * Update last completed
+		 */
+		plchan->lc =
+			(plchan->at->tx.cookie);
+
+		/*
+		 * Callback peripheral driver for p/m
+		 * to signal completion
+		 */
+		if (callback)
+			callback(callback_param);
+
+		/*
+		 * Device callbacks should NOT clear
+		 * the current transaction on the channel
+		 * Linus: sometimes they should?
+		 */
+		if (!plchan->at)
+			BUG();
+
+		/*
+		 * Free the descriptor if it's not for a device
+		 * using a circular buffer
+		 */
+		if (!plchan->at->cd->circular_buffer) {
+			pl08x_free_txd(plchan->at);
+			plchan->at = NULL;
+		}
+		/*
+		 * else descriptor for circular
+		 * buffers only freed when
+		 * client has disabled dma
+		 */
+	}
+	/*
+	 * If a new descriptor is queued, set it up
+	 */
+	if (!list_empty(&plchan->desc_list)) {
+		list_for_each_entry_safe(txdi,
+					 next, &plchan->desc_list, node) {
+			list_del_init(&txdi->node);
+		}
+	} else {
+		/*
+		 * No more jobs, so free up the physical channel
+		 * Free any allocated signal on slave transfers too
+		 */
+		if ((phychan->signal >= 0) && pl08x.pd->put_signal)
+			pl08x.pd->put_signal(plchan);
+		pl08x_put_phy_channel(phychan);
+		plchan->phychan = NULL;
+	}
+
+	spin_unlock_irqrestore(&plchan->lock, flags);
+}
+
+/*
+ * issue pending() will start the next transfer
+ * - it only need be loaded here
+ * CAUTION the work queue function may run during the handler
+ * CAUTION function callbacks may have interesting side effects
+ * TODO: the majority of the handler should probably be moved
+ * into a tasklet to enable other IRQs to run while it's handling
+ * stuff. And loose the work item...
+ */
+static irqreturn_t pl08x_irq(int irq, void *dev)
+{
+	u32 mask = 0;
+	u32 val;
+	int i;
+
+	val = readl(pl08x.base + PL08X_OS_ISR_ERR);
+	mb();
+	if (val) {
+		/*
+		 * An error interrupt (on one or more channels)
+		 */
+		dev_err(&pl08x.adev->dev,
+			"%s - error interrupt, register value 0x%08x\n",
+				__func__, val);
+		/*
+		 * Simply clear ALL PL08X error interrupts,
+		 * regardless of channel and cause
+		 * FIXME: should be 0x00000003 on PL081 really.
+		 */
+		writel(0x000000FF, pl08x.base + PL08X_OS_ICLR_ERR);
+	}
+	val = readl(pl08x.base + PL08X_OS_ISR);
+	mb();
+	for (i = 0; i < pl08x.vd->channels; i++) {
+		if ((1 << i) & val) {
+			/* Locate physical channel */
+			struct pl08x_phy_chan *phychan = &pl08x.phy_chans[i];
+			struct pl08x_dma_chan *plchan = phychan->serving;
+
+			/* Schedule tasklet on this channel */
+			tasklet_schedule(&plchan->tasklet);
+
+			mask |= (1 << i);
+		}
+	}
+	/*
+	 * Clear only the terminal interrupts on channels we processed
+	 */
+	writel(mask, pl08x.base + PL08X_OS_ICLR_TC);
+	mb();
+
+	return mask ? IRQ_HANDLED : IRQ_NONE;
+}
+
+
+/*
+ * The DMA ENGINE API
+ */
+static int pl08x_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+
+	return 0;
+}
+
+static void pl08x_free_chan_resources(struct dma_chan *chan)
+{
+}
+
+/*
+ * This should be called with the channel plchan->lock held
+ */
+static int prep_phy_channel(struct pl08x_dma_chan *plchan,
+			    struct pl08x_txd *txd)
+{
+	struct pl08x_phy_chan *ch;
+	int ret;
+
+	/* Check if we already have a channel */
+	if (plchan->phychan)
+		return 0;
+
+	ch = pl08x_get_phy_channel(plchan);
+	if (!ch) {
+		/* No physical channel available, cope with it */
+		dev_info(&pl08x.adev->dev, "no physical channel "
+			"available for xfer on %s\n", plchan->name);
+		return -EBUSY;
+	}
+
+	/*
+	 * OK we have a physical channel: for memcpy() this is all we
+	 * need, but for slaves the physical siglals may be muxed!
+	 * Can the platform allow us to use this channel?
+	 */
+	if ((txd->direction == DMA_FROM_DEVICE || txd->direction == DMA_TO_DEVICE) &&
+	    pl08x.pd->get_signal) {
+		ret = pl08x.pd->get_signal(plchan);
+		if (ret < 0) {
+			dev_info(&pl08x.adev->dev,
+				"unable to use physical channel "
+				"%d for transfer on %s due to "
+				"platform restrictions\n",
+				ch->id, plchan->name);
+			/* Release physical channel & return */
+			pl08x_put_phy_channel(ch);
+			return -EBUSY;
+		}
+		ch->signal = ret;
+	}
+
+	dev_dbg(&pl08x.adev->dev, "allocated physical "
+		 "channel %d and signal %d for xfer on %s\n",
+		 ch->id,
+		 ch->signal,
+		 plchan->name);
+
+	plchan->phychan = ch;
+
+	return 0;
+}
+
+/*
+ * First make the LLIs (could/should we do this earlier??)
+ * slave (m/p) - no queued transactions allowed at present
+ *	TODO allow queued transactions for non circular buffers
+ * Set up the channel active txd as inactive
+ * m2m	- transactions may be queued
+ * If no active txd on channel
+ *	set it up as inactive
+ *	- issue_pending() will set active & start
+ * else
+ *	queue it
+ * Lock channel since there may be (at least for m2m) multiple calls
+ *
+ * Return < 0 for error
+ */
+
+static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	int num_llis;
+	unsigned long flags;
+	struct pl08x_txd *txd = container_of(tx, struct pl08x_txd, tx);
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(tx->chan);
+	int ret;
+
+	num_llis = fill_LLIS_for_desc(txd);
+
+	if (num_llis) {
+		spin_lock_irqsave(&plchan->lock, flags);
+		atomic_inc(&plchan->last_issued);
+		tx->cookie = atomic_read(&plchan->last_issued);
+
+		if (plchan->at) {
+
+			/*
+			 * If this device not using a circular buffer then
+			 * queue this new descriptor for transfer.
+			 * The descriptor for a circular buffer continues
+			 * to be used until the channel is freed.
+			 */
+			if (txd->cd->circular_buffer)
+				dev_err(&pl08x.adev->dev,
+					"%s - attempting to queue a circular buffer\n",
+						__func__);
+			else
+				list_add_tail(&txd->node,
+					&plchan->desc_list);
+
+		} else {
+			plchan->at = txd;
+			txd->active = false;
+		}
+
+		/*
+		 * See if we already have a physical channel allocated,
+		 * else this is the time to try to get one.
+		 */
+		ret = prep_phy_channel(plchan, txd);
+		if (ret) {
+			/* No physical channel available, cope with it */
+			spin_unlock_irqrestore(&plchan->lock, flags);
+			return -EBUSY;
+		}
+
+		spin_unlock_irqrestore(&plchan->lock, flags);
+
+		return tx->cookie;
+	} else
+		return -EINVAL;
+}
+
+static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
+		struct dma_chan *chan, unsigned long flags)
+{
+	struct dma_async_tx_descriptor *retval = NULL;
+
+	return retval;
+}
+
+/*
+ * Code accessing dma_async_is_complete() in a tight loop
+ * may give problems - could schedule where indicated.
+ * If slaves are relying on interrupts to signal completion this
+ * function must not be called with interrupts disabled
+ */
+static enum dma_status
+pl08x_dma_tx_status(struct dma_chan *chan,
+		    dma_cookie_t cookie,
+		    struct dma_tx_state *txstate)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	dma_cookie_t last_used;
+	dma_cookie_t last_complete;
+	enum dma_status ret;
+	u32 bytesleft = 0;
+
+	last_used = atomic_read(&plchan->last_issued);
+	last_complete = plchan->lc;
+
+	ret = dma_async_is_complete(cookie, last_complete, last_used);
+	if (ret == DMA_SUCCESS) {
+		dma_set_tx_state(txstate, last_complete, last_used, 0);
+		return ret;
+	}
+
+	/*
+	 * schedule(); could be inserted here
+	 */
+
+	/*
+	 * This cookie not complete yet
+	 */
+	last_used = atomic_read(&plchan->last_issued);
+	last_complete = plchan->lc;
+
+	/* Get number of bytes left in the active transaction */
+	if (plchan->phychan)
+		bytesleft = pl08x_getbytes_phy_chan(plchan->phychan);
+
+	dma_set_tx_state(txstate, last_complete, last_used,
+			 bytesleft);
+
+	return DMA_IN_PROGRESS;
+	/* FIXME: make possible to return DMA_IN_PROGRESS */
+}
+
+/* PrimeCell DMA extension */
+struct burst_table {
+	int burstwords;
+	u32 reg;
+};
+
+static const struct burst_table burst_sizes[] = {
+	{
+		.burstwords = 256,
+		.reg = PL08X_CCTL_BSIZE_256 << 12 | PL08X_CCTL_BSIZE_256 << 15,
+	},
+	{
+		.burstwords = 128,
+		.reg = PL08X_CCTL_BSIZE_128 << 12 | PL08X_CCTL_BSIZE_128 << 15,
+	},
+	{
+		.burstwords = 64,
+		.reg = PL08X_CCTL_BSIZE_64 << 12 | PL08X_CCTL_BSIZE_64 << 15,
+	},
+	{
+		.burstwords = 32,
+		.reg = PL08X_CCTL_BSIZE_32 << 12 | PL08X_CCTL_BSIZE_32 << 15,
+	},
+	{
+		.burstwords = 16,
+		.reg = PL08X_CCTL_BSIZE_16 << 12 | PL08X_CCTL_BSIZE_16 << 15,
+	},
+	{
+		.burstwords = 8,
+		.reg = PL08X_CCTL_BSIZE_8 << 12 | PL08X_CCTL_BSIZE_8 << 15,
+	},
+	{
+		.burstwords = 4,
+		.reg = PL08X_CCTL_BSIZE_4 << 12 | PL08X_CCTL_BSIZE_4 << 15,
+	},
+	{
+		.burstwords = 1,
+		.reg = PL08X_CCTL_BSIZE_1 << 12 | PL08X_CCTL_BSIZE_1 << 15,
+	},
+};
+
+void dma_set_ambaconfig(struct dma_chan *chan,
+			struct amba_dma_channel_config *config)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	struct pl08x_channel_data *cd = plchan->cd;
+	int maxburst = config->maxburst;
+	u32 cctl = 0;
+	/* Mask out all except src and dst channel */
+	u32 ccfg = cd->ccfg & 0x000003DEU;
+	int i = 0;
+	
+	plchan->amba_addr = config->addr;
+	plchan->amba_direction = config->direction;
+
+	switch (config->addr_width) {
+	case 1:
+		cctl |= PL08X_WIDTH_8BIT << 18 | PL08X_WIDTH_8BIT << 21;
+		break;
+	case 2:
+		cctl |= PL08X_WIDTH_16BIT << 18 | PL08X_WIDTH_16BIT << 21;
+		break;
+	case 4:
+		cctl |= PL08X_WIDTH_32BIT << 18 | PL08X_WIDTH_32BIT << 21;
+		break;
+	default:
+		dev_err(&pl08x.adev->dev,
+			"bad ambaconfig: alien address width\n");
+		return;
+	}
+
+	/* Now decide on a maxburst */
+	while (i < ARRAY_SIZE(burst_sizes)) {
+		if (burst_sizes[i].burstwords <= maxburst)
+			break;
+		i++;
+	}
+	cctl |= burst_sizes[i].reg;
+
+	/* Transfer direction */
+	if (config->direction == DMA_TO_DEVICE) {
+		cctl |= PL08X_CCTL_INCR_YES << 26 |
+			PL08X_CCTL_INCR_NO << 27;
+		ccfg |= PL08X_CCFG_MEM2PER_DMAC;
+	} else if (config->direction == DMA_FROM_DEVICE) {
+		cctl |= PL08X_CCTL_INCR_NO << 26 |
+			PL08X_CCTL_INCR_YES << 27;
+		ccfg |= PL08X_CCFG_PER2MEM_DMAC;
+	} else {
+		dev_err(&pl08x.adev->dev,
+			"bad ambaconfig: alien transfer direction\n");
+	}
+
+	/* Access the cell in privileged mode, non-bufferable, non-cacheable */
+	cctl |= (PL08X_CCTL_PROT_PRI << 28 |
+		 PL08X_CCTL_PROT_UNBUFF << 29 |
+		 PL08X_CCTL_PROT_NON_CACHE << 30);
+
+	/* Modify the default channel data to fit PrimeCell request */
+	cd->cctl = cctl;
+	cd->ccfg = ccfg;
+
+	dev_info(&pl08x.adev->dev,
+		 "configured channel %s (%s) for %s, data width %d, "
+		 "maxburst %d words, LE, CCTL=%08x, CCFG=%08x\n",
+		 dma_chan_name(chan), plchan->name,
+		 (config->direction == DMA_FROM_DEVICE) ? "RX" : "TX",
+		 config->addr_width,
+		 config->maxburst,
+		 cctl, ccfg);
+}
+
+/*
+ * Slave transactions callback to the slave device to allow
+ * synchronization of slave DMA signals with the DMAC enable
+ */
+static void pl08x_issue_pending(struct dma_chan *chan)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+
+	if (plchan->at) {
+		if (!plchan->at->active) {
+			/* Configure the physical channel for the active txd */
+			pl08x_config_phychan_for_txd(plchan);
+			pl08x_set_cregs(plchan->phychan);
+			pl08x_enable_phy_chan(plchan->phychan);
+			plchan->at->active = true;
+		}
+		/*
+		 * else skip active transfer
+		 * Calls with active txd occur for NET_DMA
+		 * - there can be queued descriptors
+		 */
+	}
+	/*
+	 * else - calls with no active descriptor occur for NET_DMA
+	 */
+}
+
+/*
+ * Initialize a descriptor to be used by memcpy submit
+ */
+static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
+		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+		size_t len, unsigned long flags)
+{
+	struct pl08x_txd *txd;
+
+	txd = kzalloc(sizeof(struct pl08x_txd), GFP_KERNEL);
+	if (!txd) {
+		dev_err(&pl08x.adev->dev,
+			"%s - no memory for descriptor\n", __func__);
+		return NULL;
+	}
+
+	dma_async_tx_descriptor_init(&txd->tx, chan);
+	txd->direction = DMA_NONE;
+	txd->srcbus.addr = src;
+	txd->dstbus.addr = dest;
+
+	/* Set platform data for m2m */
+	txd->cd = &pl08x.pd->memcpy_channel;
+	/* Both to be incremented or the code will break */
+	txd->cd->cctl |= PL08X_CCTL_INCR_YES << 26 | PL08X_CCTL_INCR_YES << 27;
+	txd->tx.tx_submit = pl08x_tx_submit;
+	txd->tx.callback = NULL;
+	txd->tx.callback_param = NULL;
+	txd->len = len;
+
+	INIT_LIST_HEAD(&txd->node);
+
+	return &txd->tx;
+}
+
+struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_data_direction direction,
+		unsigned long flags)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	struct pl08x_txd *txd;
+
+	/*
+	 * Current implementation ASSUMES only one sg
+	 */
+	if (sg_len != 1)
+		BUG();
+
+	dev_info(&pl08x.adev->dev, "%s - prepare transaction from %s\n",
+		 __func__, plchan->name);
+
+	txd = kmalloc(sizeof(struct pl08x_txd), GFP_KERNEL);
+	if (!txd) {
+		dev_err(&pl08x.adev->dev, "%s - no txd\n", __func__);
+		return NULL;
+	}
+
+	dma_async_tx_descriptor_init(&txd->tx, chan);
+
+	if (direction != plchan->amba_direction)
+		dev_err(&pl08x.adev->dev, "%s - DMA setup does not match "
+			"the direction configured for the PrimeCell\n",
+			__func__);
+
+	txd->direction = direction;
+	if (direction == DMA_TO_DEVICE) {
+		txd->srcbus.addr	= sgl->dma_address;
+		txd->dstbus.addr	= plchan->amba_addr;
+	} else if (direction == DMA_FROM_DEVICE) {
+		txd->srcbus.addr	= plchan->amba_addr;
+		txd->dstbus.addr	= sgl->dma_address;
+	} else {
+		dev_err(&pl08x.adev->dev,
+			"%s - direction unsupported\n", __func__);
+		return NULL;
+	}
+	txd->cd = plchan->cd;
+	txd->tx.tx_submit = pl08x_tx_submit;
+	txd->tx.callback = NULL;
+	txd->tx.callback_param = NULL;
+	txd->len = sgl->length;
+
+	INIT_LIST_HEAD(&txd->node);
+
+	return &txd->tx;
+}
+
+static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	unsigned long flags;
+
+	/* Anything succeeds on non-existing transfers */
+	if (!plchan->at || !plchan->phychan)
+		return 0;
+
+	switch (cmd) {
+	case DMA_TERMINATE_ALL:
+		spin_lock_irqsave(&plchan->lock, flags);
+		pl08x_stop_phy_chan(plchan->phychan);
+		/* Mark physical channel as free and free any slave signal */
+		if ((plchan->phychan->signal >= 0) && pl08x.pd->put_signal)
+			pl08x.pd->put_signal(plchan);
+		pl08x_put_phy_channel(plchan->phychan);
+		plchan->phychan = NULL;
+		/* Dequeue all jobs on the channel */
+		pl08x_free_txd(plchan->at);
+		pl08x_free_txd_list(&plchan->desc_list);
+		spin_unlock_irqrestore(&plchan->lock, flags);
+		return 0;
+	case DMA_PAUSE:
+		pl08x_pause_phy_chan(plchan->phychan);
+		return 0;
+	case DMA_RESUME:
+		pl08x_resume_phy_chan(plchan->phychan);
+		return 0;
+	}
+
+	/* Unknown command */
+	return -ENXIO;
+}
+
+bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	char *name = chan_id;
+
+	/* Check that the channel is not taken! */
+	if (!strcmp(plchan->name, name))
+		return true;
+
+	return false;
+}
+
+struct dma_device dmac_memcpy = {
+	.device_alloc_chan_resources	= pl08x_alloc_chan_resources,
+	.device_free_chan_resources	= pl08x_free_chan_resources,
+	.device_prep_dma_memcpy		= pl08x_prep_dma_memcpy,
+	.device_prep_dma_xor		= NULL,
+	.device_prep_dma_memset		= NULL,
+	.device_prep_dma_interrupt	= pl08x_prep_dma_interrupt,
+	.device_tx_status		= pl08x_dma_tx_status,
+	.device_issue_pending		= pl08x_issue_pending,
+	.device_control			= pl08x_control,
+	/*
+	 * Align to 4-byte boundary
+	 * If we don't do this, the test results gradually degenerates until
+	 * the channels lock up even after a soft reset (!)
+	 */
+	.copy_align			= 2,
+};
+
+struct dma_device dmac_slave = {
+	.device_alloc_chan_resources	= pl08x_alloc_chan_resources,
+	.device_free_chan_resources	= pl08x_free_chan_resources,
+	.device_prep_dma_xor		= NULL,
+	.device_prep_dma_memset		= NULL,
+	.device_prep_dma_interrupt	= pl08x_prep_dma_interrupt,
+	.device_tx_status		= pl08x_dma_tx_status,
+	.device_issue_pending		= pl08x_issue_pending,
+	.device_prep_slave_sg		= pl08x_prep_slave_sg,
+	.device_control			= pl08x_control,
+};
+
+
+/*
+ * Just check that the device is there and active
+ * TODO: turn this bit on/off depending on the number of
+ * physical channels actually used, if it is zero... well
+ * shut it off.
+ */
+static void __init pl08x_ensure_on(void){
+	u32 val;
+
+	val = readl(pl08x.base + PL08X_OS_CFG);
+	val &= PL08X_MASK_CFG;
+	/* We implictly clear bit 1 and that means little-endian mode */
+	val |= PL08X_MASK_EN;
+	mb();
+	writel(val, pl08x.base + PL08X_OS_CFG);
+	mb();
+}
+
+/*
+ * Initialise the DMAC memcpy channels.
+ * Make a local wrapper to hold required data
+ */
+static int __init pl08x_dma_init_memcpy_channels(struct dma_device *memdev)
+{
+	struct pl08x_dma_chan *chan;
+	int i;
+
+	INIT_LIST_HEAD(&memdev->channels);
+	/*
+	 * Register as many many memcpy as we have physical channels,
+	 * we won't always be able to use all but the code will have
+	 * to cope with that situation.
+	 */
+	for (i = 0; i < pl08x.vd->channels; i++) {
+		chan = kzalloc(sizeof(struct pl08x_dma_chan), GFP_KERNEL);
+		if (!chan) {
+			dev_err(&pl08x.adev->dev,
+				"%s - no memory for channel\n", __func__);
+			return -ENOMEM;
+		}
+
+		chan->name = kasprintf(GFP_KERNEL, "memcpy%d", i);
+		if (!chan->name) {
+			kfree(chan);
+			return -ENOMEM;
+		}
+		chan->cd = &pl08x.pd->memcpy_channel;
+		dev_info(&pl08x.adev->dev,
+			"initialize virtual memcpy channel \"%s\"\n",
+			chan->name);
+
+		/*
+		 * Save the DMAC channel number
+		 * to indicate which registers to access
+		 */
+		chan->chan_id = i;
+		chan->chan.device = memdev;
+		atomic_set(&chan->last_issued, 0);
+		chan->lc = atomic_read(&chan->last_issued);
+
+		spin_lock_init(&chan->lock);
+		INIT_LIST_HEAD(&chan->desc_list);
+		tasklet_init(&chan->tasklet, pl08x_tasklet,
+			     (unsigned long) chan);
+
+		list_add_tail(&chan->chan.device_node, &memdev->channels);
+	}
+	dev_info(&pl08x.adev->dev, "initialized %d virtual memcpy channels\n", i);
+	return i;
+}
+
+/*
+ * Initialise the DMAC slave channels.
+ * Make a local wrapper to hold required data
+ */
+static int __init pl08x_dma_init_slave_channels(struct dma_device *slave)
+{
+	struct pl08x_dma_chan *chan;
+	int i;
+
+	INIT_LIST_HEAD(&slave->channels);
+	for (i = 0; i < pl08x.pd->num_slave_channels; i++) {
+		chan = kzalloc(sizeof(struct pl08x_dma_chan), GFP_KERNEL);
+		if (!chan) {
+			dev_err(&pl08x.adev->dev,
+				"%s - no memory for channel\n", __func__);
+			return -ENOMEM;
+		}
+
+		chan->name = pl08x.pd->slave_channels[i].bus_id;
+		chan->cd = &pl08x.pd->slave_channels[i];
+		dev_info(&pl08x.adev->dev,
+			"initialize virtual channel \"%s\"\n",
+			chan->name);
+
+		/*
+		 * Save the DMAC channel number
+		 * to indicate which registers to access
+		 */
+		chan->chan_id = i;
+		chan->chan.device = slave;
+		atomic_set(&chan->last_issued, 0);
+		chan->lc = atomic_read(&chan->last_issued);
+
+		spin_lock_init(&chan->lock);
+		INIT_LIST_HEAD(&chan->desc_list);
+		tasklet_init(&chan->tasklet, pl08x_tasklet,
+			     (unsigned long) chan);
+
+		list_add_tail(&chan->chan.device_node, &slave->channels);
+	}
+	dev_info(&pl08x.adev->dev, "initialized %d virtual slave channels\n", i);
+	return i;
+}
+
+static int __init pl08x_probe(struct amba_device *adev, struct amba_id *id)
+{
+	struct pl08x_phy_chan *pchans;
+	struct vendor_data *vd = id->data;
+	int ret = 0;
+	int i;
+
+	/* Assign useful pointers to the singleton */
+	pl08x.adev = adev;
+	pl08x.vd = vd;
+
+	ret = amba_request_regions(adev, NULL);
+	if (ret)
+		return ret;
+
+	ret = pl08x_make_LLIs();
+	if (ret)
+		return -ENOMEM;
+
+	pl08x.max_num_llis = 0;
+
+    	spin_lock_init(&pl08x.lock);
+
+	pl08x.base = ioremap(adev->res.start, resource_size(&adev->res));
+	if (!pl08x.base) {
+		ret = -ENOMEM;
+		goto out_release_regions;
+	}
+
+	/* Turn on the PL08x */
+	pl08x_ensure_on();
+
+	/*
+	 * Attach the interrupt handler
+	 */
+	writel(0x000000FF, pl08x.base + PL08X_OS_ICLR_ERR);
+	writel(0x000000FF, pl08x.base + PL08X_OS_ICLR_TC);
+	mb();
+
+	ret = request_irq(adev->irq[0], pl08x_irq, IRQF_DISABLED,
+			  vd->name, &adev->dev);
+	if (ret) {
+		dev_err(&adev->dev, "%s - failed to request "
+			"interrupt %d\n",
+			__func__, adev->irq[0]);
+		goto out_unmap;
+	}
+
+	/* Initialize physical channels */
+	pchans = kmalloc((vd->channels * sizeof(struct pl08x_phy_chan)),
+			GFP_KERNEL);
+	if (!pchans) {
+		dev_err(&adev->dev, "%s - failed to allocate "
+			"physical channel holders\n",
+			__func__);
+		goto out_relirq;
+	}
+
+	for (i = 0; i < vd->channels; i++) {
+		struct pl08x_phy_chan *ch = &pchans[i];
+
+		ch->id = i;
+		ch->serving = NULL;
+		ch->signal = -1;
+		dev_info(&adev->dev,
+			 "physical channel %d is %s\n", i,
+			 pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
+	}
+	pl08x.phy_chans = pchans;
+	spin_lock_init(&pl08x.phy_chan_lock);
+
+	/* BUG IS BELOW HERE */
+
+	/*
+	 * Data exchange
+	 */
+	amba_set_drvdata(adev, &pl08x);
+	pl08x.pd = (struct pl08x_platform_data *)(adev->dev.platform_data);
+
+	/* Set caps */
+	dma_cap_set(DMA_MEMCPY, dmac_memcpy.cap_mask);
+	dma_cap_set(DMA_SLAVE, dmac_slave.cap_mask);
+	dmac_memcpy.dev = &adev->dev;
+	dmac_slave.dev = &adev->dev;
+
+	/* Register memcpy channels */
+	ret = pl08x_dma_init_memcpy_channels(&dmac_memcpy);
+	if (ret <= 0) {
+		dev_warn(&pl08x.adev->dev,
+			 "%s - failed to enumerate memcpy channels - %d\n",
+			 __func__, ret);
+		goto out_freechans;
+	}
+	dmac_memcpy.chancnt = ret;
+
+	/* Register slave channels */
+	ret = pl08x_dma_init_slave_channels(&dmac_slave);
+	if (ret <= 0) {
+		dev_warn(&pl08x.adev->dev,
+			"%s - failed to enumerate slave channels - %d\n",
+				__func__, ret);
+		goto out_freechans;
+	}
+	dmac_slave.chancnt = ret;
+
+	ret = dma_async_device_register(&dmac_memcpy);
+	if (ret) {
+		dev_warn(&pl08x.adev->dev,
+			"%s - failed to register memcpy as an async device - %d\n",
+			__func__, ret);
+		goto out_freechans;
+	}
+
+	ret = dma_async_device_register(&dmac_slave);
+	if (ret) {
+		dev_warn(&pl08x.adev->dev,
+			"%s - failed to register slave as an async device - %d\n",
+			__func__, ret);
+		goto out_unreg_memcpy;
+	}
+
+	dev_info(&pl08x.adev->dev, "ARM(R) %s DMA block initialized @%08x\n",
+		vd->name, adev->res.start);
+	return 0;
+
+out_unreg_memcpy:
+	dma_async_device_unregister(&dmac_memcpy);
+out_freechans:
+	/* FIXME: add proper cleanup function that will free channels lists too */
+out_freephy:
+	kfree(pl08x.phy_chans);
+out_relirq:
+	free_irq(adev->irq[0], &adev->dev);
+out_unmap:
+	iounmap(pl08x.base);
+out_release_regions:
+	amba_release_regions(adev);
+	return ret;
+}
+
+/* PL080 has 8 channels and the PL080 have just 2 */
+static struct vendor_data vendor_pl080 = {
+	.name = "PL080",
+	.channels = 8,
+};
+
+static struct vendor_data vendor_pl081 = {
+	.name = "PL081",
+	.channels = 2,
+};
+
+static struct amba_id pl08x_ids[] = {
+	/* PL080 */
+	{
+		.id	= 0x00041080,
+		.mask	= 0x000fffff,
+		.data	= &vendor_pl080,
+	},
+	/* PL081 */
+	{
+		.id	= 0x00041081,
+		.mask	= 0x000fffff,
+		.data	= &vendor_pl081,
+	},
+	{ 0, 0 },
+};
+
+static struct amba_driver pl08x_amba_driver = {
+	.drv.name	= DRIVER_NAME,
+	.id_table	= pl08x_ids,
+	.probe		= pl08x_probe,
+};
+
+static int __init pl08x_init(void)
+{
+	int retval;
+	retval = amba_driver_register(&pl08x_amba_driver);
+	if (retval)
+		printk(KERN_WARNING
+			"PL08X::pl08x_init() - failed to register as an amba device - %d\n",
+			retval);
+	return retval;
+}
+subsys_initcall(pl08x_init);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
new file mode 100644
index 0000000..077ae56
--- /dev/null
+++ b/include/linux/amba/pl08x.h
@@ -0,0 +1,242 @@
+/*
+ *	linux/amba/pl08x.h - ARM PrimeCell DMA Controller driver
+ *
+ *	Copyright (C) 2005 ARM Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * pl08x information required by platform code
+ *
+ * Please credit ARM.com
+ * Documentation: ARM DDI 0196D
+ *
+ */
+
+#ifndef AMBA_PL08X_H
+#define AMBA_PL08X_H
+
+/* We need sizes of structs from this header */
+#include <linux/dmaengine.h>
+
+/*
+ * PL080 & PL081 both have 16 sets of DMA signals
+ * - they differ in the number of channels which may be in use at once
+ * Also PL080 has a dual bus master, PL081 has a single master
+ */
+#define PL08X_DMA_SIGNALS		(16)
+#define PL08X_BOUNDARY_SHIFT		(10)	/* 1KB 0x400 */
+#define PL08X_BOUNDARY_SIZE		(1 << PL08X_BOUNDARY_SHIFT)
+#define PL08X_CCTL_INTR_YES		(1)
+#define PL08X_CCTL_INTR_NO		(0)
+#define PL08X_CCTL_PROT_CACHE		(4)
+#define PL08X_CCTL_PROT_NON_CACHE	(0)
+#define PL08X_CCTL_PROT_BUFF		(2)
+#define PL08X_CCTL_PROT_UNBUFF		(0)
+#define PL08X_CCTL_PROT_USR		(0)
+#define PL08X_CCTL_PROT_PRI		(1)
+#define PL08X_CCTL_INCR_NO		(0)
+#define PL08X_CCTL_INCR_YES		(1)
+#define PL08X_CCTL_MASTER_1		(0)
+#define PL08X_CCTL_MASTER_2		(1)
+#define PL08X_CCTL_WIDTH_8		(0)
+#define PL08X_CCTL_WIDTH_16		(1)
+#define PL08X_CCTL_WIDTH_32		(2)
+#define PL08X_CCTL_BSIZE_1		(0)
+#define PL08X_CCTL_BSIZE_4		(1)
+#define PL08X_CCTL_BSIZE_8		(2)
+#define PL08X_CCTL_BSIZE_16		(3)
+#define PL08X_CCTL_BSIZE_32		(4)
+#define PL08X_CCTL_BSIZE_64		(5)
+#define PL08X_CCTL_BSIZE_128		(6)
+#define PL08X_CCTL_BSIZE_256		(7)
+/*
+ * Channel transfer flow controls
+ */
+#define PL08X_CCFG_MEM2MEM_DMAC		(0x00 << 11) /* PL08x is in control */
+#define PL08X_CCFG_MEM2PER_DMAC		(0x01 << 11) /* PL08x is in control */
+#define PL08X_CCFG_PER2MEM_DMAC		(0x02 << 11) /* PL08x is in control */
+#define PL08X_CCFG_PER2PER_DMAC		(0x03 << 11) /* PL08x is in control */
+#define PL08X_CCFG_PER2PER_DEST		(0x04 << 11) /* Dest per is in control */
+#define PL08X_CCFG_MEM2PER_PER		(0x05 << 11) /* Per is in control */
+#define PL08X_CCFG_PER2MEM_PER		(0x06 << 11) /* Per is in control */
+#define PL08X_CCFG_PER2PER_SRC		(0x07 << 11) /* Source per is in control */
+/*
+ * Channel transfer channels
+ */
+#define PL08X_CCFG_SRC_CHAN_0		(0 << 1)
+#define PL08X_CCFG_SRC_CHAN_1		(1 << 1)
+#define PL08X_CCFG_SRC_CHAN_2		(2 << 1)
+#define PL08X_CCFG_SRC_CHAN_3		(3 << 1)
+#define PL08X_CCFG_SRC_CHAN_4		(4 << 1)
+#define PL08X_CCFG_SRC_CHAN_5		(5 << 1)
+#define PL08X_CCFG_SRC_CHAN_6		(6 << 1)
+#define PL08X_CCFG_SRC_CHAN_7		(7 << 1)
+#define PL08X_CCFG_SRC_CHAN_8		(8 << 1)
+#define PL08X_CCFG_SRC_CHAN_9		(9 << 1)
+#define PL08X_CCFG_SRC_CHAN_10		(10 << 1)
+#define PL08X_CCFG_SRC_CHAN_11		(11 << 1)
+#define PL08X_CCFG_SRC_CHAN_12		(12 << 1)
+#define PL08X_CCFG_SRC_CHAN_13		(13 << 1)
+#define PL08X_CCFG_SRC_CHAN_15		(15 << 1)
+#define PL08X_CCFG_DST_CHAN_0		(0 << 6)
+#define PL08X_CCFG_DST_CHAN_1		(1 << 6)
+#define PL08X_CCFG_DST_CHAN_2		(2 << 6)
+#define PL08X_CCFG_DST_CHAN_3		(3 << 6)
+#define PL08X_CCFG_DST_CHAN_4		(4 << 6)
+#define PL08X_CCFG_DST_CHAN_5		(5 << 6)
+#define PL08X_CCFG_DST_CHAN_6		(6 << 6)
+#define PL08X_CCFG_DST_CHAN_7		(7 << 6)
+#define PL08X_CCFG_DST_CHAN_8		(8 << 6)
+#define PL08X_CCFG_DST_CHAN_9		(9 << 6)
+#define PL08X_CCFG_DST_CHAN_10		(10 << 6)
+#define PL08X_CCFG_DST_CHAN_11		(11 << 6)
+#define PL08X_CCFG_DST_CHAN_12		(12 << 6)
+#define PL08X_CCFG_DST_CHAN_13		(13 << 6)
+#define PL08X_CCFG_DST_CHAN_14		(14 << 6)
+#define PL08X_CCFG_DST_CHAN_15		(15 << 6)
+
+/**
+ * struct pl08x_channel_data - data structure to pass info between
+ * platform and PL08x driver regarding channel configuration
+ * @bus_id: name of this device channel, not just a device name since
+ * devices may have more than one channel e.g. "foo_tx"
+ * @min_signal: the minimum DMA signal number to be muxed in for this
+ * channel (for platforms supporting muxed signals). If you have
+ * static assignments, make sure this is set to the assigned signal
+ * number, PL08x have 16 possible signals in number 0 thru 15 so
+ * when these are not enough they often get muxed (in hardware)
+ * disabling simultaneous use of the same channel for two devices.
+ * @max_signal: the maximum DMA signal number to be muxed in for
+ * the channel. Set to the same as min_signal for
+ * devices with static assignments
+ * @muxval: a number usually used to poke into some mux regiser to
+ * mux in the signal to this channel
+ * @cctl_opt: default options for the channel control register
+ * @circular_buffer: whether the buffer passed in is circular and
+ * shall simply be looped round round (like a record baby round
+ * round round round)
+ */
+struct pl08x_channel_data {
+	char *bus_id;
+	int min_signal;
+	int max_signal;
+	u32 muxval;
+	unsigned int cctl; /* Turn me into u32? */
+	u32 ccfg;
+	bool circular_buffer;
+};
+
+struct pl08x_bus_data {
+	dma_addr_t addr;		/* Current address */
+	unsigned int maxwidth;		/* Tsfrs may use less i.e. buswidth */
+	unsigned int maxwidth_bits;
+	unsigned int buswidth;
+	/* Bytes required to fill to the next bus memory boundary */
+	unsigned int fill_bytes;
+};
+
+/**
+ * struct pl08x_phy_chan - holder for the physical channels
+ * @id: physical index to this channel
+ * @signal: the physical signal (aka channel) serving this
+ * physical channel right now
+ * @serving: the virtual channel currently being served by this
+ * physical channel
+ */
+struct pl08x_phy_chan {
+	unsigned int id;
+	int signal;
+	struct pl08x_dma_chan *serving;
+	u32 csrc;
+	u32 cdst;
+	u32 clli;
+	u32 cctl;
+	u32 ccfg;
+};
+
+/*
+ * Wrapper for struct dma_async_tx_descriptor
+ */
+struct pl08x_txd {
+	struct dma_async_tx_descriptor tx;
+	enum dma_data_direction	direction;
+	struct pl08x_bus_data  srcbus;
+	struct pl08x_bus_data  dstbus;
+	int len;
+	/* Start of the llis for this transaction - dma address */
+	dma_addr_t	llis_bus;
+	/* Start of the llis for this transaction - kernel address */
+	void		*llis_va;
+	struct list_head node;
+	struct pl08x_channel_data *cd;
+	bool active;
+	/* Settings to be put into the physical channel when we submit this txd */
+	u32 csrc;
+	u32 cdst;
+	u32 clli;
+	u32 cctl;
+};
+
+/**
+ * struct pl08x_dma_chan - this structure wraps a DMA ENGINE channel
+ * @chan: wrappped abstract channel
+ * @phychan: the physical channel utilized by this channel, if there is one
+ * @tasklet: tasklet scheduled by the IRQ to handle actual work etc
+ * @name: name of channel
+ * @cd: channel platform data
+ * @amba_addr: address for RX/TX according to the PrimeCell config
+ * @amba_direction: current direction of this channel according to
+ * @lock: a lock for this channel data
+ * the PrimeCell config
+ */
+struct pl08x_dma_chan {
+	struct dma_chan chan;
+	struct pl08x_phy_chan *phychan;
+	struct tasklet_struct tasklet;
+	char *name;
+	struct pl08x_channel_data *cd;
+	/* AMBA extensions */
+	dma_addr_t		amba_addr;
+	enum dma_data_direction	amba_direction;
+	/* Index of the DMAC channel whose registers we use */
+	unsigned int		chan_id;
+	atomic_t		last_issued;
+	/* Last completed */
+	dma_cookie_t		lc;
+	/* Queued transfers */
+	struct list_head	desc_list;
+	/* Current transaction on channel */
+	struct pl08x_txd	*at;
+	spinlock_t lock;
+};
+
+/**
+ * struct pl08x_platform_data - the platform configuration for the
+ * PL08x PrimeCells.
+ * @slave_channels: the channels defined for the different devices on the
+ * platform, all inclusive, including multiplexed channels. The available
+ * physical channels will be multiplexed around these signals as they
+ * are requested, just enumerate all possible channels.
+ * @get_signal: request a physical signal to be used for a DMA
+ * transfer immediately: if there is some multiplexing or similar blocking
+ * the use of the channel the transfer can be denied by returning
+ * less than zero, else it returns the allocated signal number
+ * @put_signal: indicate to the platform that this physical signal is not
+ * running any DMA transfer and multiplexing can be recycled
+ * @bus_bit_lli: Bit[0] of the address indicated which AHB bus master the
+ * LLI addresses are on 0/1 Master 1/2.
+ */
+struct pl08x_platform_data {
+	struct pl08x_channel_data *slave_channels;
+	unsigned int num_slave_channels;
+	struct pl08x_channel_data memcpy_channel;
+	int (*get_signal)(struct pl08x_dma_chan *);
+	void (*put_signal)(struct pl08x_dma_chan *);
+	unsigned int bus_bit_lli:1;
+};
+
+bool pl08x_filter_id(struct dma_chan *chan, void *chan_id);
+
+#endif	/* AMBA_PL08X_H */
-- 
1.7.0.1

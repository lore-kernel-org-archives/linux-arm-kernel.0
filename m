From: per.forlin@stericsson.com (Per Forlin)
Date: Mon, 6 Dec 2010 13:52:25 +0100
Subject: [PATCH 3/3] ux500: Add DMA support for U5500
In-Reply-To: <1291639945-2866-3-git-send-email-per.forlin@stericsson.com>
References: <1291639945-2866-1-git-send-email-per.forlin@stericsson.com>
	<1291639945-2866-2-git-send-email-per.forlin@stericsson.com>
	<1291639945-2866-3-git-send-email-per.forlin@stericsson.com>
Message-ID: <1291639945-2866-4-git-send-email-per.forlin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Forlin <per.forlin@linaro.org>

Add basic DMA configuration for u5500 supporting memcpy.
Make way for SDI0 dma support by setting SDI0 to -1,
indicating it will be configured in runtime.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 arch/arm/mach-ux500/Makefile                   |    2 +-
 arch/arm/mach-ux500/cpu-db5500.c               |    2 +
 arch/arm/mach-ux500/dma-db5500.c               |  120 ++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/db5500-regs.h |    4 +
 arch/arm/mach-ux500/include/mach/setup.h       |    2 +
 5 files changed, 129 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ux500/dma-db5500.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index fb65e59..9720e42 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y				:= clock.o cpu.o devices.o devices-common.o
-obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o
+obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index bcc0fd4..8816844 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -135,6 +135,8 @@ void __init u5500_map_io(void)
 
 void __init u5500_init_devices(void)
 {
+	db5500_dma_init();
+
 	db5500_add_rtc();
 
 	platform_add_devices(u5500_platform_devs,
diff --git a/arch/arm/mach-ux500/dma-db5500.c b/arch/arm/mach-ux500/dma-db5500.c
new file mode 100644
index 0000000..32a061f
--- /dev/null
+++ b/arch/arm/mach-ux500/dma-db5500.c
@@ -0,0 +1,120 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Per Forlin <per.forlin@stericsson.com> for ST-Ericsson
+ * Author: Jonas Aaberg <jonas.aberg@stericsson.com> for ST-Ericsson
+ * Author: Rabin Vincent <rabinv.vincent@stericsson.com> for ST-Ericsson
+ *
+ * License terms: GNU General Public License (GPL), version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <plat/ste_dma40.h>
+#include <mach/setup.h>
+#include <mach/hardware.h>
+
+#include "ste-dma40-db5500.h"
+
+static struct resource dma40_resources[] = {
+	[0] = {
+		.start = U5500_DMA_BASE,
+		.end   = U5500_DMA_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+		.name  = "base",
+	},
+	[1] = {
+		.start = U5500_DMA_LCPA_BASE,
+		.end   = U5500_DMA_LCPA_BASE + 2 * SZ_1K - 1,
+		.flags = IORESOURCE_MEM,
+		.name  = "lcpa",
+	},
+	[2] = {
+		.start = IRQ_DB5500_DMA,
+		.end   = IRQ_DB5500_DMA,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+/* Default configuration for physical memcpy */
+static struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
+	.mode = STEDMA40_MODE_PHYSICAL,
+	.dir = STEDMA40_MEM_TO_MEM,
+
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.src_info.psize = STEDMA40_PSIZE_PHY_1,
+	.src_info.flow_ctrl = STEDMA40_NO_FLOW_CTRL,
+
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.psize = STEDMA40_PSIZE_PHY_1,
+	.dst_info.flow_ctrl = STEDMA40_NO_FLOW_CTRL,
+};
+
+/* Default configuration for logical memcpy */
+static struct stedma40_chan_cfg dma40_memcpy_conf_log = {
+	.dir = STEDMA40_MEM_TO_MEM,
+
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.src_info.psize = STEDMA40_PSIZE_LOG_1,
+	.src_info.flow_ctrl = STEDMA40_NO_FLOW_CTRL,
+
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.psize = STEDMA40_PSIZE_LOG_1,
+	.dst_info.flow_ctrl = STEDMA40_NO_FLOW_CTRL,
+};
+
+/*
+ * Mapping between soruce event lines and physical device address This was
+ * created assuming that the event line is tied to a device and therefore the
+ * address is constant, however this is not true for at least USB, and the
+ * values are just placeholders for USB.  This table is preserved and used for
+ * now.
+ */
+static const dma_addr_t dma40_rx_map[DB5500_DMA_NR_DEV] = {
+	[DB5500_DMA_DEV24_SDMMC0_RX] = -1,
+};
+
+/* Mapping between destination event lines and physical device address */
+static const dma_addr_t dma40_tx_map[DB5500_DMA_NR_DEV] = {
+	[DB5500_DMA_DEV24_SDMMC0_TX] = -1,
+};
+
+static int dma40_memcpy_event[] = {
+	DB5500_DMA_MEMCPY_TX_1,
+	DB5500_DMA_MEMCPY_TX_2,
+	DB5500_DMA_MEMCPY_TX_3,
+	DB5500_DMA_MEMCPY_TX_4,
+	DB5500_DMA_MEMCPY_TX_5,
+};
+
+static struct stedma40_platform_data dma40_plat_data = {
+	.dev_len		= ARRAY_SIZE(dma40_rx_map),
+	.dev_rx			= dma40_rx_map,
+	.dev_tx			= dma40_tx_map,
+	.memcpy			= dma40_memcpy_event,
+	.memcpy_len		= ARRAY_SIZE(dma40_memcpy_event),
+	.memcpy_conf_phy	= &dma40_memcpy_conf_phy,
+	.memcpy_conf_log	= &dma40_memcpy_conf_log,
+	.disabled_channels	= {-1},
+};
+
+static struct platform_device dma40_device = {
+	.dev = {
+		.platform_data = &dma40_plat_data,
+	},
+	.name		= "dma40",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(dma40_resources),
+	.resource	= dma40_resources
+};
+
+void __init db5500_dma_init(void)
+{
+	int ret;
+
+	ret = platform_device_register(&dma40_device);
+	if (ret)
+		dev_err(&dma40_device.dev, "unable to register device: %d\n", ret);
+
+}
diff --git a/arch/arm/mach-ux500/include/mach/db5500-regs.h b/arch/arm/mach-ux500/include/mach/db5500-regs.h
index 3eafc0e..bd88c1e 100644
--- a/arch/arm/mach-ux500/include/mach/db5500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db5500-regs.h
@@ -114,4 +114,8 @@
 #define U5500_MBOX2_LOCAL_START	(U5500_MBOX_BASE + 0x20)
 #define U5500_MBOX2_LOCAL_END	(U5500_MBOX_BASE + 0x3F)
 
+#define U5500_ESRAM_BASE		0x40000000
+#define U5500_ESRAM_DMA_LCPA_OFFSET	0x10000
+#define U5500_DMA_LCPA_BASE    (U5500_ESRAM_BASE + U5500_ESRAM_DMA_LCPA_OFFSET)
+
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 22788a7..469877e 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -25,6 +25,8 @@ extern void __init ux500_init_irq(void);
 
 extern void __init u5500_sdi_init(void);
 
+extern void __init db5500_dma_init(void);
+
 /* We re-use nomadik_timer for this platform */
 extern void nmdk_timer_init(void);
 
-- 
1.6.3.3

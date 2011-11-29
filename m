From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 29 Nov 2011 15:11:12 +0000
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for RS1 memory map based Versatile Express
motherboard.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi           |  196 +++++++++++++++++++++
 arch/arm/mach-vexpress/Kconfig                    |    8 +
 arch/arm/mach-vexpress/Makefile.boot              |    6 +
 arch/arm/mach-vexpress/include/mach/debug-macro.S |   37 ++++-
 arch/arm/mach-vexpress/include/mach/uncompress.h  |   13 ++-
 arch/arm/mach-vexpress/v2m.c                      |   64 +++++++-
 6 files changed, 318 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
new file mode 100644
index 0000000..a75ebc3
--- /dev/null
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -0,0 +1,196 @@
+/*
+ * ARM Ltd. Versatile Express
+ *
+ * Motherboard Express uATX
+ * V2M-P1
+ *
+ * HBI-0190D
+ *
+ * RS1 memory map ("ARM Cortex-A Series memory map" in the board's
+ * Technical Reference Manual)
+ *
+ * WARNING! The hardware described in this file is independent from the
+ * original variant (vexpress-v2m.dtsi), but there is a strong
+ * correspondence between the two configurations.
+ *
+ * TAKE CARE WHEN MAINTAINING THIS FILE TO PROPAGATE ANY RELEVANT
+ * CHANGES TO vexpress-v2m.dtsi!
+ */
+
+/ {
+	aliases {
+		arm,v2m_timer = &v2m_timer01;
+	};
+
+	motherboard {
+		compatible = "simple-bus";
+		arm,v2m-memory-map = "rs1";
+		#address-cells = <2>; /* SMB chipselect number and offset */
+		#size-cells = <1>;
+		#interrupt-cells = <1>;
+
+		flash at 0,00000000 {
+			compatible = "arm,vexpress-flash", "cfi-flash";
+			reg = <0 0x00000000 0x04000000>,
+			      <4 0x00000000 0x04000000>;
+			bank-width = <4>;
+		};
+
+		psram at 1,00000000 {
+			compatible = "mtd-ram";
+			reg = <1 0x00000000 0x02000000>;
+			bank-width = <4>;
+		};
+
+		ethernet at 2,02000000 {
+			compatible = "smsc,lan9118", "smsc,lan9115";
+			reg = <2 0x02000000 0x10000>;
+			interrupts = <15>;
+			phy-mode = "mii";
+			reg-io-width = <4>;
+			smsc,irq-active-high;
+			smsc,irq-push-pull;
+		};
+
+		usb at 2,03000000 {
+			compatible = "nxp,usb-isp1761";
+			reg = <2 0x03000000 0x20000>;
+			interrupts = <16>;
+			port1-otg;
+		};
+
+		iofpga at 3,00000000 {
+			compatible = "arm,amba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 3 0 0x200000>;
+
+			sysreg at 010000 {
+				compatible = "arm,vexpress-sysreg";
+				reg = <0x010000 0x1000>;
+			};
+
+			sysctl at 020000 {
+				compatible = "arm,sp810", "arm,primecell";
+				reg = <0x020000 0x1000>;
+			};
+
+			/* PCI-E I2C bus */
+			v2m_i2c_pcie: i2c at 030000 {
+				compatible = "arm,versatile-i2c";
+				reg = <0x030000 0x1000>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pcie-switch at 60 {
+					compatible = "idt,89hpes32h8";
+					reg = <0x60>;
+				};
+			};
+
+			aaci at 040000 {
+				compatible = "arm,pl041", "arm,primecell";
+				reg = <0x040000 0x1000>;
+				interrupts = <11>;
+			};
+
+			mmci at 050000 {
+				compatible = "arm,pl180", "arm,primecell";
+				reg = <0x050000 0x1000>;
+				interrupts = <9 10>;
+			};
+
+			kmi at 060000 {
+				compatible = "arm,pl050", "arm,primecell";
+				reg = <0x060000 0x1000>;
+				interrupts = <12>;
+			};
+
+			kmi at 070000 {
+				compatible = "arm,pl050", "arm,primecell";
+				reg = <0x070000 0x1000>;
+				interrupts = <13>;
+			};
+
+			v2m_serial0: uart at 090000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x090000 0x1000>;
+				interrupts = <5>;
+			};
+
+			v2m_serial1: uart at 0a0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0a0000 0x1000>;
+				interrupts = <6>;
+			};
+
+			v2m_serial2: uart at 0b0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0b0000 0x1000>;
+				interrupts = <7>;
+			};
+
+			v2m_serial3: uart at 0c0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0c0000 0x1000>;
+				interrupts = <8>;
+			};
+
+			wdt at 0f0000 {
+				compatible = "arm,sp805", "arm,primecell";
+				reg = <0x0f0000 0x1000>;
+				interrupts = <0>;
+			};
+
+			v2m_timer01: timer at 110000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x110000 0x1000>;
+				interrupts = <2>;
+			};
+
+			v2m_timer23: timer at 120000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x120000 0x1000>;
+			};
+
+			/* DVI I2C bus */
+			v2m_i2c_dvi: i2c at 160000 {
+				compatible = "arm,versatile-i2c";
+				reg = <0x160000 0x1000>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dvi-transmitter at 39 {
+					compatible = "sil,sii9022-tpi", "sil,sii9022";
+					reg = <0x39>;
+				};
+
+				dvi-transmitter at 60 {
+					compatible = "sil,sii9022-cpi", "sil,sii9022";
+					reg = <0x60>;
+				};
+			};
+
+			rtc at 170000 {
+				compatible = "arm,pl031", "arm,primecell";
+				reg = <0x170000 0x1000>;
+				interrupts = <4>;
+			};
+
+			compact-flash at 1a0000 {
+				compatible = "ata-generic";
+				reg = <0x1a0000 0x100
+				       0x1a0100 0xf00>;
+				reg-shift = <2>;
+			};
+
+			clcd at 1f0000 {
+				compatible = "arm,pl111", "arm,primecell";
+				reg = <0x1f0000 0x1000>;
+				interrupts = <14>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 6a6fa22..2180888 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -15,4 +15,12 @@ config ARCH_VEXPRESS_DT
 	help
 	  VE platform *requiring* Flattened Device Tree to boot.
 
+config ARCH_VEXPRESS_RS1
+	bool
+	select AUTO_ZRELADDR
+	select ARM_PATCH_PHYS_VIRT
+	help
+	  RS1 VE memory map (i.a. motherboard peripherals at
+	  0x1c000000, RAM at 0x80000000).
+
 endmenu
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 8630b3d..05b77a5 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -1,3 +1,9 @@
+ifeq ($(CONFIG_ARCH_VEXPRESS_RS1),y)
+   zreladdr-y	+= 0x80008000
+params_phys-y	:= 0x80000100
+initrd_phys-y	:= 0x80800000
+else
    zreladdr-y	+= 0x60008000
 params_phys-y	:= 0x60000100
 initrd_phys-y	:= 0x60800000
+endif
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index fd9e6c7..8010ff9 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -10,12 +10,41 @@
  * published by the Free Software Foundation.
  */
 
-#define DEBUG_LL_UART_OFFSET	0x00009000
+#define DEBUG_LL_PHYS_BASE		0x10000000
+#define DEBUG_LL_UART_OFFSET		0x00009000
+
+#define DEBUG_LL_PHYS_BASE_RS1		0x1c000000
+#define DEBUG_LL_UART_OFFSET_RS1	0x00090000
+
+#define DEBUG_LL_VIRT_BASE		0xf8000000
 
 		.macro	addruart,rp,rv,tmp
-		mov	\rp, #DEBUG_LL_UART_OFFSET
-		orr	\rv, \rp, #0xf8000000	@ virtual base
-		orr	\rp, \rp, #0x10000000	@ physical base
+
+		@ Check the MMU state
+#if defined(CONFIG_MMU)
+		mrc	p15, 0, \tmp, c1, c0	@ SCTRL
+		tst	\tmp, #1		@ MMU enabled?
+		moveq	\tmp, #DEBUG_LL_PHYS_BASE
+		movne	\tmp, #DEBUG_LL_VIRT_BASE
+#else
+		mov	\tmp, #DEBUG_LL_PHYS_BASE
+#endif
+
+		@ PL011 present in "original" place?
+		orr	\tmp, \tmp, #DEBUG_LL_UART_OFFSET
+		ldr	\tmp, [\tmp, #0xfe0]	@ PeriphID0
+		teq	\tmp, #0x11		@ PL011
+
+		@ Original memory map
+		moveq	\rp, #DEBUG_LL_UART_OFFSET
+		orreq	\rv, \rp, #DEBUG_LL_VIRT_BASE
+		orreq	\rp, \rp, #DEBUG_LL_PHYS_BASE
+
+		@ RS1 memory map
+		movne	\rp, #DEBUG_LL_UART_OFFSET_RS1
+		orrne	\rv, \rp, #DEBUG_LL_VIRT_BASE
+		orrne	\rp, \rp, #DEBUG_LL_PHYS_BASE_RS1
+
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index 7972c57..c491565 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -22,7 +22,18 @@
 #define AMBA_UART_CR(base)	(*(volatile unsigned char *)((base) + 0x30))
 #define AMBA_UART_FR(base)	(*(volatile unsigned char *)((base) + 0x18))
 
-#define get_uart_base()	(0x10000000 + 0x00009000)
+#define AMBA_PERIPH_ID0(base)	(*(volatile unsigned char *)((base) + 0xfe0))
+
+#define UART_BASE	0x10009000
+#define UART_BASE_RS1	0x1c090000
+
+static unsigned long get_uart_base(void)
+{
+	if (AMBA_PERIPH_ID0(UART_BASE) == 0x11)
+		return UART_BASE;
+	else
+		return UART_BASE_RS1;
+}
 
 /*
  * This does not append a newline
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index a8ea95a..6965f64 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -507,9 +507,38 @@ struct sys_timer v2m_dt_timer = {
 	.init	= v2m_dt_timer_init,
 };
 
+static struct map_desc v2m_rs1_io_desc[] __initdata = {
+	{
+		.virtual	= V2M_PERIPH,
+		.pfn		= __phys_to_pfn(0x1c000000),
+		.length		= SZ_2M,
+		.type		= MT_DEVICE,
+	},
+};
+
+static int __init v2m_dt_scan_memory_map(unsigned long node, const char *uname,
+		int depth, void *data)
+{
+	const char **map = data;
+
+	if (strcmp(uname, "motherboard") != 0)
+		return 0;
+
+	*map = of_get_flat_dt_prop(node, "arm,v2m-memory-map", NULL);
+
+	return 1;
+}
+
 void __init v2m_dt_map_io(void)
 {
-	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
+	const char *map = NULL;
+
+	of_scan_flat_dt(v2m_dt_scan_memory_map, &map);
+
+	if (map && strcmp(map, "rs1") == 0)
+		iotable_init(v2m_rs1_io_desc, ARRAY_SIZE(v2m_rs1_io_desc));
+	else
+		iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
 }
 
 static struct clk_lookup v2m_dt_lookups[] = {
@@ -552,6 +581,35 @@ static struct clk_lookup v2m_dt_lookups[] = {
 		.dev_id		= "1001f000.clcd",
 		.clk		= &osc1_clk,
 	},
+	/* RS1 memory map */
+	{	/* PL180 MMCI */
+		.dev_id		= "mb:mmci", /* 1c050000.mmci */
+		.clk		= &osc2_clk,
+	}, {	/* PL050 KMI0 */
+		.dev_id		= "1c060000.kmi",
+		.clk		= &osc2_clk,
+	}, {	/* PL050 KMI1 */
+		.dev_id		= "1c070000.kmi",
+		.clk		= &osc2_clk,
+	}, {	/* PL011 UART0 */
+		.dev_id		= "1c090000.uart",
+		.clk		= &osc2_clk,
+	}, {	/* PL011 UART1 */
+		.dev_id		= "1c0a0000.uart",
+		.clk		= &osc2_clk,
+	}, {	/* PL011 UART2 */
+		.dev_id		= "1c0b0000.uart",
+		.clk		= &osc2_clk,
+	}, {	/* PL011 UART3 */
+		.dev_id		= "1c0c0000.uart",
+		.clk		= &osc2_clk,
+	}, {	/* SP805 WDT */
+		.dev_id		= "1c0f0000.wdt",
+		.clk		= &v2m_ref_clk,
+	}, {	/* PL111 CLCD */
+		.dev_id		= "1c1f0000.clcd",
+		.clk		= &osc1_clk,
+	},
 };
 
 void __init v2m_dt_init_early(void)
@@ -590,6 +648,10 @@ static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash",
 			&v2m_flash_data),
 	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
+	/* RS1 memory map */
+	OF_DEV_AUXDATA("arm,vexpress-flash", 0x08000000, "physmap-flash",
+			&v2m_flash_data),
+	OF_DEV_AUXDATA("arm,primecell", 0x1c050000, "mb:mmci", &v2m_mmci_data),
 	{}
 };
 
-- 
1.6.3.3

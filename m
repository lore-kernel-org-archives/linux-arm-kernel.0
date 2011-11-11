From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 11 Nov 2011 18:27:05 +0000
Subject: [PATCH 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1321036026-23411-5-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for RS1 memory map based Versatile Express
motherboard. As the RAM location has changed, the ZRE values and
PLAT_PHYS_OFFSET defaults are changed to the new address (all
future tiles will use RS1 map) and enforces AUTO_ZRELADD and
ARM_PATCH_PHYS_VIRT when legacy devices are being used.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi           |  190 +++++++++++++++++++++
 arch/arm/mach-vexpress/Kconfig                    |    9 +
 arch/arm/mach-vexpress/Makefile.boot              |    6 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S |   37 ++++-
 arch/arm/mach-vexpress/include/mach/uncompress.h  |   13 ++-
 arch/arm/mach-vexpress/v2m.c                      |   46 +++++
 6 files changed, 293 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
new file mode 100644
index 0000000..6f9a822
--- /dev/null
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -0,0 +1,190 @@
+/*
+ * ARM Ltd. Versatile Express
+ *
+ * Motherboard Express uATX
+ * V2M-P1
+ *
+ * HBI-0190D
+ *
+ * RS1 memory map (a.k.a. ARM Cortex-A Series memory map)
+ *
+ * WARNING! The hardware described in this file is independent from the
+ * legacy variant (vexpress-v2m-legacy.dtsi), but there is a strong
+ * correspondence between the two configurations.
+ *
+ * TAKE CARE WHEN MAINTAINING THIS FILE TO PROPAGATE ANY RELEVANT
+ * CHANGES TO vexpress-v2m-legacy.dtsi!
+ */
+
+/ {
+	motherboard {
+		compatible = "simple-bus";
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
+			mb_i2c_pcie: i2c at 030000 {
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
+			mb_serial0: uart at 090000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x090000 0x1000>;
+				interrupts = <5>;
+			};
+
+			mb_serial1: uart at 0a0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0a0000 0x1000>;
+				interrupts = <6>;
+			};
+
+			mb_serial2: uart at 0b0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0b0000 0x1000>;
+				interrupts = <7>;
+			};
+
+			mb_serial3: uart at 0c0000 {
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
+			mb_timer01: timer at 110000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x110000 0x1000>;
+				interrupts = <2>;
+			};
+
+			mb_timer23: timer at 120000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x120000 0x1000>;
+			};
+
+			/* DVI I2C bus */
+			mb_i2c_dvi: i2c at 160000 {
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
index 4c11e90..d1b0f35 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,6 +1,14 @@
 menu "Versatile Express platform type"
 	depends on ARCH_VEXPRESS
 
+config ARCH_VEXPRESS_LEGACY
+	bool
+	select AUTO_ZRELADDR
+	select ARM_PATCH_PHYS_VIRT
+
+config ARCH_VEXPRESS_RS1
+	bool
+
 config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 	select CPU_V7
@@ -8,6 +16,7 @@ config ARCH_VEXPRESS_CA9X4
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
+	select ARCH_VEXPRESS_LEGACY
 
 config ARCH_VEXPRESS_DT
 	bool
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 8630b3d..3278615 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	+= 0x60008000
-params_phys-y	:= 0x60000100
-initrd_phys-y	:= 0x60800000
+   zreladdr-y	+= 0x80008000
+params_phys-y	:= 0x80000100
+initrd_phys-y	:= 0x80800000
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index fd9e6c7..adc94ce 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -10,12 +10,41 @@
  * published by the Free Software Foundation.
  */
 
-#define DEBUG_LL_UART_OFFSET	0x00009000
+#define VEXPRESS_PHYS_BASE_LEGACY	0x10000000
+#define VEXPRESS_UART_OFFSET_LEGACY	0x00009000
+
+#define VEXPRESS_PHYS_BASE_RS1		0x1c000000
+#define VEXPRESS_UART_OFFSET_RS1	0x00090000
+
+#define VEXPRESS_VIRT_BASE		0xf8000000
 
 		.macro	addruart,rp,rv,tmp
-		mov	\rp, #DEBUG_LL_UART_OFFSET
-		orr	\rv, \rp, #0xf8000000	@ virtual base
-		orr	\rp, \rp, #0x10000000	@ physical base
+
+		@ Check the MMU state
+#if defined(CONFIG_MMU)
+		mrc	p15, 0, \tmp, c1, c0	@ SCTRL
+		tst	\tmp, #1		@ MMU enabled?
+		moveq	\tmp, #VEXPRESS_PHYS_BASE_LEGACY
+		movne	\tmp, #VEXPRESS_VIRT_BASE
+#else
+		mov	\tmp, #VEXPRESS_PHYS_BASE_LEGACY
+#endif
+
+		@ PL011 present in "legacy place"?
+		orr	\tmp, \tmp, #VEXPRESS_UART_OFFSET_LEGACY
+		ldr	\tmp, [\tmp, #0xfe0]	@ PeriphID0
+		teq	\tmp, #0x11		@ PL011
+
+		@ Legacy memory map
+		moveq	\rp, #VEXPRESS_UART_OFFSET_LEGACY
+		orreq	\rv, \rp, #VEXPRESS_VIRT_BASE
+		orreq	\rp, \rp, #VEXPRESS_PHYS_BASE_LEGACY
+
+		@ RS1 memory map
+		movne	\rp, #VEXPRESS_UART_OFFSET_RS1
+		orrne	\rv, \rp, #VEXPRESS_VIRT_BASE
+		orrne	\rp, \rp, #VEXPRESS_PHYS_BASE_RS1
+
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index 7972c57..0ac6ba5 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -22,7 +22,18 @@
 #define AMBA_UART_CR(base)	(*(volatile unsigned char *)((base) + 0x30))
 #define AMBA_UART_FR(base)	(*(volatile unsigned char *)((base) + 0x18))
 
-#define get_uart_base()	(0x10000000 + 0x00009000)
+#define AMBA_PERIPH_ID0(base)	(*(volatile unsigned char *)((base) + 0xfe0))
+
+#define UART_BASE_LEGACY	0x10009000
+#define UART_BASE_RS1		0x1c090000
+
+static unsigned long get_uart_base(void)
+{
+	if (AMBA_PERIPH_ID0(UART_BASE_LEGACY) == 0x11)
+		return UART_BASE_LEGACY;
+	else
+		return UART_BASE_RS1;
+}
 
 /*
  * This does not append a newline
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 9ad772d..d96bde1 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -513,8 +513,21 @@ MACHINE_END
 
 #if defined(CONFIG_ARCH_VEXPRESS_DT)
 
+static struct map_desc v2m_rs1_io_desc[] __initdata = {
+	{
+		.virtual	= V2M_PERIPH,
+		.pfn		= __phys_to_pfn(0x1c000000),
+		.length		= SZ_2M,
+		.type		= MT_DEVICE,
+	},
+};
+
 void __init v2m_dt_map_io(void)
 {
+	if (of_flat_dt_is_compatible(of_get_flat_dt_root(),
+			"arm,vexpress-legacy"))
+		iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
+	else
 		iotable_init(v2m_rs1_io_desc, ARRAY_SIZE(v2m_rs1_io_desc));
 }
 
@@ -560,6 +573,35 @@ static struct clk_lookup v2m_dt_lookups[] = {
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
@@ -601,6 +643,10 @@ static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
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

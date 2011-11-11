From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 11 Nov 2011 18:27:04 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides hooks for DT-based tile machine implementations
and adds Device Tree description for the motherboard.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/devicetree/bindings/arm/vexpress    |   92 ++++++++++
 arch/arm/boot/dts/vexpress-v2m-legacy.dtsi        |  190 +++++++++++++++++++++
 arch/arm/mach-vexpress/Kconfig                    |    4 +
 arch/arm/mach-vexpress/core.h                     |    9 +
 arch/arm/mach-vexpress/include/mach/motherboard.h |    8 +
 arch/arm/mach-vexpress/v2m.c                      |  140 +++++++++++++++-
 6 files changed, 442 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-legacy.dtsi

diff --git a/Documentation/devicetree/bindings/arm/vexpress b/Documentation/devicetree/bindings/arm/vexpress
new file mode 100644
index 0000000..7bf4602
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vexpress
@@ -0,0 +1,92 @@
+ARM Versatile Express boards family
+-----------------------------------
+
+ARM's Versatile Express platform consists of a motherboard
+and one or more daughterboards (tiles). The motherboard provides
+set of peripherals. Processor and RAM "live" on the tiles.
+Both parts of the system should be described in two separate
+Device Tree source files, with the tile's description including
+motherboard's file. As the motherboard can be work in one of two
+possible configuration ("legacy" and "RS1"), care must be taken
+to include the correct one.
+
+Required properties in the root node:
+- compatible value:
+  - for motherboard in "legacy" mode:
+	compatible = "arm,vexpress-<model>", "arm,vexpress-legacy", "arm-vexpress";
+  - for motherboard in "RS1" mode:
+	compatible = "arm,vexpress-<model>", "arm-vexpress";
+  where <model> is the the model, eg:
+  - for Coretile Express A5x2 (V2P-CA5s):
+	compatible = "arm,vexpress-v2p-ca5s", "arm-vexpress";
+  - Coretile Express A9x4 (V2P-CA9):
+	comaptible = "arm,vexpress-v2p-ca9", "arm,vexpress-legacy", "arm-vexpress";
+
+Current Linux implementation requires a "timer" alias pointing
+at a SP804 timer block to be used when tile is not using local
+timer source.
+
+Optional properties in the root node:
+- tile model name (use the same names as in the tile's Technical
+  Reference Manuals, eg. "V2P-CA5s")
+	model = "<model>";
+- tile's HBI number (unique ARM's board model ID, visible on the
+  PCB's silkscreen) in hexadecimal transcription:
+	arm,hbi = <0xhbi>
+  eg:
+  - for Coretile Express A5x2 (V2P-CA5s) HBI-0191:
+	arm,hbi = <0x191>;
+  - Coretile Express A9x4 (V2P-CA9) HBI-0225:
+	arm,hbi = <0x225>;
+
+Motherboard .dtsi files provide set of phandles to peripherals that
+can be used in the tile's aliases node:
+- UARTs:
+	mb_serial0, mb_serial1, mb_serial2 and mb_serial3
+- I2C controllers:
+	mb_i2c_dvi and mb_i2c_pcie
+- SP804 timers:
+	mb_timer01 and mb_timer23
+
+The motherboard description file provides single "motherboard" node
+using 2 address cells corresponding to the Static Memory Bus used
+between the motherboard and the tile. First cell defines Chip Select
+(CS) line number, the second cell address offset within the CS.
+All interrupts lines between the motherboard and the tile are active
+high and are described using single cell.
+
+The tile description must define "ranges", "interrupt-map-mask" and
+"interrupt-map" properties to translate the motherboard's address
+and interrupt space into one used by the tile's processor.
+
+Abbreviated example:
+
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "V2P-CA5s";
+	arm,hbi = <0x225>;
+	compatible = "arm,vexpress-v2p-ca5s", "arm,vexpress";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &mb_serial0;
+		timer = &mb_timer01;
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a9-gic";
+	};
+
+	motherboard {
+		/* CS0 is visible at 0x08000000 */
+		ranges = <0 0 0x08000000 0x04000000>;
+		interrupt-map-mask = <0 0 63>;
+		/* Active high IRQ 0 is connected to GIC's SPI0 */
+		interrupt-map = <0 0  0 &gic 0  0 4>;
+	};
+}
+
+/include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi b/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
new file mode 100644
index 0000000..50905a6
--- /dev/null
+++ b/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
@@ -0,0 +1,190 @@
+/*
+ * ARM Ltd. Versatile Express
+ *
+ * Motherboard Express uATX
+ * V2M-P1
+ *
+ * HBI-0190D
+ *
+ * Legacy memory map
+ *
+ * WARNING! The hardware described in this file is independent from the
+ * RS1 variant (vexpress-v2m-rs1.dtsi), but there is a strong
+ * correspondence between the two configurations.
+ *
+ * TAKE CARE WHEN MAINTAINING THIS FILE TO PROPAGATE ANY RELEVANT
+ * CHANGES TO vexpress-v2m-rs1.dtsi!
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
+			      <1 0x00000000 0x04000000>;
+			bank-width = <4>;
+		};
+
+		psram at 2,00000000 {
+			compatible = "mtd-ram";
+			reg = <2 0x00000000 0x02000000>;
+			bank-width = <4>;
+		};
+
+		ethernet at 3,02000000 {
+			compatible = "smsc,lan9118", "smsc,lan9115";
+			reg = <3 0x02000000 0x10000>;
+			interrupts = <15>;
+			phy-mode = "mii";
+			reg-io-width = <4>;
+			smsc,irq-active-high;
+			smsc,irq-push-pull;
+		};
+
+		usb at 3,03000000 {
+			compatible = "nxp,usb-isp1761";
+			reg = <3 0x03000000 0x20000>;
+			interrupts = <16>;
+			port1-otg;
+		};
+
+		iofpga at 7,00000000 {
+			compatible = "arm,amba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 7 0 0x20000>;
+
+			sysreg at 00000 {
+				compatible = "arm,vexpress-sysreg";
+				reg = <0x00000 0x1000>;
+			};
+
+			sysctl at 01000 {
+				compatible = "arm,sp810", "arm,primecell";
+				reg = <0x01000 0x1000>;
+			};
+
+			/* PCI-E I2C bus */
+			mb_i2c_pcie: i2c at 02000 {
+				compatible = "arm,versatile-i2c";
+				reg = <0x02000 0x1000>;
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
+			aaci at 04000 {
+				compatible = "arm,pl041", "arm,primecell";
+				reg = <0x04000 0x1000>;
+				interrupts = <11>;
+			};
+
+			mmci at 05000 {
+				compatible = "arm,pl180", "arm,primecell";
+				reg = <0x05000 0x1000>;
+				interrupts = <9 10>;
+			};
+
+			kmi at 06000 {
+				compatible = "arm,pl050", "arm,primecell";
+				reg = <0x06000 0x1000>;
+				interrupts = <12>;
+			};
+
+			kmi at 07000 {
+				compatible = "arm,pl050", "arm,primecell";
+				reg = <0x07000 0x1000>;
+				interrupts = <13>;
+			};
+
+			mb_serial0: uart at 09000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x09000 0x1000>;
+				interrupts = <5>;
+			};
+
+			mb_serial1: uart at 0a000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0a000 0x1000>;
+				interrupts = <6>;
+			};
+
+			mb_serial2: uart at 0b000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0b000 0x1000>;
+				interrupts = <7>;
+			};
+
+			mb_serial3: uart at 0c000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0c000 0x1000>;
+				interrupts = <8>;
+			};
+
+			wdt at 0f000 {
+				compatible = "arm,sp805", "arm,primecell";
+				reg = <0x0f000 0x1000>;
+				interrupts = <0>;
+			};
+
+			mb_timer01: timer at 11000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x11000 0x1000>;
+				interrupts = <2>;
+			};
+
+			mb_timer23: timer at 12000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x12000 0x1000>;
+			};
+
+			/* DVI I2C bus */
+			mb_i2c_dvi: i2c at 16000 {
+				compatible = "arm,versatile-i2c";
+				reg = <0x16000 0x1000>;
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
+			rtc at 17000 {
+				compatible = "arm,pl031", "arm,primecell";
+				reg = <0x17000 0x1000>;
+				interrupts = <4>;
+			};
+
+			compact-flash at 1a000 {
+				compatible = "ata-generic";
+				reg = <0x1a000 0x100
+				       0x1a100 0xf00>;
+				reg-shift = <2>;
+			};
+
+			clcd at 1f000 {
+				compatible = "arm,pl111", "arm,primecell";
+				reg = <0x1f000 0x1000>;
+				interrupts = <14>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 9311484..4c11e90 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -9,4 +9,8 @@ config ARCH_VEXPRESS_CA9X4
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
 
+config ARCH_VEXPRESS_DT
+	bool
+	select OF
+
 endmenu
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index 2139b37..e5eaba6 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -29,3 +29,12 @@ extern void (*vexpress_init_cpu_map)(void);
 extern void (*vexpress_smp_enable)(unsigned int);
 #endif
 
+#if defined(CONFIG_ARCH_VEXPRESS_DT)
+
+extern struct sys_timer v2m_timer;
+
+void __init v2m_dt_map_io(void);
+void __init v2m_dt_init_early(void);
+struct of_dev_auxdata * __init v2m_dt_get_auxdata(void);
+
+#endif
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index 848353b..37b56ed 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -116,6 +116,14 @@ int v2m_cfg_read(u32 devfn, u32 *data);
 void v2m_flags_set(u32 data);
 
 /*
+ * Miscellaneous
+ */
+#define SYS_MISC_MASTERSITE     (1 << 14)
+#define SYS_PROCIDx_HBI_MASK	0xfff
+
+
+
+/*
  * Core tile IDs
  */
 #define V2M_CT_ID_CA9		0x0c000191
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index b84fa45..9ad772d 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -6,6 +6,10 @@
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/smsc911x.h>
@@ -17,6 +21,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/sizes.h>
+#include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -31,6 +36,7 @@
 
 #include "core.h"
 
+/* Legacy memory map values for non-DT code */
 #define V2M_PA_CS0	0x40000000
 #define V2M_PA_CS1	0x44000000
 #define V2M_PA_CS2	0x48000000
@@ -57,11 +63,33 @@ static void __init v2m_timer_init(void)
 	unsigned int timer01_irq;
 	u32 scctrl;
 
+	if (of_have_populated_dt()) {
+#if defined(CONFIG_ARCH_VEXPRESS_DT)
+		int err;
+		const char *path;
+		struct device_node *node;
+
+		node = of_find_compatible_node(NULL, NULL, "arm,sp810");
+		BUG_ON(!node);
+		sysctl_base = of_iomap(node, 0);
+		BUG_ON(!sysctl_base);
+
+		err = of_property_read_string(of_aliases, "timer", &path);
+		BUG_ON(err);
+		node = of_find_node_by_path(path);
+		BUG_ON(!node);
+		timer01_base = of_iomap(node, 0);
+		BUG_ON(!timer01_base);
+		timer01_irq = irq_of_parse_and_map(node, 0);
+#endif
+	} else {
 		sysctl_base = ioremap(V2M_SYSCTL, SZ_4K);
 		BUG_ON(!sysctl_base);
 		timer01_base = ioremap(V2M_TIMER01, SZ_4K);
 		BUG_ON(!timer01_base);
 		timer01_irq = IRQ_V2M_TIMER0;
+	}
+
 	/* Select 1MHz TIMCLK as the reference clock for SP804 timers */
 	scctrl = readl(sysctl_base + SCCTRL);
 	scctrl |= SCCTRL_TIMEREN0SEL_TIMCLK;
@@ -76,7 +104,8 @@ static void __init v2m_timer_init(void)
 			"v2m-timer0");
 }
 
-static struct sys_timer v2m_timer = {
+/* Used by DT-powered core tiles */
+struct sys_timer v2m_timer = {
 	.init	= v2m_timer_init,
 };
 
@@ -383,11 +412,18 @@ static struct clk_lookup v2m_lookups[] = {
 	},
 };
 
+static void __init v2m_system_id(void)
+{
+	if (!system_rev)
+		system_rev = readl(v2m_sysreg_base + V2M_SYS_ID);
+}
+
 static void __init v2m_init_early(void)
 {
 	ct_desc->init_early();
 	clkdev_add_table(v2m_lookups, ARRAY_SIZE(v2m_lookups));
 	versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
+	v2m_system_id();
 }
 
 static void v2m_power_off(void)
@@ -472,3 +508,105 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.timer		= &v2m_timer,
 	.init_machine	= v2m_init,
 MACHINE_END
+
+
+
+#if defined(CONFIG_ARCH_VEXPRESS_DT)
+
+void __init v2m_dt_map_io(void)
+{
+		iotable_init(v2m_rs1_io_desc, ARRAY_SIZE(v2m_rs1_io_desc));
+}
+
+static struct clk_lookup v2m_dt_lookups[] = {
+	{	/* AMBA bus clock */
+		.con_id		= "apb_pclk",
+		.clk		= &dummy_apb_pclk,
+	}, {	/* SP804 timers */
+		.dev_id		= "sp804",
+		.con_id		= "v2m-timer0",
+		.clk		= &v2m_sp804_clk,
+	}, {	/* SP804 timers */
+		.dev_id		= "sp804",
+		.con_id		= "v2m-timer1",
+		.clk		= &v2m_sp804_clk,
+	},
+	/* Legacy memory map */
+	{	/* PL180 MMCI */
+		.dev_id		= "mb:mmci", /* 10005000.mmci */
+		.clk		= &osc2_clk,
+	}, {	/* PL050 KMI0 */
+		.dev_id		= "10006000.kmi",
+		.clk		= &osc2_clk,
+	}, {	/* PL050 KMI1 */
+		.dev_id		= "10007000.kmi",
+		.clk		= &osc2_clk,
+	}, {	/* PL011 UART0 */
+		.dev_id		= "10009000.uart",
+		.clk		= &osc2_clk,
+	}, {	/* PL011 UART1 */
+		.dev_id		= "1000a000.uart",
+		.clk		= &osc2_clk,
+	}, {	/* PL011 UART2 */
+		.dev_id		= "1000b000.uart",
+		.clk		= &osc2_clk,
+	}, {	/* PL011 UART3 */
+		.dev_id		= "1000c000.uart",
+		.clk		= &osc2_clk,
+	}, {	/* SP805 WDT */
+		.dev_id		= "1000f000.wdt",
+		.clk		= &v2m_ref_clk,
+	}, {	/* PL111 CLCD */
+		.dev_id		= "1001f000.clcd",
+		.clk		= &osc1_clk,
+	},
+};
+
+void __init v2m_dt_init_early(void)
+{
+	struct device_node *node;
+	const __be32 *reg;
+	u32 dt_hbi;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,vexpress-sysreg");
+	BUG_ON(!node);
+	/* The following will become of_iomap() when possible */
+	reg = of_get_property(node, "reg", NULL);
+	BUG_ON(!reg);
+	v2m_sysreg_base = V2M_PERIPH_P2V(be32_to_cpup(reg));
+
+	/* Confirm board type against DT property, if available */
+	if (of_property_read_u32(allnodes, "arm,hbi", &dt_hbi) == 0) {
+		u32 misc = readl(v2m_sysreg_base + V2M_SYS_MISC);
+		u32 id = readl(v2m_sysreg_base + (misc & SYS_MISC_MASTERSITE ?
+				V2M_SYS_PROCID1 : V2M_SYS_PROCID0));
+		u32 hbi = id & SYS_PROCIDx_HBI_MASK;
+
+		if (WARN_ON(dt_hbi != hbi))
+			pr_warning("vexpress: DT HBI (%x) is not matching "
+					"hardware (%x)!\n", dt_hbi, hbi);
+	}
+
+	clkdev_add_table(v2m_dt_lookups, ARRAY_SIZE(v2m_dt_lookups));
+	versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
+
+	pm_power_off = v2m_power_off;
+	arm_pm_restart = v2m_restart;
+
+	v2m_system_id();
+}
+
+static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
+	/* Legacy memory map */
+	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash",
+			&v2m_flash_data),
+	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
+	{}
+};
+
+struct of_dev_auxdata * __init v2m_dt_get_auxdata(void)
+{
+	return v2m_dt_auxdata_lookup;
+}
+
+#endif
-- 
1.6.3.3

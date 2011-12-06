From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  6 Dec 2011 15:43:46 +0000
Subject: [PATCH v4 3/6] ARM: vexpress: Add DT support for the motherboard
In-Reply-To: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
References: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1323186229-22054-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides hooks for DT-based tile machine implementations
and adds Flattened Device Tree description for the motherboard.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/devicetree/bindings/arm/vexpress.txt |  118 ++++++++++++
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  195 ++++++++++++++++++++
 arch/arm/mach-vexpress/Kconfig                     |   12 ++
 arch/arm/mach-vexpress/Makefile.boot               |    2 +
 arch/arm/mach-vexpress/core.h                      |   10 +
 arch/arm/mach-vexpress/include/mach/motherboard.h  |    6 +
 arch/arm/mach-vexpress/v2m.c                       |  129 +++++++++++++-
 7 files changed, 470 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress.txt
 create mode 100644 arch/arm/boot/dts/vexpress-v2m.dtsi

diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documentation/devicetree/bindings/arm/vexpress.txt
new file mode 100644
index 0000000..d82c36e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vexpress.txt
@@ -0,0 +1,118 @@
+ARM Versatile Express boards family
+-----------------------------------
+
+ARM's Versatile Express platform consists of a motherboard and one
+or more daughterboards (tiles). The motherboard provides a set of
+peripherals. Processor and RAM "live" on the tiles.
+
+The motherboard and each core tile should be described by a separate
+Device Tree source file, with the tile's description including
+the motherboard file using a /include/ directive. As the motherboard
+can be initialized in one of two different configurations ("memory
+maps"), care must be taken to include the correct one.
+
+Required properties in the root node:
+- compatible value:
+	compatible = "arm,vexpress-<model>", "arm,vexpress-<processor>";
+  where:
+  - <processor> is type of the tile's processor, one of:
+	- "arm,vexpress-cortex_a5" for Cortex-A5 based tile,
+	- "arm,vexpress-cortex_a7" for Cortex-A7 based tile,
+	- "arm,vexpress-cortex_a9" for Cortex-A9 based tile,
+	- "arm,vexpress-cortex_a15" for Cortex-A15 based tile.
+  - <model> is the full tile model name (as used in the tile's
+    Technical Reference Manual), eg.:
+    - for Coretile Express A5x2 (V2P-CA5s):
+	compatible = "arm,vexpress-v2p-ca5s", "arm,vexpress-cortex_a5";
+    - Coretile Express A9x4 (V2P-CA9):
+	compatible = "arm,vexpress-v2p-ca9", "arm,vexpress-cortex_a9";
+    - Coretile Express A15x2 (V2P-CA15):
+	compatible = "arm,vexpress-v2p-ca15", "arm,vexpress-cortex_a15";
+
+Current Linux implementation relies on the processor type value.
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
+The motherboard description file provides a single "motherboard" node
+using 2 address cells corresponding to the Static Memory Bus used
+between the motherboard and the tile. The first cell defines the Chip
+Select (CS) line number, the second cell address offset within the CS.
+All interrupt lines between the motherboard and the tile are active
+high and are described using single cell.
+
+Optional properties of the "motherboard" node:
+- motherboard's memory map variant:
+	arm,v2m-memory-map = "<name>";
+  where name is one of:
+  - "rs1" - for RS1 map (i.a. peripherals on CS3); this map is also
+            referred to as "ARM Cortex-A Series memory map":
+	arm,v2m-memory-map = "rs1";
+  When this property is missing, the motherboard is using the original
+  memory map (also known as the "Legacy memory map", primarily used
+  with the original CoreTile Express A9x4) with peripherals on CS7.
+
+Motherboard .dtsi files provide a set of labelled peripherals that
+can be used to obtain required phandle in the tile's "aliases" node:
+- UARTs, note that the numbers correspond to the physical connectors
+  on the motherboard's back panel:
+	v2m_serial0, v2m_serial1, v2m_serial2 and v2m_serial3
+- I2C controllers:
+	v2m_i2c_dvi and v2m_i2c_pcie
+- SP804 timers:
+	v2m_timer01 and v2m_timer23
+
+Current Linux implementation requires a "arm,v2m_timer" alias
+pointing at one of the motherboard's SP804 timers, if it is to be
+used as the system timer. This alias should be defined in the
+motherboard files.
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
+	compatible = "arm,vexpress-v2p-ca5s";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &v2m_serial0;
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x2c001000 0x1000>,
+		      <0x2c000100 0x100>;
+	};
+
+	motherboard {
+		/* CS0 is visible at 0x08000000 */
+		ranges = <0 0 0x08000000 0x04000000>;
+		interrupt-map-mask = <0 0 63>;
+		/* Active high IRQ 0 is connected to GIC's SPI0 */
+		interrupt-map = <0 0 0 &gic 0 0 4>;
+	};
+};
+
+/include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
new file mode 100644
index 0000000..7bc29e9
--- /dev/null
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -0,0 +1,195 @@
+/*
+ * ARM Ltd. Versatile Express
+ *
+ * Motherboard Express uATX
+ * V2M-P1
+ *
+ * HBI-0190D
+ *
+ * Original memory map ("Legacy memory map" in the board's
+ * Technical Reference Manual)
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
+	aliases {
+		arm,v2m_timer = &v2m_timer01;
+	};
+
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
+			v2m_i2c_pcie: i2c at 02000 {
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
+			v2m_serial0: uart at 09000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x09000 0x1000>;
+				interrupts = <5>;
+			};
+
+			v2m_serial1: uart at 0a000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0a000 0x1000>;
+				interrupts = <6>;
+			};
+
+			v2m_serial2: uart at 0b000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0b000 0x1000>;
+				interrupts = <7>;
+			};
+
+			v2m_serial3: uart at 0c000 {
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
+			v2m_timer01: timer at 11000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x11000 0x1000>;
+				interrupts = <2>;
+			};
+
+			v2m_timer23: timer at 12000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x12000 0x1000>;
+			};
+
+			/* DVI I2C bus */
+			v2m_i2c_dvi: i2c at 16000 {
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
+				compatible = "arm,vexpress-cf", "ata-generic";
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
index 9311484..56a61fb 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -9,4 +9,16 @@ config ARCH_VEXPRESS_CA9X4
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
 
+config ARCH_VEXPRESS_DT
+	bool "Device Tree support for Versatile Express platforms"
+	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR
+	select USE_OF
+	help
+	  New Versatile Express platforms require Flattened Device Tree to
+	  be passed to the kernel.
+
+	  If your bootloader supports Flattened Device Tree based booting,
+	  say Y here.
+
 endmenu
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 8630b3d..c6dd891 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -1,3 +1,5 @@
+# Those numbers are used only by the non-DT V2P-CA9 platform
+# The DT-enabled ones require CONFIG_AUTO_ZRELADDR=y
    zreladdr-y	+= 0x60008000
 params_phys-y	:= 0x60000100
 initrd_phys-y	:= 0x60800000
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index 75a640a..01eb8d0 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -20,3 +20,13 @@ struct amba_device name##_device = {		\
 
 /* Tile's peripherals static mappings should start here */
 #define V2T_PERIPH ((void __iomem *)0xf8200000)
+
+#if defined(CONFIG_ARCH_VEXPRESS_DT)
+
+extern struct sys_timer v2m_dt_timer;
+
+void __init v2m_dt_map_io(void);
+void __init v2m_dt_init_early(void);
+struct of_dev_auxdata * __init v2m_dt_get_auxdata(void);
+
+#endif
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index b4c498c..31a9289 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -117,6 +117,12 @@ int v2m_cfg_read(u32 devfn, u32 *data);
 void v2m_flags_set(u32 data);
 
 /*
+ * Miscellaneous
+ */
+#define SYS_MISC_MASTERSITE	(1 << 14)
+#define SYS_PROCIDx_HBI_MASK	0xfff
+
+/*
  * Core tile IDs
  */
 #define V2M_CT_ID_CA9		0x0c000191
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 05b4f46..8101b54 100644
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
@@ -429,8 +433,9 @@ static void __init v2m_populate_ct_desc(void)
 			ct_desc = ct_descs[i];
 
 	if (!ct_desc)
-		panic("vexpress: failed to populate core tile description "
-		      "for tile ID 0x%8x\n", current_tile_id);
+		panic("vexpress: this kernel does not support core tile ID 0x%08x when booting via ATAGs.\n"
+		      "You may need a device tree blob or a different kernel to boot on this board.\n",
+		      current_tile_id);
 }
 
 static void __init v2m_map_io(void)
@@ -474,3 +479,123 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.timer		= &v2m_timer,
 	.init_machine	= v2m_init,
 MACHINE_END
+
+/*
+ * Notice that machine descriptions for the Device Tree "powered" tiles
+ * (DT_MACHINE_START macros) live in the corresponding dt-*.c files.
+ */
+
+#if defined(CONFIG_ARCH_VEXPRESS_DT)
+
+static void __init v2m_dt_timer_init(void)
+{
+	struct device_node *node;
+	const char *path;
+	int err;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,sp810");
+	v2m_sysctl_init(of_iomap(node, 0));
+
+	err = of_property_read_string(of_aliases, "arm,v2m_timer", &path);
+	if (WARN_ON(err))
+		return;
+	node = of_find_node_by_path(path);
+	v2m_sp804_init(of_iomap(node, 0), irq_of_parse_and_map(node, 0));
+}
+
+struct sys_timer v2m_dt_timer = {
+	.init	= v2m_dt_timer_init,
+};
+
+void __init v2m_dt_map_io(void)
+{
+	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
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
+	}, {	/* PL180 MMCI */
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
+	reg = of_get_property(node, "reg", NULL);
+	if (WARN_ON(!reg))
+		return;
+
+	v2m_sysreg_base = V2M_PERIPH + be32_to_cpup(reg);
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
+}
+
+static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
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

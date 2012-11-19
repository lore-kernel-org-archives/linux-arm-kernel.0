From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon, 19 Nov 2012 17:27:31 +0100
Subject: [PATCH] arm: orion5x: convert Netgear WNR854T to device tree
Message-ID: <1353342451-27180-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit converts the Netgear WNR854T to device tree

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/arm/boot/dts/Makefile                    |    3 +-
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts |   83 +++++++++++++++++++++++++
 arch/arm/mach-orion5x/Kconfig                 |    7 +-
 arch/arm/mach-orion5x/Makefile                |    2 +-
 arch/arm/mach-orion5x/board-dt.c              |    3 +
 arch/arm/mach-orion5x/common.h                |    5 ++
 arch/arm/mach-orion5x/wnr854t-setup.c         |   59 +-----------------
 7 files changed, 99 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6cb3b3c..a6c8e9a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -73,7 +73,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap5-evm.dtb \
 	am335x-evm.dtb \
 	am335x-bone.dtb
-dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
+dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb \
+	orion5x-netgear-wnr854t.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
diff --git a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
new file mode 100644
index 0000000..502ac49
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2012 Imre Kaloz <kaloz@openwrt.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "orion5x.dtsi"
+
+/ {
+	model = "Netgear WNR854T";
+	compatible = "netgear,wnr854t", "marvell-orion5x-88f5180n", "marvell,orion5x";
+
+	memory {
+		reg = <0x00000000 0x2000000>; /* 32 MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		serial at 12000 {
+			clock-frequency = <166666667>;
+			status = "okay";
+		};
+	};
+
+	nor_flash at f4000000 {
+		compatible = "cfi-flash";
+		bank-width = <2>;
+		reg = <0xf4000000 0x800000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "kernel";
+			reg = <0x0 0x100000>;
+			};
+
+		partition at 100000 {
+			label = "rootfs";
+			reg = <0x100000 0x660000>;
+			};
+
+		partition at 760000 {
+			label = "uboot_env";
+			reg = <0x760000 0x10000>;
+			};
+
+		partition at 770000 {
+			label = "uboot";
+			reg = <0x770000 0x90000>;
+			};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "reset";
+			linux,code = <198>;
+			gpios = <&gpio0 1 0>;
+		};
+	};
+
+	gpio_leds {
+		compatible = "gpio-leds";
+
+		power {
+			label = "power:green";
+			gpios = <&gpio0 0 1>;
+		};
+
+		wan {
+			label = "wan:amber";
+			gpios = <&gpio0 3 0>;
+		};
+	};
+};
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 2cb2f06..2c2dc79 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -138,11 +138,12 @@ config MACH_MSS2
 	  Say 'Y' here if you want your kernel to support the
 	  Maxtor Shared Storage II platform.
 
-config MACH_WNR854T
-	bool "Netgear WNR854T"
+config MACH_WNR854T_DT
+	bool "Netgear WNR854T (Flattened Device Tree)"
+	select ARCH_ORION5X_DT
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Netgear WNR854T platform.
+	  Netgear WNR854T platform (Flattened Device Tree).
 
 config MACH_RD88F5181L_GE
 	bool "Marvell Orion-VoIP GE Reference Design"
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index 9e809a7..391cacc 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_MACH_D2NET)	+= d2net-setup.o
 obj-$(CONFIG_MACH_BIGDISK)	+= d2net-setup.o
 obj-$(CONFIG_MACH_NET2BIG)	+= net2big-setup.o
 obj-$(CONFIG_MACH_MSS2)		+= mss2-setup.o
-obj-$(CONFIG_MACH_WNR854T)	+= wnr854t-setup.o
 obj-$(CONFIG_MACH_RD88F5181L_GE)	+= rd88f5181l-ge-setup.o
 obj-$(CONFIG_MACH_RD88F5181L_FXO)	+= rd88f5181l-fxo-setup.o
 obj-$(CONFIG_MACH_RD88F6183AP_GE)	+= rd88f6183ap-ge-setup.o
@@ -24,3 +23,4 @@ obj-$(CONFIG_MACH_LINKSTATION_LSCHL)	+= ls-chl-setup.o
 
 obj-$(CONFIG_ARCH_ORION5X_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_EDMINI_V2_DT)	+= edmini_v2-setup.o
+obj-$(CONFIG_MACH_WNR854T_DT)	+= wnr854t-setup.o
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 32e5c21..70fd830 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -58,6 +58,9 @@ static void __init orion5x_dt_init(void)
 	if (of_machine_is_compatible("lacie,ethernet-disk-mini-v2"))
 		edmini_v2_init();
 
+	if (of_machine_is_compatible("netgear,wnr854t"))
+		wnr854t_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     orion5x_auxdata_lookup, NULL);
 }
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index 7db5cdd..e24e716 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -62,6 +62,11 @@ void edmini_v2_init(void);
 #else
 static inline void edmini_v2_init(void) {};
 #endif
+#ifdef CONFIG_MACH_WNR854T_DT
+void wnr854t_init(void);
+#else
+static inline void wnr854t_init(void) {};
+#endif
 
 struct meminfo;
 struct tag;
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 754c12b..2009a6d 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -53,44 +53,6 @@ static unsigned int wnr854t_mpp_modes[] __initdata = {
 #define WNR854T_NOR_BOOT_BASE	0xf4000000
 #define WNR854T_NOR_BOOT_SIZE	SZ_8M
 
-static struct mtd_partition wnr854t_nor_flash_partitions[] = {
-	{
-		.name		= "kernel",
-		.offset		= 0x00000000,
-		.size		= 0x00100000,
-	}, {
-		.name		= "rootfs",
-		.offset		= 0x00100000,
-		.size		= 0x00660000,
-	}, {
-		.name		= "uboot",
-		.offset		= 0x00760000,
-		.size		= 0x00040000,
-	},
-};
-
-static struct physmap_flash_data wnr854t_nor_flash_data = {
-	.width		= 2,
-	.parts		= wnr854t_nor_flash_partitions,
-	.nr_parts	= ARRAY_SIZE(wnr854t_nor_flash_partitions),
-};
-
-static struct resource wnr854t_nor_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= WNR854T_NOR_BOOT_BASE,
-	.end		= WNR854T_NOR_BOOT_BASE + WNR854T_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device wnr854t_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &wnr854t_nor_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &wnr854t_nor_flash_resource,
-};
-
 static struct mv643xx_eth_platform_data wnr854t_eth_data = {
 	.phy_addr	= MV643XX_ETH_PHY_NONE,
 	.speed		= SPEED_1000,
@@ -111,13 +73,8 @@ static struct dsa_platform_data wnr854t_switch_plat_data = {
 	.chip		= &wnr854t_switch_chip_data,
 };
 
-static void __init wnr854t_init(void)
+void __init wnr854t_init(void)
 {
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
 	orion5x_mpp_conf(wnr854t_mpp_modes);
 
 	/*
@@ -125,11 +82,9 @@ static void __init wnr854t_init(void)
 	 */
 	orion5x_eth_init(&wnr854t_eth_data);
 	orion5x_eth_switch_init(&wnr854t_switch_plat_data, NO_IRQ);
-	orion5x_uart0_init();
 
 	orion5x_setup_dev_boot_win(WNR854T_NOR_BOOT_BASE,
 				   WNR854T_NOR_BOOT_SIZE);
-	platform_device_register(&wnr854t_nor_flash);
 }
 
 static int __init wnr854t_pci_map_irq(const struct pci_dev *dev, u8 slot,
@@ -168,15 +123,3 @@ static int __init wnr854t_pci_init(void)
 	return 0;
 }
 subsys_initcall(wnr854t_pci_init);
-
-MACHINE_START(WNR854T, "Netgear WNR854T")
-	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
-	.atag_offset	= 0x100,
-	.init_machine	= wnr854t_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.timer		= &orion5x_timer,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
-- 
1.7.1

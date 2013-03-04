From: pavel@denx.de (Pavel Machek)
Date: Mon, 4 Mar 2013 21:43:35 +0100
Subject: socfpga ethernet/MMC support for 3.8
Message-ID: <20130304204335.GA27437@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Below are changes that get MMC/ethernet working for me. Probably not
everything is strictly neccessary, I'll try to prune them some more.

Strange thing is that enh_desc.c (disabling checksumming AFAICT) seems
to be neccessary for NFS to work.

In the meantime... does it make sense to split simple changes and
submit them upstream?

arch/arm/boot/dts/Makefile -- dtb files should be build, this can be
probably considered bugfix.

socfpga.c: socfpga_cyclone5_restart() -- this is self-contained reset
function marked with "TODO".

(patches are originally from Altera).
Signed-off-by: Pavel Machek <pavel@denx.de>
(but not for merge for now).

Thanks,
								Pavel

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5ebb44f..d675c986 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -124,6 +124,9 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	sh73a0-kzm9g.dtb \
 	sh7372-mackerel.dtb
+dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb\
+	socfpga_ice.dtb\
+	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
 	spear1340-evb.dtb
 dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 19aec42..c59ca7d 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -23,8 +23,13 @@
 
 	aliases {
 		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 		serial0 = &uart0;
 		serial1 = &uart1;
+		timer0 = &timer0;
+		timer1 = &timer1;
+		timer2 = &timer2;
+		timer3 = &timer3;
 	};
 
 	cpus {
@@ -61,6 +66,21 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		agpio0: gpio at 0xc0000000 {
+			compatible = "altr,pio-1.0";
+			/* Register base 0xff200000 is for a light-weight bridge */
+			reg = <0xff200000 0x10>;
+			width = <32>;
+			/* There are 64 interrupts from the FPGA start at 72, so 45 has to be wrong */
+			interrupts = <0 45 4>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			level_trigger = <0>;
+		};
+
+
 		amba {
 			compatible = "arm,amba-bus";
 			#address-cells = <1>;
@@ -74,13 +94,62 @@
 			};
 		};
 
-		gmac0: stmmac at ff700000 {
+		clkmgr at ffd04000 {
+				compatible = "altr,clk-mgr";
+				reg = <0xffd04000 0x1000>;
+			};
+
+
+		gmac0: ethernet at ff700000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
 			reg = <0xff700000 0x2000>;
 			interrupts = <0 115 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-			phy-mode = "gmii";
+		};
+
+		gmac1: ethernet at ff702000 {
+			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
+			reg = <0xff702000 0x2000>;
+			interrupts = <0 120 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
+		};
+
+		gpio0: gpio at ff708000 {
+			compatible = "snps,dw-gpio";
+			reg = <0xff708000 0x1000>;
+			interrupts = <0 164 4>;
+			width = <29>;
+			virtual_irq_start = <257>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio1: gpio at ff709000 {
+			compatible = "snps,dw-gpio";
+			reg = <0xff709000 0x1000>;
+			interrupts = <0 165 4>;
+			width = <29>;
+			virtual_irq_start = <286>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio2: gpio at ff70a000 {
+			compatible = "snps,dw-gpio";
+			reg = <0xff70a000 0x1000>;
+			interrupts = <0 166 4>;
+			width = <27>;
+			virtual_irq_start = <315>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
 		};
 
 		L2: l2-cache at fffef000 {
@@ -89,6 +158,83 @@
 			interrupts = <0 38 0x04>;
 			cache-unified;
 			cache-level = <2>;
+			arm,tag-latency = <1 1 1>;
+			arm,data-latency = <2 1 1>;
+		};
+
+		mmc: dwmmc0 at ff704000 {
+			compatible = "snps,dw-mshc";
+			reg = <0xff704000 0x1000>;
+			interrupts = <0 139 4>;
+			bus-hz = <12500000>; /*12.5 MHz*/
+			#address-cells = <1>;
+			#size-cells = <0>;
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			fifo-depth = <0x400>;
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+			};
+		};
+
+		nand: nand at ff900000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "denali,denali-nand-dt";
+			reg = <0xff900000 0x100000>, <0xffb80000 0x10000>;
+			reg-names = "nand_data", "denali_reg";
+			interrupts = <0 144 4>;
+			dma-mask = <0xffffffff>;
+			};
+
+		rstmgr at ffd05000 {
+			compatible = "altr,rst-mgr";
+			reg = <0xffd05000 0x1000>;
+		};
+
+		spi0: spi at fff00000 {
+			compatible = "snps,dw-spi-mmio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xfff00000 0x1000>;
+			interrupts = <0 154 4>;
+			num-chipselect = <4>;
+			bus-num = <0>;
+			tx-dma-channel = <&pdma 16>;
+			rx-dma-channel = <&pdma 17>;
+
+			spidev at 0 {
+				compatible = "spidev";
+				reg = <0>;	/* chip select */
+				spi-max-frequency = <100000000>;
+				enable-dma = <1>;
+			};
+		};
+
+		spi1: spi at fff01000 {
+			compatible = "snps,dw-spi-mmio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xfff01000 0x1000>;
+			interrupts = <0 156 4>;
+			num-chipselect = <4>;
+			bus-num = <1>;
+			tx-dma-channel = <&pdma 20>;
+			rx-dma-channel = <&pdma 21>;
+
+			spidev at 0 {
+				compatible = "spidev";
+				reg = <0>;
+				spi-max-frequency = <100000000>;
+				enable-dma = <1>;
+			};
+		};
+		
+		sysmgr at ffd08000 {
+			compatible = "altr,sys-mgr";
+			reg = <0xffd08000 0x4000>;
 		};
 
 		/* Local timer */
@@ -98,60 +244,44 @@
 			interrupts = <1 13 0xf04>;
 		};
 
-		timer0: timer at ffc08000 {
+		timer0: timer0 at ffc08000 {
 			compatible = "snps,dw-apb-timer-sp";
 			interrupts = <0 167 4>;
-			clock-frequency = <200000000>;
 			reg = <0xffc08000 0x1000>;
 		};
 
-		timer1: timer at ffc09000 {
+		timer1: timer1 at ffc09000 {
 			compatible = "snps,dw-apb-timer-sp";
 			interrupts = <0 168 4>;
-			clock-frequency = <200000000>;
 			reg = <0xffc09000 0x1000>;
 		};
 
-		timer2: timer at ffd00000 {
+		timer2: timer2 at ffd00000 {
 			compatible = "snps,dw-apb-timer-osc";
 			interrupts = <0 169 4>;
-			clock-frequency = <200000000>;
 			reg = <0xffd00000 0x1000>;
 		};
 
-		timer3: timer at ffd01000 {
+		timer3: timer3 at ffd01000 {
 			compatible = "snps,dw-apb-timer-osc";
 			interrupts = <0 170 4>;
-			clock-frequency = <200000000>;
 			reg = <0xffd01000 0x1000>;
 		};
 
-		uart0: uart at ffc02000 {
+		uart0: serial0 at ffc02000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02000 0x1000>;
-			clock-frequency = <7372800>;
 			interrupts = <0 162 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 		};
 
-		uart1: uart at ffc03000 {
+		uart1: serial1 at ffc03000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc03000 0x1000>;
-			clock-frequency = <7372800>;
 			interrupts = <0 163 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 		};
-
-		rstmgr at ffd05000 {
-				compatible = "altr,rst-mgr";
-				reg = <0xffd05000 0x1000>;
-			};
-
-		sysmgr at ffd08000 {
-				compatible = "altr,sys-mgr";
-				reg = <0xffd08000 0x4000>;
-			};
 	};
 };
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index ab7e4a9..d29addc 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -26,9 +26,169 @@
 		bootargs = "console=ttyS0,57600";
 	};
 
-	memory {
-		name = "memory";
-		device_type = "memory";
-		reg = <0x0 0x10000000>; /* 256MB */
+	aliases {
+		/* this allow the ethaddr uboot environmnet variable contents
+		 * to be added to the gmac1 device tree blob.
+		 */
+		ethernet0 = &gmac1;
+	};
+
+	soc {
+		ethernet at ff700000 {
+			status = "disabled";
+		};
+
+		ethernet at ff702000 {
+			phy-mode = "rgmii";
+			phy-addr = <0xffffffff>; /* probe for phy addr */
+		};
+
+		qspi: spi at ff705000 {
+				compatible = "cadence,qspi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0xff705000 0x1000>,
+					<0xffa00000 0x1000>;
+				interrupts = <0 151 4>;
+				master-ref-clk = <400000000>;
+				ext-decoder = <0>;  /* external decoder */
+				num-chipselect = <4>;
+				fifo-depth = <128>;
+				bus-num = <2>;
+
+				flash0: n25q128 at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "n25q128";
+					reg = <0>;	/* chip select */
+					spi-max-frequency = <100000000>;
+					page-size = <256>;
+					block-size = <16>; /* 2^16, 64KB */
+					quad = <1>;	   /* 1-support quad */
+					tshsl-ns = <200>;
+					tsd2d-ns = <255>;
+					tchsh-ns = <20>;
+					tslch-ns = <20>;
+
+					partition at 0 {
+						/* 8MB for raw data. */
+						label = "Flash 0 Raw Data";
+						reg = <0x0 0x800000>;
+					};
+					partition at 800000 {
+						/* 8MB for jffs2 data. */
+						label = "Flash 0 jffs2 Filesystem";
+						reg = <0x800000 0x800000>;
+					};
+				};
+
+				flash1: n25q128 at 1 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "n25q128";
+					reg = <1>;	/* chip select */
+					spi-max-frequency = <100000000>;
+					page-size = <256>;
+					block-size = <16>; /* 2^16, 64KB */
+					quad = <1>;
+					tshsl-ns = <200>;
+					tsd2d-ns = <255>;
+					tchsh-ns = <20>;
+					tslch-ns = <20>;
+
+					partition at 0 {
+						/* 16MB for user data. */
+						label = "Flash 1 User Data";
+						reg = <0x0 0x1000000>;
+					};
+				};
+			};
+
+		timer0 at ffc08000 {
+			clock-frequency = <100000000>;
+		};
+
+		timer1 at ffc09000 {
+			clock-frequency = <100000000>;
+		};
+
+		timer2 at ffd00000 {
+			clock-frequency = <25000000>;
+		};
+
+		timer3 at ffd01000 {
+			clock-frequency = <25000000>;
+		};
+
+		serial0 at ffc02000 {
+			clock-frequency = <100000000>;
+		};
+
+		serial1 at ffc03000 {
+			clock-frequency = <100000000>;
+		};
+
+		i2c0: i2c at ffc04000 {
+			speed-mode = <0>;
+		};
+
+		leds {
+			compatible = "gpio-leds";
+			fpga0 {
+				label = "fpga_led0";
+				gpios = <&agpio0 0 1>;
+			};
+
+			fpga1 {
+				label = "fpga_led1";
+				gpios = <&agpio0 1 1>;
+			};
+
+			fpga2 {
+				label = "fpga_led2";
+				gpios = <&agpio0 2 1>;
+			};
+
+			fpga3 {
+				label = "fpga_led3";
+				gpios = <&agpio0 3 1>;
+			};
+
+			hps0 {
+				label = "hps_led0";
+				gpios = <&gpio1 15 1>;
+			};
+
+			hps1 {
+				label = "hps_led1";
+				gpios = <&gpio1 14 1>;
+			};
+
+			hps2 {
+				label = "hps_led2";
+				gpios = <&gpio1 13 1>;
+			};
+
+			hps3 {
+				label = "hps_led3";
+				gpios = <&gpio1 12 1>;
+			};
+		};
+	};
+};
+
+&i2c0 {
+	lcd: lcd at 28 {
+		compatible = "newhaven,nhd-0216k3z-nsw-bbw";
+		reg = <0x28>;
+		height = <2>;
+		width = <16>;
+		brightness = <8>;
+	};
+
+	eeprom at 51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
 	};
 };
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 9941caa..e297307 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -24,11 +24,34 @@ extern void secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
 extern void socfpga_init_clocks(void);
-extern void socfpga_sysmgr_init(void);
+//extern void socfpga_sysmgr_init(void);
 
 extern struct smp_operations socfpga_smp_ops;
 extern char secondary_trampoline, secondary_trampoline_end;
 
 #define SOCFPGA_SCU_VIRT_BASE   0xfffec000
 
+
+#define SOCFPGA_RSTMGR_CTRL	0x04
+#define SOCFPGA_RSTMGR_MODPERRST	0x14
+#define SOCFPGA_RSTMGR_BRGMODRST	0x1c
+
+/* System Manager bits */
+#define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
+#define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
+/*MPU Module Reset Register */
+ #define RSTMGR_MPUMODRST_CPU0	0x1	/*CPU0 Reset*/
+ #define RSTMGR_MPUMODRST_CPU1	0x2	/*CPU1 Reset*/
+ #define RSTMGR_MPUMODRST_WDS		0x4	/*Watchdog Reset*/
+ #define RSTMGR_MPUMODRST_SCUPER	0x8	/*SCU and periphs reset*/
+ #define RSTMGR_MPUMODRST_L2		0x10	/*L2 Cache reset*/
+
+#define SYSMGR_EMACGRP_CTRL_OFFSET 0x60
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII 0x0
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII 0x1
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII 0x2
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_WIDTH 2
+
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_MASK 0x00000003
+
 #endif
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 6732924..4d41642 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -17,12 +17,19 @@
 #include <linux/dw_apb_timer.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/of_net.h>
+#include <linux/stmmac.h>
+#include <linux/phy.h>
+#include <linux/micrel_phy.h>
+
 
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/smp_twd.h>
 
 #include "core.h"
 
@@ -30,6 +37,29 @@ void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
 
+static int socfpga_phy_reset_mii(struct mii_bus *bus, int phyaddr);
+static int stmmac_plat_init(struct platform_device *pdev);
+
+static struct stmmac_mdio_bus_data stmmacenet_mdio_bus_data = {
+	.phy_reset_mii = socfpga_phy_reset_mii,
+};
+
+static struct plat_stmmacenet_data stmmacenet0_data = {
+	.mdio_bus_data = &stmmacenet_mdio_bus_data,
+	.init = &stmmac_plat_init,
+};
+
+static struct plat_stmmacenet_data stmmacenet1_data = {
+	.mdio_bus_data = &stmmacenet_mdio_bus_data,
+	.init = &stmmac_plat_init,
+};
+
+static const struct of_dev_auxdata socfpga_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("snps,dwmac-3.70a", 0xff700000, NULL, &stmmacenet0_data),
+	OF_DEV_AUXDATA("snps,dwmac-3.70a", 0xff702000, NULL, &stmmacenet1_data),
+	{ /* sentinel */ }
+};
+ 
 static struct map_desc scu_io_desc __initdata = {
 	.virtual	= SOCFPGA_SCU_VIRT_BASE,
 	.pfn		= 0, /* run-time */
@@ -55,19 +85,126 @@ static void __init socfpga_scu_map_io(void)
 	iotable_init(&scu_io_desc, 1);
 }
 
-static void __init socfpga_map_io(void)
+static void __init enable_periphs(void)
 {
-	socfpga_scu_map_io();
-	iotable_init(&uart_io_desc, 1);
-	early_printk("Early printk initialized\n");
+	/* Release all peripherals from reset.*/
+	__raw_writel(0, rst_manager_base_addr + SOCFPGA_RSTMGR_MODPERRST);
+
+	/* Release all FPGA bridges from reset.*/
+	__raw_writel(0, rst_manager_base_addr + SOCFPGA_RSTMGR_BRGMODRST);
 }
 
-const static struct of_device_id irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{}
-};
+static int stmmac_mdio_write_null(struct mii_bus *bus, int phyaddr, int phyreg,
+			     u16 phydata)
+{
+	return 0;
+}
+
+#define MICREL_KSZ9021_EXTREG_CTRL 11
+#define MICREL_KSZ9021_EXTREG_DATA_WRITE 12
+#define MICREL_KSZ9021_RGMII_CLK_CTRL_PAD_SCEW 260
+#define MICREL_KSZ9021_RGMII_RX_DATA_PAD_SCEW 261
 
-void __init socfpga_sysmgr_init(void)
+static int stmmac_emdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
+			     u16 phydata)
+{
+	int ret = (bus->write)(bus, phyaddr,
+		MICREL_KSZ9021_EXTREG_CTRL, 0x8000|phyreg);
+	if (ret) {
+		pr_warn("stmmac_emdio_write write1 failed %d\n", ret);
+		return ret;
+	}
+
+	ret = (bus->write)(bus, phyaddr,
+		MICREL_KSZ9021_EXTREG_DATA_WRITE, phydata);
+	if (ret) {
+		pr_warn("stmmac_emdio_write write2 failed %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int socfpga_phy_reset_mii(struct mii_bus *bus, int phyaddr)
+{
+	struct phy_device *phydev;
+
+	if (of_machine_is_compatible("altr,socfpga-vt"))
+		return 0;
+
+	phydev = bus->phy_map[phyaddr];
+
+	if (NULL == phydev) {
+		pr_err("%s no phydev found\n", __func__);
+		return -EINVAL;
+	}
+
+	if (PHY_ID_KSZ9021RLRN != phydev->phy_id) {
+		pr_err("%s unexpected PHY ID %08x\n", __func__, phydev->phy_id);
+		return -EINVAL;
+	}
+
+	pr_info("%s writing extended registers to phyaddr %d\n",
+		__func__, phyaddr);
+
+	/* add 2 ns of RXC PAD Skew and 2.6 ns of TXC PAD Skew */
+	stmmac_emdio_write(bus, phyaddr,
+		MICREL_KSZ9021_RGMII_CLK_CTRL_PAD_SCEW, 0xa0d0);
+
+	/* set no PAD skew for data */
+	stmmac_emdio_write(bus, phyaddr,
+		MICREL_KSZ9021_RGMII_RX_DATA_PAD_SCEW, 0x0000);
+
+	bus->write = &stmmac_mdio_write_null;
+	return 0;
+}
+
+static int stmmac_plat_init(struct platform_device *pdev)
+{
+	u32 ctrl, val, shift;
+	int phymode;
+
+	if (of_machine_is_compatible("altr,socfpga-vt"))
+		return 0;
+
+	phymode = of_get_phy_mode(pdev->dev.of_node);
+
+	switch (phymode) {
+	case PHY_INTERFACE_MODE_RGMII:
+		val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII;
+		break;
+	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_GMII:
+		val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;
+		break;
+	default:
+		pr_err("%s bad phy mode %d", __func__, phymode);
+		return -EINVAL;
+	}
+
+	if (&stmmacenet1_data == pdev->dev.platform_data)
+		shift = SYSMGR_EMACGRP_CTRL_PHYSEL_WIDTH;
+	else if (&stmmacenet0_data == pdev->dev.platform_data)
+		shift = 0;
+	else {
+		pr_err("%s unexpected platform data pointer\n", __func__);
+		return -EINVAL;
+	}
+
+	ctrl =  __raw_readl(sys_manager_base_addr +
+		SYSMGR_EMACGRP_CTRL_OFFSET);
+
+	ctrl &= ~(SYSMGR_EMACGRP_CTRL_PHYSEL_MASK << shift);
+
+	ctrl |= (val << shift);
+
+	__raw_writel(ctrl, (sys_manager_base_addr +
+		SYSMGR_EMACGRP_CTRL_OFFSET));
+
+	return 0;
+}
+
+static void __init socfpga_sysmgr_init(void)
 {
 	struct device_node *np;
 
@@ -78,27 +215,58 @@ void __init socfpga_sysmgr_init(void)
 	rst_manager_base_addr = of_iomap(np, 0);
 }
 
+static void __init socfpga_map_io(void)
+{
+	socfpga_scu_map_io();
+	iotable_init(&uart_io_desc, 1);
+	early_printk("Early printk initialized\n");
+}
+
+const static struct of_device_id irq_match[] = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{}
+};
+
 static void __init gic_init_irq(void)
 {
 	of_irq_init(irq_match);
 	socfpga_sysmgr_init();
+	socfpga_init_clocks();
+	twd_local_timer_of_register();
 }
 
 static void socfpga_cyclone5_restart(char mode, const char *cmd)
 {
-	/* TODO: */
+	u32 temp;
+
+	temp = __raw_readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
+
+	if (mode == 'h')
+		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
+	else
+		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
+	__raw_writel(temp, rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 }
 
 static void __init socfpga_cyclone5_init(void)
 {
-	l2x0_of_init(0, ~0UL);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	socfpga_init_clocks();
+#ifdef CONFIG_CACHE_L2X0
+	u32 aux_ctrl = 0;
+	aux_ctrl |= (1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
+			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT);
+	l2x0_of_init(aux_ctrl, ~0UL);
+#endif
+	of_platform_populate(NULL, of_default_bus_match_table,
+		socfpga_auxdata_lookup, NULL);
+
+	enable_periphs();
 }
 
 static const char *altera_dt_match[] = {
 	"altr,socfpga",
 	"altr,socfpga-cyclone5",
+	"altr,socfpga-vt",
+	"altr,socfpga-ice",
 	NULL
 };
 
diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 2c855a6..30c76c4 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -17,6 +17,11 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+static DEFINE_SPINLOCK(_lock);
 
 #define SOCFPGA_OSC1_CLK	10000000
 #define SOCFPGA_MPU_CLK		800000000
@@ -24,28 +29,124 @@
 #define SOCFPGA_MAIN_NAND_SDMMC_CLK	250000000
 #define SOCFPGA_S2F_USR_CLK		125000000
 
+#define SOCFPGA_MAIN_PLL_CLK		1200000000
+#define SOCFPGA_PER_PLL_CLK		900000000
+#define SOCFPGA_SDRAM_PLL_CLK		800000000
+
+#define CLKMGR_PERPLLGRP_EN	0xA0
+
+#define CLKMGR_QSPI_CLK_EN				11
+#define CLKMGR_NAND_CLK_EN				10
+#define CLKMGR_NAND_X_CLK_EN			9
+#define CLKMGR_SDMMC_CLK_EN			8
+#define CLKMGR_S2FUSR_CLK_EN			7
+#define CLKMGR_GPIO_CLK_EN				6
+#define CLKMGR_CAN1_CLK_EN				5
+#define CLKMGR_CAN0_CLK_EN				4
+#define CLKMGR_SPI_M_CLK_EN			3
+#define CLKMGR_USB_MP_CLK_EN			2
+#define CLKMGR_EMAC1_CLK_EN			1
+#define CLKMGR_EMAC0_CLK_EN			0
+
+void __iomem *clk_mgr_base_addr;
+
 void __init socfpga_init_clocks(void)
 {
 	struct clk *clk;
+	struct device_node *np;
 
-	clk = clk_register_fixed_rate(NULL, "osc1_clk", NULL, CLK_IS_ROOT, SOCFPGA_OSC1_CLK);
+	np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
+	clk_mgr_base_addr = of_iomap(np, 0);
+
+	clk = clk_register_fixed_rate(NULL, "main_pll_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_MAIN_PLL_CLK);
+	clk_register_clkdev(clk, "main_pll_clk", NULL);
+
+	clk = clk_register_fixed_rate(NULL, "per_pll_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_PER_PLL_CLK);
+	clk_register_clkdev(clk, "per_pll_clk", NULL);
+
+	clk = clk_register_fixed_rate(NULL, "sdram_pll_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_SDRAM_PLL_CLK);
+	clk_register_clkdev(clk, "sdram_pll_clk", NULL);
+
+	clk = clk_register_fixed_rate(NULL, "osc1_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_OSC1_CLK);
 	clk_register_clkdev(clk, "osc1_clk", NULL);
 
-	clk = clk_register_fixed_rate(NULL, "mpu_clk", NULL, CLK_IS_ROOT, SOCFPGA_MPU_CLK);
+	clk = clk_register_fixed_rate(NULL, "mpu_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_MPU_CLK);
 	clk_register_clkdev(clk, "mpu_clk", NULL);
 
-	clk = clk_register_fixed_rate(NULL, "main_clk", NULL, CLK_IS_ROOT, SOCFPGA_MPU_CLK/2);
+	clk = clk_register_fixed_rate(NULL, "main_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_MPU_CLK/2);
 	clk_register_clkdev(clk, "main_clk", NULL);
 
-	clk = clk_register_fixed_rate(NULL, "dbg_base_clk", NULL, CLK_IS_ROOT, SOCFPGA_MPU_CLK/2);
+	clk = clk_register_fixed_rate(NULL, "dbg_base_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_MPU_CLK/2);
 	clk_register_clkdev(clk, "dbg_base_clk", NULL);
 
-	clk = clk_register_fixed_rate(NULL, "main_qspi_clk", NULL, CLK_IS_ROOT, SOCFPGA_MAIN_QSPI_CLK);
+	clk = clk_register_fixed_rate(NULL, "smp_twd", NULL, CLK_IS_ROOT,
+			SOCFPGA_MPU_CLK/4);
+	clk_register_clkdev(clk, NULL, "smp_twd");
+
+	clk = clk_register_fixed_rate(NULL, "main_qspi_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_MAIN_QSPI_CLK);
 	clk_register_clkdev(clk, "main_qspi_clk", NULL);
 
-	clk = clk_register_fixed_rate(NULL, "main_nand_sdmmc_clk", NULL, CLK_IS_ROOT, SOCFPGA_MAIN_NAND_SDMMC_CLK);
+	clk = clk_register_fixed_rate(NULL, "main_nand_sdmmc_clk", NULL,
+			CLK_IS_ROOT, SOCFPGA_MAIN_NAND_SDMMC_CLK);
 	clk_register_clkdev(clk, "main_nand_sdmmc_clk", NULL);
 
-	clk = clk_register_fixed_rate(NULL, "s2f_usr_clk", NULL, CLK_IS_ROOT, SOCFPGA_S2F_USR_CLK);
+	clk = clk_register_fixed_rate(NULL, "s2f_usr_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_S2F_USR_CLK);
 	clk_register_clkdev(clk, "s2f_usr_clk", NULL);
+
+	clk = clk_register_fixed_rate(NULL, "i2c0_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_PER_PLL_CLK);
+	clk_register_clkdev(clk, NULL, "ffc04000.i2c");
+
+	clk = clk_register_fixed_rate(NULL, "i2c1_clk", NULL, CLK_IS_ROOT,
+			SOCFPGA_PER_PLL_CLK);
+	clk_register_clkdev(clk, NULL, "ffc05000.i2c");
+
+	clk = clk_register_gate(NULL, "gmac0_clk", "per_pll_clk", 0,
+			clk_mgr_base_addr + CLKMGR_PERPLLGRP_EN,
+			CLKMGR_EMAC0_CLK_EN, 0, &_lock);
+	clk_register_clkdev(clk, NULL, "ff700000.ethernet");
+
+	clk = clk_register_gate(NULL, "gmac1_clk", "per_pll_clk", 0,
+			clk_mgr_base_addr + CLKMGR_PERPLLGRP_EN,
+			CLKMGR_EMAC1_CLK_EN, 0, &_lock);
+	clk_register_clkdev(clk, NULL, "ff702000.ethernet");
+
+	clk = clk_register_gate(NULL, "spi0_clk", "per_pll_clk", 0,
+			clk_mgr_base_addr + CLKMGR_PERPLLGRP_EN,
+			CLKMGR_SPI_M_CLK_EN, 0, &_lock);
+	clk_register_clkdev(clk, NULL, "fff00000.spi");
+
+	clk = clk_register_gate(NULL, "spi1_clk", "per_pll_clk", 0,
+			clk_mgr_base_addr + CLKMGR_PERPLLGRP_EN,
+			CLKMGR_SPI_M_CLK_EN, 0, &_lock);
+	clk_register_clkdev(clk, NULL, "fff01000.spi");
+
+	clk = clk_register_gate(NULL, "gpio0_clk", "per_pll_clk", 0,
+			clk_mgr_base_addr + CLKMGR_PERPLLGRP_EN,
+			CLKMGR_GPIO_CLK_EN, 0, &_lock);
+	clk_register_clkdev(clk, NULL, "ff708000.gpio");
+
+	clk = clk_register_gate(NULL, "gpio1_clk", "per_pll_clk", 0,
+			clk_mgr_base_addr + CLKMGR_PERPLLGRP_EN,
+			CLKMGR_GPIO_CLK_EN, 0, &_lock);
+	clk_register_clkdev(clk, NULL, "ff709000.gpio");
+
+	clk = clk_register_gate(NULL, "gpio2_clk", "per_pll_clk", 0,
+			clk_mgr_base_addr + CLKMGR_PERPLLGRP_EN,
+			CLKMGR_GPIO_CLK_EN, 0, &_lock);
+	clk_register_clkdev(clk, NULL, "ff70a000.gpio");
+
+	clk = clk_register_gate(NULL, "nand_clk", "main_nand_sdmmc_clk", 0,
+			clk_mgr_base_addr + CLKMGR_PERPLLGRP_EN,
+			CLKMGR_NAND_CLK_EN, 0, &_lock);
+	clk_register_clkdev(clk, NULL, "ff900000.nand");
 }
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 323c502..c199847 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -38,9 +38,14 @@
 #include "dw_mmc.h"
 
 /* Common flag combinations */
-#define DW_MCI_DATA_ERROR_FLAGS	(SDMMC_INT_DTO | SDMMC_INT_DCRC | \
-				 SDMMC_INT_HTO | SDMMC_INT_SBE  | \
-				 SDMMC_INT_EBE)
+
+/* According to Synopsys, the data starvation interrupt (HTO) should not treat
+ * as error. Software should continue the data transfer. We have verified this
+ * in Virtual Target. The same is applied to FIFO under/overrun (FRUN) as well.
+ */
+#define DW_MCI_DATA_ERROR_FLAGS (SDMMC_INT_DTO | SDMMC_INT_DCRC | \
+				 SDMMC_INT_HTO | SDMMC_INT_FRUN | SDMMC_INT_SBE | SDMMC_INT_EBE)
+
 #define DW_MCI_CMD_ERROR_FLAGS	(SDMMC_INT_RTO | SDMMC_INT_RCRC | \
 				 SDMMC_INT_RESP_ERR)
 #define DW_MCI_ERROR_FLAGS	(DW_MCI_DATA_ERROR_FLAGS | \
@@ -265,6 +270,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 	if (drv_data && drv_data->prepare_command)
 		drv_data->prepare_command(slot->host, &cmdr);
 
+	if (slot->host->use_hold_reg)
+		cmdr |= SDMMC_CMD_USE_HOLD_REG;
+
 	return cmdr;
 }
 
@@ -2047,6 +2055,16 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (of_property_read_u32(dev->of_node, "bus-hz", &pdata->bus_hz)) {
+		dev_err(dev, "couldn't determine bus-hz\n");
+		pdata->bus_hz = 50000000;
+	}
+
+	if (of_property_read_u32(dev->of_node, "pwr-en", &pdata->pwr_en)) {
+		dev_info(dev, "couldn't determine pwr-en, assuming pwr-en = 0\n");
+		pdata->pwr_en = 0;
+	}
+
 	/* find out number of slots supported */
 	if (of_property_read_u32(dev->of_node, "num-slots",
 				&pdata->num_slots)) {
@@ -2183,6 +2201,9 @@ int dw_mci_probe(struct dw_mci *host)
 		host->data_shift = 2;
 	}
 
+	/* Get the USE_HOLD_REG */
+	host->use_hold_reg = mci_readl(host, CMD) & SDMMC_CMD_USE_HOLD_REG;
+
 	/* Reset all blocks */
 	if (!mci_wait_reset(host->dev, host))
 		return -ENODEV;
@@ -2194,6 +2215,9 @@ int dw_mci_probe(struct dw_mci *host)
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
 
+	/* Set PWREN bit */
+	mci_writel(host, PWREN, host->pdata->pwr_en);
+
 	/* Put in max timeout */
 	mci_writel(host, TMOUT, 0xFFFFFFFF);
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 53b8fd9..6172900 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -111,6 +111,7 @@
 #define SDMMC_INT_ERROR			0xbfc2
 /* Command register defines */
 #define SDMMC_CMD_START			BIT(31)
+#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
 #define SDMMC_CMD_CCS_EXP		BIT(23)
 #define SDMMC_CMD_CEATA_RD		BIT(22)
 #define SDMMC_CMD_UPD_CLK		BIT(21)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 7ad56af..03846dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -228,6 +228,9 @@ enum rtc_control {
 #define GMAC_MMC_CTRL      0x100
 #define GMAC_MMC_RX_INTR   0x104
 #define GMAC_MMC_TX_INTR   0x108
+#define GMAC_MMC_INTR_MASK_RX		  0x10C
+#define GMAC_MMC_INTR_MASK_TX		  0x110
+#define GMAC_MMC_IPC_INTR_MASK_RX  0x200
 #define GMAC_MMC_RX_CSUM_OFFLOAD   0x208
 
 extern const struct stmmac_dma_ops dwmac1000_dma_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index bfe0226..ade7bfb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -40,6 +40,11 @@ static void dwmac1000_core_init(void __iomem *ioaddr)
 	/* Mask GMAC interrupts */
 	writel(0x207, ioaddr + GMAC_INT_MASK);
 
+	/* mask out interrupts because we don't handle them yet */
+	writel(~0UL, ioaddr + GMAC_MMC_INTR_MASK_RX);
+	writel(~0UL, ioaddr + GMAC_MMC_INTR_MASK_TX);
+	writel(~0UL, ioaddr + GMAC_MMC_IPC_INTR_MASK_RX);
+
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Tag detection without filtering */
 	writel(0x0, ioaddr + GMAC_VLAN_TAG);
@@ -198,6 +203,7 @@ static int dwmac1000_irq_status(void __iomem *ioaddr)
 {
 	u32 intr_status = readl(ioaddr + GMAC_INT_STATUS);
 	int status = 0;
+	u32 value;
 
 	/* Not used events (e.g. MMC interrupts) are not handled. */
 	if ((intr_status & mmc_tx_irq)) {
@@ -222,6 +228,11 @@ static int dwmac1000_irq_status(void __iomem *ioaddr)
 		readl(ioaddr + GMAC_PMT);
 		status |= core_irq_receive_pmt_irq;
 	}
+	if (unlikely(intr_status & rgmii_irq)) {
+		CHIP_DBG(KERN_INFO "GMAC: Interrupt Status\n");
+		/* clear this link change interrupt because we are not handling it yet. */
+		value = readl(ioaddr + GMAC_GMII_STATUS);
+	}
 	/* MAC trx/rx EEE LPI entry/exit interrupts */
 	if (intr_status & lpiis_irq) {
 		/* Clean LPI interrupt by reading the Reg 12 */
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 2fc8ef9..6996b2e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -145,7 +145,11 @@ static int enh_desc_coe_rdes0(int ipc_err, int type, int payload_err)
 		ret = discard_frame;
 	} else if (status == 0x3) {
 		CHIP_DBG(KERN_ERR "RX Des0 status: No IPv4, IPv6 frame.\n");
+#ifdef CONFIG_ARCH_SOCFPGA
+		ret = csum_none;
+#else
 		ret = discard_frame;
+#endif
 	}
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 0b9829f..294060e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -242,6 +242,11 @@ int stmmac_mdio_register(struct net_device *ndev)
 		return -ENODEV;
 	}
 
+	if (priv->plat->mdio_bus_data->phy_reset_mii) {
+		priv->plat->mdio_bus_data->phy_reset_mii(new_bus,
+			priv->plat->phy_addr);
+	}
+
 	priv->mii = new_bus;
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index b43d68b..e7b455a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -34,15 +34,18 @@ static int stmmac_probe_config_dt(struct platform_device *pdev,
 				  const char **mac)
 {
 	struct device_node *np = pdev->dev.of_node;
+	u32 phyaddr;
 
 	if (!np)
 		return -ENODEV;
 
 	*mac = of_get_mac_address(np);
 	plat->interface = of_get_phy_mode(np);
-	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
+	if (NULL == plat->mdio_bus_data) {
+		plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
 					   sizeof(struct stmmac_mdio_bus_data),
 					   GFP_KERNEL);
+	}
 
 	/*
 	 * Currently only the properties needed on SPEAr600
@@ -56,6 +59,17 @@ static int stmmac_probe_config_dt(struct platform_device *pdev,
 		plat->pmt = 1;
 	}
 
+	if (0 == of_property_read_u32(np, "phy-addr", &phyaddr)) {
+		if ((-1 == phyaddr) ||
+			((phyaddr >= 0) && (phyaddr < PHY_MAX_ADDR))) {
+			plat->phy_addr = phyaddr;
+		} else {
+			pr_err("%s: ERROR: bad phy address: %d\n",
+				__func__, phyaddr);
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 #else
@@ -94,10 +108,14 @@ static int stmmac_pltfr_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	plat_dat = pdev->dev.platform_data;
+
 	if (pdev->dev.of_node) {
-		plat_dat = devm_kzalloc(&pdev->dev,
+		if (NULL == plat_dat) {
+			plat_dat = devm_kzalloc(&pdev->dev,
 					sizeof(struct plat_stmmacenet_data),
 					GFP_KERNEL);
+		}
 		if (!plat_dat) {
 			pr_err("%s: ERROR: no memory", __func__);
 			return  -ENOMEM;
@@ -108,8 +126,6 @@ static int stmmac_pltfr_probe(struct platform_device *pdev)
 			pr_err("%s: main dt probe failed", __func__);
 			return ret;
 		}
-	} else {
-		plat_dat = pdev->dev.platform_data;
 	}
 
 	/* Custom initialisation (if needed)*/
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index adfe8c0..f699596 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -17,6 +17,7 @@
 
 #define PHY_ID_KSZ8873MLL	0x000e7237
 #define PHY_ID_KSZ9021		0x00221610
+#define PHY_ID_KSZ9021RLRN	0x00221611
 #define PHY_ID_KS8737		0x00221720
 #define PHY_ID_KSZ8021		0x00221555
 #define PHY_ID_KSZ8041		0x00221510
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 34be4f4..cf22d32 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -187,6 +187,11 @@ struct dw_mci {
 	struct regulator	*vmmc;	/* Power regulator */
 	unsigned long		irq_flags; /* IRQ flags */
 	int			irq;
+
+	/* Set to one for SDR12 and SDR25 */
+	unsigned int use_hold_reg;
+	/*Card needs power enable bit */
+	u32 pwr_en;
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -228,6 +233,8 @@ struct dw_mci_board {
 
 	u32 quirks; /* Workaround / Quirk flags */
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
+	/*Card needs power enable bit */
+	u32 pwr_en;
 
 	u32 caps;	/* Capabilities */
 	u32 caps2;	/* More capabilities */
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c1b3ed3..3666be2 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -27,6 +27,8 @@
 #define __STMMAC_PLATFORM_DATA
 
 #include <linux/platform_device.h>
+#include <linux/mii.h>
+#include <linux/phy.h>
 
 #define STMMAC_RX_COE_NONE	0
 #define STMMAC_RX_COE_TYPE1	1
@@ -77,6 +79,7 @@
 
 struct stmmac_mdio_bus_data {
 	int (*phy_reset)(void *priv);
+	int (*phy_reset_mii)(struct mii_bus *bus, int phyaddr);
 	unsigned int phy_mask;
 	int *irqs;
 	int probed_phy_irq;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

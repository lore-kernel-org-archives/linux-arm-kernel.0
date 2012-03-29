From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 29 Mar 2012 16:11:04 +0530
Subject: [PATCH V3 6/7] SPEAr: Add PL080 DMA support for 3xx and 6xx
In-Reply-To: <cover.1333017183.git.viresh.kumar@st.com>
References: <cover.1333017183.git.viresh.kumar@st.com>
Message-ID: <6fb0ec92c408efe9e0192b54cc00dd4828331a45.1333017183.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both SPEAr3xx and SPEAr6xx families have one instance of ARM PL080 DMA
controller. This patch adds in support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/boot/dts/spear300-evb.dts            |    4 +
 arch/arm/boot/dts/spear310-evb.dts            |    4 +
 arch/arm/boot/dts/spear320-evb.dts            |    4 +
 arch/arm/boot/dts/spear3xx.dtsi               |    8 +
 arch/arm/boot/dts/spear600-evb.dts            |    4 +
 arch/arm/boot/dts/spear600.dtsi               |    8 +
 arch/arm/mach-spear3xx/clock.c                |    2 +-
 arch/arm/mach-spear3xx/include/mach/generic.h |    2 +
 arch/arm/mach-spear3xx/spear300.c             |  193 +++++++++++++
 arch/arm/mach-spear3xx/spear310.c             |  192 +++++++++++++
 arch/arm/mach-spear3xx/spear320.c             |  192 +++++++++++++
 arch/arm/mach-spear3xx/spear3xx.c             |   19 ++
 arch/arm/mach-spear6xx/clock.c                |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c             |  372 ++++++++++++++++++++++++-
 arch/arm/plat-spear/Makefile                  |    2 +-
 arch/arm/plat-spear/include/plat/pl080.h      |   21 ++
 arch/arm/plat-spear/pl080.c                   |   79 ++++++
 17 files changed, 1104 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/pl080.h
 create mode 100644 arch/arm/plat-spear/pl080.c

diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts
index f2ee991..eaecc29 100644
--- a/arch/arm/boot/dts/spear300-evb.dts
+++ b/arch/arm/boot/dts/spear300-evb.dts
@@ -29,6 +29,10 @@
 			status = "okay";
 		};
 
+		dma at fc400000 {
+			status = "okay";
+		};
+
 		fsmc: flash at 94000000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear310-evb.dts b/arch/arm/boot/dts/spear310-evb.dts
index ec19d7b..c86af33 100644
--- a/arch/arm/boot/dts/spear310-evb.dts
+++ b/arch/arm/boot/dts/spear310-evb.dts
@@ -25,6 +25,10 @@
 	};
 
 	ahb {
+		dma at fc400000 {
+			status = "okay";
+		};
+
 		fsmc: flash at 44000000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index 5681a97..d43de71 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -29,6 +29,10 @@
 			status = "okay";
 		};
 
+		dma at fc400000 {
+			status = "okay";
+		};
+
 		fsmc: flash at 4c000000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear3xx.dtsi b/arch/arm/boot/dts/spear3xx.dtsi
index 924a6f6..0ae7c8e 100644
--- a/arch/arm/boot/dts/spear3xx.dtsi
+++ b/arch/arm/boot/dts/spear3xx.dtsi
@@ -40,6 +40,14 @@
 			#interrupt-cells = <1>;
 		};
 
+		dma at fc400000 {
+			compatible = "arm,pl080", "arm,primecell";
+			reg = <0xfc400000 0x1000>;
+			interrupt-parent = <&vic>;
+			interrupts = <8>;
+			status = "disabled";
+		};
+
 		gmac: eth at e0800000 {
 			compatible = "st,spear600-gmac";
 			reg = <0xe0800000 0x8000>;
diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
index 636292e..790a7a8 100644
--- a/arch/arm/boot/dts/spear600-evb.dts
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -24,6 +24,10 @@
 	};
 
 	ahb {
+		dma at fc400000 {
+			status = "okay";
+		};
+
 		gmac: ethernet at e0800000 {
 			phy-mode = "gmii";
 			status = "okay";
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index ebe0885..d777e3a 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -45,6 +45,14 @@
 			#interrupt-cells = <1>;
 		};
 
+		dma at fc400000 {
+			compatible = "arm,pl080", "arm,primecell";
+			reg = <0xfc400000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <10>;
+			status = "disabled";
+		};
+
 		gmac: ethernet at e0800000 {
 			compatible = "st,spear600-gmac";
 			reg = <0xe0800000 0x8000>;
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 9293c14..eeafe38 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -701,7 +701,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	/* clock derived from ahb clk */
 	CLKDEV_INIT(NULL, "apb_clk", &apb_clk),
 	CLKDEV_INIT("d0180000.i2c", NULL, &i2c_clk),
-	CLKDEV_INIT("dma", NULL, &dma_clk),
+	CLKDEV_INIT("fc400000.dma", NULL, &dma_clk),
 	CLKDEV_INIT("jpeg", NULL, &jpeg_clk),
 	CLKDEV_INIT("e0800000.eth", NULL, &gmac_clk),
 	CLKDEV_INIT("fc000000.flash", NULL, &smi_clk),
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 84ee2bb..a756958 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -14,6 +14,7 @@
 #ifndef __MACH_GENERIC_H
 #define __MACH_GENERIC_H
 
+#include <linux/amba/pl08x.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
@@ -33,6 +34,7 @@
 /* Add spear3xx family device structure declarations here */
 extern struct sys_timer spear3xx_timer;
 extern struct pl022_ssp_controller pl022_plat_data;
+extern struct pl08x_platform_data pl080_plat_data;
 
 /* Add spear3xx family function declarations here */
 void __init spear_setup_timer(void);
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index c876c6a..f46fc26 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) "SPEAr300: " fmt
 
+#include <linux/amba/pl08x.h>
 #include <linux/of_platform.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
@@ -440,10 +441,199 @@ static struct pmx_dev *spear300_evb_pmx_devs[] = {
 	&spear300_pmx_gpio1,
 };
 
+/* DMAC platform data's slave info */
+struct pl08x_channel_data spear300_dma_info[] = {
+	{
+		.bus_id = "uart0_rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart0_tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp0_rx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp0_tx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "i2c_rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "i2c_tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "irda",
+		.min_signal = 12,
+		.max_signal = 12,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "adc",
+		.min_signal = 13,
+		.max_signal = 13,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "to_jpeg",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "from_jpeg",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras0_rx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras0_tx",
+		.min_signal = 1,
+		.max_signal = 1,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras1_rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras1_tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras2_rx",
+		.min_signal = 4,
+		.max_signal = 4,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras2_tx",
+		.min_signal = 5,
+		.max_signal = 5,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras3_rx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras3_tx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras4_rx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras4_tx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras5_rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras5_tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras6_rx",
+		.min_signal = 12,
+		.max_signal = 12,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras6_tx",
+		.min_signal = 13,
+		.max_signal = 13,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras7_rx",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras7_tx",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	},
+};
+
 /* Add SPEAr300 auxdata to pass platform data */
 static struct of_dev_auxdata spear300_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl022", SPEAR3XX_ICM1_SSP_BASE, NULL,
 			&pl022_plat_data),
+	OF_DEV_AUXDATA("arm,pl080", SPEAR3XX_ICM3_DMA_BASE, NULL,
+			&pl080_plat_data),
 	{}
 };
 
@@ -451,6 +641,9 @@ static void __init spear300_dt_init(void)
 {
 	int ret = -EINVAL;
 
+	pl080_plat_data.slave_channels = spear300_dma_info;
+	pl080_plat_data.num_slave_channels = ARRAY_SIZE(spear300_dma_info);
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			spear300_auxdata_lookup, NULL);
 
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 641fd4c..063e7da 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -284,6 +284,193 @@ static struct pmx_dev *spear310_evb_pmx_devs[] = {
 	&spear310_pmx_tdm0,
 };
 
+/* DMAC platform data's slave info */
+struct pl08x_channel_data spear310_dma_info[] = {
+	{
+		.bus_id = "uart0_rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart0_tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp0_rx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp0_tx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "i2c_rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "i2c_tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "irda",
+		.min_signal = 12,
+		.max_signal = 12,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "adc",
+		.min_signal = 13,
+		.max_signal = 13,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "to_jpeg",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "from_jpeg",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart1_rx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart1_tx",
+		.min_signal = 1,
+		.max_signal = 1,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart2_rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart2_tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart3_rx",
+		.min_signal = 4,
+		.max_signal = 4,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart3_tx",
+		.min_signal = 5,
+		.max_signal = 5,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart4_rx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart4_tx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart5_rx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart5_tx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras5_rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras5_tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras6_rx",
+		.min_signal = 12,
+		.max_signal = 12,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras6_tx",
+		.min_signal = 13,
+		.max_signal = 13,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras7_rx",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras7_tx",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	},
+};
+
 /* uart devices plat data */
 static struct amba_pl011_data spear310_uart_data[] = {
 	{
@@ -313,6 +500,8 @@ static struct amba_pl011_data spear310_uart_data[] = {
 static struct of_dev_auxdata spear310_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl022", SPEAR3XX_ICM1_SSP_BASE, NULL,
 			&pl022_plat_data),
+	OF_DEV_AUXDATA("arm,pl080", SPEAR3XX_ICM3_DMA_BASE, NULL,
+			&pl080_plat_data),
 	OF_DEV_AUXDATA("arm,pl011", SPEAR310_UART1_BASE, NULL,
 			&spear310_uart_data[0]),
 	OF_DEV_AUXDATA("arm,pl011", SPEAR310_UART2_BASE, NULL,
@@ -331,6 +520,9 @@ static void __init spear310_dt_init(void)
 	void __iomem *base;
 	int ret = 0;
 
+	pl080_plat_data.slave_channels = spear310_dma_info;
+	pl080_plat_data.num_slave_channels = ARRAY_SIZE(spear310_dma_info);
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			spear310_auxdata_lookup, NULL);
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 9c571d0..1e74031 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -535,6 +535,193 @@ static struct pmx_dev *spear320_evb_pmx_devs[] = {
 	&spear320_pmx_mii1,
 };
 
+/* DMAC platform data's slave info */
+struct pl08x_channel_data spear320_dma_info[] = {
+	{
+		.bus_id = "uart0_rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart0_tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp0_rx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp0_tx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "i2c0_rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "i2c0_tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "irda",
+		.min_signal = 12,
+		.max_signal = 12,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "adc",
+		.min_signal = 13,
+		.max_signal = 13,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "to_jpeg",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "from_jpeg",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp1_rx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ssp1_tx",
+		.min_signal = 1,
+		.max_signal = 1,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ssp2_rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ssp2_tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "uart1_rx",
+		.min_signal = 4,
+		.max_signal = 4,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "uart1_tx",
+		.min_signal = 5,
+		.max_signal = 5,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "uart2_rx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "uart2_tx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "i2c1_rx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "i2c1_tx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "i2c2_rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "i2c2_tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "i2s_rx",
+		.min_signal = 12,
+		.max_signal = 12,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "i2s_tx",
+		.min_signal = 13,
+		.max_signal = 13,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "rs485_rx",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "rs485_tx",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	},
+};
+
 static struct pl022_ssp_controller spear320_ssp_data[] = {
 	{
 		.bus_id = 1,
@@ -569,6 +756,8 @@ static struct amba_pl011_data spear320_uart_data[] = {
 static struct of_dev_auxdata spear320_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl022", SPEAR3XX_ICM1_SSP_BASE, NULL,
 			&pl022_plat_data),
+	OF_DEV_AUXDATA("arm,pl080", SPEAR3XX_ICM3_DMA_BASE, NULL,
+			&pl080_plat_data),
 	OF_DEV_AUXDATA("arm,pl022", SPEAR320_SSP0_BASE, NULL,
 			&spear320_ssp_data[0]),
 	OF_DEV_AUXDATA("arm,pl022", SPEAR320_SSP1_BASE, NULL,
@@ -585,6 +774,9 @@ static void __init spear320_dt_init(void)
 	void __iomem *base;
 	int ret = 0;
 
+	pl080_plat_data.slave_channels = spear320_dma_info;
+	pl080_plat_data.num_slave_channels = ARRAY_SIZE(spear320_dma_info);
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			spear320_auxdata_lookup, NULL);
 
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index a94d8c1..17d4ac9 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -17,7 +17,9 @@
 #include <linux/amba/pl08x.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
+#include <asm/hardware/pl080.h>
 #include <asm/hardware/vic.h>
+#include <plat/pl080.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
@@ -465,6 +467,23 @@ struct pl022_ssp_controller pl022_plat_data = {
 	.num_chipselect = 2,
 };
 
+/* dmac device registration */
+struct pl08x_platform_data pl080_plat_data = {
+	.memcpy_channel = {
+		.bus_id = "memcpy",
+		.cctl = (PL080_BSIZE_16 << PL080_CONTROL_SB_SIZE_SHIFT | \
+			PL080_BSIZE_16 << PL080_CONTROL_DB_SIZE_SHIFT | \
+			PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT | \
+			PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT | \
+			PL080_CONTROL_PROT_BUFF | PL080_CONTROL_PROT_CACHE | \
+			PL080_CONTROL_PROT_SYS),
+	},
+	.lli_buses = PL08X_AHB1,
+	.mem_buses = PL08X_AHB1,
+	.get_signal = pl080_get_signal,
+	.put_signal = pl080_put_signal,
+};
+
 /*
  * Following will create 16MB static virtual/physical mappings
  * PHYSICAL		VIRTUAL
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 5a46980..adadef2 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -657,7 +657,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	/* clock derived from ahb clk */
 	CLKDEV_INIT(NULL, "apb_clk", &apb_clk),
 	CLKDEV_INIT("d0200000.i2c", NULL, &i2c_clk),
-	CLKDEV_INIT("dma", NULL, &dma_clk),
+	CLKDEV_INIT("fc400000.dma", NULL, &dma_clk),
 	CLKDEV_INIT("jpeg", NULL, &jpeg_clk),
 	CLKDEV_INIT("gmac", NULL, &gmac_clk),
 	CLKDEV_INIT("fc000000.flash", NULL, &smi_clk),
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 2ed8b14..5b9e30f 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -13,15 +13,377 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/amba/pl08x.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <asm/hardware/pl080.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
+#include <plat/pl080.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
+/* dmac device registration */
+static struct pl08x_channel_data spear600_dma_info[] = {
+	{
+		.bus_id = "ssp1_rx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp1_tx",
+		.min_signal = 1,
+		.max_signal = 1,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart0_rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart0_tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart1_rx",
+		.min_signal = 4,
+		.max_signal = 4,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "uart1_tx",
+		.min_signal = 5,
+		.max_signal = 5,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp2_rx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ssp2_tx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ssp0_rx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ssp0_tx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "i2c_rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "i2c_tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "irda",
+		.min_signal = 12,
+		.max_signal = 12,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "adc",
+		.min_signal = 13,
+		.max_signal = 13,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "to_jpeg",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "from_jpeg",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 0,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras0_rx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras0_tx",
+		.min_signal = 1,
+		.max_signal = 1,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras1_rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras1_tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras2_rx",
+		.min_signal = 4,
+		.max_signal = 4,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras2_tx",
+		.min_signal = 5,
+		.max_signal = 5,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras3_rx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras3_tx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras4_rx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras4_tx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras5_rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras5_tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras6_rx",
+		.min_signal = 12,
+		.max_signal = 12,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras6_tx",
+		.min_signal = 13,
+		.max_signal = 13,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras7_rx",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ras7_tx",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 1,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB1,
+	}, {
+		.bus_id = "ext0_rx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext0_tx",
+		.min_signal = 1,
+		.max_signal = 1,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext1_rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext1_tx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext2_rx",
+		.min_signal = 4,
+		.max_signal = 4,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext2_tx",
+		.min_signal = 5,
+		.max_signal = 5,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext3_rx",
+		.min_signal = 6,
+		.max_signal = 6,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext3_tx",
+		.min_signal = 7,
+		.max_signal = 7,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext4_rx",
+		.min_signal = 8,
+		.max_signal = 8,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext4_tx",
+		.min_signal = 9,
+		.max_signal = 9,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext5_rx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext5_tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext6_rx",
+		.min_signal = 12,
+		.max_signal = 12,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext6_tx",
+		.min_signal = 13,
+		.max_signal = 13,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext7_rx",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	}, {
+		.bus_id = "ext7_tx",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 2,
+		.cctl = 0,
+		.periph_buses = PL08X_AHB2,
+	},
+};
+
+struct pl08x_platform_data pl080_plat_data = {
+	.memcpy_channel = {
+		.bus_id = "memcpy",
+		.cctl = (PL080_BSIZE_16 << PL080_CONTROL_SB_SIZE_SHIFT | \
+			PL080_BSIZE_16 << PL080_CONTROL_DB_SIZE_SHIFT | \
+			PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT | \
+			PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT | \
+			PL080_CONTROL_PROT_BUFF | PL080_CONTROL_PROT_CACHE | \
+			PL080_CONTROL_PROT_SYS),
+	},
+	.lli_buses = PL08X_AHB1,
+	.mem_buses = PL08X_AHB1,
+	.get_signal = pl080_get_signal,
+	.put_signal = pl080_put_signal,
+	.slave_channels = spear600_dma_info,
+	.num_slave_channels = ARRAY_SIZE(spear600_dma_info),
+};
+
 /* Following will create static virtual/physical mappings */
 static struct map_desc spear6xx_io_desc[] __initdata = {
 	{
@@ -92,9 +454,17 @@ struct sys_timer spear6xx_timer = {
 	.init = spear6xx_timer_init,
 };
 
+/* Add auxdata to pass platform data */
+struct of_dev_auxdata spear6xx_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,pl080", SPEAR6XX_ICM3_DMA_BASE, NULL,
+			&pl080_plat_data),
+	{}
+};
+
 static void __init spear600_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			spear6xx_auxdata_lookup, NULL);
 }
 
 static const char *spear600_dt_board_compat[] = {
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index e0f2e5b..4af6258 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -3,6 +3,6 @@
 #
 
 # Common support
-obj-y	:= clock.o restart.o time.o
+obj-y	:= clock.o restart.o time.o pl080.o
 
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
diff --git a/arch/arm/plat-spear/include/plat/pl080.h b/arch/arm/plat-spear/include/plat/pl080.h
new file mode 100644
index 0000000..e14a3e4
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/pl080.h
@@ -0,0 +1,21 @@
+/*
+ * arch/arm/plat-spear/include/plat/pl080.h
+ *
+ * DMAC pl080 definitions for SPEAr platform
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_PL080_H
+#define __PLAT_PL080_H
+
+struct pl08x_dma_chan;
+int pl080_get_signal(struct pl08x_dma_chan *ch);
+void pl080_put_signal(struct pl08x_dma_chan *ch);
+
+#endif /* __PLAT_PL080_H */
diff --git a/arch/arm/plat-spear/pl080.c b/arch/arm/plat-spear/pl080.c
new file mode 100644
index 0000000..d53d75e
--- /dev/null
+++ b/arch/arm/plat-spear/pl080.c
@@ -0,0 +1,79 @@
+/*
+ * arch/arm/plat-spear/pl080.c
+ *
+ * DMAC pl080 definitions for SPEAr platform
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/amba/pl08x.h>
+#include <linux/amba/bus.h>
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/spinlock_types.h>
+#include <mach/misc_regs.h>
+
+static spinlock_t lock = __SPIN_LOCK_UNLOCKED(x);
+
+struct {
+	unsigned char busy;
+	unsigned char val;
+} signals[16] = {{0, 0}, };
+
+int pl080_get_signal(struct pl08x_dma_chan *ch)
+{
+	const struct pl08x_channel_data *cd = ch->cd;
+	unsigned int signal = cd->min_signal, val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+
+	/* Return if signal is already acquired by somebody else */
+	if (signals[signal].busy &&
+			(signals[signal].val != cd->muxval)) {
+		spin_unlock_irqrestore(&lock, flags);
+		return -EBUSY;
+	}
+
+	/* If acquiring for the first time, configure it */
+	if (!signals[signal].busy) {
+		val = readl(DMA_CHN_CFG);
+
+		/*
+		 * Each request line has two bits in DMA_CHN_CFG register. To
+		 * goto the bits of current request line, do left shift of
+		 * value by 2 * signal number.
+		 */
+		val &= ~(0x3 << (signal * 2));
+		val |= cd->muxval << (signal * 2);
+		writel(val, DMA_CHN_CFG);
+	}
+
+	signals[signal].busy++;
+	signals[signal].val = cd->muxval;
+	spin_unlock_irqrestore(&lock, flags);
+
+	return signal;
+}
+
+void pl080_put_signal(struct pl08x_dma_chan *ch)
+{
+	const struct pl08x_channel_data *cd = ch->cd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+
+	/* if signal is not used */
+	if (!signals[cd->min_signal].busy)
+		BUG();
+
+	signals[cd->min_signal].busy--;
+
+	spin_unlock_irqrestore(&lock, flags);
+}
-- 
1.7.9

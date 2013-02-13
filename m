From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 13 Feb 2013 18:34:30 +0100
Subject: [PATCH v2 6/8] ARM i.MX5: Add System Reset Controller (SRC) support
 for i.MX51 and i.MX53
In-Reply-To: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1360776872-18584-7-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SRC in i.MX51 and i.MX53 is similar to the one in i.MX6q minus
the IPU2 reset line and multi core CPU reset/enable bits.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
Changes since v1:
 - Changed matching compatible string to "fsl,imx51-src"
 - Use imx_src_init for both i.MX5 and i.MX6
---
 arch/arm/boot/dts/imx6q.dtsi |    2 +-
 arch/arm/mach-imx/Kconfig    |    2 ++
 arch/arm/mach-imx/mm-imx5.c  |    2 ++
 arch/arm/mach-imx/src.c      |    4 +++-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 03ad5d5..c444336 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -552,7 +552,7 @@
 			};
 
 			src: src at 020d8000 {
-				compatible = "fsl,imx6q-src";
+				compatible = "fsl,imx6q-src", "fsl,imx51-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <0 91 0x04 0 96 0x04>;
 				#reset-cells = <1>;
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7b11d33..82c7f07 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -165,6 +165,7 @@ config	SOC_IMX51
 	bool
 	select ARCH_MX5
 	select ARCH_MX51
+	select HAVE_IMX_SRC
 	select PINCTRL
 	select PINCTRL_IMX51
 	select SOC_IMX5
@@ -792,6 +793,7 @@ config	SOC_IMX53
 	select ARCH_MX5
 	select ARCH_MX53
 	select HAVE_CAN_FLEXCAN if CAN
+	select HAVE_IMX_SRC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select PINCTRL
 	select PINCTRL_IMX53
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index cf34994..b7c4e70 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -84,6 +84,7 @@ void __init imx51_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
+	imx_src_init();
 }
 
 void __init imx53_init_early(void)
@@ -91,6 +92,7 @@ void __init imx53_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX53);
 	mxc_iomux_v3_init(MX53_IO_ADDRESS(MX53_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG1_BASE_ADDR));
+	imx_src_init();
 }
 
 void __init mx51_init_irq(void)
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 3228484..7ca37bb 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -112,7 +112,9 @@ void __init imx_src_init(void)
 	struct device_node *np;
 	u32 val;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx51-src");
+	if (!np)
+		return;
 	src_base = of_iomap(np, 0);
 	WARN_ON(!src_base);
 
-- 
1.7.10.4

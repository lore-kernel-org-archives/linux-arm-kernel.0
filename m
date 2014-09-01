From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Mon, 01 Sep 2014 09:42:49 +0530
Subject: [PATCH] drivers: mfd: exynos-pmu: Add support for Exynos7
Message-ID: <1409544769-2695-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add intial PMU settings for exynos7. This is required for
future suspend-to-ram and cpuidle support.

Signed-off-by: Eunseok Choi <es10.choi@samsung.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
This patch has been tested on an Exynos7 espresso board and is based
on Kgene's tree (for-next branch).

Following are the dependencies:
1) Support 64bit Cortex A57 based Exynos7 SoC
http://www.spinics.net/lists/arm-kernel/msg357380.html
2) mfd: syscon: Decouple syscon interface from syscon devices
http://www.spinics.net/lists/linux-samsung-soc/msg35906.html
3) ARM: EXYNOS: Add platform driver support for Exynos PMU
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275675.html
4) ARM: EXYNOS: Move PMU specific definitions from common.h
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/270655.html
5) ARM: EXYNOS: Move pmu specific header files under "linux/mfd/samsung"
https://lkml.org/lkml/2014/4/28/217
6) drivers: mfd: Add support for Exynos PMU driver
https://lkml.org/lkml/2014/4/28/332

NOTE: The above dependencies are not final yet, especially the
movement of exynos pmu driver to the mfd directory. I will re-work
this patch when the final location for exynos PMU driver is decided.

 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 arch/arm64/boot/dts/exynos7.dtsi                   |    5 +
 drivers/mfd/exynos-pmu.c                           |  285 ++++++++++++++++++++
 include/linux/mfd/samsung/exynos-regs-pmu.h        |  212 +++++++++++++++
 4 files changed, 503 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index 1e1979b..67b2113 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -10,6 +10,7 @@ Properties:
 		   - "samsung,exynos5260-pmu" - for Exynos5260 SoC.
 		   - "samsung,exynos5410-pmu" - for Exynos5410 SoC,
 		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
+		   - "samsung,exynos7-pmu" - for Exynos7 SoC.
 		second value must be always "syscon".
 
  - reg : offset and length of the register set.
diff --git a/arch/arm64/boot/dts/exynos7.dtsi b/arch/arm64/boot/dts/exynos7.dtsi
index 6b9eaf4..e2f9f85 100644
--- a/arch/arm64/boot/dts/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos7.dtsi
@@ -361,6 +361,11 @@
 		status = "disabled";
 	};
 
+	pmu: pmu-controller at 105c0000 {
+		compatible = "samsung,exynos7-pmu";
+		reg = <0x105c0000 0x5000>;
+	};
+
 	rtc at 10590000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10590000 0x100>;
diff --git a/drivers/mfd/exynos-pmu.c b/drivers/mfd/exynos-pmu.c
index bfdadbf..9af3b53 100644
--- a/drivers/mfd/exynos-pmu.c
+++ b/drivers/mfd/exynos-pmu.c
@@ -11,6 +11,7 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
@@ -348,6 +349,185 @@ static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
+static const struct exynos_pmu_conf exynos7_pmu_config[] = {
+	/* { .addr = address, .val = { AFTR, LPA, SLEEP } } */
+	{ EXYNOS7_ATLAS_CPU0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU0_LOCAL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU0_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU0_CPUSEQUENCER_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_ATLAS_CPU1_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU1_LOCAL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU1_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU1_CPUSEQUENCER_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_ATLAS_CPU2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU2_LOCAL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU2_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU2_CPUSEQUENCER_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_ATLAS_CPU3_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU3_LOCAL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU3_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DIS_IRQ_ATLAS_CPU3_CPUSEQUENCER_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_ATLAS_NONCPU_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_ATLAS_DBG_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_ATLAS_L2_SYS_PWR_REG,				{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_TOP_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_TOP_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_TOP_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CPUCLKSTOP_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_MIF_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_MIF_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_MIF_SYS_PWR_REG,			{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_DDRPHY_DLLLOCK_SYS_PWR_REG,			{ 0x1, 0x1, 0x1 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_TOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_TOP_BUS_SYS_PWR_REG,				{ 0x7, 0x0, 0x0 } },
+	{ EXYNOS7_TOP_RETENTION_SYS_PWR_REG,			{ 0x1, 0x0, 0x1 } },
+	{ EXYNOS7_TOP_PWR_SYS_PWR_REG,				{ 0x3, 0x0, 0x3 } },
+	{ EXYNOS7_TOP_BUS_MIF_SYS_PWR_REG,			{ 0x7, 0x0, 0x0 } },
+	{ EXYNOS7_TOP_RETENTION_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x1 } },
+	{ EXYNOS7_TOP_PWR_MIF_SYS_PWR_REG,			{ 0x3, 0x0, 0x3 } },
+	{ EXYNOS7_RET_OSCCLK_GATE_SYS_PWR_REG,			{ 0x1, 0x0, 0x1 } },
+	{ EXYNOS7_LOGIC_RESET_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_OSCCLK_GATE_SYS_PWR_REG,			{ 0x1, 0x0, 0x1 } },
+	{ EXYNOS7_SLEEP_RESET_SYS_PWR_REG,			{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_LOGIC_RESET_MIF_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_OSCCLK_GATE_MIF_SYS_PWR_REG,			{ 0x1, 0x0, 0x1 } },
+	{ EXYNOS7_SLEEP_RESET_MIF_SYS_PWR_REG,			{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_RET_OSCCLK_GATE_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x1 } },
+	{ EXYNOS7_MEMORY_TOP_SYS_PWR_REG,			{ 0x3, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_TOP_ALV_SYS_PWR_REG,			{ 0x3, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_LPDDR4_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_AUD_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_JTAG_SYS_PWR_REG,		{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_MMC2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_TOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_UART_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_MMC0_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_MMC1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_EBIA_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_EBIB_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_SPI_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_ISOLATION_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_LLI_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_UFS_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_ISOLATION_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_RETENTION_FSYSGENIO_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_PAD_ALV_SEL_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_XXTI_SYS_PWR_REG,				{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_XXTI26_SYS_PWR_REG,				{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_EXT_REGULATOR_SYS_PWR_REG,			{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_GPIO_MODE_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_GPIO_MODE_FSYS0_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_GPIO_MODE_FSYS1_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_GPIO_MODE_BUS0_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_GPIO_MODE_MIF_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_GPIO_MODE_AUD_SYS_PWR_REG,			{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_ATLAS_SYS_PWR_REG,				{ 0xF, 0xF, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_ATLAS_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_ATLAS_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_ATLAS_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_ATLAS_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_ATLAS_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_ATLAS_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_SLEEP_ATLAS_SYS_PWR_REG,		{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_AUD_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_BUS0_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_DISP_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_FSYS0_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_FSYS1_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_G2D_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_HEVC_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_MFC_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_MSCL_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_VPP_SYS_PWR_REG,				{ 0xF, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_AUD_SYS_PWR_REG,			{ 0x0, 0x1, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_BUS0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_DISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_FSYS0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_FSYS1_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_G2D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_HEVC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_MSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKRUN_CMU_VPP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_AUD_SYS_PWR_REG,			{ 0x0, 0x1, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_BUS0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_DISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_FSYS0_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_FSYS1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_G2D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_HEVC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_MSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_CLKSTOP_CMU_VPP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_AUD_SYS_PWR_REG,		{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_BUS0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_DISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_FSYS0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_FSYS1_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_G2D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_HEVC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_MSCL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_DISABLE_PLL_CMU_VPP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_AUD_SYS_PWR_REG,			{ 0x0, 0x1, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_BUS0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_DISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_FSYS0_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_FSYS1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_G2D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_HEVC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_MSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_LOGIC_VPP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_AUD_SYS_PWR_REG,			{ 0x0, 0x3, 0x0 } },
+	{ EXYNOS7_MEMORY_DISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_FSYS0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_FSYS1_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_G2D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_HEVC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_MSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_MEMORY_VPP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_AUD_SYS_PWR_REG,			{ 0x0, 0x1, 0x0 } },
+	{ EXYNOS7_RESET_CMU_BUS0_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_DISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_FSYS0_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_FSYS1_SYS_PWR_REG,			{ 0x1, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_G2D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_HEVC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_MSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_CMU_VPP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0 } },
+	{ EXYNOS7_RESET_SLEEP_BUS0_SYS_PWR_REG,			{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_RESET_SLEEP_FSYS0_SYS_PWR_REG,		{ 0x1, 0x1, 0x0 } },
+	{ EXYNOS7_RESET_SLEEP_FSYS1_SYS_PWR_REG,		{ 0x1, 0x1, 0x0 } },
+	{ PMU_TABLE_END, },
+};
+
+/* Extra PMU configurations (provided by hardware team) that are not part of the UM */
+static const struct exynos_pmu_conf exynos7_pmu_config_extra[] = {
+	/* { .addr = address, .val = { AFTR, LPA, SLEEP } } */
+	{ EXYNOS7_PMU_SYNC_CTRL,		{ 0x0,      0x0,        0x0        } },
+	{ EXYNOS7_CENTRAL_SEQ_MIF_OPTION,	{ 0x1000,   0x1000,     0x0        } },
+	{ EXYNOS7_WAKEUP_MASK_MIF,		{ 0x100013, 0x100013,   0x0        } },
+	{ EXYNOS7_ATLAS_NONCPU_OPTION,		{ 0x11,     0x11,       0x11       } },
+	{ EXYNOS7_MEMORY_TOP_OPTION,		{ 0x11,     0x11,       0x1        } },
+	{ EXYNOS7_MEMORY_TOP_ALV_OPTION,	{ 0x11,     0x11,       0x11       } },
+	{ EXYNOS7_RESET_CMU_TOP_OPTION,		{ 0x0,      0x80000000, 0x0        } },
+	{ EXYNOS7_ATLAS_OPTION,			{ 0x101,    0x101,      0x80001101 } },
+	{ EXYNOS7_BUS0_OPTION,			{ 0x101,    0x101,      0x1101     } },
+	{ EXYNOS7_FSYS0_OPTION,			{ 0x101,    0x101,      0x1101     } },
+	{ EXYNOS7_FSYS1_OPTION,			{ 0x101,    0x101,      0x1101     } },
+	{ EXYNOS7_AUD_OPTION,			{ 0x101,    0xC0000101, 0x101      } },
+	{ EXYNOS7_SLEEP_RESET_OPTION,		{ 0x100000, 0x100000,   0x100000   } },
+	{ EXYNOS7_TOP_PWR_OPTION,		{ 0x1,      0x80800002, 0x1        } },
+	{ EXYNOS7_LOGIC_RESET_OPTION,		{ 0x0,      0x80000000, 0x0        } },
+	{ EXYNOS7_TOP_RETENTION_OPTION,		{ 0x0,      0x80000000, 0x0        } },
+	{ PMU_TABLE_END, },
+};
+
 static unsigned int const exynos5_list_both_cnt_feed[] = {
 	EXYNOS5_ARM_CORE0_OPTION,
 	EXYNOS5_ARM_CORE1_OPTION,
@@ -368,6 +548,22 @@ static unsigned int const exynos5_list_diable_wfi_wfe[] = {
 	EXYNOS5_ISP_ARM_OPTION,
 };
 
+static unsigned int const exynos7_list_feed[] = {
+	EXYNOS7_ATLAS_NONCPU_OPTION,
+	EXYNOS7_TOP_PWR_OPTION,
+	EXYNOS7_TOP_PWR_MIF_OPTION,
+	EXYNOS7_AUD_OPTION,
+	EXYNOS7_DISP_OPTION,
+	EXYNOS7_G2D_OPTION,
+	EXYNOS7_HEVC_OPTION,
+	EXYNOS7_MSCL_OPTION,
+	EXYNOS7_MFC_OPTION,
+	EXYNOS7_BUS0_OPTION,
+	EXYNOS7_FSYS0_OPTION,
+	EXYNOS7_FSYS1_OPTION,
+	EXYNOS7_VPP_OPTION,
+};
+
 static void exynos5_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
@@ -439,6 +635,86 @@ static void exynos5250_pmu_init(void)
 	pmu_raw_writel(value, EXYNOS5_MASK_WDTRESET_REQUEST);
 }
 
+#define EXYNOS7_CORE_ARMCLK_STOPCTRL		(0x1000)
+static void exynos7_pmu_init(void)
+{
+	unsigned int cpu;
+	unsigned int tmp, i;
+	struct device_node *node;
+	static void __iomem *atlas_cmu_base;
+
+	 /* Enable only SC_FEEDBACK for the register list */
+	for (i = 0 ; i < ARRAY_SIZE(exynos7_list_feed) ; i++) {
+		tmp = pmu_raw_readl(exynos7_list_feed[i]);
+		tmp &= ~EXYNOS5_USE_SC_COUNTER;
+		tmp |= EXYNOS5_USE_SC_FEEDBACK;
+		pmu_raw_writel(tmp, exynos7_list_feed[i]);
+	}
+
+	/*
+	 * - Disable automatic L2 flush
+	 * - Disable L2 retention
+	 * - Enable STANDBYWFIL2, ACE/ACP
+	 */
+	tmp = pmu_raw_readl(EXYNOS7_ATLAS_L2_OPTION);
+	tmp &= ~(EXYNOS7_USE_AUTO_L2FLUSHREQ | EXYNOS7_USE_RETENTION);
+	tmp |= (EXYNOS7_USE_STANDBYWFIL2 |
+		EXYNOS7_USE_DEACTIVATE_ACE |
+		EXYNOS7_USE_DEACTIVATE_ACP);
+	pmu_raw_writel(tmp, EXYNOS7_ATLAS_L2_OPTION);
+
+	/*
+	 * Enable both SC_COUNTER and SC_FEEDBACK for the CPUs
+	 * Use STANDBYWFI and SMPEN to indicate that core is ready to enter
+	 * low power mode
+	 */
+	for (cpu = 0; cpu < 4; cpu++) {
+		tmp = pmu_raw_readl(EXYNOS7_CPU_OPTION(cpu));
+		tmp |= (EXYNOS5_USE_SC_FEEDBACK | EXYNOS5_USE_SC_COUNTER);
+		tmp |= EXYNOS7_USE_SMPEN;
+		tmp |= EXYNOS7_USE_STANDBYWFI;
+		tmp &= ~EXYNOS7_USE_STANDBYWFE;
+		pmu_raw_writel(tmp, EXYNOS7_CPU_OPTION(cpu));
+
+		tmp = pmu_raw_readl(EXYNOS7_CPU_DURATION(cpu));
+		tmp |= EXYNOS7_DUR_WAIT_RESET;
+		tmp &= ~EXYNOS7_DUR_SCALL;
+		tmp |= EXYNOS7_DUR_SCALL_VALUE;
+		pmu_raw_writel(tmp, EXYNOS7_CPU_DURATION(cpu));
+	}
+
+	/* Skip atlas block power-off during automatic power down sequence */
+	tmp = pmu_raw_readl(EXYNOS7_ATLAS_CPUSEQUENCER_OPTION);
+	tmp |= EXYNOS7_SKIP_BLK_PWR_DOWN;
+	pmu_raw_writel(tmp, EXYNOS7_ATLAS_CPUSEQUENCER_OPTION);
+
+	/* Limit in-rush current during local power up of cores */
+	tmp = pmu_raw_readl(EXYNOS7_UP_SCHEDULER);
+	tmp |= EXYNOS7_ENABLE_ATLAS_CPU;
+	pmu_raw_writel(tmp, EXYNOS7_UP_SCHEDULER);
+
+	/* Enable PS hold and hardware tripping */
+	tmp = pmu_raw_readl(EXYNOS7_PS_HOLD_CONTROL);
+	tmp ^= EXYNOS7_PS_HOLD_OUTPUT;
+	tmp |= EXYNOS7_ENABLE_HW_TRIP;
+	pmu_raw_writel(tmp, EXYNOS7_PS_HOLD_CONTROL);
+
+	/* Enable debug area of atlas cpu */
+	tmp = pmu_raw_readl(EXYNOS7_ATLAS_DBG_CONFIGURATION);
+	tmp |= EXYNOS7_DBG_INITIATE_WAKEUP;
+	pmu_raw_writel(tmp, EXYNOS7_ATLAS_DBG_CONFIGURATION);
+
+	/*
+	 * Set clock freeze cycle count to 0 before and after arm clamp or
+	 * reset signal transition
+	 */
+	node = of_find_compatible_node(NULL, NULL,
+				"samsung,exynos7-clock-atlas");
+	atlas_cmu_base = of_iomap(node, 0);
+	__raw_writel(0x0, atlas_cmu_base + EXYNOS7_CORE_ARMCLK_STOPCTRL);
+	iounmap(atlas_cmu_base);
+}
+
 static const struct exynos_pmu_data exynos4210_pmu_data = {
 	.pmu_config	= exynos4210_pmu_config,
 };
@@ -458,6 +734,12 @@ static const struct exynos_pmu_data exynos5250_pmu_data = {
 	.powerdown_conf	= exynos5_powerdown_conf,
 };
 
+static const struct exynos_pmu_data exynos7_pmu_data = {
+	.pmu_config		= exynos7_pmu_config,
+	.pmu_init		= exynos7_pmu_init,
+	.pmu_config_extra	= exynos7_pmu_config_extra,
+};
+
 static const struct regmap_config pmu_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -480,6 +762,9 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
 	}, {
 		.compatible = "samsung,exynos5250-pmu",
 		.data = &exynos5250_pmu_data,
+	}, {
+		.compatible = "samsung,exynos7-pmu",
+		.data = &exynos7_pmu_data,
 	},
 	{ /*sentinel*/ },
 };
diff --git a/include/linux/mfd/samsung/exynos-regs-pmu.h b/include/linux/mfd/samsung/exynos-regs-pmu.h
index 96a1569..5d58d08 100644
--- a/include/linux/mfd/samsung/exynos-regs-pmu.h
+++ b/include/linux/mfd/samsung/exynos-regs-pmu.h
@@ -326,4 +326,216 @@ static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
 		 + MPIDR_AFFINITY_LEVEL(mpidr, 0));
 }
 
+/* For EXYNOS7 */
+
+#define EXYNOS7_PMU_SYNC_CTRL					(0x0020)
+#define EXYNOS7_UP_SCHEDULER					(0x0120)
+#define EXYNOS7_CENTRAL_SEQ_OPTION				(0x0208)
+#define EXYNOS7_CENTRAL_SEQ_MIF_OPTION				(0x0248)
+#define EXYNOS7_WAKEUP_MASK_MIF					(0x0628)
+#define EXYNOS7_ARM_CONTROL_OPTION				(0x0A04)
+#define EXYNOS7_ATLAS_CPU0_SYS_PWR_REG				(0x1000)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU0_LOCAL_SYS_PWR_REG		(0x1004)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU0_CENTRAL_SYS_PWR_REG		(0x1008)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU0_CPUSEQUENCER_SYS_PWR_REG	(0x100C)
+#define EXYNOS7_ATLAS_CPU1_SYS_PWR_REG				(0x1010)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU1_LOCAL_SYS_PWR_REG		(0x1014)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU1_CENTRAL_SYS_PWR_REG		(0x1018)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU1_CPUSEQUENCER_SYS_PWR_REG	(0x101C)
+#define EXYNOS7_ATLAS_CPU2_SYS_PWR_REG				(0x1020)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU2_LOCAL_SYS_PWR_REG		(0x1024)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU2_CENTRAL_SYS_PWR_REG		(0x1028)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU2_CPUSEQUENCER_SYS_PWR_REG	(0x102C)
+#define EXYNOS7_ATLAS_CPU3_SYS_PWR_REG				(0x1030)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU3_LOCAL_SYS_PWR_REG		(0x1034)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU3_CENTRAL_SYS_PWR_REG		(0x1038)
+#define EXYNOS7_DIS_IRQ_ATLAS_CPU3_CPUSEQUENCER_SYS_PWR_REG	(0x103C)
+#define EXYNOS7_ATLAS_NONCPU_SYS_PWR_REG			(0x1080)
+#define EXYNOS7_ATLAS_DBG_SYS_PWR_REG				(0x1088)
+#define EXYNOS7_ATLAS_L2_SYS_PWR_REG				(0x10C0)
+#define EXYNOS7_CLKSTOP_CMU_TOP_SYS_PWR_REG			(0x1100)
+#define EXYNOS7_CLKRUN_CMU_TOP_SYS_PWR_REG			(0x1104)
+#define EXYNOS7_RESET_CMU_TOP_SYS_PWR_REG			(0x110C)
+#define EXYNOS7_RESET_CPUCLKSTOP_SYS_PWR_REG			(0x111C)
+#define EXYNOS7_CLKSTOP_CMU_MIF_SYS_PWR_REG			(0x1120)
+#define EXYNOS7_CLKRUN_CMU_MIF_SYS_PWR_REG			(0x1124)
+#define EXYNOS7_RESET_CMU_MIF_SYS_PWR_REG			(0x112C)
+#define EXYNOS7_DDRPHY_DLLLOCK_SYS_PWR_REG			(0x1138)
+#define EXYNOS7_DISABLE_PLL_CMU_TOP_SYS_PWR_REG			(0x1140)
+#define EXYNOS7_DISABLE_PLL_CMU_MIF_SYS_PWR_REG			(0x1160)
+#define EXYNOS7_TOP_BUS_SYS_PWR_REG				(0x1180)
+#define EXYNOS7_TOP_RETENTION_SYS_PWR_REG			(0x1184)
+#define EXYNOS7_TOP_PWR_SYS_PWR_REG				(0x1188)
+#define EXYNOS7_TOP_BUS_MIF_SYS_PWR_REG				(0x1190)
+#define EXYNOS7_TOP_RETENTION_MIF_SYS_PWR_REG			(0x1194)
+#define EXYNOS7_TOP_PWR_MIF_SYS_PWR_REG				(0x1198)
+#define EXYNOS7_RET_OSCCLK_GATE_SYS_PWR_REG			(0x119C)
+#define EXYNOS7_LOGIC_RESET_SYS_PWR_REG				(0x11A0)
+#define EXYNOS7_OSCCLK_GATE_SYS_PWR_REG				(0x11A4)
+#define EXYNOS7_SLEEP_RESET_SYS_PWR_REG				(0x11A8)
+#define EXYNOS7_LOGIC_RESET_MIF_SYS_PWR_REG			(0x11B0)
+#define EXYNOS7_OSCCLK_GATE_MIF_SYS_PWR_REG			(0x11B4)
+#define EXYNOS7_SLEEP_RESET_MIF_SYS_PWR_REG			(0x11B8)
+#define EXYNOS7_RET_OSCCLK_GATE_MIF_SYS_PWR_REG			(0x11BC)
+#define EXYNOS7_MEMORY_TOP_SYS_PWR_REG				(0x11C0)
+#define EXYNOS7_MEMORY_TOP_ALV_SYS_PWR_REG			(0x11C4)
+#define EXYNOS7_PAD_RETENTION_LPDDR4_SYS_PWR_REG		(0x1200)
+#define EXYNOS7_PAD_RETENTION_AUD_SYS_PWR_REG			(0x1204)
+#define EXYNOS7_PAD_RETENTION_JTAG_SYS_PWR_REG			(0x1208)
+#define EXYNOS7_PAD_RETENTION_MMC2_SYS_PWR_REG			(0x1218)
+#define EXYNOS7_PAD_RETENTION_TOP_SYS_PWR_REG			(0x1220)
+#define EXYNOS7_PAD_RETENTION_UART_SYS_PWR_REG			(0x1224)
+#define EXYNOS7_PAD_RETENTION_MMC0_SYS_PWR_REG			(0x1228)
+#define EXYNOS7_PAD_RETENTION_MMC1_SYS_PWR_REG			(0x122C)
+#define EXYNOS7_PAD_RETENTION_EBIA_SYS_PWR_REG			(0x1230)
+#define EXYNOS7_PAD_RETENTION_EBIB_SYS_PWR_REG			(0x1234)
+#define EXYNOS7_PAD_RETENTION_SPI_SYS_PWR_REG			(0x1238)
+#define EXYNOS7_PAD_RETENTION_MIF_SYS_PWR_REG			(0x123C)
+#define EXYNOS7_PAD_ISOLATION_SYS_PWR_REG			(0x1240)
+#define EXYNOS7_PAD_RETENTION_LLI_SYS_PWR_REG			(0x1244)
+#define EXYNOS7_PAD_RETENTION_UFS_SYS_PWR_REG			(0x1248)
+#define EXYNOS7_PAD_ISOLATION_MIF_SYS_PWR_REG			(0x1250)
+#define EXYNOS7_PAD_RETENTION_FSYSGENIO_SYS_PWR_REG		(0x1254)
+#define EXYNOS7_PAD_ALV_SEL_SYS_PWR_REG				(0x1260)
+#define EXYNOS7_XXTI_SYS_PWR_REG				(0x1284)
+#define EXYNOS7_XXTI26_SYS_PWR_REG				(0x1288)
+#define EXYNOS7_EXT_REGULATOR_SYS_PWR_REG			(0x12C0)
+#define EXYNOS7_GPIO_MODE_SYS_PWR_REG				(0x1300)
+#define EXYNOS7_GPIO_MODE_FSYS0_SYS_PWR_REG			(0x1304)
+#define EXYNOS7_GPIO_MODE_FSYS1_SYS_PWR_REG			(0x1308)
+#define EXYNOS7_GPIO_MODE_BUS0_SYS_PWR_REG			(0x130C)
+#define EXYNOS7_GPIO_MODE_MIF_SYS_PWR_REG			(0x1320)
+#define EXYNOS7_GPIO_MODE_AUD_SYS_PWR_REG			(0x1340)
+#define EXYNOS7_ATLAS_SYS_PWR_REG				(0x1350)
+#define EXYNOS7_CLKRUN_CMU_ATLAS_SYS_PWR_REG			(0x1358)
+#define EXYNOS7_CLKSTOP_CMU_ATLAS_SYS_PWR_REG			(0x1360)
+#define EXYNOS7_DISABLE_PLL_CMU_ATLAS_SYS_PWR_REG		(0x1368)
+#define EXYNOS7_RESET_LOGIC_ATLAS_SYS_PWR_REG			(0x1370)
+#define EXYNOS7_MEMORY_ATLAS_SYS_PWR_REG			(0x1378)
+#define EXYNOS7_RESET_CMU_ATLAS_SYS_PWR_REG			(0x137C)
+#define EXYNOS7_RESET_SLEEP_ATLAS_SYS_PWR_REG			(0x1384)
+#define EXYNOS7_AUD_SYS_PWR_REG					(0x1400)
+#define EXYNOS7_BUS0_SYS_PWR_REG				(0x1404)
+#define EXYNOS7_DISP_SYS_PWR_REG				(0x1410)
+#define EXYNOS7_FSYS0_SYS_PWR_REG				(0x1414)
+#define EXYNOS7_FSYS1_SYS_PWR_REG				(0x1418)
+#define EXYNOS7_G2D_SYS_PWR_REG					(0x141C)
+#define EXYNOS7_HEVC_SYS_PWR_REG				(0x1424)
+#define EXYNOS7_MFC_SYS_PWR_REG					(0x1430)
+#define EXYNOS7_MSCL_SYS_PWR_REG				(0x1434)
+#define EXYNOS7_VPP_SYS_PWR_REG					(0x1438)
+#define EXYNOS7_CLKRUN_CMU_AUD_SYS_PWR_REG			(0x1440)
+#define EXYNOS7_CLKRUN_CMU_BUS0_SYS_PWR_REG			(0x1444)
+#define EXYNOS7_CLKRUN_CMU_DISP_SYS_PWR_REG			(0x1450)
+#define EXYNOS7_CLKRUN_CMU_FSYS0_SYS_PWR_REG			(0x1454)
+#define EXYNOS7_CLKRUN_CMU_FSYS1_SYS_PWR_REG			(0x1458)
+#define EXYNOS7_CLKRUN_CMU_G2D_SYS_PWR_REG			(0x145C)
+#define EXYNOS7_CLKRUN_CMU_HEVC_SYS_PWR_REG			(0x1464)
+#define EXYNOS7_CLKRUN_CMU_MFC_SYS_PWR_REG			(0x1470)
+#define EXYNOS7_CLKRUN_CMU_MSCL_SYS_PWR_REG			(0x1474)
+#define EXYNOS7_CLKRUN_CMU_VPP_SYS_PWR_REG			(0x1478)
+#define EXYNOS7_CLKSTOP_CMU_AUD_SYS_PWR_REG			(0x1480)
+#define EXYNOS7_CLKSTOP_CMU_BUS0_SYS_PWR_REG			(0x1484)
+#define EXYNOS7_CLKSTOP_CMU_DISP_SYS_PWR_REG			(0x1490)
+#define EXYNOS7_CLKSTOP_CMU_FSYS0_SYS_PWR_REG			(0x1494)
+#define EXYNOS7_CLKSTOP_CMU_FSYS1_SYS_PWR_REG			(0x1498)
+#define EXYNOS7_CLKSTOP_CMU_G2D_SYS_PWR_REG			(0x149C)
+#define EXYNOS7_CLKSTOP_CMU_HEVC_SYS_PWR_REG			(0x14A4)
+#define EXYNOS7_CLKSTOP_CMU_MFC_SYS_PWR_REG			(0x14B0)
+#define EXYNOS7_CLKSTOP_CMU_MSCL_SYS_PWR_REG			(0x14B4)
+#define EXYNOS7_CLKSTOP_CMU_VPP_SYS_PWR_REG			(0x14B8)
+#define EXYNOS7_DISABLE_PLL_CMU_AUD_SYS_PWR_REG			(0x14C0)
+#define EXYNOS7_DISABLE_PLL_CMU_BUS0_SYS_PWR_REG		(0x14C4)
+#define EXYNOS7_DISABLE_PLL_CMU_DISP_SYS_PWR_REG		(0x14D0)
+#define EXYNOS7_DISABLE_PLL_CMU_FSYS0_SYS_PWR_REG		(0x14D4)
+#define EXYNOS7_DISABLE_PLL_CMU_FSYS1_SYS_PWR_REG		(0x14D8)
+#define EXYNOS7_DISABLE_PLL_CMU_G2D_SYS_PWR_REG			(0x14DC)
+#define EXYNOS7_DISABLE_PLL_CMU_HEVC_SYS_PWR_REG		(0x14E4)
+#define EXYNOS7_DISABLE_PLL_CMU_MFC_SYS_PWR_REG			(0x14F0)
+#define EXYNOS7_DISABLE_PLL_CMU_MSCL_SYS_PWR_REG		(0x14F4)
+#define EXYNOS7_DISABLE_PLL_CMU_VPP_SYS_PWR_REG			(0x14F8)
+#define EXYNOS7_RESET_LOGIC_AUD_SYS_PWR_REG			(0x1500)
+#define EXYNOS7_RESET_LOGIC_BUS0_SYS_PWR_REG			(0x1504)
+#define EXYNOS7_RESET_LOGIC_DISP_SYS_PWR_REG			(0x1510)
+#define EXYNOS7_RESET_LOGIC_FSYS0_SYS_PWR_REG			(0x1514)
+#define EXYNOS7_RESET_LOGIC_FSYS1_SYS_PWR_REG			(0x1518)
+#define EXYNOS7_RESET_LOGIC_G2D_SYS_PWR_REG			(0x151C)
+#define EXYNOS7_RESET_LOGIC_HEVC_SYS_PWR_REG			(0x1524)
+#define EXYNOS7_RESET_LOGIC_MFC_SYS_PWR_REG			(0x1530)
+#define EXYNOS7_RESET_LOGIC_MSCL_SYS_PWR_REG			(0x1534)
+#define EXYNOS7_RESET_LOGIC_VPP_SYS_PWR_REG			(0x1538)
+#define EXYNOS7_MEMORY_AUD_SYS_PWR_REG				(0x1540)
+#define EXYNOS7_MEMORY_DISP_SYS_PWR_REG				(0x1550)
+#define EXYNOS7_MEMORY_FSYS0_SYS_PWR_REG			(0x1554)
+#define EXYNOS7_MEMORY_FSYS1_SYS_PWR_REG			(0x1558)
+#define EXYNOS7_MEMORY_G2D_SYS_PWR_REG				(0x155C)
+#define EXYNOS7_MEMORY_HEVC_SYS_PWR_REG				(0x1564)
+#define EXYNOS7_MEMORY_MFC_SYS_PWR_REG				(0x1570)
+#define EXYNOS7_MEMORY_MSCL_SYS_PWR_REG				(0x1574)
+#define EXYNOS7_MEMORY_VPP_SYS_PWR_REG				(0x1578)
+#define EXYNOS7_RESET_CMU_AUD_SYS_PWR_REG			(0x1580)
+#define EXYNOS7_RESET_CMU_BUS0_SYS_PWR_REG			(0x1584)
+#define EXYNOS7_RESET_CMU_DISP_SYS_PWR_REG			(0x1590)
+#define EXYNOS7_RESET_CMU_FSYS0_SYS_PWR_REG			(0x1594)
+#define EXYNOS7_RESET_CMU_FSYS1_SYS_PWR_REG			(0x1598)
+#define EXYNOS7_RESET_CMU_G2D_SYS_PWR_REG			(0x159C)
+#define EXYNOS7_RESET_CMU_HEVC_SYS_PWR_REG			(0x15A4)
+#define EXYNOS7_RESET_CMU_MFC_SYS_PWR_REG			(0x15B0)
+#define EXYNOS7_RESET_CMU_MSCL_SYS_PWR_REG			(0x15B4)
+#define EXYNOS7_RESET_CMU_VPP_SYS_PWR_REG			(0x15B8)
+#define EXYNOS7_RESET_SLEEP_BUS0_SYS_PWR_REG			(0x15C4)
+#define EXYNOS7_RESET_SLEEP_FSYS0_SYS_PWR_REG			(0x15D4)
+#define EXYNOS7_RESET_SLEEP_FSYS1_SYS_PWR_REG			(0x15D8)
+#define EXYNOS7_ATLAS_CPU0_OPTION				(0x2008)
+#define EXYNOS7_CPU_OPTION(_nr)					(EXYNOS7_ATLAS_CPU0_OPTION + (_nr) * 0x80)
+#define EXYNOS7_ATLAS_CPU0_DURATION0				(0x2010)
+#define EXYNOS7_CPU_DURATION(_nr)				(EXYNOS7_ATLAS_CPU0_DURATION0 + (_nr) * 0x80)
+#define EXYNOS7_ATLAS_NONCPU_OPTION				(0x2408)
+#define EXYNOS7_ATLAS_CPUSEQUENCER_OPTION			(0x2488)
+#define EXYNOS7_ATLAS_DBG_CONFIGURATION				(0x2440)
+#define EXYNOS7_ATLAS_L2_OPTION					(0x2608)
+#define EXYNOS7_RESET_CMU_TOP_OPTION				(0x2868)
+#define EXYNOS7_TOP_PWR_MIF_OPTION				(0x2CC8)
+#define EXYNOS7_TOP_RETENTION_OPTION				(0x2C28)
+#define EXYNOS7_TOP_PWR_OPTION					(0x2C48)
+#define EXYNOS7_LOGIC_RESET_OPTION				(0x2D08)
+#define EXYNOS7_SLEEP_RESET_OPTION				(0x2D48)
+#define EXYNOS7_MEMORY_TOP_ALV_OPTION				(0x2E28)
+#define EXYNOS7_MEMORY_TOP_OPTION				(0x2E08)
+#define EXYNOS7_PS_HOLD_CONTROL					(0x330C)
+#define EXYNOS7_ATLAS_OPTION					(0x3A08)
+#define EXYNOS7_AUD_OPTION					(0x4008)
+#define EXYNOS7_BUS0_OPTION					(0x4028)
+#define EXYNOS7_DISP_OPTION					(0x4088)
+#define EXYNOS7_FSYS0_OPTION					(0x40A8)
+#define EXYNOS7_FSYS1_OPTION					(0x40C8)
+#define EXYNOS7_G2D_OPTION					(0x40E8)
+#define EXYNOS7_HEVC_OPTION					(0x4128)
+#define EXYNOS7_MFC_OPTION					(0x41A8)
+#define EXYNOS7_MSCL_OPTION					(0x41C8)
+#define EXYNOS7_VPP_OPTION					(0x41E8)
+
+#define EXYNOS7_USE_DEACTIVATE_ACE				(0x1 << 19)
+#define EXYNOS7_USE_DEACTIVATE_ACP				(0x1 << 18)
+#define EXYNOS7_USE_AUTO_L2FLUSHREQ				(0x1 << 17)
+#define EXYNOS7_USE_STANDBYWFIL2				(0x1 << 16)
+#define EXYNOS7_USE_RETENTION					(0x1 << 4)
+
+#define EXYNOS7_USE_SMPEN					(0x1 << 28)
+#define EXYNOS7_USE_STANDBYWFE					(0x1 << 24)
+#define EXYNOS7_USE_STANDBYWFI					(0x1 << 16)
+#define EXYNOS7_USE_SC_FEEDBACK					(0x1 << 1)
+#define EXYNOS7_USE_SC_COUNTER					(0x1 << 0)
+
+#define EXYNOS7_DUR_WAIT_RESET					(0xF << 20)
+#define EXYNOS7_DUR_SCALL					(0xF << 4)
+#define EXYNOS7_DUR_SCALL_VALUE					(0x1 << 4)
+
+#define EXYNOS7_SKIP_BLK_PWR_DOWN				(0x1 << 8)
+#define EXYNOS7_ENABLE_ATLAS_CPU				(0x1 << 0)
+
+#define EXYNOS7_PS_HOLD_OUTPUT					(0x1 << 8)
+#define EXYNOS7_ENABLE_HW_TRIP					(0x1 << 31)
+#define EXYNOS7_DBG_INITIATE_WAKEUP				(0x3 << 16)
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
-- 
1.7.9.5

From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Sat, 13 Aug 2011 12:51:41 -0700
Subject: [PATCH v3 1/3] ARM: i.MX51: Remove _MX51_PAD_xxx references
Message-ID: <1313265101-11478-1-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new macro NEW_PAD_CTRL to remove _MX51_PAD_xxx references.
A later patch will remove the _MX51_PAD_xxx symbols.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    2 +-
 arch/arm/mach-mx5/board-mx51_babbage.c       |    4 ++--
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |    4 ++--
 arch/arm/plat-mxc/include/mach/iomux-v3.h    |    1 +
 4 files changed, 6 insertions(+), 5 deletions(-)


Changes since v2: add () around cfg in NEW_PAD_CTRL macro
as noticed by Sascha.

2/3 and 3/3 are the same as v2 and are not reposted.





diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index ff096d5..040c5c3 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -108,7 +108,7 @@ static iomux_v3_cfg_t eukrea_cpuimx51sd_pads[] = {
 
 	/* Touchscreen */
 	/* IRQ */
-	_MX51_PAD_GPIO_NAND__GPIO_NAND | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
+	NEW_PAD_CTRL(MX51_PAD_GPIO_NAND__GPIO_NAND, PAD_CTL_PUS_22K_UP |
 			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
 			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
 };
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index e400b09..5a578f9 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -357,8 +357,8 @@ static const struct esdhc_platform_data mx51_babbage_sd2_data __initconst = {
 static void __init mx51_babbage_init(void)
 {
 	iomux_v3_cfg_t usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
-	iomux_v3_cfg_t power_key = _MX51_PAD_EIM_A27__GPIO2_21 |
-		MUX_PAD_CTRL(PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | PAD_CTL_PUS_100K_UP);
+	iomux_v3_cfg_t power_key = NEW_PAD_CTRL(MX51_PAD_EIM_A27__GPIO2_21,
+		PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | PAD_CTL_PUS_100K_UP);
 
 	imx51_soc_init();
 
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index 2619239..f046d4b 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -47,7 +47,7 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	/* LED */
 	MX51_PAD_NANDF_D10__GPIO3_30,
 	/* SWITCH */
-	_MX51_PAD_NANDF_D9__GPIO3_31 | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
+	NEW_PAD_CTRL(MX51_PAD_NANDF_D9__GPIO3_31, PAD_CTL_PUS_22K_UP |
 			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
 			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
 	/* UART2 */
@@ -66,7 +66,7 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	MX51_PAD_SD1_DATA2__SD1_DATA2,
 	MX51_PAD_SD1_DATA3__SD1_DATA3,
 	/* SD1 CD */
-	_MX51_PAD_GPIO1_0__SD1_CD | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
+	NEW_PAD_CTRL(MX51_PAD_GPIO1_0__SD1_CD, PAD_CTL_PUS_22K_UP |
 			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
 			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
 };
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
index ebbce33..35e0df2 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
@@ -80,6 +80,7 @@ typedef u64 iomux_v3_cfg_t;
 		((iomux_v3_cfg_t)(_sel_input_ofs) << MUX_SEL_INPUT_OFS_SHIFT) | \
 		((iomux_v3_cfg_t)(_sel_input) << MUX_SEL_INPUT_SHIFT))
 
+#define NEW_PAD_CTRL(cfg, pad)	(((cfg) & ~MUX_PAD_CTRL_MASK) | MUX_PAD_CTRL(pad))
 /*
  * Use to set PAD control
  */
-- 
1.7.0.4

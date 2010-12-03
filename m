From: phorton@bitbox.co.uk (Peter Horton)
Date: Fri, 3 Dec 2010 17:07:28 +0000
Subject: [PATCH] mx51: add SSI3
Message-ID: <20101203170727.GA25996@porta-pete.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SSI3 to MX51

Signed-off-by: Peter Horton <phorton@bitbox.co.uk>

---

Patch is against Sascha's "for-next" tree

 arch/arm/mach-mx5/clock-mx51-mx53.c          |    5 +++++
 arch/arm/plat-mxc/devices/platform-imx-ssi.c |    1 +
 arch/arm/plat-mxc/include/mach/mx51.h        |   12 ++++++------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 344ee8e..3b1da76 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1036,6 +1036,10 @@ DEFINE_CLOCK(ssi2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG10_OFFSET,
 	NULL, NULL, &ipg_clk, NULL);
 DEFINE_CLOCK(ssi2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG11_OFFSET,
 	NULL, NULL, &pll3_sw_clk, &ssi2_ipg_clk);
+DEFINE_CLOCK(ssi3_ipg_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG12_OFFSET,
+	NULL, NULL, &ipg_clk, NULL);
+DEFINE_CLOCK(ssi3_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG13_OFFSET,
+	NULL, NULL, &pll3_sw_clk, &ssi3_ipg_clk);
 
 /* eCSPI */
 DEFINE_CLOCK_FULL(ecspi1_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG9_OFFSET,
@@ -1095,6 +1099,7 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
+	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
 	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
 	_REGISTER_CLOCK(NULL, "ckih", ckih_clk)
 	_REGISTER_CLOCK(NULL, "ckih2", ckih2_clk)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
index ac3d572..2569c8d 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-ssi.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
@@ -72,6 +72,7 @@ const struct imx_imx_ssi_data imx51_imx_ssi_data[] __initconst = {
 	imx_imx_ssi_data_entry(MX51, _id, _hwid, SZ_4K)
 	imx51_imx_ssi_data_entry(0, 1),
 	imx51_imx_ssi_data_entry(1, 2),
+	imx51_imx_ssi_data_entry(2, 3),
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 8fddfef..88b8b07 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -109,7 +109,7 @@
 #define MX51_MIPI_HSC_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xdc000)
 #define MX51_ATA_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xe0000)
 #define MX51_SIM_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xe4000)
-#define MX51_SSI3BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xe8000)
+#define MX51_SSI3_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xe8000)
 #define MX51_FEC_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xec000)
 #define MX51_TVE_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xf0000)
 #define MX51_VPU_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xf4000)
@@ -223,9 +223,9 @@
 #define MX51_DMA_REQ_EMI_WR		32
 #define MX51_DMA_REQ_CTI2_1		33
 #define MX51_DMA_REQ_EPIT2		34
-#define MX51_DMA_REQ_SSI3_RX2		35
+#define MX51_DMA_REQ_SSI3_RX1		35
 #define MX51_DMA_REQ_IPU		36
-#define MX51_DMA_REQ_SSI3_TX2		37
+#define MX51_DMA_REQ_SSI3_TX1		37
 #define MX51_DMA_REQ_CSPI_RX		38
 #define MX51_DMA_REQ_CSPI_TX		39
 #define MX51_DMA_REQ_SDHC3		40
@@ -234,8 +234,8 @@
 #define MX51_DMA_REQ_UART3_RX		43
 #define MX51_DMA_REQ_UART3_TX		44
 #define MX51_DMA_REQ_SPDIF		45
-#define MX51_DMA_REQ_SSI3_RX1		46
-#define MX51_DMA_REQ_SSI3_TX1		47
+#define MX51_DMA_REQ_SSI3_RX0		46
+#define MX51_DMA_REQ_SSI3_TX0		47
 
 /*
  * Interrupt numbers
@@ -337,7 +337,7 @@
 #define MX51_MXC_INT_FIRI		93
 #define MX51_MXC_INT_PWM2		94
 #define MX51_MXC_INT_SLIM_EXP		95
-#define MX51_MXC_INT_SSI3		96
+#define MX51_INT_SSI3			96
 #define MX51_MXC_INT_EMI_BOOT		97
 #define MX51_MXC_INT_CTI1_TG3		98
 #define MX51_MXC_INT_SMC_RX		99
-- 
1.7.3.2

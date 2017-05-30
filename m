From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 30 May 2017 19:11:19 +0300
Subject: [PATCH] ARM: imx6ull: Make suspend/resume work like on 6ul
Message-ID: <c63fd9031493cefed47d59c9918c0ecb76ffaf85.1496160320.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend and resume on imx6ull is currenty not working because of some
missed checks where behavior should match imx6ul.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/mach-imx/mxc.h     | 6 ++++++
 arch/arm/mach-imx/pm-imx6.c | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 34f2ff6..e00d626 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -39,6 +39,7 @@
 #define MXC_CPU_IMX6SX		0x62
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
+#define MXC_CPU_IMX6ULL		0x65
 #define MXC_CPU_IMX7D		0x72
 
 #define IMX_DDR_TYPE_LPDDR2		1
@@ -73,6 +74,11 @@ static inline bool cpu_is_imx6ul(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6UL;
 }
 
+static inline bool cpu_is_imx6ull(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6ULL;
+}
+
 static inline bool cpu_is_imx6q(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6Q;
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index e61b1d1..ecdf071 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -295,7 +295,8 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val &= ~BM_CLPCR_SBYOS;
 		if (cpu_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
+		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
+		    cpu_is_imx6ull())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -312,7 +313,8 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= BM_CLPCR_SBYOS;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
+		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
+		    cpu_is_imx6ull())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
-- 
2.7.4

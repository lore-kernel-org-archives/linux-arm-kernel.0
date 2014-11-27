From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 27 Nov 2014 16:35:03 +0900
Subject: [PATCH 06/19] clk: samsung: exynos5433: Add clocks for CMU_PERIS
 domain
In-Reply-To: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1417073716-22997-7-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing gate clocks of CMU_PERIS domain
which includes TMU/TZPC/SECKEY/CHIPID/TOPRTC/EFUSE IPs.
The special clocks of CMU_PERIS use fin_pll source clock directly.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c   | 146 ++++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/exynos5433.h |  33 +++++++-
 2 files changed, 176 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 11ee2d8..b09f2cfe 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -248,6 +248,7 @@ PNAME(mout_sclk_audio0_p)	= { "ioclk_audiocdclk0", "fin_pll",
 static struct samsung_fixed_factor_clock top_fixed_factor_clks[] __initdata = {
 	FFACTOR(0, "sclk_bus_pll", "fout_bus_pll", 1, 1, 0),
 	FFACTOR(0, "sclk_mfc_pll", "fout_mfc_pll", 1, 1, 0),
+	FFACTOR(0, "oscclk_efuse_common", "fin_pll", 1, 1, 0),
 
 	/* HACK: fin_pll hardcoded to xusbxti until detection is implemented */
 	FFACTOR(CLK_FIN_PLL, "fin_pll", "xusbxti", 1, 1, 0),
@@ -959,15 +960,69 @@ CLK_OF_DECLARE(exynos5433_cmu_peric, "samsung,exynos5433-cmu-peric",
 /*
  * Register offset definitions for CMU_PERIS
  */
-#define ENABLE_ACLK_PERIS		0x0800
-#define ENABLE_PCLK_PERIS		0x0900
+#define ENABLE_ACLK_PERIS				0x0800
+#define ENABLE_PCLK_PERIS				0x0900
+#define ENABLE_PCLK_PERIS_SECURE_TZPC			0x0904
+#define ENABLE_PCLK_PERIS_SECURE_SECKEY_APBIF		0x0908
+#define ENABLE_PCLK_PERIS_SECURE_CHIPID_APBIF		0x090c
+#define ENABLE_PCLK_PERIS_SECURE_TOPRTC			0x0910
+#define ENABLE_PCLK_PERIS_SECURE_CUSTOM_EFUSE_APBIF	0x0914
+#define ENABLE_PCLK_PERIS_SECURE_ANTIRBK_CNT_APBIF	0x0918
+#define ENABLE_PCLK_PERIS_SECURE_OTP_CON_APBIF		0x091c
+#define ENABLE_SCLK_PERIS				0x0a00
+#define ENABLE_SCLK_PERIS_SECURE_SECKEY			0x0a04
+#define ENABLE_SCLK_PERIS_SECURE_CHIPID			0x0a08
+#define ENABLE_SCLK_PERIS_SECURE_TOPRTC			0x0a0c
+#define ENABLE_SCLK_PERIS_SECURE_CUSTOM_EFUSE		0x0a10
+#define ENABLE_SCLK_PERIS_SECURE_ANTIRBK_CNT		0x0a14
+#define ENABLE_SCLK_PERIS_SECURE_OTP_CON		0x0a18
+#define ENABLE_IP_PERIS0				0x0b00
+#define ENABLE_IP_PERIS1				0x0b04
+#define ENABLE_IP_PERIS_SECURE_TZPC			0x0b08
+#define ENABLE_IP_PERIS_SECURE_SECKEY			0x0b0c
+#define ENABLE_IP_PERIS_SECURE_CHIPID			0x0b10
+#define ENABLE_IP_PERIS_SECURE_TOPRTC			0x0b14
+#define ENABLE_IP_PERIS_SECURE_CUSTOM_EFUSE		0x0b18
+#define ENABLE_IP_PERIS_SECURE_ANTIBRK_CNT		0x0b1c
+#define ENABLE_IP_PERIS_SECURE_OTP_CON			0x0b20
 
 static unsigned long peris_clk_regs[] __initdata = {
 	ENABLE_ACLK_PERIS,
 	ENABLE_PCLK_PERIS,
+	ENABLE_PCLK_PERIS_SECURE_TZPC,
+	ENABLE_PCLK_PERIS_SECURE_SECKEY_APBIF,
+	ENABLE_PCLK_PERIS_SECURE_CHIPID_APBIF,
+	ENABLE_PCLK_PERIS_SECURE_TOPRTC,
+	ENABLE_PCLK_PERIS_SECURE_CUSTOM_EFUSE_APBIF,
+	ENABLE_PCLK_PERIS_SECURE_ANTIRBK_CNT_APBIF,
+	ENABLE_PCLK_PERIS_SECURE_OTP_CON_APBIF,
+	ENABLE_SCLK_PERIS,
+	ENABLE_SCLK_PERIS_SECURE_SECKEY,
+	ENABLE_SCLK_PERIS_SECURE_CHIPID,
+	ENABLE_SCLK_PERIS_SECURE_TOPRTC,
+	ENABLE_SCLK_PERIS_SECURE_CUSTOM_EFUSE,
+	ENABLE_SCLK_PERIS_SECURE_ANTIRBK_CNT,
+	ENABLE_SCLK_PERIS_SECURE_OTP_CON,
+	ENABLE_IP_PERIS0,
+	ENABLE_IP_PERIS1,
+	ENABLE_IP_PERIS_SECURE_TZPC,
+	ENABLE_IP_PERIS_SECURE_SECKEY,
+	ENABLE_IP_PERIS_SECURE_CHIPID,
+	ENABLE_IP_PERIS_SECURE_TOPRTC,
+	ENABLE_IP_PERIS_SECURE_CUSTOM_EFUSE,
+	ENABLE_IP_PERIS_SECURE_ANTIBRK_CNT,
+	ENABLE_IP_PERIS_SECURE_OTP_CON,
 };
 
 static struct samsung_gate_clock peris_gate_clks[] __initdata = {
+	/* ENABLE_ACLK_PERIS */
+	GATE(CLK_ACLK_AHB2APB_PERIS1P, "aclk_ahb2apb_peris1p", "aclk_peris_66",
+			ENABLE_ACLK_PERIS, 2, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_AHB2APB_PERIS0P, "aclk_ahb2apb_peris0p", "aclk_peris_66",
+			ENABLE_ACLK_PERIS, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PERISNP_66, "aclk_perisnp_66", "aclk_peris_66",
+			ENABLE_ACLK_PERIS, 0, CLK_IGNORE_UNUSED, 0),
+
 	/* ENABLE_PCLK_PERIS */
 	GATE(CLK_PCLK_HPM_APBIF, "pclk_hpm_apbif", "aclk_peris_66",
 			ENABLE_PCLK_PERIS, 30, CLK_IGNORE_UNUSED, 0),
@@ -989,6 +1044,93 @@ static struct samsung_gate_clock peris_gate_clks[] __initdata = {
 			ENABLE_PCLK_PERIS, 15, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_PCLK_HDMI_CEC, "pclk_hdmi_cec", "aclk_peris_66",
 			ENABLE_PCLK_PERIS, 14, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_PCLK_PERIS_SECURE_TZPC */
+	GATE(CLK_PCLK_TZPC12, "pclk_tzpc12", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 12, 0, 0),
+	GATE(CLK_PCLK_TZPC11, "pclk_tzpc11", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 11, 0, 0),
+	GATE(CLK_PCLK_TZPC10, "pclk_tzpc10", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 10, 0, 0),
+	GATE(CLK_PCLK_TZPC9, "pclk_tzpc9", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 9, 0, 0),
+	GATE(CLK_PCLK_TZPC8, "pclk_tzpc8", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 8, 0, 0),
+	GATE(CLK_PCLK_TZPC7, "pclk_tzpc7", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 7, 0, 0),
+	GATE(CLK_PCLK_TZPC6, "pclk_tzpc6", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 6, 0, 0),
+	GATE(CLK_PCLK_TZPC5, "pclk_tzpc5", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 5, 0, 0),
+	GATE(CLK_PCLK_TZPC4, "pclk_tzpc4", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 4, 0, 0),
+	GATE(CLK_PCLK_TZPC3, "pclk_tzpc3", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 3, 0, 0),
+	GATE(CLK_PCLK_TZPC2, "pclk_tzpc2", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 2, 0, 0),
+	GATE(CLK_PCLK_TZPC1, "pclk_tzpc1", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 1, 0, 0),
+	GATE(CLK_PCLK_TZPC0, "pclk_tzpc0", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TZPC, 0, 0, 0),
+
+	/* ENABLE_PCLK_PERIS_SECURE_SECKEY_APBIF */
+	GATE(CLK_PCLK_SECKEY_APBIF, "pclk_seckey_apbif", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_SECKEY_APBIF, 0, 0, 0),
+
+	/* ENABLE_PCLK_PERIS_SECURE_CHIPID_APBIF */
+	GATE(CLK_PCLK_CHIPID_APBIF, "pclk_chipid_apbif", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_CHIPID_APBIF, 0, 0, 0),
+
+	/* ENABLE_PCLK_PERIS_SECURE_TOPRTC */
+	GATE(CLK_PCLK_TOPRTC, "pclk_toprtc", "aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_TOPRTC, 0, 0, 0),
+
+	/* ENABLE_PCLK_PERIS_SECURE_CUSTOM_EFUSE_APBIF */
+	GATE(CLK_PCLK_CUSTOM_EFUSE_APBIF, "pclk_custom_efuse_apbif",
+			"aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_CUSTOM_EFUSE_APBIF, 0, 0, 0),
+
+	/* ENABLE_PCLK_PERIS_SECURE_ANTIRBK_CNT_APBIF */
+	GATE(CLK_PCLK_ANTIRBK_CNT_APBIF, "pclk_antirbk_cnt_apbif",
+			"aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_ANTIRBK_CNT_APBIF, 0, 0, 0),
+
+	/* ENABLE_PCLK_PERIS_SECURE_OTP_CON_APBIF */
+	GATE(CLK_PCLK_OTP_CON_APBIF, "pclk_otp_con_apbif",
+			"aclk_peris_66",
+			ENABLE_PCLK_PERIS_SECURE_OTP_CON_APBIF, 0, 0, 0),
+
+	/* ENABLE_SCLK_PERIS */
+	GATE(CLK_SCLK_ASV_TB, "sclk_asv_tb", "oscclk_efuse_common",
+			ENABLE_SCLK_PERIS, 10, 0, 0),
+	GATE(CLK_SCLK_TMU1, "sclk_tmu1", "oscclk_efuse_common",
+			ENABLE_SCLK_PERIS, 4, 0, 0),
+	GATE(CLK_SCLK_TMU0, "sclk_tmu0", "oscclk_efuse_common",
+			ENABLE_SCLK_PERIS, 3, 0, 0),
+
+	/* ENABLE_SCLK_PERIS_SECURE_SECKEY */
+	GATE(CLK_SCLK_SECKEY, "sclk_seckey", "oscclk_efuse_common",
+			ENABLE_SCLK_PERIS_SECURE_SECKEY, 0, 0, 0),
+
+	/* ENABLE_SCLK_PERIS_SECURE_CHIPID */
+	GATE(CLK_SCLK_CHIPID, "sclk_chipid", "oscclk_efuse_common",
+			ENABLE_SCLK_PERIS_SECURE_CHIPID, 0, 0, 0),
+
+	/* ENABLE_SCLK_PERIS_SECURE_TOPRTC */
+	GATE(CLK_SCLK_TOPRTC, "sclk_toprtc", "oscclk_efuse_common",
+			ENABLE_SCLK_PERIS_SECURE_TOPRTC, 0, 0, 0),
+
+	/* ENABLE_SCLK_PERIS_SECURE_CUSTOM_EFUSE */
+	GATE(CLK_SCLK_CUSTOM_EFUSE, "sclk_custom_efuse", "oscclk_efuse_common",
+			ENABLE_SCLK_PERIS_SECURE_CUSTOM_EFUSE, 0, 0, 0),
+
+	/* ENABLE_SCLK_PERIS_SECURE_ANTIRBK_CNT */
+	GATE(CLK_SCLK_ANTIRBK_CNT, "sclk_antirbk_cnt", "oscclk_efuse_common",
+			ENABLE_SCLK_PERIS_SECURE_ANTIRBK_CNT, 0, 0, 0),
+
+	/* ENABLE_SCLK_PERIS_SECURE_OTP_CON */
+	GATE(CLK_SCLK_OTP_CON, "sclk_otp_con", "oscclk_efuse_common",
+			ENABLE_SCLK_PERIS_SECURE_OTP_CON, 0, 0, 0),
 };
 
 static struct samsung_cmu_info peris_cmu_info __initdata = {
diff --git a/include/dt-bindings/clock/exynos5433.h b/include/dt-bindings/clock/exynos5433.h
index 3d7d0cf..5c34631 100644
--- a/include/dt-bindings/clock/exynos5433.h
+++ b/include/dt-bindings/clock/exynos5433.h
@@ -228,8 +228,39 @@
 #define	CLK_PCLK_WDT_ATLAS		8
 #define	CLK_PCLK_MCT			9
 #define	CLK_PCLK_HDMI_CEC		10
+#define CLK_ACLK_AHB2APB_PERIS1P	11
+#define CLK_ACLK_AHB2APB_PERIS0P	12
+#define CLK_ACLK_PERISNP_66		13
+#define CLK_PCLK_TZPC12			14
+#define CLK_PCLK_TZPC11			15
+#define CLK_PCLK_TZPC10			16
+#define CLK_PCLK_TZPC9			17
+#define CLK_PCLK_TZPC8			18
+#define CLK_PCLK_TZPC7			19
+#define CLK_PCLK_TZPC6			20
+#define CLK_PCLK_TZPC5			21
+#define CLK_PCLK_TZPC4			22
+#define CLK_PCLK_TZPC3			23
+#define CLK_PCLK_TZPC2			24
+#define CLK_PCLK_TZPC1			25
+#define CLK_PCLK_TZPC0			26
+#define CLK_PCLK_SECKEY_APBIF		27
+#define CLK_PCLK_CHIPID_APBIF		28
+#define CLK_PCLK_TOPRTC			29
+#define CLK_PCLK_CUSTOM_EFUSE_APBIF	30
+#define CLK_PCLK_ANTIRBK_CNT_APBIF	31
+#define CLK_PCLK_OTP_CON_APBIF		32
+#define CLK_SCLK_ASV_TB			33
+#define CLK_SCLK_TMU1			34
+#define CLK_SCLK_TMU0			35
+#define CLK_SCLK_SECKEY			36
+#define CLK_SCLK_CHIPID			37
+#define CLK_SCLK_TOPRTC			38
+#define CLK_SCLK_CUSTOM_EFUSE		39
+#define CLK_SCLK_ANTIRBK_CNT		40
+#define CLK_SCLK_OTP_CON		41
 
-#define PERIS_NR_CLK			11
+#define PERIS_NR_CLK			42
 
 /* CMU_FSYS */
 #define CLK_MOUT_ACLK_FSYS_200_USER	1
-- 
1.8.5.5

From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sat,  2 Oct 2010 17:15:28 +0200
Subject: [PATCH 3/4] i.mx25: add esdhc support
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1286032529-26509-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/clock.c            |   22 ++++++++++++++++++++++
 arch/arm/mach-mx25/devices-imx25.h    |    5 +++++
 arch/arm/plat-mxc/include/mach/mx25.h |    4 ++++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 40c7cc4..7a3d4e6 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -139,6 +139,16 @@ static unsigned long get_rate_lcdc(struct clk *clk)
 	return get_rate_per(7);
 }
 
+static unsigned long get_rate_esdhc1(struct clk *clk)
+{
+	return get_rate_per(3);
+}
+
+static unsigned long get_rate_esdhc2(struct clk *clk)
+{
+	return get_rate_per(4);
+}
+
 static unsigned long get_rate_csi(struct clk *clk)
 {
 	return get_rate_per(0);
@@ -213,6 +223,12 @@ DEFINE_CLOCK(ssi2_per_clk, 0, CCM_CGCR0, 14, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(esdhc1_ahb_clk, 0, CCM_CGCR0, 21, get_rate_esdhc1,	 NULL, NULL);
+DEFINE_CLOCK(esdhc1_per_clk, 0, CCM_CGCR0,  3, get_rate_esdhc1,	 NULL,
+		&esdhc1_ahb_clk);
+DEFINE_CLOCK(esdhc2_ahb_clk, 0, CCM_CGCR0, 22, get_rate_esdhc2,	 NULL, NULL);
+DEFINE_CLOCK(esdhc2_per_clk, 0, CCM_CGCR0,  4, get_rate_esdhc2,	 NULL,
+		&esdhc2_ahb_clk);
 DEFINE_CLOCK(fec_ahb_clk, 0, CCM_CGCR0, 23, NULL,	 NULL, NULL);
 DEFINE_CLOCK(lcdc_ahb_clk, 0, CCM_CGCR0, 24, NULL,	 NULL, NULL);
 DEFINE_CLOCK(lcdc_per_clk, 0, CCM_CGCR0,  7, NULL,	 NULL, &lcdc_ahb_clk);
@@ -238,6 +254,10 @@ DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
 DEFINE_CLOCK(wdt_clk,    0, CCM_CGCR2, 19, get_rate_ipg, NULL,  NULL);
 DEFINE_CLOCK(ssi1_clk,  0, CCM_CGCR2, 11, get_rate_ssi1, NULL, &ssi1_per_clk);
 DEFINE_CLOCK(ssi2_clk,  1, CCM_CGCR2, 12, get_rate_ssi2, NULL, &ssi2_per_clk);
+DEFINE_CLOCK(esdhc1_clk,  0, CCM_CGCR1, 13, get_rate_esdhc1, NULL,
+		&esdhc1_per_clk);
+DEFINE_CLOCK(esdhc2_clk,  1, CCM_CGCR1, 14, get_rate_esdhc2, NULL,
+		&esdhc2_per_clk);
 DEFINE_CLOCK(audmux_clk, 0, CCM_CGCR1, 0, NULL, NULL, NULL);
 DEFINE_CLOCK(csi_clk,    0, CCM_CGCR1,  4, get_rate_csi, NULL,  &csi_per_clk);
 DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
@@ -279,6 +299,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx-wdt.0", NULL, wdt_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
+	_REGISTER_CLOCK(NULL, "sdhc", esdhc1_clk)
+	_REGISTER_CLOCK(NULL, "sdhc", esdhc2_clk)
 	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
 	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index d86a7c3..4acb0c9 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -41,3 +41,8 @@
 	imx_add_spi_imx(1, MX25_CSPI2_BASE_ADDR, SZ_16K, MX25_INT_CSPI2, pdata)
 #define imx25_add_spi_imx2(pdata)	\
 	imx_add_spi_imx(2, MX25_CSPI3_BASE_ADDR, SZ_16K, MX25_INT_CSPI3, pdata)
+
+#define imx25_add_esdhc0(pdata)	\
+	imx_add_esdhc(0, MX25_ESDHC1_BASE_ADDR, SZ_16K, MX25_INT_MMC_SDHC1, pdata)
+#define imx25_add_esdhc1(pdata)	\
+	imx_add_esdhc(1, MX25_ESDHC2_BASE_ADDR, SZ_16K, MX25_INT_MMC_SDHC2, pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 4a6f800..67060e9 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -50,6 +50,8 @@
 #define MX25_SSI1_BASE_ADDR		0x50034000
 #define MX25_NFC_BASE_ADDR		0xbb000000
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
+#define MX25_ESDHC1_BASE_ADDR		0x53fb4000
+#define MX25_ESDHC2_BASE_ADDR		0x53fb8000
 #define MX25_LCDC_BASE_ADDR		0x53fbc000
 #define MX25_KPP_BASE_ADDR		0x43fa8000
 #define MX25_OTG_BASE_ADDR		0x53ff4000
@@ -59,6 +61,8 @@
 #define MX25_INT_I2C1		3
 #define MX25_INT_I2C2		4
 #define MX25_INT_UART4		5
+#define MX25_INT_MMC_SDHC2	8
+#define MX25_INT_MMC_SDHC1	9
 #define MX25_INT_I2C3		10
 #define MX25_INT_SSI2		11
 #define MX25_INT_SSI1		12
-- 
1.7.0.4

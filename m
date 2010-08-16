From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Mon, 16 Aug 2010 15:54:07 +0200
Subject: [PATCH|RESEND 4/4] clock-imx35: Calculate the base clock rate for the
	IPU unit
In-Reply-To: <1281966847-553-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1281966847-553-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1281966847-553-5-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

The mx3fb driver needs the clock the IPU runs in order to calculate
the divider for the LCD clock. This patch adds the clock rate calculation
routine for the i.MX35 CPU.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 009156d..9b7dbcc 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -300,6 +300,33 @@ static unsigned long get_rate_ipg_per(struct clk *clk)
 	}
 }
 
+static unsigned long get_rate_hsp(struct clk *clk)
+{
+	unsigned long hsp_podf = (__raw_readl(CCM_BASE + CCM_PDR0) >> 20) & 0x03;
+	unsigned long fref = get_rate_mpll();
+
+	if (fref > 400 * 1000 * 1000) {
+		switch (hsp_podf) {
+		case 0:
+			return fref >> 2;
+		case 1:
+			return fref >> 3;
+		case 2:
+			return fref / 3;
+		}
+	} else {
+		switch (hsp_podf) {
+		case 0:
+		case 2:
+			return fref / 3;
+		case 1:
+			return fref / 6;
+		}
+	}
+
+	return 0;
+}
+
 static int clk_cgr_enable(struct clk *clk)
 {
 	u32 reg;
@@ -357,7 +384,7 @@ DEFINE_CLOCK(i2c1_clk,   0, CCM_CGR1, 10, get_rate_ipg_per, NULL);
 DEFINE_CLOCK(i2c2_clk,   1, CCM_CGR1, 12, get_rate_ipg_per, NULL);
 DEFINE_CLOCK(i2c3_clk,   2, CCM_CGR1, 14, get_rate_ipg_per, NULL);
 DEFINE_CLOCK(iomuxc_clk, 0, CCM_CGR1, 16, NULL, NULL);
-DEFINE_CLOCK(ipu_clk,    0, CCM_CGR1, 18, get_rate_ahb, NULL);
+DEFINE_CLOCK(ipu_clk,    0, CCM_CGR1, 18, get_rate_hsp, NULL);
 DEFINE_CLOCK(kpp_clk,    0, CCM_CGR1, 20, get_rate_ipg, NULL);
 DEFINE_CLOCK(mlb_clk,    0, CCM_CGR1, 22, get_rate_ahb, NULL);
 DEFINE_CLOCK(mshc_clk,   0, CCM_CGR1, 24, get_rate_mshc, NULL);
-- 
1.7.1

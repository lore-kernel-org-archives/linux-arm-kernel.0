From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 20 Apr 2011 13:28:41 -0600
Subject: [PATCH 2/5] OMAP4: clock data: Change DSS clock aliases
In-Reply-To: <20110420192601.16986.56558.stgit@twilight.localdomain>
References: <20110420192601.16986.56558.stgit@twilight.localdomain>
Message-ID: <20110420192839.16986.17445.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS driver has used fck and ick clocks on OMAP2/3 to get DSS HW up and
running, and also to get the pixel clock's source clock rate from the
fck.

On OMAP4 the clock data is set up in a different way, as there's no ick,
dss_fck points to a fake clock which just affects DSS's MODULEMODE, and
dss_dss_clk if the DSS_FCK.

>From DSS driver's point of view the dss_fck sounds like an ick, and
dss_dss_clk is the fck. While this is not entirely correct from HW point
of view, especially for the ick, configuring the clock aliases that way
makes DSS "just work" with OMAP4's clock setup.

In the (hopefully near) future DSS driver will be reworked to use
pm_runtime support which should clean up the clock code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 276992d..8c96567 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3116,14 +3116,9 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
 	CLK("omapdss_dss",	"sys_clk",			&dss_sys_clk,	CK_443X),
 	CLK("omapdss_dss",	"tv_clk",			&dss_tv_clk,	CK_443X),
-	CLK("omapdss_dss",	"dss_clk",			&dss_dss_clk,	CK_443X),
 	CLK("omapdss_dss",	"video_clk",			&dss_48mhz_clk,	CK_443X),
-	CLK("omapdss_dss",	"fck",				&dss_fck,	CK_443X),
-	/*
-	 * On OMAP4, DSS ick is a dummy clock; this is needed for compatibility
-	 * with OMAP2/3.
-	 */
-	CLK("omapdss_dss",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omapdss_dss",	"fck",				&dss_dss_clk,	CK_443X),
+	CLK("omapdss_dss",	"ick",				&dss_fck,	CK_443X),
 	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
 	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
 	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),

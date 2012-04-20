From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 20 Apr 2012 18:09:22 +0530
Subject: [PATCH v2 3/4] ARM: OMAP2+: dmtimer: cleanup iclk usage
In-Reply-To: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1334925563-20768-4-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do not use iclk anywhere in the dmtimer driver and so removing it.
Hence removing the timer iclk entries from OMAP4 clkdev table as well.

Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c      |   11 -----------
 arch/arm/mach-omap2/timer.c               |    7 -------
 arch/arm/plat-omap/include/plat/dmtimer.h |    2 +-
 3 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index fa6ea65..2172f66 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3355,17 +3355,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
 	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt3_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt4_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt5_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt6_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt7_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt8_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt9_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt10_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt11_ick",			&dummy_ck,	CK_443X),
 	CLK("omap_i2c.1",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_i2c.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_i2c.3",	"ick",				&dummy_ck,	CK_443X),
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index c512bac..5d7a0ee 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -169,13 +169,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (IS_ERR(timer->fclk))
 		return -ENODEV;
 
-	sprintf(name, "gpt%d_ick", gptimer_id);
-	timer->iclk = clk_get(NULL, name);
-	if (IS_ERR(timer->iclk)) {
-		clk_put(timer->fclk);
-		return -ENODEV;
-	}
-
 	omap_hwmod_enable(oh);
 
 	sys_timer_reserved |= (1 << (gptimer_id - 1));
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 9418f00..be2b8c4 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -259,7 +259,7 @@ struct omap_dm_timer {
 	unsigned long phys_base;
 	int id;
 	int irq;
-	struct clk *iclk, *fclk;
+	struct clk *fclk;
 
 	void __iomem	*io_base;
 	void __iomem	*sys_stat;	/* TISTAT timer status */
-- 
1.7.0.4

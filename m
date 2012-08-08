From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  8 Aug 2012 12:11:40 +0300
Subject: [PATCH 10/11] ASoC: omap-mcbsp: Remove cpu_is_omap* checks from the
 code
In-Reply-To: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1344417101-5015-11-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can use the has_ccr flag to replace the cpu_is_omap* checks.
This provides future proof implementation and we do not need to update the
code if new OMAP revision starts to use the McBSP driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 5061594..b9770ee 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -398,12 +398,14 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* Generic McBSP register settings */
 	regs->spcr2	|= XINTM(3) | FREE;
 	regs->spcr1	|= RINTM(3);
-	/* RFIG and XFIG are not defined in 34xx */
-	if (!cpu_is_omap34xx() && !cpu_is_omap44xx()) {
+	/* RFIG and XFIG are not defined in 2430 and on OMAP3+ */
+	if (!mcbsp->pdata->has_ccr) {
 		regs->rcr2	|= RFIG;
 		regs->xcr2	|= XFIG;
 	}
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+
+	/* Configure XCCR/RCCR only for revisions which have ccr registers */
+	if (mcbsp->pdata->has_ccr) {
 		regs->xccr = DXENDLY(1) | XDMAEN | XDISABLE;
 		regs->rccr = RFULL_CYCLE | RDMAEN | RDISABLE;
 	}
-- 
1.7.8.6

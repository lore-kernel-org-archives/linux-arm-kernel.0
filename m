From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 15 Nov 2014 22:51:46 +0300
Subject: [PATCH] ASoC: pxa: prepare/unprepare clocks in pxa-ssp
Message-ID: <1416081106-28324-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change clk_enable/disable() calls to clk_prepare_enable() and
clk_disable_unrepapre().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index a8e0974..cbba063 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -97,7 +97,7 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 	int ret = 0;
 
 	if (!cpu_dai->active) {
-		clk_enable(ssp->clk);
+		clk_prepare_enable(ssp->clk);
 		pxa_ssp_disable(ssp);
 	}
 
@@ -121,7 +121,7 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 
 	if (!cpu_dai->active) {
 		pxa_ssp_disable(ssp);
-		clk_disable(ssp->clk);
+		clk_disable_unprepare(ssp->clk);
 	}
 
 	kfree(snd_soc_dai_get_dma_data(cpu_dai, substream));
@@ -136,7 +136,7 @@ static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
 	struct ssp_device *ssp = priv->ssp;
 
 	if (!cpu_dai->active)
-		clk_enable(ssp->clk);
+		clk_prepare_enable(ssp->clk);
 
 	priv->cr0 = __raw_readl(ssp->mmio_base + SSCR0);
 	priv->cr1 = __raw_readl(ssp->mmio_base + SSCR1);
@@ -144,7 +144,7 @@ static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
 	priv->psp = __raw_readl(ssp->mmio_base + SSPSP);
 
 	pxa_ssp_disable(ssp);
-	clk_disable(ssp->clk);
+	clk_disable_unprepare(ssp->clk);
 	return 0;
 }
 
@@ -154,7 +154,7 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 	struct ssp_device *ssp = priv->ssp;
 	uint32_t sssr = SSSR_ROR | SSSR_TUR | SSSR_BCE;
 
-	clk_enable(ssp->clk);
+	clk_prepare_enable(ssp->clk);
 
 	__raw_writel(sssr, ssp->mmio_base + SSSR);
 	__raw_writel(priv->cr0 & ~SSCR0_SSE, ssp->mmio_base + SSCR0);
@@ -165,7 +165,7 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 	if (cpu_dai->active)
 		pxa_ssp_enable(ssp);
 	else
-		clk_disable(ssp->clk);
+		clk_disable_unprepare(ssp->clk);
 
 	return 0;
 }
@@ -256,11 +256,11 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	/* The SSP clock must be disabled when changing SSP clock mode
 	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
 	if (ssp->type != PXA3xx_SSP)
-		clk_disable(ssp->clk);
+		clk_disable_unprepare(ssp->clk);
 	val = pxa_ssp_read_reg(ssp, SSCR0) | sscr0;
 	pxa_ssp_write_reg(ssp, SSCR0, val);
 	if (ssp->type != PXA3xx_SSP)
-		clk_enable(ssp->clk);
+		clk_prepare_enable(ssp->clk);
 
 	return 0;
 }
-- 
2.1.1

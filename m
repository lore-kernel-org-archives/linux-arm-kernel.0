From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 25 Jul 2017 15:46:10 +0530
Subject: [PATCH 11/11] ASoC: pxa-ssp: Handle return value of
 clk_prepare_enable.
In-Reply-To: <1500977770-28142-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500977770-28142-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1500977770-28142-2-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 0291c7c..dad5cf62 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -97,7 +97,10 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 	int ret = 0;
 
 	if (!cpu_dai->active) {
-		clk_prepare_enable(ssp->clk);
+		ret = clk_prepare_enable(ssp->clk);
+		if (ret)
+			return ret;
+
 		pxa_ssp_disable(ssp);
 	}
 
@@ -134,9 +137,13 @@ static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
 {
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
+	int ret;
 
-	if (!cpu_dai->active)
-		clk_prepare_enable(ssp->clk);
+	if (!cpu_dai->active) {
+		ret = clk_prepare_enable(ssp->clk);
+		if (ret)
+			return ret;
+	}
 
 	priv->cr0 = __raw_readl(ssp->mmio_base + SSCR0);
 	priv->cr1 = __raw_readl(ssp->mmio_base + SSCR1);
@@ -153,8 +160,11 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
 	uint32_t sssr = SSSR_ROR | SSSR_TUR | SSSR_BCE;
+	int ret;
 
-	clk_prepare_enable(ssp->clk);
+	ret = clk_prepare_enable(ssp->clk);
+	if (ret)
+		return ret;
 
 	__raw_writel(sssr, ssp->mmio_base + SSSR);
 	__raw_writel(priv->cr0 & ~SSCR0_SSE, ssp->mmio_base + SSCR0);
@@ -217,6 +227,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
 	int val;
+	int ret = 0;
 
 	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
 		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
@@ -260,9 +271,9 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	val = pxa_ssp_read_reg(ssp, SSCR0) | sscr0;
 	pxa_ssp_write_reg(ssp, SSCR0, val);
 	if (ssp->type != PXA3xx_SSP)
-		clk_prepare_enable(ssp->clk);
+		ret = clk_prepare_enable(ssp->clk);
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
1.9.1

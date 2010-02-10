From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 10 Feb 2010 13:17:48 +0000
Subject: [PATCH 2/2] ASoC: Remove legacy PXA SSP API usage
In-Reply-To: <f17812d71002100421v6e8e36c5n7e3786b55311b76a@mail.gmail.com>
References: <f17812d71002100421v6e8e36c5n7e3786b55311b76a@mail.gmail.com>
Message-ID: <20100210131748.GB27173@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2010 at 08:21:30PM +0800, Eric Miao wrote:
> commit c7b67965c24aae11b7ea36522b27b63057ed81e5
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Tue Feb 9 19:46:01 2010 +0800
> 
>     ASoC: Remove legacy SSP API usage
> 
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Makes sense to merge this via the ARM tree due to the overlap with
moving the header to plat/

> diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
> index 89de275..376e14a 100644
> --- a/sound/soc/pxa/Kconfig
> +++ b/sound/soc/pxa/Kconfig
> @@ -23,7 +23,6 @@ config SND_PXA2XX_SOC_I2S
> 
>  config SND_PXA_SOC_SSP
>  	tristate
> -	select PXA_SSP_LEGACY
> 
>  config SND_PXA2XX_SOC_CORGI
>  	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index 532277b..b90e9e7 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -32,7 +32,7 @@
>  #include <mach/hardware.h>
>  #include <mach/dma.h>
>  #include <mach/audio.h>
> -#include <mach/ssp.h>
> +#include <plat/ssp.h>
> 
>  #include "pxa2xx-pcm.h"
>  #include "pxa-ssp.h"
> @@ -41,11 +41,14 @@
>   * SSP audio private data
>   */
>  struct ssp_priv {
> -	struct ssp_dev dev;
> +	struct ssp_device *ssp;
>  	unsigned int sysclk;
>  	int dai_fmt;
>  #ifdef CONFIG_PM
> -	struct ssp_state state;
> +	uint32_t	cr0;
> +	uint32_t	cr1;
> +	uint32_t	to;
> +	uint32_t	psp;
>  #endif
>  };
> 
> @@ -60,6 +63,22 @@ static void dump_registers(struct ssp_device *ssp)
>  		 ssp_read_reg(ssp, SSACD));
>  }
> 
> +static void ssp_enable(struct ssp_device *ssp)
> +{
> +	uint32_t sscr0;
> +
> +	sscr0 = __raw_readl(ssp->mmio_base + SSCR0) | SSCR0_SSE;
> +	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
> +}
> +
> +static void ssp_disable(struct ssp_device *ssp)
> +{
> +	uint32_t sscr0;
> +
> +	sscr0 = __raw_readl(ssp->mmio_base + SSCR0) & ~SSCR0_SSE;
> +	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
> +}
> +
>  struct pxa2xx_pcm_dma_data {
>  	struct pxa2xx_pcm_dma_params params;
>  	char name[20];
> @@ -93,13 +112,12 @@ static int pxa_ssp_startup(struct
> snd_pcm_substream *substream,
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
>  	struct ssp_priv *priv = cpu_dai->private_data;
> +	struct ssp_device *ssp = priv->ssp;
>  	int ret = 0;
> 
>  	if (!cpu_dai->active) {
> -		priv->dev.port = cpu_dai->id + 1;
> -		priv->dev.irq = NO_IRQ;
> -		clk_enable(priv->dev.ssp->clk);
> -		ssp_disable(&priv->dev);
> +		clk_enable(ssp->clk);
> +		ssp_disable(ssp);
>  	}
> 
>  	if (cpu_dai->dma_data) {
> @@ -115,10 +133,11 @@ static void pxa_ssp_shutdown(struct
> snd_pcm_substream *substream,
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
>  	struct ssp_priv *priv = cpu_dai->private_data;
> +	struct ssp_device *ssp = priv->ssp;
> 
>  	if (!cpu_dai->active) {
> -		ssp_disable(&priv->dev);
> -		clk_disable(priv->dev.ssp->clk);
> +		ssp_disable(ssp);
> +		clk_disable(ssp->clk);
>  	}
> 
>  	if (cpu_dai->dma_data) {
> @@ -132,26 +151,39 @@ static void pxa_ssp_shutdown(struct
> snd_pcm_substream *substream,
>  static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
>  {
>  	struct ssp_priv *priv = cpu_dai->private_data;
> +	struct ssp_device *ssp = priv->ssp;
> 
>  	if (!cpu_dai->active)
>  		return 0;
> 
> -	ssp_save_state(&priv->dev, &priv->state);
> -	clk_disable(priv->dev.ssp->clk);
> +	priv->cr0 = __raw_readl(ssp->mmio_base + SSCR0);
> +	priv->cr1 = __raw_readl(ssp->mmio_base + SSCR1);
> +	priv->to  = __raw_readl(ssp->mmio_base + SSTO);
> +	priv->psp = __raw_readl(ssp->mmio_base + SSPSP);
> +
> +	ssp_disable(ssp);
> +	clk_disable(ssp->clk);
>  	return 0;
>  }
> 
>  static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
>  {
>  	struct ssp_priv *priv = cpu_dai->private_data;
> +	struct ssp_device *ssp = priv->ssp;
> +	uint32_t sssr = SSSR_ROR | SSSR_TUR | SSSR_BCE;
> 
>  	if (!cpu_dai->active)
>  		return 0;
> 
> -	clk_enable(priv->dev.ssp->clk);
> -	ssp_restore_state(&priv->dev, &priv->state);
> -	ssp_enable(&priv->dev);
> +	clk_enable(ssp->clk);
> +
> +	__raw_writel(sssr, ssp->mmio_base + SSSR);
> 
> +	__raw_writel(priv->cr0 & ~SSCR0_SSE, ssp->mmio_base + SSCR0);
> +	__raw_writel(priv->cr1, ssp->mmio_base + SSCR1);
> +	__raw_writel(priv->to,  ssp->mmio_base + SSTO);
> +	__raw_writel(priv->psp, ssp->mmio_base + SSPSP);
> +	__raw_writel(priv->cr0 | SSCR0_SSE, ssp->mmio_base + SSCR0);
>  	return 0;
>  }
> 
> @@ -200,7 +232,7 @@ static int pxa_ssp_set_dai_sysclk(struct
> snd_soc_dai *cpu_dai,
>  	int clk_id, unsigned int freq, int dir)
>  {
>  	struct ssp_priv *priv = cpu_dai->private_data;
> -	struct ssp_device *ssp = priv->dev.ssp;
> +	struct ssp_device *ssp = priv->ssp;
>  	int val;
> 
>  	u32 sscr0 = ssp_read_reg(ssp, SSCR0) &
> @@ -241,11 +273,11 @@ static int pxa_ssp_set_dai_sysclk(struct
> snd_soc_dai *cpu_dai,
>  	/* The SSP clock must be disabled when changing SSP clock mode
>  	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
>  	if (!cpu_is_pxa3xx())
> -		clk_disable(priv->dev.ssp->clk);
> +		clk_disable(ssp->clk);
>  	val = ssp_read_reg(ssp, SSCR0) | sscr0;
>  	ssp_write_reg(ssp, SSCR0, val);
>  	if (!cpu_is_pxa3xx())
> -		clk_enable(priv->dev.ssp->clk);
> +		clk_enable(ssp->clk);
> 
>  	return 0;
>  }
> @@ -257,7 +289,7 @@ static int pxa_ssp_set_dai_clkdiv(struct
> snd_soc_dai *cpu_dai,
>  	int div_id, int div)
>  {
>  	struct ssp_priv *priv = cpu_dai->private_data;
> -	struct ssp_device *ssp = priv->dev.ssp;
> +	struct ssp_device *ssp = priv->ssp;
>  	int val;
> 
>  	switch (div_id) {
> @@ -308,7 +340,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai
> *cpu_dai, int pll_id,
>  	int source, unsigned int freq_in, unsigned int freq_out)
>  {
>  	struct ssp_priv *priv = cpu_dai->private_data;
> -	struct ssp_device *ssp = priv->dev.ssp;
> +	struct ssp_device *ssp = priv->ssp;
>  	u32 ssacd = ssp_read_reg(ssp, SSACD) & ~0x70;
> 
>  #if defined(CONFIG_PXA3xx)
> @@ -377,7 +409,7 @@ static int pxa_ssp_set_dai_tdm_slot(struct
> snd_soc_dai *cpu_dai,
>  	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
>  {
>  	struct ssp_priv *priv = cpu_dai->private_data;
> -	struct ssp_device *ssp = priv->dev.ssp;
> +	struct ssp_device *ssp = priv->ssp;
>  	u32 sscr0;
> 
>  	sscr0 = ssp_read_reg(ssp, SSCR0);
> @@ -412,7 +444,7 @@ static int pxa_ssp_set_dai_tristate(struct
> snd_soc_dai *cpu_dai,
>  	int tristate)
>  {
>  	struct ssp_priv *priv = cpu_dai->private_data;
> -	struct ssp_device *ssp = priv->dev.ssp;
> +	struct ssp_device *ssp = priv->ssp;
>  	u32 sscr1;
> 
>  	sscr1 = ssp_read_reg(ssp, SSCR1);
> @@ -434,7 +466,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  		unsigned int fmt)
>  {
>  	struct ssp_priv *priv = cpu_dai->private_data;
> -	struct ssp_device *ssp = priv->dev.ssp;
> +	struct ssp_device *ssp = priv->ssp;
>  	u32 sscr0;
>  	u32 sscr1;
>  	u32 sspsp;
> @@ -529,7 +561,7 @@ static int pxa_ssp_hw_params(struct
> snd_pcm_substream *substream,
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
>  	struct ssp_priv *priv = cpu_dai->private_data;
> -	struct ssp_device *ssp = priv->dev.ssp;
> +	struct ssp_device *ssp = priv->ssp;
>  	int chn = params_channels(params);
>  	u32 sscr0;
>  	u32 sspsp;
> @@ -639,12 +671,12 @@ static int pxa_ssp_trigger(struct
> snd_pcm_substream *substream, int cmd,
>  	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
>  	int ret = 0;
>  	struct ssp_priv *priv = cpu_dai->private_data;
> -	struct ssp_device *ssp = priv->dev.ssp;
> +	struct ssp_device *ssp = priv->ssp;
>  	int val;
> 
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_RESUME:
> -		ssp_enable(&priv->dev);
> +		ssp_enable(ssp);
>  		break;
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		val = ssp_read_reg(ssp, SSCR1);
> @@ -663,7 +695,7 @@ static int pxa_ssp_trigger(struct
> snd_pcm_substream *substream, int cmd,
>  		else
>  			val |= SSCR1_RSRE;
>  		ssp_write_reg(ssp, SSCR1, val);
> -		ssp_enable(&priv->dev);
> +		ssp_enable(ssp);
>  		break;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  		val = ssp_read_reg(ssp, SSCR1);
> @@ -674,7 +706,7 @@ static int pxa_ssp_trigger(struct
> snd_pcm_substream *substream, int cmd,
>  		ssp_write_reg(ssp, SSCR1, val);
>  		break;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
> -		ssp_disable(&priv->dev);
> +		ssp_disable(ssp);
>  		break;
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		val = ssp_read_reg(ssp, SSCR1);
> @@ -704,8 +736,8 @@ static int pxa_ssp_probe(struct platform_device *pdev,
>  	if (!priv)
>  		return -ENOMEM;
> 
> -	priv->dev.ssp = ssp_request(dai->id + 1, "SoC audio");
> -	if (priv->dev.ssp == NULL) {
> +	priv->ssp = ssp_request(dai->id + 1, "SoC audio");
> +	if (priv->ssp == NULL) {
>  		ret = -ENODEV;
>  		goto err_priv;
>  	}
> @@ -724,7 +756,7 @@ static void pxa_ssp_remove(struct platform_device *pdev,
>  			      struct snd_soc_dai *dai)
>  {
>  	struct ssp_priv *priv = dai->private_data;
> -	ssp_free(priv->dev.ssp);
> +	ssp_free(priv->ssp);
>  }
> 
>  #define PXA_SSP_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."

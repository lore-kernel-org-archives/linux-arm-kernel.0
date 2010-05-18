From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 May 2010 19:33:03 +0100
Subject: [RFC PATCH 1/3] ep93xx i2s driver
In-Reply-To: <4BF21D48.3020005@bluewatersys.com>
References: <4BF21B67.8090404@bluewatersys.com>
	<4BF21D48.3020005@bluewatersys.com>
Message-ID: <20100518183302.GC22554@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 04:53:28PM +1200, Ryan Mallon wrote:

> index 0000000..6af5dd8
> --- /dev/null
> +++ b/sound/soc/ep93xx/Kconfig
> @@ -0,0 +1,15 @@
> +config SND_EP93XX_SOC
> +	tristate "SoC Audio support for the Cirrus Logic EP93xx series"
> +	depends on ARCH_EP93XX && SND_SOC
> +	help
> +	  Say Y or M if you want to add support for codecs attached to
> +	  the EP93xx I2S interface.
> +
> +config SND_EP93XX_SOC_I2S
> +	tristate
> +
> +config SND_EP93XX_SOC_SNAPPERCL15
> +        tristate "SoC Audio support for Bluewater Systems Snapper CL15 module"
> +        depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15
> +        select SND_EP93XX_SOC_I2S
> +        select SND_SOC_TLV320AIC23

Please split at least the machine driver out into a separate patch.
Probably a good idea to split the DMA driver for legibility.

> +static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
> +			      struct snd_soc_dai *dai)
> +{	
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct ep93xx_i2s_info *info = rtd->dai->cpu_dai->private_data;
> +	
> +	clk_enable(info->i2s_clk);
> +	cpu_dai->dma_data = info->dma_params[substream->stream];	

You'll want to rebase against the for-2.6.36 branch of

 git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

> +static int ep93xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
> +			      struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}

Remove empty functins like this.

> +static int ep93xx_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai, int div_id,
> +				 int div)
> +{
> +	unsigned val;
> +
> +	/*
> +	 * The LRDIV (frame clock) and SDIV (bit clock) controls are in the
> +	 * EP93XX_SYSCON_I2SCLKDIV register, which is also used by clock.c
> +	 * to set the I2S master clock.
> +	 *
> +	 * FIXME - This functions is potentially racy with the clock api for
> +	 * the I2S master clock. Its also ugly modifying the syscon registers
> +	 * here.
> +	 */

Exposing LRCLK and BCLK via the clock API seems like a sensible way of
resolving this.  You probably also want to consider making the
configuration of the LRCLK and BCLK automatic, at least by default,
since the configuration can be inferred from the hw_params for most
setups.  This makes machine drivers easier to write.

> +#ifdef CONFIG_PM
> +static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
> +{
> +	struct ep93xx_i2s_info *info = dai->private_data;
> +
> +	if (!dai->active)
> +		return;
> +	
> +	ep93xx_i2s_enable(info, 0);

This doesn't seem to tie in with the way i2s_enable() is called
elsewhere - it's not conditional on the DAI being active, it's done
unconditionally in probe().  I'd expect to see some handling of the
clocks here, though.

> +static int ep93xx_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

Remove this.

> +static int ep93xx_pcm_mmap(struct snd_pcm_substream *substream,
> +			   struct vm_area_struct *vma)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +				     runtime->dma_area,
> +				     runtime->dma_addr,
> +				     runtime->dma_bytes);
> +}

We really ought to provide a helper for this, it's cookie cuttered far
too often.

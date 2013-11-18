From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 11:45:17 -0700
Subject: [PATCH 15/31] ASoC: dmaengine: add custom DMA config to
 snd_dmaengine_pcm_config
In-Reply-To: <20131116094412.GD15393@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-16-git-send-email-swarren@wwwdotorg.org>
 <20131116094412.GD15393@sirena.org.uk>
Message-ID: <528A603D.2000307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2013 02:44 AM, Mark Brown wrote:
> On Fri, Nov 15, 2013 at 01:54:10PM -0700, Stephen Warren wrote:
> 
>> - DMA device
> 
>> This allows requesting DMA channels for a device other than the 
>> device which is registering the "PCM" driver. This is quite 
>> unusual, but is currently useful on Tegra. In much HW, and in 
>> Tegra20, each DAI HW
...
> I'm a bit concerned about anything actually using dma_dev since it
>  indicates that something is being worked around, it'd be a bit 
> nicer to print a warning when doing this to give people a hint
> that they might not be doing the right thing if they use it
> (unless someone comes up with a system that has a clear use case
> for it).

What if I squash the following into that patch:

> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 1160d1cba133..0e2645dee96a 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -296,8 +296,17 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
>  	    !dev->of_node)
>  		return 0;
>  
> -	if (config->dma_dev)
> +	if (config->dma_dev) {
> +		/*
> +		 * If this warning is seen, it probably means that your Linux
> +		 * device structure does not match your HW device structure.
> +		 * It would be best to refactor the Linux device structure to
> +		 * correctly match the HW structure.
> +		 */
> +		dev_warn(dev, "DMA channels sourced from device %s",
> +			 dev_name(config->dma_dev));
>  		dev = config->dma_dev;
> +	}
>  
>  	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE;
>  	     i++) {

(a few patches later) That yields the following warning on Tegra, for
example:

> [    2.629623] tegra30-i2s 70080400.i2s: DMA channels sourced from device 70080000.ahub

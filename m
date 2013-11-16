From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 16 Nov 2013 11:49:02 +0100
Subject: [alsa-devel] [PATCH 14/31] ASoC: dmaengine: support deferred
 probe for DMA channels
In-Reply-To: <1384548866-13141-15-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-15-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52874D9E.1010708@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2013 09:54 PM, Stephen Warren wrote:
>  
> @@ -315,6 +343,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
>  	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
>  {
>  	struct dmaengine_pcm *pcm;
> +	int ret;
>  
>  	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
>  	if (!pcm)
> @@ -323,14 +352,26 @@ int snd_dmaengine_pcm_register(struct device *dev,
>  	pcm->config = config;
>  	pcm->flags = flags;
>  
> -	dmaengine_pcm_request_chan_of(pcm, dev);
> +	ret = dmaengine_pcm_request_chan_of(pcm, dev);
> +	if (ret)
> +		goto err_free_pcm;
>  

We should still call dmaengine_pcm_release_chan() in case requesting the
first channel succeeded, but the second did not.

>  	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
> -		return snd_soc_add_platform(dev, &pcm->platform,
> +		ret = snd_soc_add_platform(dev, &pcm->platform,
>  				&dmaengine_no_residue_pcm_platform);
>  	else
> -		return snd_soc_add_platform(dev, &pcm->platform,
> +		ret = snd_soc_add_platform(dev, &pcm->platform,
>  				&dmaengine_pcm_platform);
> +	if (ret)
> +		goto err_free_dma;
> +
> +	return 0;
> +
> +err_free_dma:
> +	dmaengine_pcm_release_chan(pcm);
> +err_free_pcm:
> +	kfree(pcm);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_register);
[...]

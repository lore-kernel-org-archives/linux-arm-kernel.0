From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 20 Mar 2010 16:42:20 +0000
Subject: [PATCH 5/6] ASoC: enable wm8753 in aspenite
In-Reply-To: <771cded01003190854o39aae5bj6ae5279a5316b73d@mail.gmail.com>
References: <771cded01003190854o39aae5bj6ae5279a5316b73d@mail.gmail.com>
Message-ID: <20100320164220.GA1549@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 11:54:40AM -0400, Haojian Zhuang wrote:

I note that you're not copying any of these ALSA patches to the ALSA
list...

> +	rate =  params_rate(params);
> +	width = snd_pcm_format_physical_width(params_format(params));
> +	channel = params_channels(params);
> +	ret = pxa168_seek_mclk_conf(rate, width, channel);
> +	if (ret < 0)
> +		return ret;
> +	index = ret;
> +	mclk = pxa168_get_mclk(ret);

Now that it's slightly clearer that this is exported from the SSP driver
the interface here looks odd - there doesn't seem to be any reason to
expose anything of the PXA internal configuration outside the SSP
driver, especially given that the configurations are expressed in terms
of an index into a table of configuration values which aren't much use
to anything outside the SSP driver.

A function allowing the MCLK rate to be queried seems reasonable since
this can be used to configure external devices (as you're doing here)
but this block of code and the subsequent passing of index back into the
driver both seem like boilerplate which every user (or at least most
users) will have to do so it'd be better to save them the effort.

> +	/* set codec DAI configuration */
> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
> +				  | SND_SOC_DAIFMT_NB_IF
> +				  | SND_SOC_DAIFMT_CBS_CFS);
> +	if (ret < 0)
> +		return ret;

Each time you've posted this I've asked you why you're using an inverted
frame clock for the DAI.  IIRC last time you posted this you said that
you'd add a comment explaining this but I don't see one here?

I'd also suggest not running the SSP port in I2S mode if you can avoid
it - the controller is really just emulating I2S, which makes the
configuration rather fragile.  The DSP modes are more natural for the
PXA hardware, I'd suggest using one of those.

From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jul 2013 15:59:17 +0100
Subject: [PATCH v4 1/7] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
In-Reply-To: <1373379933-32749-2-git-send-email-richard.genoud@gmail.com>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130709145917.GA27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 04:25:27PM +0200, Richard Genoud wrote:

> +/*
> + * Authorized rates are:
> + * Rate = MCLK_RATE / (n * 2)
> + * Where n is in [1..4095]
> + * (cf register SSC_CMR)
> + */
> +static unsigned int rates[] = {
> +	8000,
> +	16000,
> +	32000,
> +	48000,
> +	64000,
> +	96000,
> +};

Shouldn't the SSC driver be enforcing this constraint if it comes from
the SSC hardware?  If the clock is reprogrammable the usual convention
for drivers is to not constrain if the clock is set to zero so a machine
driver could remove the constraint.

> +	ret = atmel_ssc_set_audio(0);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev,
> +			"ASoC: Failed to set SSC 0 for audio: %d\n", ret);
> +		return ret;
> +	}

Shouldn't this be a parameter in the DT too?

> +	cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
> +	if (!cpu_np) {
> +		dev_err(&pdev->dev, "ssc controller node missing\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	at91sam9x5ek_dai.cpu_of_node = cpu_np;
> +	at91sam9x5ek_dai.platform_of_node = cpu_np;

After all we're looking things up in the DT...

> +	at91sam9x5ek_dai.dai_fmt = snd_soc_of_parse_daifmt(np, "atmel,");

Is this really something that machines would want to reconfigure?  If so
why?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/8c5f9fd6/attachment.sig>

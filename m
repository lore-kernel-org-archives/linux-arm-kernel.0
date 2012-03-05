From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 14:46:01 +0000
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120305144601.GQ3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 10:31:05PM +0800, Shawn Guo wrote:

> +	ret = snd_soc_dai_set_fmt(rtd->codec_dai, SND_SOC_DAIFMT_I2S |
> +						  SND_SOC_DAIFMT_NB_NF |
> +						  SND_SOC_DAIFMT_CBM_CFM);
> +	if (ret) {
> +		dev_err(dev, "could not set codec driver audio format\n");
> +		return ret;
> +	}

This you can just set in the card struct, no need for explicit code at
all.

> +	ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
> +	if (ret) {
> +		dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
> +		return -EINVAL;
> +	}
> +	ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
> +	if (ret) {
> +		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
> +		return -EINVAL;
> +	}

It seems very odd to have namespacing on the individual property names.
Why are you doing that?  The properties are already defined in terms of
the device binding.  Though everyone else is doing it so not really a
problem.

> +	/*
> +	 * The port numbering in the hardware manual starts at 1, while
> +	 * the audmux API expects it starts at 0.
> +	 */
> +	int_port--;
> +	ext_port--;

Should have error checking somewhere to make sure that the user
remembered this.

> +	imx_audmux_v2_configure_port(int_port,
> +			IMX_AUDMUX_V2_PTCR_SYN |
> +			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
> +			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
> +			IMX_AUDMUX_V2_PTCR_TFSDIR |
> +			IMX_AUDMUX_V2_PTCR_TCLKDIR,
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));

I'm not sure we've really gained much from converting to a platform
driver given that the device just registers something globally...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/1eb910df/attachment.sig>

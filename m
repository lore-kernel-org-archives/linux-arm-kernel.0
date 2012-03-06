From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 6 Mar 2012 15:39:02 +0800
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120305144601.GQ3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
 <20120305144601.GQ3224@opensource.wolfsonmicro.com>
Message-ID: <20120306073900.GP16232@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 02:46:01PM +0000, Mark Brown wrote:
> On Mon, Mar 05, 2012 at 10:31:05PM +0800, Shawn Guo wrote:
> 
> > +	ret = snd_soc_dai_set_fmt(rtd->codec_dai, SND_SOC_DAIFMT_I2S |
> > +						  SND_SOC_DAIFMT_NB_NF |
> > +						  SND_SOC_DAIFMT_CBM_CFM);
> > +	if (ret) {
> > +		dev_err(dev, "could not set codec driver audio format\n");
> > +		return ret;
> > +	}
> 
> This you can just set in the card struct, no need for explicit code at
> all.
> 
Yes, I just tried.  It also works but a little bit differently.  We
only set_fmt for codec_dai here, while ASoC core will set_fmt for both
codec_dai and cpu_dai if dai_link->dai_fmt is set.  However, the
fsl_ssi does not provide .set_fmt implementation, and consequently we
will see error message below, which does not impact functionality
though.

  fsl-ssi-dai 83fcc000.ssi: Failed to set DAI format: -22

I hope we keep the code as it is now and improve later when fsl_ssi
gets improved.

> > +	ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
> > +		return -EINVAL;
> > +	}
> > +	ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
> > +		return -EINVAL;
> > +	}
> 
> It seems very odd to have namespacing on the individual property names.
> Why are you doing that?  The properties are already defined in terms of
> the device binding.  Though everyone else is doing it so not really a
> problem.
> 
The general device tree binding practice is we'd better have a vendor
prefix on the property name, if the property applies on specific vendor
drivers instead of common ones across different vendors.

> > +	/*
> > +	 * The port numbering in the hardware manual starts at 1, while
> > +	 * the audmux API expects it starts at 0.
> > +	 */
> > +	int_port--;
> > +	ext_port--;
> 
> Should have error checking somewhere to make sure that the user
> remembered this.
> 
Because different i.MX SoC may have different internal and external
port number, I do not think of a way to check that.  And I would not
worry about it that much, since all the hardware documents number the
port from 1, while device tree user/author will have to look at those
documents for the data.

> > +	imx_audmux_v2_configure_port(int_port,
> > +			IMX_AUDMUX_V2_PTCR_SYN |
> > +			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
> > +			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
> > +			IMX_AUDMUX_V2_PTCR_TFSDIR |
> > +			IMX_AUDMUX_V2_PTCR_TCLKDIR,
> > +			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
> 
> I'm not sure we've really gained much from converting to a platform
> driver given that the device just registers something globally...

Converting audmux to a platform driver does not change anything about
that.  It makes device tree support easier, and gets the audmux users
(imx machine drivers) stay away from including <mach/audmux.h>.

-- 
Regards,
Shawn

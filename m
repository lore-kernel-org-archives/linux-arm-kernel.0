From: hias@horus.com (Matthias Reichl)
Date: Wed, 8 Feb 2017 19:54:00 +0100
Subject: [PATCH] ASoC: bcm2835: Add 8 channel (multitrack) capability
In-Reply-To: <20170208182835.6hpwcxiae2lh56d5@sirena.org.uk>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <20170208182835.6hpwcxiae2lh56d5@sirena.org.uk>
Message-ID: <20170208185359.GA11314@camel2.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 06:28:35PM +0000, Mark Brown wrote:
> On Tue, Feb 07, 2017 at 10:09:36AM +1100, Matt Flax wrote:
> 
> >  	case SND_SOC_DAIFMT_CBS_CFM:
> >  		clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
> > +	case SND_SOC_DAIFMT_CBM_CFS:
> 
> Is this fall through deliberate?
> 
> > +	/* Default data delay to 1 bit.
> > +	   In I2S mode, we must have 2 channels */
> >  	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> >  	case SND_SOC_DAIFMT_I2S:
> > +		if (params_channels(params) != 2)
> > +			return -EINVAL;
> > +	case SND_SOC_DAIFMT_DSP_A:
> > +	case SND_SOC_DAIFMT_DSP_B:
> >  		data_delay = 1;
> >  		break;
> >  	default:

Matt, could you please include linux-rpi-kernel at lists.infradead.org
in your emails?

I fail to see the part where DSP modes are actually set up in
the hardware. bcm2835 still seems to be operating in 2-channel
stereo I2S mode, i.e. no real frame sync information at the
hardware level.

If all you do is adding code to pretend the bcm2835 could do
multichannel modes wouldn't it be easier to implement that as
a userspace alsa plugin?

> 
> Same here.  This is also buggy in that it treats DSP A and DSP B
> identically, they are different so the configuration must be incorrect
> for one of them.  I suspect this is configuring for DSP A.
> 
> You should also really have a setup() function that imposes a channel
> constraint when in I2S mode, wm8988 is one example here.



> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

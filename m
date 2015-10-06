From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Oct 2015 11:00:42 +0200
Subject: [PATCH v2 4/4] ASOC: sunxi: Add support for the spdif block
In-Reply-To: <CAEKpxB=_coi06gaixgqpLm=AFbw2mPVLPim7HCk-T-Lnsgt6mw@mail.gmail.com>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
 <1443635458-8873-5-git-send-email-codekipper@gmail.com>
 <20151001201122.GM7104@lukather>
 <CAEKpxB=_coi06gaixgqpLm=AFbw2mPVLPim7HCk-T-Lnsgt6mw@mail.gmail.com>
Message-ID: <20151006090042.GR2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 08:44:03AM +0200, Code Kipper wrote:
> >> +config SND_SOC_SUNXI_DAI_SPDIF
> >> +        tristate
> >> +     depends on OF
> >> +        select SND_SOC_GENERIC_DMAENGINE_PCM
> >> +        select REGMAP_MMIO
> >> +
> >> +config SND_SOC_SUNXI_MACHINE_SPDIF
> >> +        tristate "APB on-chip sun4i/sun5i/sun7i SPDIF"
> >> +     depends on OF
> >> +        select SND_SOC_SUNXI_DAI_SPDIF
> >> +        help
> >> +          Say Y if you want to add support for SoC S/PDIF audio as simple audio card.
> >
> > You still haven't said why you can't use simple-card...
> 
> I mentioned in the covering letter that I thought that simple-card was
> overkill.

Overkill for what? It adds no code, that will put no new maintainance
burden, without any duplication. While your code also adds all that.

> There is also a thread concerning issues with the ordering
> of module bringup here
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070534.html.
> I was initially trying to use the dummy spdif transmitter but couldn't
> get it working, this set up works for me. I haven't got an audio guy
> sitting next to me to ping and have reached out for some guidance. I
> can do this using simple-card, it just with all the driver refactoring
> it was the main place where I thought things would break.

We're all on IRC.


> >> +static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
> >> +{
> >> +     u32 reg_val;
> >> +
> >> +     /* soft reset SPDIF */
> >> +     regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET);
> >> +
> >> +     /* MCLK OUTPUT enable */
> >> +     regmap_update_bits(host->regmap, SUN4I_SPDIF_CTL,
> >> +                     SUN4I_SPDIF_CTL_MCLKOUTEN, SUN4I_SPDIF_CTL_MCLKOUTEN);
> >
> > The alignment is still not right....
> 
> I'm not even sure if we need mclk output enabled. Let me see what
> happens when I remove this.

It's not really the point. The alignment of all your wrapped lines is
wrong.

> >> +static int sun4i_spdif_startup(struct snd_pcm_substream *substream,
> >> +                             struct snd_soc_dai *cpu_dai)
> >> +{
> >> +     struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >> +     struct sun4i_spdif_dev *host = snd_soc_dai_get_drvdata(rtd->cpu_dai);
> >> +
> >> +     if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
> >> +             return -EINVAL;
> >> +
> >> +     sun4i_spdif_configure(host);
> >> +
> >> +     return clk_prepare_enable(host->clk);
> >
> > You're still not using pm_runtime...
> 
> I've removed the pm stuff and this is the same as you have it in
> sun4i-codec.

You've removed the suspend code, and both Mark and I asked you to use
runtime_pm to handle your bus clock.

And this has also been asked for the codec.

> >> +
> >> +     ret = clk_set_rate(host->audio_clk, mclk);
> >> +     if (ret < 0) {
> >> +             dev_err(&pdev->dev,
> >> +                     "Setting pll2 clock rate for %d Hz failed!\n", mclk);
> >> +             return ret;
> >> +     }
> >
> > You're still using the PLL2...
> 
> I commented this out and it stopped working...let me check again.

Then something is wrong somewhere else that needs to be fixed, either
in the clock driver or in this driver. Did you update all the other
references to PLL2 as well?

> 
> >
> >> +
> >> +     ret = clk_set_rate(host->clk, mclk);
> >> +     if (ret < 0) {
> >> +             dev_err(&pdev->dev,
> >> +                     "Setting SPDIF clock rate for %d Hz failed!\n", mclk);
> >> +             return ret;
> >> +     }
> >> +
> >> +     reg_val = 0;
> >> +     reg_val &= ~SUN4I_SPDIF_FCTL_FIFOSRC;
> >> +     reg_val |= SUN4I_SPDIF_FCTL_TXTL_MASK;
> >> +     reg_val |= SUN4I_SPDIF_FCTL_RXTL_MASK;
> >> +     reg_val |= SUN4I_SPDIF_FCTL_TXIM;
> >> +     reg_val |= SUN4I_SPDIF_FCTL_RXOM_MASK;
> >> +     regmap_write(host->regmap, SUN4I_SPDIF_FCTL, reg_val);
> >
> > You're still not using regmap_update_bits...
> 
> Why would I need to?, this is the first write to the register before
> playback and I'm not interested in keeping any of the previous fifo
> settings. Will remove"reg_val &= ~SUN4I_SPDIF_FCTL_FIFOSRC;" as that's
> not doing anything.

Dropping the masking is also an option.

> > IF you're really going to ignore all the comments we did, please tell
> > us upfront. That way, we will not waste our time doing a review of
> > your patches.
> 
> All is a strong word....did you even read my covering letter?....there
> was a major refactoring of the code and I think I covered a majority
> of the comments. Apologies if you feel that you'd wasted a lot of time
> of this....it can't be any more that the EVB dts.

The point of this is that this is a discussion. You simply ignored
most of the comments, without even mentionning why you wanted to
ignore them, and simply sent a new version.

If you feel like one comment is invalid, let's discuss this, like you
did here. But silently discarding them is not an option and actually
quite rude.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/95784d5c/attachment.sig>

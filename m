From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Oct 2015 20:20:02 +0100
Subject: [PATCH v2 4/4] ASOC: sunxi: Add support for the spdif block
In-Reply-To: <CAEKpxB=UZMe1=A7wguiyPn=YhuUaj8B8Ajc0nADVFcHEWQgvvw@mail.gmail.com>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
 <1443635458-8873-5-git-send-email-codekipper@gmail.com>
 <20151001201122.GM7104@lukather>
 <CAEKpxB=_coi06gaixgqpLm=AFbw2mPVLPim7HCk-T-Lnsgt6mw@mail.gmail.com>
 <20151006090042.GR2696@lukather>
 <CAEKpxB=UZMe1=A7wguiyPn=YhuUaj8B8Ajc0nADVFcHEWQgvvw@mail.gmail.com>
Message-ID: <20151026192002.GZ10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 06, 2015 at 12:38:57PM +0200, Code Kipper wrote:
> >> >> +static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
> >> >> +{
> >> >> +     u32 reg_val;
> >> >> +
> >> >> +     /* soft reset SPDIF */
> >> >> +     regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET);
> >> >> +
> >> >> +     /* MCLK OUTPUT enable */
> >> >> +     regmap_update_bits(host->regmap, SUN4I_SPDIF_CTL,
> >> >> +                     SUN4I_SPDIF_CTL_MCLKOUTEN, SUN4I_SPDIF_CTL_MCLKOUTEN);
> >> >
> >> > The alignment is still not right....
> >>
> >> I'm not even sure if we need mclk output enabled. Let me see what
> >> happens when I remove this.
> >
> > It's not really the point. The alignment of all your wrapped lines is
> > wrong.
> 
> Ahhhh....I was brought up to not mix tabs and spaces and I now see
> with a quick check that checkpatch doesn't barf...I'll fix this.

checkpatch --strict does

> >> >> +static int sun4i_spdif_startup(struct snd_pcm_substream *substream,
> >> >> +                             struct snd_soc_dai *cpu_dai)
> >> >> +{
> >> >> +     struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >> >> +     struct sun4i_spdif_dev *host = snd_soc_dai_get_drvdata(rtd->cpu_dai);
> >> >> +
> >> >> +     if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
> >> >> +             return -EINVAL;
> >> >> +
> >> >> +     sun4i_spdif_configure(host);
> >> >> +
> >> >> +     return clk_prepare_enable(host->clk);
> >> >
> >> > You're still not using pm_runtime...
> >>
> >> I've removed the pm stuff and this is the same as you have it in
> >> sun4i-codec.
> >
> > You've removed the suspend code, and both Mark and I asked you to use
> > runtime_pm to handle your bus clock.
> >
> > And this has also been asked for the codec.
> 
> You asked if I had tested the pm operations which I hadn't so I
> removed them after looking at your driver and searching for pm_runtime
> usage elsewhere in sound/soc. I will add them back.

What we asked you to remove were the suspend / resume hooks. What we
want you to add are runtime_pm hooks. These are not the same hooks,
and they're not called at the same moment.

The suspend / resume hooks are called before entering suspend and
after coming back from it. We don't have no way to suspend at the
moment, so there's no way you've been able to test it.

The runtime_pm hooks are called whenever your device start to be used
(for example when you start playing back an audio file on your
system).

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151026/b76b2397/attachment.sig>

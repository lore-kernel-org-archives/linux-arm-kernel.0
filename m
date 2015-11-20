From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Nov 2015 18:02:06 +0100
Subject: [PATCH 1/4] ASoC: sun4i-codec: Add support for PA gpio pin
In-Reply-To: <CAGb2v66PPm+G=RfrLgNHNeVDed8BSuGaERKLgfsnzPpAzKcmsA@mail.gmail.com>
References: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
 <20151120163047.GF32142@lukather>
 <CAGb2v66PPm+G=RfrLgNHNeVDed8BSuGaERKLgfsnzPpAzKcmsA@mail.gmail.com>
Message-ID: <20151120170206.GL32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2015 at 12:42:41AM +0800, Chen-Yu Tsai wrote:
> >>  static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
> >>  {
> >> -     /*
> >> -      * FIXME: according to the BSP, we might need to drive a PA
> >> -      *        GPIO low here on some boards
> >> -      */
> >> -
> >>       /* Disable DAC DRQ */
> >>       regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
> >>                          BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN),
> >>                          0);
> >> +
> >> +     if (scodec->gpio_pa)
> >> +             gpiod_set_value_cansleep(scodec->gpio_pa, 0);
> >
> > You should rather plug that into DAPM, using a speaker widget, and a
> > custom event function that will enable or disable the amplifier only
> > when this audio path is going to be used.
> 
> Isn't an "amplifier" widget better suited?

This is exactly what SND_SOC_DAPM_SPK is used for:
http://lxr.free-electrons.com/source/Documentation/sound/alsa/soc/dapm.txt#L273 ;)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/0a9bf38f/attachment-0001.sig>

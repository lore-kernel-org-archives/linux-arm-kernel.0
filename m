From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 29 Dec 2016 19:12:32 +0800
Subject: [PATCH] drm: zte: support hdmi audio through spdif
In-Reply-To: <CAOw6vbJzKeiTW9haRmiFhJv44pRSMNvvpFUg-4LcfxSuRzo17w@mail.gmail.com>
References: <1482412319-6304-1-git-send-email-shawnguo@kernel.org>
 <CAOw6vbJzKeiTW9haRmiFhJv44pRSMNvvpFUg-4LcfxSuRzo17w@mail.gmail.com>
Message-ID: <20161229111230.GA6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 10:18:00AM -0500, Sean Paul wrote:
> On Thu, Dec 22, 2016 at 8:11 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > +static int zx_hdmi_audio_get_n(unsigned int fs)
> > +{
> > +       unsigned int n;
> > +
> > +       switch (fs) {
> > +       case 32000:
> > +               n = 4096;
> > +               break;
> > +       case 44100:
> > +               n = 6272;
> > +               break;
> > +       case 48000:
> > +               n = 6144;
> > +               break;
> > +       case 88200:
> > +               n = 6272 * 2;
> > +               break;
> > +       case 96000:
> > +               n = 6144 * 2;
> > +               break;
> > +       case 176400:
> > +               n = 6272 * 4;
> > +               break;
> > +       case 192000:
> > +               n = 6144 * 4;
> > +               break;
> > +       default:
> > +               n = fs * 128 / 1000;
> 
> It seems like this could be distilled down to:
> 
> if (fs && (fs % 44100) == 0)
>         n = 6272 * (fs / 44100);
> else
>         n = fs * 128 / 1000;

Nice!  Thanks for the suggestion.

> 
> > +       }
> > +
> > +       return n;
> > +}
> > +
> > +static int zx_hdmi_audio_hw_params(struct device *dev,
> > +                                  void *data,
> > +                                  struct hdmi_codec_daifmt *daifmt,
> > +                                  struct hdmi_codec_params *params)
> > +{
> > +       struct zx_hdmi *hdmi = dev_get_drvdata(dev);
> > +       struct hdmi_audio_infoframe *cea = &params->cea;
> > +       union hdmi_infoframe frame;
> > +       int n;
> > +
> > +       /* We only support spdif for now */
> > +       if (daifmt->fmt != HDMI_SPDIF) {
> > +               DRM_DEV_ERROR(hdmi->dev, "invalid daifmt %d\n", daifmt->fmt);
> > +               return -EINVAL;
> > +       }
> > +
> > +       switch (params->sample_width) {
> > +       case 16:
> > +               hdmi_writeb_mask(hdmi, TPI_AUD_CONFIG, SPDIF_SAMPLE_SIZE_MASK,
> > +                                SPDIF_SAMPLE_SIZE_16BIT);
> > +               break;
> > +       case 20:
> > +               hdmi_writeb_mask(hdmi, TPI_AUD_CONFIG, SPDIF_SAMPLE_SIZE_MASK,
> > +                                SPDIF_SAMPLE_SIZE_20BIT);
> > +               break;
> > +       case 24:
> > +               hdmi_writeb_mask(hdmi, TPI_AUD_CONFIG, SPDIF_SAMPLE_SIZE_MASK,
> > +                                SPDIF_SAMPLE_SIZE_24BIT);
> > +               break;
> > +       default:
> > +               DRM_DEV_ERROR(hdmi->dev, "invalid sample width %d\n",
> > +                             params->sample_width);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* CTS is calculated by hardware, and we only need to take care of N */
> > +       n = zx_hdmi_audio_get_n(params->sample_rate);
> > +       hdmi_writeb(hdmi, N_SVAL1, n & 0xff);
> > +       hdmi_writeb(hdmi, N_SVAL2, (n >> 8) && 0xff);
> 
> s/&&/&/ ?

Oops!  Thanks for catching it.

Shawn

> 
> > +       hdmi_writeb(hdmi, N_SVAL3, (n >> 16) & 0xf);
> > +
> > +       /* Enable spdif mode */
> > +       hdmi_writeb_mask(hdmi, AUD_MODE, SPDIF_EN, SPDIF_EN);
> > +
> > +       /* Enable audio input */
> > +       hdmi_writeb_mask(hdmi, AUD_EN, AUD_IN_EN, AUD_IN_EN);
> > +
> > +       memcpy(&frame.audio, cea, sizeof(*cea));
> > +
> > +       return zx_hdmi_infoframe_trans(hdmi, &frame, FSEL_AUDIO);
> > +}

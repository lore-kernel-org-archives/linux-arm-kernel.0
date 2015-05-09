From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 18:53:28 +0100
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <20150509174054.GT2067@n2100.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
 <554E3AA8.8060601@iki.fi>
 <20150509165536.GS2067@n2100.arm.linux.org.uk>
 <554E3EE1.40904@iki.fi>
 <20150509174054.GT2067@n2100.arm.linux.org.uk>
Message-ID: <20150509175327.GU2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 06:40:54PM +0100, Russell King - ARM Linux wrote:
> Even VLC _doesn't_ if it's outputting to a standard audio - in other
> words, if you don't tick the SPDIF direct output option which defaults
> to disabled (which, when enabled, opens the device passing the AES
> bits _and_ permits it to send a compressed audio stream.)  I've looked
> at this in VLC many times...

FYI, here's the code:

    vlc_fourcc_t fourcc = aout->format.i_format;
    bool spdif = false;
    switch (fourcc)
    {
... other linear float/integer codec IDs ...
        case VLC_CODEC_U16B:
            pcm_format = SND_PCM_FORMAT_U16_BE;
            break;
        case VLC_CODEC_U16L:
            pcm_format = SND_PCM_FORMAT_U16_LE;
            break;
...
        default:
            if (AOUT_FMT_SPDIF(&aout->format))
                spdif = var_InheritBool (aout, "spdif");
            if (spdif)
            {
                fourcc = VLC_CODEC_SPDIFL;
                pcm_format = SND_PCM_FORMAT_S16;
            }
            else
            if (HAVE_FPU)
            {
                fourcc = VLC_CODEC_FL32;
                pcm_format = SND_PCM_FORMAT_FLOAT;
            }
            else
            {
                fourcc = VLC_CODEC_S16N;
                pcm_format = SND_PCM_FORMAT_S16;
            }
    }

    /* Choose the IEC device for S/PDIF output:
       if the device is overridden by the user then it will be the one.
       Otherwise we compute the default device based on the output format. */
    if (spdif && !strcmp (device, "default"))
    {
        unsigned aes3;

        switch (aout->format.i_rate)
        {
#define FS(freq) \
            case freq: aes3 = IEC958_AES3_CON_FS_ ## freq; break;
            FS( 44100) /* def. */ FS( 48000) FS( 32000)
            FS( 22050)            FS( 24000)
            FS( 88200) FS(768000) FS( 96000)
            FS(176400)            FS(192000)
#undef FS
            default:
                aes3 = IEC958_AES3_CON_FS_NOTID;
                break;
        }

        free (device);
        if (asprintf (&device,
                      "iec958:AES0=0x%x,AES1=0x%x,AES2=0x%x,AES3=0x%x",
                      IEC958_AES0_CON_EMPHASIS_NONE | IEC958_AES0_NONAUDIO,
                      IEC958_AES1_CON_ORIGINAL | IEC958_AES1_CON_PCM_CODER,
                      0, aes3) == -1)
            return VLC_ENOMEM;
    }
...
    /* VLC always has a resampler. No need for ALSA's. */
    const int mode = SND_PCM_NO_AUTO_RESAMPLE;

    int val = snd_pcm_open (&pcm, device, SND_PCM_STREAM_PLAYBACK, mode);

So, the result is:

* VLC opens the ALSA device _without_ AES information if the fourcc
  being passed if the format is a linear PCM type.

* If the format is not a linear PCM type _and_ it is a format which
  satisfies AOUT_FMT_SPDIF(), _and_ the SPDIF passthrough option is
  enabled, _then_ we open the IEC958 audio output device with the
  first four AES data bytes specified with SND_PCM_FORMAT_S16.
  Moreover, the first data byte always indicates that the stream is
  non-audio.

So, in the case of linear PCM, the AES data bytes are *not* specified
by VLC.

So, if we don't have the kernel driver specifying the IEC958 information
for HDMI/SPDIF outputs, and users of ALSA's userspace APIs don't generate
them for linear PCM, how are the required AES data bytes generated?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

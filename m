From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 May 2015 20:33:20 +0100
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <554FAA9E.100@iki.fi>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
 <554E3AA8.8060601@iki.fi>
 <20150509165536.GS2067@n2100.arm.linux.org.uk>
 <554E3EE1.40904@iki.fi>
 <20150509174054.GT2067@n2100.arm.linux.org.uk>
 <554E49FE.8040004@iki.fi>
 <20150509181153.GV2067@n2100.arm.linux.org.uk>
 <554FAA9E.100@iki.fi>
Message-ID: <20150510193320.GZ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 10, 2015 at 09:59:42PM +0300, Anssi Hannula wrote:
> I wonder whether receivers actually care with HDMI (they generally don't
> with S/PDIF) - that's one tidbit for me to test later... But of course
> it doesn't change much with the matter at hand, in any case we should
> strive to get the bits correct if only because the HDMI spec requires
> them to be (I don't think they were optional in IEC 60958-3 either, though).

I suspect they don't care too much, but the HDMI spec does require them
to be correct.  If we're trying to aim for best compatibility, setting
them correctly is something we should strive to do.

> What I'd like to see is arrive at some sort of general consensus on how
> the AES bits should be handled (i.e. should the driver always set them
> themselves and disallow/allow the userspace to override the rate bits),
> which could then be applied to other drivers as well.
> 
> But maybe that is for another time, or just a futile effort altogether...

My personal view is that where we're dealing with PCM audio, the driver
needs to set these bits correctly as there is nothing in userspace to
do this.  This provides an identical interface between each audio device
which accepts PCM samples - whether it's a SPDIF or non-SPDIF based
device.

For non-audio data sent via an audio device, the AES bits need to be
conveyed from userspace, and we should respect what userspace gives us.
(If it's wrong, it's a userspace bug, and userspace should be fixed,
rather than trying to work around the bug by patching the kernel.)

> Indeed. I did notice there is a SND(RV)_PCM_FORMAT_SPECIAL but I guess
> it might not be easily used for this purpose since it doesn't have a
> specific sample width etc (but I am not familiar enough with this to say
> whether it could work or not)...

I spent quite a while looking at alsa-lib, wondering whether I could
move all the conversions out to userspace, but I couldn't without
building them _into_ alsa-lib.  This was a while back now, but from
what I remember, plugins to alsa-lib which aren't built as part of
alsa-lib are not able to do format conversions.

> > However, in the case of VLC, if it wants to send non-audio, it will
> > open the IEC958 device, which will use the iec958 plugin to configure
> > the AES bits for non-audio, and pass IEC958 data to the kernel (which
> > still needs to be reformatted to the hardware's special format.)
> 
> Ah, so the AES bits are actually overridable by userspace, which is what
> I was initially concerned with :)
> 
> Of course, this means that applications opening "iec958" but not setting
> rate bits (which is common) will get the default 48kHz bits from
> /usr/share/alsa/pcm/(iec958|hdmi).conf). Not sure how big an issue that
> is, though. The "iec958" ALSA plugin does seem to have a FIXME comment
> about setting AES bits according to sample rate.

Note that VLC does set the "sample" rate appropriately:

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

> > <confdir:pcm/iec958.conf>
> > 
> > dw-hdmi-ahb-aud.pcm.iec958.0 {
> 
> I think you should s/iec958/hdmi/ for the above two lines. HDMI devices
> should be using "hdmi" instead of "iec958" by convention (the latter is
> used for optical/coaxial S/PDIF).

Except doing that kills VLC's passthrough option (denoted by "spdif"),
which explicitly wants the iec958 device:

    /* Choose the IEC device for S/PDIF output:
       if the device is overridden by the user then it will be the one.
       Otherwise we compute the default device based on the output format. */
    if (spdif && !strcmp (device, "default"))
    {
...
        if (asprintf (&device,
                      "iec958:AES0=0x%x,AES1=0x%x,AES2=0x%x,AES3=0x%x",
                      IEC958_AES0_CON_EMPHASIS_NONE | IEC958_AES0_NONAUDIO,
                      IEC958_AES1_CON_ORIGINAL | IEC958_AES1_CON_PCM_CODER,
                      0, aes3) == -1)

Yes, technically an application bug, since VLC should allow the device
to be selectable and/or detect hdmi devices.  I wonder if that's
something which has changed between 2.0.8 and the latest vlc.

I did consider having the hdmi output device, but also alias that to
the iec958 device name, which I think can be done via:

<confdir:pcm/hdmi.conf>

dw-hdmi-ahb-aud.pcm.hdmi.0 {
...
}

<confdir:pcm/iec958.conf>

dw-hdmi-ahb-aud.pcm.iec958.0 cards.dw-hdmi-ahb-aud.pcm.hdmi.0

However, for HDMI sinks, I haven't seen any way in Linux to allow
userspace to know the audio capabilities of the attached HDMI sink,
and thus whether the video player can output compressed MPEG audio.
Anyone know?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

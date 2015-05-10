From: anssi.hannula@iki.fi (Anssi Hannula)
Date: Sun, 10 May 2015 21:59:42 +0300
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <20150509181153.GV2067@n2100.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk> <554E3AA8.8060601@iki.fi>
 <20150509165536.GS2067@n2100.arm.linux.org.uk> <554E3EE1.40904@iki.fi>
 <20150509174054.GT2067@n2100.arm.linux.org.uk> <554E49FE.8040004@iki.fi>
 <20150509181153.GV2067@n2100.arm.linux.org.uk>
Message-ID: <554FAA9E.100@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

09.05.2015, 21:11, Russell King - ARM Linux kirjoitti:
> On Sat, May 09, 2015 at 08:55:10PM +0300, Anssi Hannula wrote:
>> 09.05.2015, 20:40, Russell King - ARM Linux kirjoitti:
>>> Even VLC _doesn't_ if it's outputting to a standard audio - in other
>>> words, if you don't tick the SPDIF direct output option which defaults
>>> to disabled (which, when enabled, opens the device passing the AES
>>> bits _and_ permits it to send a compressed audio stream.)  I've looked
>>> at this in VLC many times...
>>
>> That is my understanding as well. Same for pulseaudio, it doesn't set
>> any AES bits except for passthrough (and most other applications never
>> set them).
> 
> Right, so when you're dealing with HDMI, where it's required that the
> AES bits contain accurate information, the only real option is to set
> it appropriately in the driver if userspace doesn't specify the AES
> data bits.

I wonder whether receivers actually care with HDMI (they generally don't
with S/PDIF) - that's one tidbit for me to test later... But of course
it doesn't change much with the matter at hand, in any case we should
strive to get the bits correct if only because the HDMI spec requires
them to be (I don't think they were optional in IEC 60958-3 either, though).

> Now, with the dw-hdmi-ahb driver, I'm doing something sensible

Right.

What I'd like to see is arrive at some sort of general consensus on how
the AES bits should be handled (i.e. should the driver always set them
themselves and disallow/allow the userspace to override the rate bits),
which could then be applied to other drivers as well.

But maybe that is for another time, or just a futile effort altogether...

> - and
> yes, I do have a card file in /usr/share/alsa (see below).
> 
> What this does is ensure that linear PCM is converted to 24-bit PCM
> (which makes the kernel conversion to the required hardware format
> easier - I hate this, I'd much prefer it to be done in userspace.)

Indeed. I did notice there is a SND(RV)_PCM_FORMAT_SPECIAL but I guess
it might not be easily used for this purpose since it doesn't have a
specific sample width etc (but I am not familiar enough with this to say
whether it could work or not)...

> However, in the case of VLC, if it wants to send non-audio, it will
> open the IEC958 device, which will use the iec958 plugin to configure
> the AES bits for non-audio, and pass IEC958 data to the kernel (which
> still needs to be reformatted to the hardware's special format.)

Ah, so the AES bits are actually overridable by userspace, which is what
I was initially concerned with :)

Of course, this means that applications opening "iec958" but not setting
rate bits (which is common) will get the default 48kHz bits from
/usr/share/alsa/pcm/(iec958|hdmi).conf). Not sure how big an issue that
is, though. The "iec958" ALSA plugin does seem to have a FIXME comment
about setting AES bits according to sample rate.


[...]
> 
> <confdir:pcm/iec958.conf>
> 
> dw-hdmi-ahb-aud.pcm.iec958.0 {

I think you should s/iec958/hdmi/ for the above two lines. HDMI devices
should be using "hdmi" instead of "iec958" by convention (the latter is
used for optical/coaxial S/PDIF).

> 	@args [ CARD AES0 AES1 AES2 AES3 ]
> 	@args.CARD { type string }
> 	@args.AES0 { type integer }
> 	@args.AES1 { type integer }
> 	@args.AES2 { type integer }
> 	@args.AES3 { type integer }
> 	type iec958
> 	slave.pcm {
> 		type hw
> 		card $CARD
> 		device 0
> 	}
> 	slave.format IEC958_SUBFRAME_LE
> 	status [ $AES0 $AES1 $AES2 $AES3 ]
> }
> 
> 

-- 
Anssi Hannula

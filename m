From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 19:11:53 +0100
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <554E49FE.8040004@iki.fi>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
 <554E3AA8.8060601@iki.fi>
 <20150509165536.GS2067@n2100.arm.linux.org.uk>
 <554E3EE1.40904@iki.fi>
 <20150509174054.GT2067@n2100.arm.linux.org.uk>
 <554E49FE.8040004@iki.fi>
Message-ID: <20150509181153.GV2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 08:55:10PM +0300, Anssi Hannula wrote:
> 09.05.2015, 20:40, Russell King - ARM Linux kirjoitti:
> > Even VLC _doesn't_ if it's outputting to a standard audio - in other
> > words, if you don't tick the SPDIF direct output option which defaults
> > to disabled (which, when enabled, opens the device passing the AES
> > bits _and_ permits it to send a compressed audio stream.)  I've looked
> > at this in VLC many times...
> 
> That is my understanding as well. Same for pulseaudio, it doesn't set
> any AES bits except for passthrough (and most other applications never
> set them).

Right, so when you're dealing with HDMI, where it's required that the
AES bits contain accurate information, the only real option is to set
it appropriately in the driver if userspace doesn't specify the AES
data bits.

Now, with the dw-hdmi-ahb driver, I'm doing something sensible - and
yes, I do have a card file in /usr/share/alsa (see below).

What this does is ensure that linear PCM is converted to 24-bit PCM
(which makes the kernel conversion to the required hardware format
easier - I hate this, I'd much prefer it to be done in userspace.)

However, in the case of VLC, if it wants to send non-audio, it will
open the IEC958 device, which will use the iec958 plugin to configure
the AES bits for non-audio, and pass IEC958 data to the kernel (which
still needs to be reformatted to the hardware's special format.)

dw-hdmi-ahb-aud.pcm.default {
	@args [ CARD ]
	@args.CARD { type string }
	type asym
	playback.pcm {
		type softvol
		slave.pcm {
			type plug
			slave.pcm {
				@func concat
				strings [ "dmix:" $CARD ",FORMAT=S24_LE" ]
			}
		}
		control {
			name "PCM Playback Volume"
			card $CARD
		}
	}
}

<confdir:pcm/iec958.conf>

dw-hdmi-ahb-aud.pcm.iec958.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD { type string }
	@args.AES0 { type integer }
	@args.AES1 { type integer }
	@args.AES2 { type integer }
	@args.AES3 { type integer }
	type iec958
	slave.pcm {
		type hw
		card $CARD
		device 0
	}
	slave.format IEC958_SUBFRAME_LE
	status [ $AES0 $AES1 $AES2 $AES3 ]
}


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

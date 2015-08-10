From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Aug 2015 17:49:41 +0100
Subject: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
In-Reply-To: <s5hegjb5o44.wl-tiwai@suse.de>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <s5hk2t35ui4.wl-tiwai@suse.de>
 <20150810103921.GR7557@n2100.arm.linux.org.uk>
 <s5hegjb5o44.wl-tiwai@suse.de>
Message-ID: <20150810164941.GW7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 02:23:07PM +0200, Takashi Iwai wrote:
> I admit that alsa-lib code is very horrible to follow -- but I guess
> the change you'd need for iec958 plugin would be fairly small.  We can
> add a config option and let iec958 behaving slightly differently
> depending on it.

Yes, but there's other problems there as well.

The IEC958 plugin does the job of adding the 4 AES bytes and formatting
fairly well, but the problem when the 'default' bytes specified in the
ALSA configuration files are used.

Let's take the old chestnut of PulseAudio, or even aplay, or the miriad
of other audio-only players out there.

Most of them do not supply the AES bytes to be used, so we end up with
the default.

The default is... 0x04 0x82 0x00 0x02, which specifies a sample rate
of 48kHz.  However, the actual sample rate may not be 48kHz.  At least
the HDMI specifications say that the channel status data must be correct,
and there are AV receivers out there which do make use of this, and if
the channel status does not agree with the actual sample rate, they
either refuse to recognise the audio stream (saying there's nothing
there) or they intermittently mute the audio.  Yamaha RX-V677 is one
example which has this behaviour.

The only compliant program that I've found so far is VLC in SPDIF
pass-through mode, which is the only case where VLC passes the
channel status information.  Everything else seems broken in this
regard, by falling back to the default.

Obviously, aplay can be made to work by setting the AES bytes
manually when specifying the device for it to use, but this is not
really user-friendly or programmer friendly - especially as the
current use model expects things to "just work" (the common case
being PCM output on a PC which doesn't care about channel status.)

I'm not sure what the right solution is here: modifying every audio
player out there to make HDMI work sanely is crazy.  Having alsalib
automatically generate the correct AES channel status bytes for
linear audio formats seems to be sensible, but difficult given its
present structure with the defaults - the iec958 plugin has no idea
if the defaults are being used or not.

The advantage of having the horrid conversion in the kernel is that
we can choose to generate proper AES channel status data without
regard to userspace for standard linear PCM, and when the iec958 plugin
is being used with proper channel status (eg, in compressed audio
pass-through mode by VLC) then that works too.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

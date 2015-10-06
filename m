From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Oct 2015 19:54:29 +0100
Subject: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
In-Reply-To: <CAOMZO5DaowTGQqN_NW7T2zv-P6a_YZUCumq4-m+OtpsKqFzELw@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
 <20151006181806.GS21513@n2100.arm.linux.org.uk>
 <CAOMZO5DaowTGQqN_NW7T2zv-P6a_YZUCumq4-m+OtpsKqFzELw@mail.gmail.com>
Message-ID: <20151006185429.GU21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 03:45:32PM -0300, Fabio Estevam wrote:
> On Tue, Oct 6, 2015 at 3:18 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Sorry, I've been out for most of the day.  There's no DT patches required.
> >
> > The dw_hdmi bridge driver creates its own platform device for the audio,
> > which should then bind to the dw_hdmi-ahb-audio driver using normal Linux
> > methods.
> >
> > I don't know what's wrong with your setup, for me, it just works:
> >
> > [    1.358829] dwhdmi-imx 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
> > [    1.377173] imx-drm display-subsystem: bound 120000.hdmi (ops dw_hdmi_imx_ops)
> > ...
> > [    2.851343] ALSA device list:
> > [    2.857364]   #0: DW-HDMI rev 0x0a, irq 21
> >
> > as it always has done for me.  There's nothing special about it.
> 
> Great, got it to probe now:
> 
> [    7.454760] ALSA device list:
> [    7.457764]   #0: DW-HDMI rev 0x0a, irq 19
> [    7.461990]   #1: wm8962-audio
> 
> There was a conflict and I resolved incorrectly here. Will try to play
> a wav file via aplay now.

Make sure you have the ALSA config file, as alsalib won't get on
with dw-hdmi only accepting 24-bit audio without this.  A copy is
attached.  It also tells ALSA how to deal with multi-channel audio
as well.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
-------------- next part --------------
#
# All PCM must be 24-bit for easy kernel conversion.
# IEC958 formatted output can be sent directly.
#
# Direct-to-hardware converting to 24-bit output.
#
dw-hdmi-ahb-aud.pcm.hw-s24le {
	@args [ CARD ]
	@args.CARD { type string }
	type linear
	slave.pcm { 
		type hw
		card $CARD
	}
	slave.format S24_LE
}

#
# Dmix hardware 24-bit output.
#
dw-hdmi-ahb-aud.pcm.dmix-s24le {
	@args [ CARD ]
	@args.CARD { type string }
	type plug
	slave.pcm { @func concat strings [ "dmix:" $CARD ",FORMAT=S24_LE" ] }
}

#
# Softvol with dmix output
#
dw-hdmi-ahb-aud.pcm.default {
	@args [ CARD ]
	@args.CARD { type string }
	type asym
	playback.pcm {
		type softvol
		slave.pcm {
			@func refer name { 
				@func concat strings [
					"cards."
					{ @func card_driver card $CARD }
					".pcm.dmix-s24le:CARD=" $CARD
				]
			}
		}
		control {
			name "PCM Playback Volume"
			card $CARD
		}
	}
}

#
# Common output path for front and surround outputs
#
dw-hdmi-ahb-aud.pcm.common.0 {
	@args [ CARD ]
	@args.CARD { type string }
	type asym
	playback.pcm {
		type softvol
		slave.pcm {
			@func refer name { 
				@func concat strings [
					"cards."
					{ @func card_driver card $CARD }
					".pcm.hw-s24le:CARD=" $CARD
				]
			}
		}
		control {
			name "PCM Playback Volume"
			card $CARD
		}
	}
}

<confdir:pcm/front.conf>

dw-hdmi-ahb-aud.pcm.front.0 cards.dw-hdmi-ahb-aud.pcm.common.0

# The mapping of ALSA channels to surround channels is very imprecise.
# ALSA uses a different terminology and speaker placement to the CEA
# surround positioning.  CEA has the positioning of:
#
#			LFE
#	FL	FLC	FC	FRC	FR
#
#
#	RL	RLC	RC	RRC	RR
#
# ALSA's idea is:
#
#			LFE
#		FL	C	FR
#
#		SL		SR
#
#		RL		RR
#
# We do our best to map between these representations.

<confdir:pcm/surround40.conf>

dw-hdmi-ahb-aud.pcm.surround40.0 {
	@args [ CARD ]
	@args.CARD { type string }
	type empty
	slave.pcm {
		@func refer
		name { 
			@func concat strings [
				"cards.dw-hdmi-ahb-aud.pcm.common.0:CARD="
				$CARD
			]
		}
	}
}

# surround 41 and surround50 are (annoyingly) mapped to surround51
# We could do without stacking two 'route' plugins on top of each other

<confdir:pcm/surround41.conf>
<confdir:pcm/surround50.conf>
<confdir:pcm/surround51.conf>

dw-hdmi-ahb-aud.pcm.surround51.0 {
	@args [ CARD ]
	@args.CARD { type string }
	type route
	slave.pcm {
		@func refer
		name { 
			@func concat strings [
				"cards.dw-hdmi-ahb-aud.pcm.common.0:CARD="
				$CARD
			]
		}
	}
	ttable.0.0 1.0 # FL  -> slave 0 -> hdmi 0 FL
	ttable.1.1 1.0 # FR  -> slave 1 -> hdmi 1 FR
	ttable.2.4 1.0 # RL  -> slave 4 -> hdmi 4 RL
	ttable.3.5 1.0 # RR  -> slave 5 -> hdmi 5 RR
	ttable.4.3 1.0 # C   -> slave 3 -> hdmi 3 FC 
	ttable.5.2 1.0 # LFE -> slave 2 -> hdmi 2 LFE
}

<confdir:pcm/surround71.conf>

dw-hdmi-ahb-aud.pcm.surround71.0 {
	@args [ CARD ]
	@args.CARD { type string }
	type route
	slave.pcm {
		@func refer
		name { 
			@func concat strings [
				"cards.dw-hdmi-ahb-aud.pcm.common.0:CARD="
				$CARD
			]
		}
	}
	slave.channels 8
	ttable.0.0 1.0 # FL  -> slave 0 -> hdmi 0 FL
	ttable.1.1 1.0 # FR  -> slave 1 -> hdmi 1 FR
	ttable.2.6 1.0 # RL  -> slave 6 -> hdmi 6 RLC/FLC
	ttable.3.7 1.0 # RR  -> slave 7 -> hdmi 7 RRC/FRC
	ttable.4.3 1.0 # C   -> slave 3 -> hdmi 3 FC
	ttable.5.2 1.0 # LFE -> slave 2 -> hdmi 2 LFE
	ttable.6.4 1.0 # SL  -> slave 4 -> hdmi 4 RL
	ttable.7.5 1.0 # SR  -> slave 5 -> hdmi 5 RR
}

<confdir:pcm/hdmi.conf>

dw-hdmi-ahb-aud.pcm.hdmi.0 {
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
	}
	slave.format IEC958_SUBFRAME_LE
	# $AES3 must be correct for some AV receivers to accept the stream
	status [ $AES0 $AES1 $AES2 $AES3 ]
}

<confdir:pcm/iec958.conf>

dw-hdmi-ahb-aud.pcm.iec958.0 cards.dw-hdmi-ahb-aud.pcm.hdmi.0

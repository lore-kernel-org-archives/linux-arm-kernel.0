From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 May 2015 18:31:25 +0100
Subject: [PATCH 13/13] drm: bridge/dw_hdmi-ahb-audio: parse ELD from HDMI
 driver
In-Reply-To: <20150527104308.GA8341@phenom.ffwll.local>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1yD-0006lK-RC@rmk-PC.arm.linux.org.uk>
 <20150527104308.GA8341@phenom.ffwll.local>
Message-ID: <20150527173125.GS2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 12:43:08PM +0200, Daniel Vetter wrote:
> On Sat, May 09, 2015 at 11:26:57AM +0100, Russell King wrote:
> > Parse the ELD (EDID like data) stored from the HDMI driver to restrict
> > the sample rates and channels which are available to ALSA.  This causes
> > the ALSA device to reflect the capabilities of the overall audio path,
> > not just what is supported at the HDMI source interface level.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I completely missed the new eld helpers in this series, so fairly late
> with a few questions here.
> 
> In x86/desktop gpus we pass around the eld in hw, and there's an interrupt
> on the snd side every time that materially changes. Same goes for other
> state changes like the display pipe getting lit up/disabled again.
> 
> How is hotplug handling done here? You update the eld in get_modes, but I
> don't see any notification from hdmi->audio (it only seems to get updated
> at open time, no idea whether that's enough). And it looks like there's a
> potential use-after-free when the drm side updates the eld and frees the
> old one, while the snd side tries to access this.

It doesn't handle hotplug at all, per se.

The problem with hotplug is that (afaik) ALSA has no way to notify
userspace that something has changed: if I were to add such a
notification from the DRM side of the driver to the audio side, I
wouldn't know what to do with it when the audio side received it.

In any case, I tend to think of unplugging the display as being much
like unplugging the 3.5mm line out jack to your hifi system - just
because you've disconnected the speakers does not stop the audio
playing - the audio continues despite you not being able to hear it.

Sure, there's the problem that if you plug in a display with different
capabilities, the existing format may not be supported, but I don't
see a reasonable method which could provoke what effectively would be
a restart on the ALSA side.

In any case, hotplug is kind-of outside of the remit of these helpers -
these helpers are more to do with decoding an existing ELD and limiting
the capabilities of the audio side to that specified in the ELD.  It's
up to the driver how it gets the ELD, and it's left to the driver to
determine how to handle the change-of-ELD notification.

Given your description of i915 hardware above, I think this makes sense
anyway: if you have a hardware notification system, it makes sense to use
that rather than some software implementation, and requiring a software
implementation for everything to me sounds too limiting.

That's not to say that we couldn't have a software implementation in the
future: right now, I merely concentrated on the parsing issue.

The dw-hdmi audio driver isn't ready for mainlining yet - there's two
variants of this at the moment (one for iMX6 and a different one for
Rockchip - same IP but configured with different interfaces for getting
the audio data into the HDMI block.)  There's still some work to be done
to properly unify the two approaches into something sane.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

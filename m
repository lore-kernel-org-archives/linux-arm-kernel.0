From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 28 May 2015 06:56:28 +0200
Subject: [alsa-devel] [PATCH 13/13] drm: bridge/dw_hdmi-ahb-audio: parse
 ELD from HDMI driver
In-Reply-To: <20150527173125.GS2067@n2100.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1yD-0006lK-RC@rmk-PC.arm.linux.org.uk>
 <20150527104308.GA8341@phenom.ffwll.local>
 <20150527173125.GS2067@n2100.arm.linux.org.uk>
Message-ID: <s5hh9qxcnb7.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Wed, 27 May 2015 18:31:25 +0100,
Russell King - ARM Linux wrote:
> 
> On Wed, May 27, 2015 at 12:43:08PM +0200, Daniel Vetter wrote:
> > On Sat, May 09, 2015 at 11:26:57AM +0100, Russell King wrote:
> > > Parse the ELD (EDID like data) stored from the HDMI driver to restrict
> > > the sample rates and channels which are available to ALSA.  This causes
> > > the ALSA device to reflect the capabilities of the overall audio path,
> > > not just what is supported at the HDMI source interface level.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > I completely missed the new eld helpers in this series, so fairly late
> > with a few questions here.
> > 
> > In x86/desktop gpus we pass around the eld in hw, and there's an interrupt
> > on the snd side every time that materially changes. Same goes for other
> > state changes like the display pipe getting lit up/disabled again.
> > 
> > How is hotplug handling done here? You update the eld in get_modes, but I
> > don't see any notification from hdmi->audio (it only seems to get updated
> > at open time, no idea whether that's enough). And it looks like there's a
> > potential use-after-free when the drm side updates the eld and frees the
> > old one, while the snd side tries to access this.
> 
> It doesn't handle hotplug at all, per se.
> 
> The problem with hotplug is that (afaik) ALSA has no way to notify
> userspace that something has changed: if I were to add such a
> notification from the DRM side of the driver to the audio side, I
> wouldn't know what to do with it when the audio side received it.

The notification itself is present.  For HD-audio HDMI/DP, the driver
creates jack kctl for each port for notifying the monitor/ELD change.
The recent PA actually listens to it and handles accordingly.

But it doesn't mean that the PCM and other state changes are
proactively dealt inside the driver.  Rather it gives the
notification, keeps running and waits for the further action from
user-space.

> In any case, I tend to think of unplugging the display as being much
> like unplugging the 3.5mm line out jack to your hifi system - just
> because you've disconnected the speakers does not stop the audio
> playing - the audio continues despite you not being able to hear it.

Ditto for HD-audio.  The interface is still present, even playable,
without the connection.  Maybe we should return an error explicitly
when played during unconnected?  The handling of HDMI/DP hotplug has
been discussed many times, and I vaguely remember of pros/cons with
the above shown in past threads.


Takashi

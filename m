From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 May 2015 12:42:30 +0100
Subject: [alsa-devel] [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
In-Reply-To: <ef04b1827963c2746c252f65bfa0d172@kapsi.fi>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk>
 <s5ha8ymy3e2.wl-tiwai@suse.de>
 <20150405162034.GH13898@n2100.arm.linux.org.uk>
 <s5h4mouy14a.wl-tiwai@suse.de>
 <20150405172608.GA12732@n2100.arm.linux.org.uk>
 <ef04b1827963c2746c252f65bfa0d172@kapsi.fi>
Message-ID: <20150508114230.GI2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 01:56:02PM +0300, Jyri Sarha wrote:
> On 2015-04-05 20:26, Russell King - ARM Linux wrote:
> >On Sun, Apr 05, 2015 at 06:46:13PM +0200, Takashi Iwai wrote:
> >>At Sun, 5 Apr 2015 17:20:34 +0100,
> >>Russell King - ARM Linux wrote:
> >>> Since (afaik) ALSA has a lack of support for dynamic reconfiguration
> >>> according to the attached device changing, the best we can do without
> >>> a huge amount of re-work of HDMI support across all adapters is to
> >>> process the capabilities of the attached device at prepare time
> >>> according to the current capabilities.
> >>
> >>Yeah, reconfiguration is tricky.  BTW, how is the HDMI unplug handled
> >>during playback?
> >
> >We don't handle it right now - and we don't have any notification to
> >the audio drivers that that has happened.  Even if we did have such a
> >notification, I'm not sure what the audio driver could do with it at
> >the moment.
> >
> >>> Implementing dynamic reconfiguration in ALSA is not something I want to
> >>> get involved with, and as we /already/ have HDMI support merged in the
> >>> kernel, this is not a blocker for at least trying to get some semblence
> >>> of sanity, rather than having every driver re-implementing stuff like
> >>> this.
> >>
> >>Well, I didn't mean about the dynamic reconfiguration.  I thought of
> >>rather min/max pairs, but it was just a wrong assumption.  Scratch
> >>it.
> >>
> >>One another question: don't we need to deal with the sample bits in
> >>sad[2]?
> >
> >It should, but I'm very wary about doing that without seeing more
> >examples of real SADs.
> 
> If the same constraint setting helpers are to be used also with
> external HDMI encoders with i2s interface, there should be an option
> to leave out the constraints for the sample bits. There is no direct
> connection between the number of bits on I2S and HDMI link. The CPU
> DAI may apply its own constraints on the available sample formats and
> too strict constraints at the encoder end may lead to zero available
> formats.

Possibly, but then how do we know which SAD to apply to limit the number
of channels?

I suspect for the use case you're suggesting above, it's better left to
the user rather than generic code to work it out otherwise things get
far too complex.  We'd need to have some way for the driver to report
back to this generic code the actual number of bits on the HDMI link.

However, as we currently know, ALSA appears to have a problem here which
pretty much makes properly restricting the channels and sample rates
impossible to do.  That issue is the one I'm much more keen to solve
right now, because without that being solved, this set of patches is
pretty much dead in the water.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

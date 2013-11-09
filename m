From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Nov 2013 00:53:17 +0000
Subject: imx-drm: Add HDMI support
In-Reply-To: <CAHCPf3unnmGDD2jGJYHdmYFALdcNa9OcWejLpUdzaxATSAyjSQ@mail.gmail.com>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <CAHCPf3viBN5RwxPYGN_gMhbgbJbwJAQDJKHHYFyLUFBqvsFztg@mail.gmail.com>
 <20131030190123.GM16735@n2100.arm.linux.org.uk>
 <CAHCPf3sFe4Z6-pfR+4wk4Z_aSHzyzQN8j1KgpF5Uq+W9HLzoWQ@mail.gmail.com>
 <20131107172920.GH16735@n2100.arm.linux.org.uk>
 <CAHCPf3unnmGDD2jGJYHdmYFALdcNa9OcWejLpUdzaxATSAyjSQ@mail.gmail.com>
Message-ID: <20131109005317.GW16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 06:23:37PM -0600, Matt Sealey wrote:
> On Thu, Nov 7, 2013 at 11:29 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Nov 05, 2013 at 04:39:40PM -0600, Matt Sealey wrote:
> >> On Wed, Oct 30, 2013 at 2:01 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > That's where validating the modes you're prepared to support becomes
> >> > important, and there's hooks in DRM for doing that.
> >>
> >> Nope! Not in the right place.
> >
> > Sure it's the right place.  It's the connector which gets to read the
> > modes, and the connector is part of the DRM system.
> 
> It's really not the right place.
> 
> >> > If you can't support those with 148.5MHz dotclocks, then you have to return
> >> > MODE_CLOCK_HIGH from the connector's mode_valid callback.
> >>
> >> Here's the problem; connectors and encoders are initialized under DRM
> >> before the display driver. For the connector to even KNOW what the
> >> highest valid clock is, it would need to ask the lower level display
> >> driver, since the connector and even encoder has no clue of this
> >> limitation and shouldn't be hardcoded, or even know what the input
> >> pixel clock capabilities are.
> >
> > That's because the way imx-drm is setup with its multitude of individual
> > drivers is utter madness;
> 
> This is how all DRM cards are written, even the good ones. For the
> connector to be able to ask the crtc "is this mode even supportable?"
> it would need a mode_valid callback to call, down to the encoder (and
> maybe the encoder would call crtc) and down down to the crtc. No such
> callback exists for this exact reason. At the point the connector
> pulls EDID modes and uses mode_valid, it's entirely possible and
> nearly always true that it doesn't even HAVE an encoder or CRTC.

Now look at the bigger picture.  What makes the decision about whether
to use a mode with a particular CRTC?  Is it:

(a) DRM
(b) Userspace

The answer is not (a) - DRM just does what userspace instructs.  What
this means is that you can't do per-CRTC validation of mode settings
without big changes to the API, which aren't going to happen.

So the best you can do is to limit the displayed modes according to
what the hardware in general is able to do.

Luckily, with imx-drm, in the case of single IPUs, both "crtcs" have
exactly the same capability as far as clocks go - which is common with
every other DRM system so far.  So really, there's no need to know which
CRTC is going to be associated with the connector - we already know the
capabilities there.

> What it lacks, in this case, is not any functional code in those
> components, but a workable model to glue those components together in
> the correct order, on a per-board basis.
> 
> The appropriate card model isn't implemented - except in crazy
> functions in imx-drm-core.c - the rest of it is absolutely fine.

Well, I've actually fixed the problem *right* *now*.

> The ONLY thing that can happen is a call to the crtc mode_fixup()
> which exists only to say "go fuck yourself" to a mode_set call.
> Nothing ever culls these mode lists after the connector generates
> them, because it owns that object and ditching items from it is
> semi-dangerous layering violation. So here is the user experience with
> the current model:
> 
> * User clicks a button in GNOME to set the fanciest resolution they
> can find, which is listed in their dialog
> * User is told "that mode can't be set, sorry"
> * User waits for you to go to sleep and then suffocates you with a pillow
> 
> And what it should be is:
> 
> * User clicks a button in GNOME to set the fanciest resolution
> actually supported with this combination, because the drivers knew
> enough to pre-filter invalid modes
> * User always gets a valid mode set because it only ever reports valid modes
> 
> That second, consumer-oriented, model where the usable mode list is
> predicated on results from the *entire* card and not just what the
> monitor said, simply wasn't - and I assume still isn't - possible. Why
> not? Because when a Radeon is plugged into a monitor it bloody well
> supports it, and that's the end of it. People don't make displays that
> modern graphics cards can't use. By the time 1080p TVs in common
> circulation rolled around for consumer devices, WQXGA monitors already
> existed, so desktop PC graphics cards followed suit pretty quickly.

Sorry, no, I'm not buying your arguments here - you may be right but
your apparant bias towards "oh, DRM was written for Radeon" is soo
wrong.  Maybe you should consider that the DRM maintainer works for
Intel, who are a competitor of AMD not only in the CPU market but also
the video market too.

However, even so.  Getting back to the hardware we have, which is
imx-drm, there is no difference between the capabilities of the two
"CRTCs" in a single IPU as far as mode pixel rates are concerned.
There _may_ be a difference between the two IPUs on IMX6Q, but not
within a single IPU.

> However, some embedded devices have restrictions. I have a couple
> devices at home that have a maximum resolution of 1280x720 - because
> the SoC doesn't provide anything that can do more than a 75MHz pixel
> clock or so. So, that sucks, but it's a real limitation of the SoC
> that is essentially insurmountable.

Right, so turning everything into micro-components is a bad idea.
That's already been said (I think I've already said that about imx-drm.)

> In the case on the i.MX51, it was just never designed to be a
> 1080p-capable device. However, there is NOTHING in the architecture of
> the chip except the maximum clock and some bus bandwidth foibles that
> says it's impossible. I can run 1080p at 30 and it operates great in 2D
> and even does respectable 3D. The video decoders still work - if you
> have a low enough bitrate/complexity movie, it *will* decode 1080p at
> 30fps. So artificially restricting the displays to "720p maximum" is
> overly restrictive to customers, considering that 1366x768,1440x900
> are well within the performance of the units. 1600x900, 1920x1080 (low
> enough refresh rate) are still usable.
> 
> The problem is under DRM

Err no.  The reason 1080p at 30 works is because it uses the same pixel
rate as 1280x720.  74.25MHz.

So the problem is with your thinking.  What you're thinking is "it won't
do 1080p so we have to deny modes based on the resolution".  There's
absolutely no problem what so ever restricting the set of available
modes based on _pixel_ _clock_ _rate_ in DRM.  DRM fully supports this.
There is no problem here.

So you _can_ have 1080p at 30Hz if you have a bandwidth limitation.
All it takes is for the _correct_ limitations to be imposed rather than
the artificial ones you seem to be making up.

And at this point I give up reading your diatribe.  You've been told
many times in the past not to write huge long essays as emails, because
frankly people won't read them.  It's 1 am, I'm not going to spend
another hour or more reading whatever you've written below this point
because its another 300 lines I just don't have time to read at this.

If you'd like to rephrase in a more concise manner then I may read
your message.

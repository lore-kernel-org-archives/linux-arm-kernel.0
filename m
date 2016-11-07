From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2016 15:46:52 +0000
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
In-Reply-To: <20161107150909.rcte56amjkmd6mhx@lukather>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <20161018092422.GJ1041@n2100.armlinux.org.uk>
 <20161018100349.qm2f554oiwyjwrsi@lukather>
 <20161031084233.GS1041@n2100.armlinux.org.uk>
 <20161103090106.dq2bn4z7m2hzhi53@lukather>
 <20161103095444.GX1041@n2100.armlinux.org.uk>
 <20161107150909.rcte56amjkmd6mhx@lukather>
Message-ID: <20161107154652.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 04:09:09PM +0100, Maxime Ripard wrote:
> Hi Russell,
> 
> On Thu, Nov 03, 2016 at 09:54:45AM +0000, Russell King - ARM Linux wrote:
> > > Yes. And that is an XBMC only solution, that doesn't work with the
> > > fbdev emulation and is probably doing an additional composition to
> > > scale down and center their frames through OpenGL.
> > 
> > Well, it will have to be doing a scaling step anyway.  If the video
> > frame is a different size to the active area, scaling is required
> > no matter what.  A 576p SD image needs to be scaled up, and a 1080p
> > image would need to be scaled down for a 1080p overscanned display
> > with a reduced active area to counter the overscanning - no matter
> > how you do it.
> 
> Yes, except that scaling is not always an option. In my particular
> example, there's no scaler after the CRTC, which essentially prevents
> it from being used in that use case. Which is also why I ended up
> reducing the mode reported to the user.

I think you completely missed my point.  Let me try again.

If you expose a reduced mode to the user, you are reporting that (eg)
the 1080p-timings mode does not have 1920 pixels horizontally, and
1080 lines.  You are instead reporting that it has (eg) 1800 pixels
horizontally and maybe 1000 lines.

So, when you play back a 1080 video, you are going to have to either:

1. crop the extra 120 pixels horizontally and 80 lines vertically
or
2. scale the image.

However, this is a completely independent issue to how we go about
setting a video mode that is 1800x1000 in the first place.

What you're suggesting is that we add code to the kernel to report that
your non-EDID, analogue output transforms the standard 1920x1080 timings
such that it has a 1800x1000 active area.

I'm suggesting instead that you can do the same thing in userspace by
specifically adding a mode which has the 1920x1080 standard timings,
but with the porches increased and the active area reduced - in exactly
the same way that you'd have to do within the kernel to report your
active-area-reduced 1800x1000 mode.

> > For graphics, userspace could add mode(s) with increased porches and
> > reduced active area itself to achieve an underscanned display on a
> > timing which the display device always overscans - there's no need to
> > do that in the kernel, all the APIs are there to be able to do it
> > already.
> > 
> > That means your framebuffer will be smaller, but that's the case
> > anyway.
> 
> Yes, that would be a good idea. But it's not always an option for
> applications that would rely on the fbdev emulation (like QT's eglfs),
> which would then have no way to change whatever default there is (and
> the only one able to know how bad it actually is is the user).

I guess this is the problem with DRM people wanting to deprecate fbdev...
too much stuff currently relies upon it, but DRM on x86 has always had
the reduced functionality.

I guess there's two solutions here:

1. Either DRMs fbdev gains increased functionality, or
2. The fbdev-only applications/libraries need to be ported over to
   support DRM natively.

This has been a bar for some time to moving over to DRM, and I've heard
very little desire on either side to find some sort of compromise on the
issue, so I guess things are rather stuck where they are.

> > So, I may want my graphics to appear on an overscanned display such
> > that I can see the borders, but I may want the overlaid video to use
> > the full active area (including overscan) to hide some of the broadcast
> > mess at the edges of the screen.
> > 
> > > > Yea, that's quite sad, "analog" has become a dirty word, but really
> > > > this has nothing to do with "analog" at all - there are LCD TVs (and
> > > > some monitors) out there which take HDMI signals but refuse to
> > > > disable overscan no matter what you do to them if you provide them
> > > > with a "broadcast"  mode - so the analog excuse is very poor.
> > > 
> > > I'd agree with you, but I was also told to not turn that into a
> > > generic code and deal with that in my driver.
> > 
> > I guess whoever told you that was wrong.  I used to have a cheap TV
> > here which took HDMI, and always overscans broadcast modes, and
> > underscans PC modes.  No amount of fiddling with various settings
> > (either in the TV or AVI frames) changes that.
> > 
> > I've run into that with a _monitor_ that Andrew Hutton has, which has
> > a HDMI input - exactly the same thing - 1080p, 720p etc are all
> > unconditionally overscanned, 1024x768 etc are all unconditionally
> > underscanned and there's nothing that can be done to change it.
> > 
> > The problem is that TVs are at liberty to have this behaviour, so
> > the overscaned problem is always going to be there, and each driver
> > should not be dealing with it in their own specific ways.
> 
> I agree with you, however, without any directions on how to do this,
> and willingness to merge this, I don't really see why we would work on
> such a generic implementation in the first place.

As I've already said - if you've been told that a generic implementation
is wrong, then I suspect that either those who told you that either
failed to understand the problem, or they failed to appreciate just what
a problem it is.

I guess if DRM folk want to keep throwing up blocks in the way to moving
forward, then we'll end up with lots of hacks in various random trees to
work around the various issues, and everything will end up in a total
mess.

This is _not_ a driver specific problem, it _is_ a _generic_ problem.

I guess DRM folk have nice expensive display devices which don't exhibit
the problem, so they just don't give a damn - which basically means
they're out of touch with the rest of the world.  This isn't a problem
that's going to go away just because DRM folk want it to, and it's not
limited to "obsolete analogue" either.

I'd go as far as to say that DRM people are totally wrong to tell you
that a solution to this should not be generic, period.  I think I've
made that point several times through the course of this discussion
already.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

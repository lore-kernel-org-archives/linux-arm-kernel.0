From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Nov 2016 15:25:07 +0100
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
In-Reply-To: <20161107154652.GH1041@n2100.armlinux.org.uk>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <20161018092422.GJ1041@n2100.armlinux.org.uk>
 <20161018100349.qm2f554oiwyjwrsi@lukather>
 <20161031084233.GS1041@n2100.armlinux.org.uk>
 <20161103090106.dq2bn4z7m2hzhi53@lukather>
 <20161103095444.GX1041@n2100.armlinux.org.uk>
 <20161107150909.rcte56amjkmd6mhx@lukather>
 <20161107154652.GH1041@n2100.armlinux.org.uk>
Message-ID: <20161110142507.hxf25hm6x5wijv5q@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 03:46:52PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 07, 2016 at 04:09:09PM +0100, Maxime Ripard wrote:
> > Hi Russell,
> > 
> > On Thu, Nov 03, 2016 at 09:54:45AM +0000, Russell King - ARM Linux wrote:
> > > > Yes. And that is an XBMC only solution, that doesn't work with the
> > > > fbdev emulation and is probably doing an additional composition to
> > > > scale down and center their frames through OpenGL.
> > > 
> > > Well, it will have to be doing a scaling step anyway.  If the video
> > > frame is a different size to the active area, scaling is required
> > > no matter what.  A 576p SD image needs to be scaled up, and a 1080p
> > > image would need to be scaled down for a 1080p overscanned display
> > > with a reduced active area to counter the overscanning - no matter
> > > how you do it.
> > 
> > Yes, except that scaling is not always an option. In my particular
> > example, there's no scaler after the CRTC, which essentially prevents
> > it from being used in that use case. Which is also why I ended up
> > reducing the mode reported to the user.
> 
> I think you completely missed my point.  Let me try again.
> 
> If you expose a reduced mode to the user, you are reporting that (eg)
> the 1080p-timings mode does not have 1920 pixels horizontally, and
> 1080 lines.  You are instead reporting that it has (eg) 1800 pixels
> horizontally and maybe 1000 lines.
> 
> So, when you play back a 1080 video, you are going to have to either:
> 
> 1. crop the extra 120 pixels horizontally and 80 lines vertically
> or
> 2. scale the image.
> 
> However, this is a completely independent issue to how we go about
> setting a video mode that is 1800x1000 in the first place.
> 
> What you're suggesting is that we add code to the kernel to report that
> your non-EDID, analogue output transforms the standard 1920x1080 timings
> such that it has a 1800x1000 active area.
> 
> I'm suggesting instead that you can do the same thing in userspace by
> specifically adding a mode which has the 1920x1080 standard timings,
> but with the porches increased and the active area reduced - in exactly
> the same way that you'd have to do within the kernel to report your
> active-area-reduced 1800x1000 mode.

Ah, yes, you meant input scaling, not output, sorry.

> > > For graphics, userspace could add mode(s) with increased porches and
> > > reduced active area itself to achieve an underscanned display on a
> > > timing which the display device always overscans - there's no need to
> > > do that in the kernel, all the APIs are there to be able to do it
> > > already.
> > > 
> > > That means your framebuffer will be smaller, but that's the case
> > > anyway.
> > 
> > Yes, that would be a good idea. But it's not always an option for
> > applications that would rely on the fbdev emulation (like QT's eglfs),
> > which would then have no way to change whatever default there is (and
> > the only one able to know how bad it actually is is the user).
> 
> I guess this is the problem with DRM people wanting to deprecate fbdev...
> too much stuff currently relies upon it, but DRM on x86 has always had
> the reduced functionality.
> 
> I guess there's two solutions here:
> 
> 1. Either DRMs fbdev gains increased functionality, or
> 2. The fbdev-only applications/libraries need to be ported over to
>    support DRM natively.
> 
> This has been a bar for some time to moving over to DRM, and I've heard
> very little desire on either side to find some sort of compromise on the
> issue, so I guess things are rather stuck where they are.

I guess it really all boils down to this, and whether the userspace
will be able to set a custom mode on its own. "Advanced" stacks like
Xorg and Wayland will, but simpler and / or legacy applications will
depend on the fbdev emulation, either because they've not been
converted through DRM (like you suggested) or because it depends on a
blob that requires it (and then you're stuck).

And since the kernel already deals with overscan through a generic
property, it really feels like it's the place it should be done to
address all needs (and ideally in a generic way).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161110/a482bcf9/attachment.sig>

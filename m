From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Nov 2016 16:09:09 +0100
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
In-Reply-To: <20161103095444.GX1041@n2100.armlinux.org.uk>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <20161018092422.GJ1041@n2100.armlinux.org.uk>
 <20161018100349.qm2f554oiwyjwrsi@lukather>
 <20161031084233.GS1041@n2100.armlinux.org.uk>
 <20161103090106.dq2bn4z7m2hzhi53@lukather>
 <20161103095444.GX1041@n2100.armlinux.org.uk>
Message-ID: <20161107150909.rcte56amjkmd6mhx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Nov 03, 2016 at 09:54:45AM +0000, Russell King - ARM Linux wrote:
> > Yes. And that is an XBMC only solution, that doesn't work with the
> > fbdev emulation and is probably doing an additional composition to
> > scale down and center their frames through OpenGL.
> 
> Well, it will have to be doing a scaling step anyway.  If the video
> frame is a different size to the active area, scaling is required
> no matter what.  A 576p SD image needs to be scaled up, and a 1080p
> image would need to be scaled down for a 1080p overscanned display
> with a reduced active area to counter the overscanning - no matter
> how you do it.

Yes, except that scaling is not always an option. In my particular
example, there's no scaler after the CRTC, which essentially prevents
it from being used in that use case. Which is also why I ended up
reducing the mode reported to the user.

> For graphics, userspace could add mode(s) with increased porches and
> reduced active area itself to achieve an underscanned display on a
> timing which the display device always overscans - there's no need to
> do that in the kernel, all the APIs are there to be able to do it
> already.
> 
> That means your framebuffer will be smaller, but that's the case
> anyway.

Yes, that would be a good idea. But it's not always an option for
applications that would rely on the fbdev emulation (like QT's eglfs),
which would then have no way to change whatever default there is (and
the only one able to know how bad it actually is is the user).

> > > > The second one is that we still need to expose the reduced modes to
> > > > userspace, and not only the displayed size, so that the applications
> > > > know what they must draw on. But I guess this could be adjusted by the
> > > > core too.
> > > > 
> > > > In order to work consistently, I think all planes should be adjusted
> > > > that way, so that relative coordinates are from the primary plane
> > > > origin, and not the display origin. But that could be adjusted too by
> > > > the core I guess.
> > > 
> > > I'm not sure about that - we want the graphics to be visible, but that
> > > may not be appropriate for an video overlay frame.  It's quite common
> > > for (eg) broadcast video to contain dead pixels or other artifacts on
> > > the right hand side, and the broadcast video expects overscan to be
> > > present.
> > >
> > > I know this because I have run my TV with overscan disabled, even for
> > > broadcast TV.
> > 
> > I know, but on this particular hardware, composite really is just
> > another video output. There's not even a TV receiver in it, so I don't
> > think we have to worry about it.
> 
> Whether or not there's a TV receiver is irrelevant - if you can decode
> broadcast video, then you run into the problem.  For example, if you
> plug in a USB DVB stick, stream it across the network, etc.

Good point.

> Remember, you're proposing a generic solution, so making arguments
> about things that are not possible with your specific hardware isn't
> really that relevant to a generic solution.

This is definitely not what I'm proposing. I've been told very early
on that such a generic solution was not even worth working on.

> So, I may want my graphics to appear on an overscanned display such
> that I can see the borders, but I may want the overlaid video to use
> the full active area (including overscan) to hide some of the broadcast
> mess at the edges of the screen.
> 
> > > Yea, that's quite sad, "analog" has become a dirty word, but really
> > > this has nothing to do with "analog" at all - there are LCD TVs (and
> > > some monitors) out there which take HDMI signals but refuse to
> > > disable overscan no matter what you do to them if you provide them
> > > with a "broadcast"  mode - so the analog excuse is very poor.
> > 
> > I'd agree with you, but I was also told to not turn that into a
> > generic code and deal with that in my driver.
> 
> I guess whoever told you that was wrong.  I used to have a cheap TV
> here which took HDMI, and always overscans broadcast modes, and
> underscans PC modes.  No amount of fiddling with various settings
> (either in the TV or AVI frames) changes that.
> 
> I've run into that with a _monitor_ that Andrew Hutton has, which has
> a HDMI input - exactly the same thing - 1080p, 720p etc are all
> unconditionally overscanned, 1024x768 etc are all unconditionally
> underscanned and there's nothing that can be done to change it.
> 
> The problem is that TVs are at liberty to have this behaviour, so
> the overscaned problem is always going to be there, and each driver
> should not be dealing with it in their own specific ways.

I agree with you, however, without any directions on how to do this,
and willingness to merge this, I don't really see why we would work on
such a generic implementation in the first place.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/8a156bb1/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Oct 2016 12:03:49 +0200
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
In-Reply-To: <20161018092422.GJ1041@n2100.armlinux.org.uk>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <20161018092422.GJ1041@n2100.armlinux.org.uk>
Message-ID: <20161018100349.qm2f554oiwyjwrsi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Oct 18, 2016 at 10:24:22AM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 18, 2016 at 10:29:33AM +0200, Maxime Ripard wrote:
> > The Allwinner display engine doesn't have any kind of hardware help to deal
> > with TV overscan.
> 
> I'm not sure I follow.  My understanding (from reading the CEA specs)
> is that TVs are expected to overscan the image, so the upper left, and
> bottom right pixels are not visible.

Yes, this is why we have to work around it somehow.

> I assume we are talking about TVs connected via HDMI.  In the HDMI AVI
> infoframe, there are bits which specify whether the image should be
> overscanned or underscanned - however, whether a TV implements those
> bits is rather sketchy.  I assume when you say "any kind of hardware
> help" you mean you can't control these bits?
> 
> However, some (most?) TVs now implement a menu option which allows the
> (over)scan mode to be selected.  Others assume that if it's a TV mode,
> it's supposed to be overscanned, if it's a "PC" mode, it should be
> underscanned and provide no option to change the behaviour.

We're talking about plain dumb composite output, so no infoframes,
setup or anything here :)

> > This means that if we use the only mode the hardware provides (either PAL
> > or NTSC, or something else), most of the screens will crop the borders of
> > the image, which is bad.
> 
> I think you're trying to apply monitor-type behaviour to TVs...

Yes, kind of. Our users are usually running a desktop distro, and the
default output on those boards are just plain composite, which means
running any DE onto a TV.

Note that it's not only about the interface itself, but you'll lose
content for all pictures displayed. And no one cares about the TV safe
area anymore these days (starting with the framebuffer console).

> > We can however use somekind of a hack, to instead reduce the mode
> > exposed to the userspace, and center it in the final image. We
> > would expose different overscan ratio to be able to deal with most
> > of the screens, each reducing more the displayable area.
> 
> I'm not sure we need "a hack".  What if we treated the primary plane just
> like any other (eg, overlay) plane?  We could then specify (eg) a 1920x1080
> display mode, but with the primary plane reduced in size, positioned in
> the centre of the display mode?
> 
> I know that there's hardware out there which can do exactly that - Marvell
> Dove implements this: you set the display size separately from two planes,
> one graphics plane and one video plane.  Both planes can be positioned
> anywhere in the displayed size.

This might have been poorly worded on my side, but it's exactly what
I'm doing in those patches.

> We could then specify at DRM level that a connected device overscans by
> N%, and have the primary plane adjusted by DRM itself.

I'd agree with you, however, there's a few issues with that I
think.

The first one is that this overscanning should be reported by the
connector I guess? but this is really TV specific, so we need one way
to let the user tell how the image is displayed on its side, and we
cannot really autodetect it, and this needs to be done at runtime so
that we can present some shiny interface to let it select which
overscan ratio works for him/her.

The second one is that we still need to expose the reduced modes to
userspace, and not only the displayed size, so that the applications
know what they must draw on. But I guess this could be adjusted by the
core too.

In order to work consistently, I think all planes should be adjusted
that way, so that relative coordinates are from the primary plane
origin, and not the display origin. But that could be adjusted too by
the core I guess.

The fourth one being the major one. Every time I raised the issue on
IRC, the answer basically was "we don't care about analog", so I'm a
bit pessimistic about whether dealing with this in the core would be
accepted, hence why I chose to deal with this at the driver level.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161018/64e682e0/attachment.sig>

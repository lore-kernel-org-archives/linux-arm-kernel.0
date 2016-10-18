From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Oct 2016 10:24:22 +0100
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
In-Reply-To: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20161018092422.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 10:29:33AM +0200, Maxime Ripard wrote:
> The Allwinner display engine doesn't have any kind of hardware help to deal
> with TV overscan.

I'm not sure I follow.  My understanding (from reading the CEA specs)
is that TVs are expected to overscan the image, so the upper left, and
bottom right pixels are not visible.

I assume we are talking about TVs connected via HDMI.  In the HDMI AVI
infoframe, there are bits which specify whether the image should be
overscanned or underscanned - however, whether a TV implements those
bits is rather sketchy.  I assume when you say "any kind of hardware
help" you mean you can't control these bits?

However, some (most?) TVs now implement a menu option which allows the
(over)scan mode to be selected.  Others assume that if it's a TV mode,
it's supposed to be overscanned, if it's a "PC" mode, it should be
underscanned and provide no option to change the behaviour.

> This means that if we use the only mode the hardware provides (either PAL
> or NTSC, or something else), most of the screens will crop the borders of
> the image, which is bad.

I think you're trying to apply monitor-type behaviour to TVs...

> We can however use somekind of a hack, to instead reduce the mode exposed
> to the userspace, and center it in the final image. We would expose
> different overscan ratio to be able to deal with most of the screens, each
> reducing more the displayable area.

I'm not sure we need "a hack".  What if we treated the primary plane just
like any other (eg, overlay) plane?  We could then specify (eg) a 1920x1080
display mode, but with the primary plane reduced in size, positioned in
the centre of the display mode?

I know that there's hardware out there which can do exactly that - Marvell
Dove implements this: you set the display size separately from two planes,
one graphics plane and one video plane.  Both planes can be positioned
anywhere in the displayed size.

We could then specify at DRM level that a connected device overscans by
N%, and have the primary plane adjusted by DRM itself.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

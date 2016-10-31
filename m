From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 08:42:34 +0000
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
In-Reply-To: <20161018100349.qm2f554oiwyjwrsi@lukather>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <20161018092422.GJ1041@n2100.armlinux.org.uk>
 <20161018100349.qm2f554oiwyjwrsi@lukather>
Message-ID: <20161031084233.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 12:03:49PM +0200, Maxime Ripard wrote:
> The first one is that this overscanning should be reported by the
> connector I guess? but this is really TV specific, so we need one way
> to let the user tell how the image is displayed on its side, and we
> cannot really autodetect it, and this needs to be done at runtime so
> that we can present some shiny interface to let it select which
> overscan ratio works for him/her.

See xbmc... they go through a nice shiny setup which includes adjusting
the visible area.  From what I remember, it has pointers on each corner
which you can adjust to be just visible on the screen, so xbmc knows
how much overscan there is, and xbmc itself reduces down to the user
set size.

> The second one is that we still need to expose the reduced modes to
> userspace, and not only the displayed size, so that the applications
> know what they must draw on. But I guess this could be adjusted by the
> core too.
> 
> In order to work consistently, I think all planes should be adjusted
> that way, so that relative coordinates are from the primary plane
> origin, and not the display origin. But that could be adjusted too by
> the core I guess.

I'm not sure about that - we want the graphics to be visible, but that
may not be appropriate for an video overlay frame.  It's quite common
for (eg) broadcast video to contain dead pixels or other artifacts on
the right hand side, and the broadcast video expects overscan to be
present.

I know this because I have run my TV with overscan disabled, even for
broadcast TV.

> The fourth one being the major one. Every time I raised the issue on
> IRC, the answer basically was "we don't care about analog", so I'm a
> bit pessimistic about whether dealing with this in the core would be
> accepted, hence why I chose to deal with this at the driver level.

Yea, that's quite sad, "analog" has become a dirty word, but really
this has nothing to do with "analog" at all - there are LCD TVs (and
some monitors) out there which take HDMI signals but refuse to
disable overscan no matter what you do to them if you provide them
with a "broadcast"  mode - so the analog excuse is very poor.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

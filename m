From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 20 Apr 2012 15:33:14 +0200
Subject: [PATCH 3/7] DRM: add sdrm layer for general embedded system
 support
In-Reply-To: <20120420131005.GO3852@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
 <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
 <CAPM=9twdGXNU7kkOnx2GCmofE3KSohdeyuT1dVhvVHTtGA-Ysw@mail.gmail.com>
 <20120420131005.GO3852@pengutronix.de>
Message-ID: <20120420133314.GF4217@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 03:10:05PM +0200, Sascha Hauer wrote:
> (BTW each driver in drm has this layer somewhere in it. If I had hidden
> it in imx specific functions I probably wouldn't have raised any
> questions, but I don't want to go that way)

That's _exactly_ what you should be doing. And once you have more than one
driver that works in a similar way, you can extract the common code as
helper functions to make life easier. Like Rob&Alan did with a few gem
helpers they needed in omapdrm/gma500.

For your case it sounds like a new set of modeset helper functions
tailored for the embedded use-case would be good (as Dave Airlie
suggested). Adding yet another middle-layer (like sdrm is) that forces
drivers to go through it usually ends up in tears. And drm core
unfortunately still has too much middle-layer heritage: For an awful lot
of setup and teardown issues it's the core of the problme - because
drivers can't control when drm sets up and tears down certain things, it's
done at the wrong time (for certain drivers at least). Same problem when
the abstraction doesn't quite fit.

Helper functions leave the driver in full control of what's going on, and
working around hw-specific madness with ease.

https://lwn.net/Articles/336262/ is the canonical reference for why a lot
of kernel people are allergic to anything that looks like a middle-layer.

Yours, Daniel
-- 
Daniel Vetter
Mail: daniel at ffwll.ch
Mobile: +41 (0)79 365 57 48

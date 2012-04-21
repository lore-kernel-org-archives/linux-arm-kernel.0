From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 21 Apr 2012 10:18:46 +0200
Subject: [PATCH 3/7] DRM: add sdrm layer for general embedded system
 support
In-Reply-To: <20120420133314.GF4217@phenom.ffwll.local>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
 <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
 <CAPM=9twdGXNU7kkOnx2GCmofE3KSohdeyuT1dVhvVHTtGA-Ysw@mail.gmail.com>
 <20120420131005.GO3852@pengutronix.de>
 <20120420133314.GF4217@phenom.ffwll.local>
Message-ID: <20120421081846.GS3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 03:33:14PM +0200, Daniel Vetter wrote:
> On Fri, Apr 20, 2012 at 03:10:05PM +0200, Sascha Hauer wrote:
> > (BTW each driver in drm has this layer somewhere in it. If I had hidden
> > it in imx specific functions I probably wouldn't have raised any
> > questions, but I don't want to go that way)
> 
> That's _exactly_ what you should be doing. And once you have more than one
> driver that works in a similar way, you can extract the common code as
> helper functions to make life easier.

I already have three drivers working in a similar way from which I
posted two. I could easily throw in some more into the pot. Also the
code is based on the exynos driver, so I think it's suitable for this
aswell.

> 
> For your case it sounds like a new set of modeset helper functions
> tailored for the embedded use-case would be good (as Dave Airlie
> suggested).

One of my problems is that currently drm is based on the assumption that
there is a single device which offers all needed resources and
information to form a drm device. On embedded systems this is simply not
the case, we have our resources all around the SoC. I have physical
devices which are crtcs, encoders or connectors, but drm does not
provide a way to glue them together. You can find this aswell in the
exynos driver if you grep for exynos_drm_subdrv_register. If you follow
this function you'll see that a good bunch of the driver actually
handles the management of these subdevices. Do you have a suggestion
solving the involved code duplication with helper functions?

Also sooner or later it will happen that the same hdmi controller is
used on two otherwise different SoCs. Currently the driver can't be
shared between SoCs because each hdmi driver implements exynos or
nouveau specific callbacks. I guess the answer is to put the common hdmi
driver code into helper functions and to implement a middle layer in
each drm driver wishing to use it.

> Adding yet another middle-layer (like sdrm is) that forces
> drivers to go through it usually ends up in tears. And drm core
> unfortunately still has too much middle-layer heritage: For an awful lot
> of setup and teardown issues it's the core of the problme - because
> drivers can't control when drm sets up and tears down certain things, it's
> done at the wrong time (for certain drivers at least). Same problem when
> the abstraction doesn't quite fit.
> 
> Helper functions leave the driver in full control of what's going on, and
> working around hw-specific madness with ease.
> 
> https://lwn.net/Articles/336262/ is the canonical reference for why a lot
> of kernel people are allergic to anything that looks like a middle-layer.

I have read the article when it was featured on LWN. While I agree to
several things I have my problems with it. Take for example the MMC
core. A MMC driver mainly has to implement two callbacks, .request and
.set_ios. Noone has ever asked to get direct access from the driver to
the underlying block device and eventually pass control to MMC helper
functions. This makes the MMC core a middle layer sitting between the
blockdevice and the driver.  With drm instead it's normal that ioctls
fall straight through to the driver. This leads to such funny things
that the kernel itself cannot control the device to bring a console on
the screen without dedicated help from the driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

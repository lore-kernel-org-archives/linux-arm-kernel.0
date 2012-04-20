From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 Apr 2012 15:10:05 +0200
Subject: [PATCH 3/7] DRM: add sdrm layer for general embedded system
 support
In-Reply-To: <CAPM=9twdGXNU7kkOnx2GCmofE3KSohdeyuT1dVhvVHTtGA-Ysw@mail.gmail.com>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
 <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
 <CAPM=9twdGXNU7kkOnx2GCmofE3KSohdeyuT1dVhvVHTtGA-Ysw@mail.gmail.com>
Message-ID: <20120420131005.GO3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Added some embedded graphics maintainers to Cc who might be interested
in this]

On Fri, Apr 20, 2012 at 11:02:02AM +0100, Dave Airlie wrote:
> On Wed, Apr 11, 2012 at 4:33 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > This patch adds support for creating simple drm devices. The
> > basic idea of this patch is that drm drivers using the sdrm layer
> > no longer have to implement a full drm device but instead only
> > register crtcs, encoders and connectors with the sdrm layer. The
> > sdrm layer then registers a drm device with the drm core and
> > takes care of the drm device.
> 
> I'm sorry to say I totally hate this on every level. I think I said to
> you before that midlayers are not the answer, and this is a hella big
> midlayer.
> 
> I understand the SoC architecture but I can't think this is the way forward.
> 
> The problems I see from a highlevel:
> 
> This layer is highly restrictive on its users, I get the feeling once
> you get to implement 2-3 complete drivers or try and implement a
> driver say on x86 that should work in a similar fashion you are going
> to realise you made things overly generic and the driver can't change
> it.

That's maybe where our philosophies clash. I'd say that drivers should just
have enough freedom to get their job done whereas you want to give
drivers the freedom to do anything they want. I come from an area where
we have dozens of drivers which mostly are quite similar, in the ARM
world we currently try to get the duplication out of the drivers because
otherwise we can't handle the sheer amount of devices we have.

> Then the drivers will start to workaround the midlayer and we'll
> end up worse off. I don't really want to pick on specifics but the
> taking over of the fb ops is on example,

The layer can be extended when we need it, no need to work around it. I
took over the fb ops because currently I don't need to adjust them. I
know that some devices have accelerated blit operations and this means
that we may add a way to overwrite the ops later. Same with the ioctls.
I didn't provide a way to add device specific ioctls now, partly because
currently I don't need them, partly to get this series out.

> 
> I think this should work as a set of helpers that might work in place
> of the current set of helpers. The current helpers are very directed
> towards desktop x86 experience, so a new set of these might be better.

Hm, this means duplicating the helpers. The KMS support is to a great
extend defined by the helpers. Duplicating them would mean more code
fragmentation and different behaviour from a users point of view. I'd
rather not go this way.

> 
> I get the feeling the drm can just be a virtual platform device of
> some sort, then it reads the device tree and binds all the information
> on what crtc/encoders are available,

We can do that. Currently I use a string matching mechanism to tie
together the different pieces of a device, but sooner or later it will
be devicetree anyway, so no problem to convert this sooner instead of
later. The only problem I see with this is that for example X86 will not
have devicetree, so I see a value in not binding whatever we come up
with too tight to devicetree.

> 
> Also the mode group stuff isn't legacy, the render nodes stuff posted
> is what is intended to use it for, again it may not be useful on ARM,
> but on desktop it has a very useful use case.

I didn't remove them because they are not useful, but because currently
I couldn't add an encoder/connector to a active drm device (see how the
exynos driver currently works around this, I doubt it will work this way
once the legacy_mode_group handling is actually used). The fact that this
is currently unused motivated me to remove it. That said, I can live without
it, no problem.

> 
> I'm sorry to not provide the answer I would fine acceptable, maybe if
> I had a week of time to write something I could figure it out, maybe
> someone else can give advice on how this sort of thing might look,
> Linearo/ARM guys can some of you guys look at this?

Take these patches as my try to show that something has to change to
make drm stuff more widely usable on embedded devices. As said, there
are dozens of different devices out there, many of them are dumb
framebuffer devices like the PXA and i.MX driver I posted, others are
more advanced like the exynos, tegra and the newer i.MX devices. Some of
the bigger players can effort to write (and maintain?) a 300KB driver,
others can not. Those who cannot currently stay in drivers/video, but
this has limitations when it comes to overlay, hot pluggable monitors,
multiple crtcs, etc.

I'd like to find a solution for this which makes us all happy. In the
end reducing the amount of code duplication also helps you as a
maintainer.

(BTW each driver in drm has this layer somewhere in it. If I had hidden
it in imx specific functions I probably wouldn't have raised any
questions, but I don't want to go that way)

Sascha




-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

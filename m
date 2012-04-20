From: airlied@gmail.com (Dave Airlie)
Date: Fri, 20 Apr 2012 11:02:02 +0100
Subject: [PATCH 3/7] DRM: add sdrm layer for general embedded system
 support
In-Reply-To: <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
 <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAPM=9twdGXNU7kkOnx2GCmofE3KSohdeyuT1dVhvVHTtGA-Ysw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 4:33 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This patch adds support for creating simple drm devices. The
> basic idea of this patch is that drm drivers using the sdrm layer
> no longer have to implement a full drm device but instead only
> register crtcs, encoders and connectors with the sdrm layer. The
> sdrm layer then registers a drm device with the drm core and
> takes care of the drm device.

I'm sorry to say I totally hate this on every level. I think I said to
you before that midlayers are not the answer, and this is a hella big
midlayer.

I understand the SoC architecture but I can't think this is the way forward.

The problems I see from a highlevel:

This layer is highly restrictive on its users, I get the feeling once
you get to implement 2-3 complete drivers or try and implement a
driver say on x86 that should work in a similar fashion you are going
to realise you made things overly generic and the driver can't change
it. Then the drivers will start to workaround the midlayer and we'll
end up worse off. I don't really want to pick on specifics but the
taking over of the fb ops is on example,

I think this should work as a set of helpers that might work in place
of the current set of helpers. The current helpers are very directed
towards desktop x86 experience, so a new set of these might be better.

I get the feeling the drm can just be a virtual platform device of
some sort, then it reads the device tree and binds all the information
on what crtc/encoders are available,

Also the mode group stuff isn't legacy, the render nodes stuff posted
is what is intended to use it for, again it may not be useful on ARM,
but on desktop it has a very useful use case.

I'm sorry to not provide the answer I would fine acceptable, maybe if
I had a week of time to write something I could figure it out, maybe
someone else can give advice on how this sort of thing might look,
Linearo/ARM guys can some of you guys look at this?

Dave.

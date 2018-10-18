From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 18 Oct 2018 11:42:58 +0200
Subject: [PATCH 9/9] [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to
 dot clock frequency check
In-Reply-To: <CAKMK7uFp2c=wqzPi096MTRB6Cdfacerkp6dM=fEqCAr99PQG9w@mail.gmail.com>
References: <20181018073327.64942-1-icenowy@aosc.io>
 <20181018073327.64942-10-icenowy@aosc.io>
 <4168274.Gmp9JTCfJR@avalon>
 <CAKMK7uFp2c=wqzPi096MTRB6Cdfacerkp6dM=fEqCAr99PQG9w@mail.gmail.com>
Message-ID: <20181018094258.oahlopafvm2udvoe@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 11:18:06AM +0200, Daniel Vetter wrote:
> On Thu, Oct 18, 2018 at 10:55 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Icenowy,
> >
> > Thank you for the patch.
> >
> > On Thursday, 18 October 2018 10:33:27 EEST Icenowy Zheng wrote:
> > > From: Chen-Yu Tsai <wens@csie.org>
> > >
> > > The panels shipped with Allwinner devices are very "generic", i.e.
> > > they do not have model numbers or reliable sources of information
> > > for the timings (that we know of) other than the fex files shipped
> > > on them. The dot clock frequency provided in the fex files have all
> > > been rounded to the nearest MHz, as that is the unit used in them.
> > >
> > > We were using the simple panel "urt,umsh-8596md-t" as a substitute
> > > for the A13 Q8 tablets in the absence of a specific model for what
> > > may be many different but otherwise timing compatible panels. This
> > > was usable without any visual artifacts or side effects, until the
> > > dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
> > > rgb: Validate the clock rate").
> > >
> > > The reason this check fails is because the dotclock frequency for
> > > this model is 33.26 MHz, which is not achievable with our dot clock
> > > hardware, and the rate returned by clk_round_rate deviates slightly,
> > > causing the driver to reject the display mode.
> > >
> > > The LCD panels have some tolerance on the dot clock frequency, even
> > > if it's not specified in their datasheets.
> > >
> > > This patch adds a 5% tolerence to the dot clock check.
> >
> > Why do you think this shouldn't be merged ?
> 
> It pisses of a lot of people who really insist upon accurate timing.

It's not just about accurate timings. That 5% is a made-up limit, that
never have really been confirmed by looking at the typical tolerancies
of panels.

And while being to relaxed might make some panels work that are not
working currently, it might also break some panels that currently work
and won't now, and ideally, we should really be able to let those
panels work if they can, and filter out resolutions if they can't.

> I think a better fix would be to have a dotclock range in drm_panel,
> and some magic to figure out which one of these we can actually
> do. Then tell userspace that this is the mode is should
> request. That way userspace knows what the actual dotclock/refresh
> rate is, and the panel still works.

It's not just about panels, but also bridges with EDID where the
tolerancy is not exposed.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181018/1f417078/attachment.sig>

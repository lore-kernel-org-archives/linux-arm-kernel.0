From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 31 Dec 2015 21:45:51 +0800
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <20151230172212.GZ16023@sirena.org.uk>
References: <1450792017-7120-1-git-send-email-djkurtz@chromium.org>
 <CACRpkdbRDzXunYK5d6Ld4Z2a=0mkp4KBvgL2P-St4P65Jajamw@mail.gmail.com>
 <20151230172212.GZ16023@sirena.org.uk>
Message-ID: <CAGS+omA9AarzE2sp1Ry3RuOt8EOa-sL=DL1iDA2OeVVdjn=xgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 1:22 AM, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Dec 22, 2015 at 04:11:47PM +0100, Linus Walleij wrote:
> > On Tue, Dec 22, 2015 at 2:46 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>
> > > Move pinctrl initialization earlier in boot so that real devices can find
> > > their pctldev without probe deferring.
> > (...)
> > > -module_init(mtk_pinctrl_init);
> > > +arch_initcall(mtk_pinctrl_init);
>
> > So I see why you're doing this (because of wanting to avoid nasty boot
> > probe deferrals, right?) and I'm going to apply it, because the work
> > with probe ordering is still in the works, but I'd like some general
> > ARM people to come in with opinions.
>
> I really don't think we should be applying this sort of stuff unless
> things are actively broken right now.  It's a bit of a rabbit hole we
> could spend a long time going down tweaking things for different
> systems in the same way that tweaking the link order can be and it masks
> the underlying issues.

Things are actively broken right now, in the sense that there are many
needless probe deferrals on boot.
These are pinctrl drivers, which are required to load before every
other driver that requests a gpio.
AFAICT, the pinctrl is part of the platform "architecture", hence why
I suggest we move this to arch_initcall().
arch_initcall() is also consistent with 39 other pinctrl drivers in
drivers/pinctrl.
19 others use subsys_initcall(), core_initcall() or
postcore_initcall(), any of which would also work.

-Dan

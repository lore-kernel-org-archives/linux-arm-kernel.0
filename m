From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jan 2016 18:23:15 +0000
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <CAGS+omDesPTYHhVLv_EtQsYxa6MNuSi06MwcXz6RcY=uAcEtnQ@mail.gmail.com>
References: <1450792017-7120-1-git-send-email-djkurtz@chromium.org>
 <CACRpkdbRDzXunYK5d6Ld4Z2a=0mkp4KBvgL2P-St4P65Jajamw@mail.gmail.com>
 <20151230172212.GZ16023@sirena.org.uk>
 <CAGS+omA9AarzE2sp1Ry3RuOt8EOa-sL=DL1iDA2OeVVdjn=xgg@mail.gmail.com>
 <20151231220712.GD16023@sirena.org.uk>
 <CAGS+omDesPTYHhVLv_EtQsYxa6MNuSi06MwcXz6RcY=uAcEtnQ@mail.gmail.com>
Message-ID: <20160104182315.GP16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 01, 2016 at 09:56:01AM +0800, Daniel Kurtz wrote:
> On Fri, Jan 1, 2016 at 6:07 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Dec 31, 2015 at 09:45:51PM +0800, Daniel Kurtz wrote:

> >> Things are actively broken right now, in the sense that there are many
> >> needless probe deferrals on boot.

> > That's just noisy, everything does end up loading OK.

> It's not just noisy, it also adds to boot time.

If you've got meaningful boot time numbers from practical systems it'd
be good to share them, nobody was able to show any actual problem there.

> >> These are pinctrl drivers, which are required to load before every
> >> other driver that requests a gpio.
> >> AFAICT, the pinctrl is part of the platform "architecture", hence why
> >> I suggest we move this to arch_initcall().

> > This is exactly the sort of hacking that leads to problems

> What problems?
> More patches as people adjust / tune / optimize boot time, or something else?

There's that and also general fragility when multiple drivers interact -
it can get really problematic when different systems end up with
different requirements for the sasme driver and disrupt each other or
conflict with each other.

> > you can
> > also make the same argument for a bunch of other things like regulators
> > but then you find there's circular dependencies or extra devices with
> > different requirements on some systems that cause further issues and
> > need more special casing, or you find that some other device gets pushed
> > earlier so you have to go round tweaking everything it uses.

> For regulators, I think things are a bit more subtle.  Most regulators
> are external components that can be used on different boards for
> different purposes, so I can see an argument for treating them in a
> more generic way by using a later device_initcall.  The exception
> being architecture specific PMICs that only make sense when paired
> with a specific small set of CPUs - and if you look, there are many
> PMIC regulator drivers that are at earlier initcall levels, presumably
> because they are required by cpufreq drivers, and/or their initcall
> level is set as the same as the rest of the functions exposed by the
> same PMIC MFD.

The reason the regulator drivers are earlier is that cpufreq and a
couple of other things are broken and don't use the device model so we
have to use link order hacks.  I'm pushing any driver that doesn't
specifically have problems with those to just use normal initcall.

> >> arch_initcall() is also consistent with 39 other pinctrl drivers in
> >> drivers/pinctrl.
> >> 19 others use subsys_initcall(), core_initcall() or
> >> postcore_initcall(), any of which would also work.

> > It's fairly clear that there's at least a case for simplifying the
> > existing practice here, for example by moving everything into a single
> > (perhaps aliased) initcall rather than by randomly picking a level per
> > system or by actually fiddling with the link ordering if the case is
> > sufficiently clear that pinctrl in general ought to load earlier than it
> > does.

> Nothing above sounds like a reason not to merge this patch, however.
> Why should we block useful patches that use existing tools to fix real
> architecture-specific issues until new infrastructure is merged that
> solves general problems?

Some of the infrastructure here is really trivial if we are saying that
basically all drivers do this.  That way you don't end up so much with
things like wondering why different drivers made different decisions so
much.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/542c5549/attachment-0001.sig>

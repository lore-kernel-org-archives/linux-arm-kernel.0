From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jul 2014 10:54:17 +0200
Subject: [PATCH 12/12] ARM: tegra: Convert PMC to a driver
In-Reply-To: <CAOesGMi=UrLS3OuFb9SAaf9dPBojYrqp4VE0YhGiX1hkLvYanw@mail.gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <20140716185715.GA4843@mithrandir>
 <CAOesGMi=UrLS3OuFb9SAaf9dPBojYrqp4VE0YhGiX1hkLvYanw@mail.gmail.com>
Message-ID: <111661024.qGiugVUugr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 July 2014 12:34:56 Olof Johansson wrote:
> On Wed, Jul 16, 2014 at 11:57 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Wed, Jul 16, 2014 at 05:22:03PM +0200, Arnd Bergmann wrote:
> >> On Wednesday 16 July 2014 17:14:29 Thierry Reding wrote:
> >> > >
> >> > > Ok, I'll have a look. I think when this becomes a separate driver, it
> >> > > should also have its own header file, so maybe you can in the meantime
> >> > > make it a local header file in mach-tegra until we have found a good
> >> > > place for it.
> >> >
> >> > Why do you think it should be a separate header? We already have a
> >> > couple in include/linux and I'm not sure it's useful to add even more.
> >> > If anything I would've thought it made sense to move the content of the
> >> > other headers into tegra-soc.h.
> >>
> >> I very much dislike the idea of having a per-vendor header file that
> >> everything gets crammed into. We should try to have proper subsystems
> >> and generic interfaces for these wherever possible.
> >
> > I completely agree. However spreading the SoC-specific functions across
> > multiple header files isn't going to help. If we keep all the per-vendor
> > APIs in one file it makes it easier to see what could still be moved off
> > into a separate subsystem.
> >
> > Now for PMC specifically, we've investigated converting the powergate
> > API to power domains. I don't think it will be possible to make that
> > work. The issue is that there's a defined sequence that needs to be
> > respected to make sure the device is powered up properly. That sequence
> > involves the primary clock and reset of the device. It's been proposed
> > to make these clocks available to the PMC driver so that it can control
> > them, but then we can't make sure that clocks are really off if they
> > need to be, since we have two drivers accessing them. The only way I see
> > to make that work reliably is by moving complete control of the
> > powergate into drivers so that they can make sure clocks and resets are
> > in the correct states.

I don't completely follow, but that's ok ;-)

> > The PMC driver also provides access to I/O rails and specifically a deep
> > power down state. Some modules are in deep power down state by default,
> > so they need to be brought out of that state. I suppose this would be
> > easier to turn into a generic framework because there aren't any cross-
> > dependencies like for powergates, but I'm not aware of any other SoC
> > having a similar feature (or implementation thereof in the kernel). And
> > adding a subsystem just for the sake of it if only one implementation is
> > available isn't a good idea in my opinion because it will be naturally
> > designed to work best (and therefore maybe only) for the one instance.
> >
> > This issue is a fundamental one and there are bound to be other SoCs
> > that have similarly unique blocks for which it's impractical to add a
> > framework. I suspect the primary reason why we haven't run into it this
> > frequently is because a lot of it is still hidden in arch/arm/mach-*.
> >
> > I'm open to suggestions of course, but the best option I currently see
> > is to collect these custom APIs in a central place so that we can easily
> > compare various SoCs for commonalities as time goes by and factor them
> > out into subsystems where appropriate.
> >
> > For the same reason I think it's valid to put this type of code into
> > drivers/soc. That way we have one subdirectory to look through for
> > potential unification rather than various ones sprinkled across arch
> > directories. It makes little sense in my opinion to move this code to
> > drivers/power if there's no common framework anyway.
> 
> I agree. We can move them out and make them common them later if needed.
> 
> We're sometimes trying too hard to find proper homes for various new
> drivers, which means that we're proliferating the kernel with a lot of
> new driver directories that have only one or two drivers in them.
> 
> I'd rather collect stuff in drivers/soc, and move it out as needed
> later. Especially since we merge drivers/soc through one merge path
> (arm-soc) and can keep an eye on it, while the
> scatter-drivers-everywhere approach merges through various
> maintainers.

Ok. I'm fine with having one driver in drivers/soc for the pmc (and
a few associated bits if necessary) and a header file for that. If you
end up with two separate drivers in drivers/soc, I'd also prefer two
separate header files.

It may be a good idea to put these headers somewhere other than
include/linux/*.h, which is completely overloaded by random stuff.
We could use include/linux/soc/*.h or include/soc/*.h for those.

	Arnd

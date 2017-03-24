From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 24 Mar 2017 17:11:25 +0100
Subject: [PATCH 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170324154600.lavc22dbw7rtioli@kozik-lap>
References: <20170324142446.31129-1-krzk@kernel.org>
 <3940941.n3qdgn1RbN@amdc3058> <20170324154600.lavc22dbw7rtioli@kozik-lap>
 <CGME20170324161128epcas1p4b9ef08e3d7e640957d30afa84aa66a16@epcas1p4.samsung.com>
Message-ID: <9265537.P6AeF50kg8@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 24, 2017 06:46:00 PM Krzysztof Kozlowski wrote:
> On Fri, Mar 24, 2017 at 04:26:47PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > Firstly, thanks for working on this.
> > 
> > The patch looks fine overall for me, some review comments below.
> > 
> > On Friday, March 24, 2017 05:24:44 PM Krzysztof Kozlowski wrote:
> > > Replace existing hw_ranndom/exynos-rng driver with a new, reworked one.
> > > This is a driver for pseudo random number generator block which on
> > > Exynos4 chipsets must be seeded with some value.  On newer Exynos5420
> > > chipsets it might seed itself from true random number generator block
> > > but this is not implemented yet.
> > > 
> > > New driver is a complete rework to use the crypto ALGAPI instead of
> > > hw_random API.  Rationale for the change:
> > > 1. hw_random interface is for true RNG devices.
> > > 2. The old driver was seeding itself with jiffies which is not a
> > >    reliable source for randomness.
> > > 3. Device generates five random numbers in each pass but old driver was
> > >    returning only one thus its performance was reduced.
> > > 
> > > Compatibility with DeviceTree bindings is preserved.
> > > 
> > > New driver does not use runtime power management but manually enables
> > > and disables the clock when needed.  This is preferred approach because
> > > using runtime PM just to toggle clock is huge overhead.  Another
> > 
> > I'm not entirely convinced that the new approach is better.
> > 
> > With the old approach exynos_rng_generate() can be called more
> > than once before PM autosuspend kicks in and thus clk_prepare_enable()/
> > clk_disable()_unprepare() operations will be done only once. This
> > would give better performance on the "burst" operations.
> > 
> > [ The above assumes that clock operations are more costly than
> >   going through PM core to check the current device state. ]
> 
> I agree that we loose the "burst" mode but:
> 1. At least on Exynso4 SSS is part of TOP power domain so it will not
>    help to reduce any more power consumption (on Exynos5422 it is
>    mentioned in G2D... which seems incorrect).
> 2. I think the overhead of clk operations is much smaller. These are only
>    two locks (prepare mutex + enable spin), simple tree traversal and
>    play with few SFRs.
> 
>    The power domain code in comparison to that is huge and complicated
>    with inter-device links and dependencies. Also the actual runtime PM
>    suspend would anyway fall back at then end to clk prepare/enable
>    locks and paths.
> 
>    We've been talking about this a lot with Marek Szyprowski (cc'ed) and
>    he was always (AFAIR) against attempts of runtime power
>    management of a single clock...

OK, thanks for explanation.

> > > +static int exynos_rng_probe(struct platform_device *pdev)
> > > +{
> > > +	struct exynos_rng_dev *rng;
> > > +	struct resource *res;
> > > +	int ret;
> > > +
> > > +	if (exynos_rng_dev)
> > > +		return -EEXIST;
> > 
> > How this condition could ever happen? 
> > 
> > The probe function will never be called twice.
> 
> I really do not like global or file-scope variables. I do not like
> drivers using them. Actually I hate them.
> 
> From time to time I encounter a driver which was designed with that
> approach - static fields and hidden assumption that there will be only
> one instance. Usually that assumption is really hidden...
> 
> ... and then it happens that I want to use two instances which of course
> fails.
> 
> This code serves as a clear documentation for this assumption - only one
> instance is allowed. You can look at it as a self-documenting
> requirement.

For me it looks as needless case of defensive programming and when
I see the code like this it always raises questions about the real
intentions of the code. I find it puzzling and not helpful.

> And I think the probe might be called twice, for example in case of
> mistake in DTB.

Even if this is possible resource allocation code in the driver will
take take care of handling it just fine,

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

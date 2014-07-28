From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 28 Jul 2014 09:45:01 +0530
Subject: [PATCH RFC] mfd: syscon: Decouple syscon interface from syscon
 devices
In-Reply-To: <5537724.LlmJ2hxcKn@wuerfel>
References: <53A05E2D.6020702@samsung.com> <5027740.B7iVUcUX2T@wuerfel>
 <53A0B27E.5010708@gmail.com> <5537724.LlmJ2hxcKn@wuerfel>
Message-ID: <002701cfaa1a$82b42770$881c7650$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wednesday, June 18, 2014 Arnd wrote:
> To: Tomasz Figa
> Cc: linux-arm-kernel at lists.infradead.org; mark.brown at linaro.org; Tomasz
Figa;
> linux-samsung-soc at vger.kernel.org; Kukjin Kim; Russell King - ARM Linux;
Samuel
> Ortiz; Pankaj Dubey; linux-kernel at vger.kernel.org; joshi at samsung.com;
> vikas.sajjan at samsung.com; chow.kim at samsung.com; Lee Jones
> Subject: Re: [PATCH RFC] mfd: syscon: Decouple syscon interface from
syscon
> devices
> 
> On Tuesday 17 June 2014 23:26:22 Tomasz Figa wrote:
> > On 17.06.2014 17:42, Arnd Bergmann wrote:
> > > This seems like a reasonable way of solving the problem, but I think
> > > there is an even better one that we have about in the past: if we
> > > promote syscon from a platform driver into a a drivers/base/ helper
> > > that is independent of the platform device matching, we can use call
> > > syscon_regmap_lookup_* for any device node, whether it's already
> > > bound to a driver or not, which do what you need. It would also make
> > > it easier to call the syscon code before the platform_device
> > > infrastructure gets initialized, which is something a number of
> > > people have asked for, e.g. for using regmap to do SMP bringup or
> > > for clock registration.
> >
> > Basically, unless I'm missing your point, this is what my patch does,
> > except that I don't move it to drivers/base/ and the registration
> > function I added require a pointer to struct device. Indeed,
> > decoupling it further from the driver model, by adding
> > of_syscon_register() should be useful for early users.
> 
> I believe the part you are missing is that with the approach I suggested,
there would
> be no registration function at all. You can easily do the lookup from the
client drivers
> using the DT data structures, with no need for the device at all. 

Will you please elaborate more on this? 

The only exception
> today is the clps711x platform using syscon_regmap_lookup_by_pdevname(),
but
> that should be solved in 3.17 when clps711x becomes DT-only.
> 

Does it mean that this may become a blocking issue for this patch to go
before 3.17?
If yes, isn't it will be good to accept this patch as it is if it's not
causing issue or breaking
anything with existing users of syscon. At least for our use of converting
Exynos PMU and
PM related consolidation this change is working fine and we have verified
it.

> > Should I move this to drivers/base/, even though from current location
> > it can be used outside the platform driver anyway?
> 
> Thinking about it some more, drivers/of might be better than drivers/base.
> It depends a bit where we are heading with this, in particular if we
expect to see non-
> DT users in the future.
> 
> 	Arnd

Thanks,
Pankaj Dubey

From: jamie.iles@picochip.com (Jamie Iles)
Date: Thu, 17 Dec 2009 16:27:10 +0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <001101ca7f33$fe8ddc90$fba995b0$@deacon@arm.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<001101ca7f33$fe8ddc90$fba995b0$@deacon@arm.com>
Message-ID: <20091217162710.GC32483@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 04:14:22PM -0000, Will Deacon wrote:
> > +const struct pmu_irqs *
> > +reserve_pmu(void)
> > +{
> > +	int ret = down_trylock(&pmu_mutex) ? -EBUSY : 0;
> > +
> > +	return ret ? ERR_PTR(ret) : &pmu_irqs;
> > +}
> 
> I think it would be sensible to return an error (-ENODEV) if
> pmu_irqs.num_irqs == 0. Not doing so can cause applications
> to fail silently when they are running on unsupported boards.
I did think about that, but when the interrupts were in oprofile, it
didn't regard this as an error so I kept this the same.

In the perf events code, we check that num_irqs is >= 1. You _could_ use
the pmu as free running counters that you just periodically sample and
wouldn't need an interrupt so I thought it best to leave this error
checking to the user.

Cheers,

Jamie

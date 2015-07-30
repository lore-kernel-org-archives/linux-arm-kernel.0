From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 30 Jul 2015 08:19:34 +0100
Subject: [PATCH] irqchip: gic: Add a cpu map for each GIC instance
In-Reply-To: <alpine.DEB.2.11.1507291810040.3825@nanos>
References: <1438180984-18219-1-git-send-email-jonathanh@nvidia.com>
 <alpine.DEB.2.11.1507291810040.3825@nanos>
Message-ID: <20150730081934.02a6aa99@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Jul 2015 17:10:45 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 29 Jul 2015, Jon Hunter wrote:
> 
> Cc'ing Marc ...

Thanks for looping me in.

> 
> > The gic_init_bases() function initialises an array that stores the mapping
> > between the GIC and CPUs. This array is a global array that is
> > unconditionally initialised on every call to gic_init_bases(). Although,
> > it is not common for there to be more than one GIC instance, there are
> > some devices that do support nested GIC controllers and gic_init_bases()
> > can be called more than once.
> > 
> > A 2nd call to gic_init_bases() will clear the previous CPU mapping and
> > will only setup the mapping again for CPU0. This is because for child GIC
> > controllers there is most likely only one recipient of the interrupt.
> > 
> > Fix this by moving the CPU mapping array to the GIC chip data structure
> > so that it is initialised for each GIC instance separately. It is assumed
> > that the bL switcher code is only interested in the root or primary GIC
> > instance.

This feels very odd. If you have a secondary GIC, it is cascaded into
the primary one, and I don't see why you would need to manage the
affinity of the interrupt for the secondary GIC. The only thing that
matters is the affinity of interrupts in the primary one, and this is
what the bl switcher is dealing with.

To me, it looks like the bug is to even try to compute an affinity for
a GIC that is not the primary one, and keeping it around doesn't
seem to make much sense. 

Or am I overlooking something?

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 25 Jun 2014 16:04:43 +0000
Subject: [PATCH v2] sched: Fix compiler warnings
In-Reply-To: <20140625155259.GQ14781@pengutronix.de>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140625071416.GM14781@pengutronix.de> <53AADC63.8080106@roeck-us.net>
 <20140625144955.GP14781@pengutronix.de> <53AAE4D2.5020104@roeck-us.net>
 <063D6719AE5E284EB5DD2968C1650D6D17265D81@AcuExch.aculab.com>
 <20140625155259.GQ14781@pengutronix.de>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17265E10@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig 
> Hello,
> 
> On Wed, Jun 25, 2014 at 03:40:28PM +0000, David Laight wrote:
> > From: Guenter Roeck
> > > Actually turns out one can use __attribute_const__, and it is
> > >
> > > 	static inline int __attribute_const__ cpu_corepower_flags(void)
> > >
> > > which turns out to be widely used.
> > >
> > > I'll change that and resubmit after testing.
> >
> > You don't need to tell the compiler that for an inline function.
> I didn't check for the functions in question here, but in general your
> statement is wrong.
> 
> For example:
> 
> static inline unsigned int __attribute_const__ read_cpuid_id(void)
> {
> 	return readl(BASEADDR_V7M_SCB + V7M_SCB_CPUID);
> }
> 
> from arch/arm/include/asm/cputype.h. The V7M_SCB_CPUID register never
> changes, but there is no way gcc can deduce that.

Hmm... it all rather depends on the order of the optimisations and 
inlining.

I've tried to use 'restrict' on the parameters to an inline function
in an attempt to get 'noalias' - but the reverse inference never
seems to be applied.

	David

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jan 2010 18:03:05 +0000
Subject: [PATCH] spinlock: don't use deprecated barriers on ARMv7
In-Reply-To: <20100125173808.GA23926@debian>
References: <1263397536-15736-1-git-send-email-rabin@rab.in>
	<20100124204233.GA25665@n2100.arm.linux.org.uk>
	<20100125173808.GA23926@debian>
Message-ID: <20100125180305.GC22481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 11:20:29PM +0530, Rabin Vincent wrote:
> On Sun, Jan 24, 2010 at 08:42:33PM +0000, Russell King - ARM Linux wrote:
> > > +static inline void smp_sev(void)
> > > +{
> > > +#if defined(CONFIG_SMP) && defined(CONFIG_CPU_32v6K)
> > > +	dsb();
> > > +	__asm__ __volatile__ ("sev" : : : "memory");
> > 
> > Why are you introducing a compiler memory barrier where there was none
> > before?
> 
> I've removed it (and the additional memory barrier from the dsb()
> helper) in the updated patch below.  I've also moved the helper into
> spinlock.h itself, to avoid unnecessarily cluttering system.h:
> 
> >From a701fe2c665f9d80aa2c96ae6f312a25ee1136a2 Mon Sep 17 00:00:00 2001
> From: Rabin Vincent <rabin@rab.in>
> Date: Mon, 11 Jan 2010 20:36:26 +0530
> Subject: [PATCH] spinlock: don't use deprecated barriers on ARMv7
> 
> On ARMv7, the use of the cp15 operations for barriers is deprecated in
> favour of the isb, dsb, and dmb instructions.  Change the locking
> functions to use the appropriate type of dsb for the architecture being
> built for.

This version looks better, thanks.  Care to send it to the patch system?

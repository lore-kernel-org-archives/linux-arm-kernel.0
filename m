From: rabin@rab.in (Rabin Vincent)
Date: Mon, 25 Jan 2010 23:20:29 +0530
Subject: [PATCH] spinlock: don't use deprecated barriers on ARMv7
In-Reply-To: <20100124204233.GA25665@n2100.arm.linux.org.uk>
References: <1263397536-15736-1-git-send-email-rabin@rab.in>
	<20100124204233.GA25665@n2100.arm.linux.org.uk>
Message-ID: <20100125173808.GA23926@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2010 at 08:42:33PM +0000, Russell King - ARM Linux wrote:
> > +static inline void smp_sev(void)
> > +{
> > +#if defined(CONFIG_SMP) && defined(CONFIG_CPU_32v6K)
> > +	dsb();
> > +	__asm__ __volatile__ ("sev" : : : "memory");
> 
> Why are you introducing a compiler memory barrier where there was none
> before?

I've removed it (and the additional memory barrier from the dsb()
helper) in the updated patch below.  I've also moved the helper into
spinlock.h itself, to avoid unnecessarily cluttering system.h:

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 10:37:39 +0000
Subject: [PATCH] Remove CPU_32v6K dependencies in asm/spinlock.h
In-Reply-To: <AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
References: <20110115161132.GH15996@n2100.arm.linux.org.uk>
	<AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
Message-ID: <20110117103739.GA18626@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 10:15:25AM +0000, Catalin Marinas wrote:
> On 15 January 2011 16:11, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > SMP requires at least the ARMv6K extensions to be present, so if we're
> > running on SMP, the WFE and SEV instructions must be available.
> >
> > However, when we run on UP, the v6K extensions may not be available,
> > and so we don't want WFE/SEV to be in the instruction stream. ?Use the
> > SMP alternatives infrastructure to replace these instructions with NOPs
> > if we build for SMP but run on UP.
> [...]
> > --- a/arch/arm/include/asm/spinlock.h
> > +++ b/arch/arm/include/asm/spinlock.h
> > @@ -5,17 +5,36 @@
> > ?#error SMP not supported on pre-ARMv6 CPUs
> > ?#endif
> >
> > +/*
> > + * sev and wfe are ARMv6K extensions. ?Uniprocessor ARMv6 may not have the K
> > + * extensions, so when running on UP, we have to patch these instructions away.
> > + */
> > +#define ALT_SMP(smp, up) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> > + ? ? ? "9998: ?" smp "\n" ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> > + ? ? ? " ? ? ? .pushsection \".alt.smp.init\", \"a\"\n" ? ? ? ?\
> > + ? ? ? " ? ? ? .long ? 9998b\n" ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> > + ? ? ? " ? ? ? " up "\n" ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> > + ? ? ? " ? ? ? .popsection\n"
> > +
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +#define SEV ? ? ? ? ? ?ALT_SMP("sev.w", "nop.w")
> > +#define WFE(cond) ? ? ?ALT_SMP("wfe" cond ".w", "nop.w")
> > +#else
> > +#define SEV ? ? ? ? ? ?ALT_SMP("sev", "nop")
> > +#define WFE(cond) ? ? ?ALT_SMP("wfe" cond, "nop")
> > +#endif
> 
> In the SEV macro definition, can you also include the dsb?

No, you can't do preprocessor conditionals in the middle of a macro
definition, and I don't want to have 4 versions of the SEV stuff.

> This barrier is only there because of sev, otherwise we don't need it
> (we have a dmb prior to releasing the lock).

1. Does it make sense to have sev and wfe instructions in non-SMP kernels?
We now have in asm/system.h:
#if __LINUX_ARM_ARCH__ >= 7 ||          \
        (__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
#define sev()   __asm__ __volatile__ ("sev" : : : "memory")
#define wfe()   __asm__ __volatile__ ("wfe" : : : "memory")
#define wfi()   __asm__ __volatile__ ("wfi" : : : "memory")
#endif

2. Should we have a smp_dsb() which makes the dsb conditional elsewhere?

3. Do we always need a dsb prior to a sev?  Maybe the SPEAR patches need
another review to determine how they're using sev()?

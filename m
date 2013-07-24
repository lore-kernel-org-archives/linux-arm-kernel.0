From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 11:42:19 +0100
Subject: [PATCH 3/6] ARM: prefetch: add support for prefetchw using pldw
 on SMP ARMv7+ CPUs
In-Reply-To: <alpine.LFD.2.03.1307231559120.15022@syhkavp.arg>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-4-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307231559120.15022@syhkavp.arg>
Message-ID: <20130724104218.GB11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 09:05:58PM +0100, Nicolas Pitre wrote:
> On Tue, 23 Jul 2013, Will Deacon wrote:
> 
> > SMP ARMv7 CPUs implement the pldw instruction, which allows them to
> > prefetch data cachelines in an exclusive state.
> > 
> > This patch defines the prefetchw macro using pldw for CPUs that support
> > it.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Minor nit below.  Otherwise:
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> > ---
> >  arch/arm/include/asm/processor.h | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> > index cbdb130..d571697 100644
> > --- a/arch/arm/include/asm/processor.h
> > +++ b/arch/arm/include/asm/processor.h
> > @@ -116,12 +116,19 @@ static inline void prefetch(const void *ptr)
> >  		:: "p" (ptr));
> >  }
> >  
> > +#if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
> >  #define ARCH_HAS_PREFETCHW
> > -#define prefetchw(ptr)	prefetch(ptr)
> > -
> > -#define ARCH_HAS_SPINLOCK_PREFETCH
> > -#define spin_lock_prefetch(x) do { } while (0)
> > -
> 
> What about keeping the above definitions when __LINUX_ARM_ARCH__ >= 7
> && defined(CONFIG_SMP) is not true?

In the case that we don't have prefetchw, then spin_lock_prefetch would end
up being defined as __builtin_prefetch(x,1) by linux/prefetch.h. GCC will
almost certainly spit out `pld' for that (it currently ignores the second
argument...), which should be better than doing nothing. The cacheline may not
be in the ideal state (shared rather than exclusive), but at least it's likely
to be in the cache rather than sitting out in memory.

Unfortunately, spin_lock_prefetch is only used in one place, so changes to
its implementation don't have any measurable difference on kernel
performance.

> > +static inline void prefetchw(const void *ptr)
> > +{
> > +	__asm__ __volatile__(
> > +		".arch_extension	mp\n"
> > +	__ALT_SMP_ASM(
> > +		WASM(pldw)		"\t%a0",
> > +		WASM(pld)		"\t%a0"
> > +	)
> 
> The paren indentation looks odd.  If you shift the whole __ALT_SMP_ASM 
> block right then it is also less likely to look like a sequential 
> execution of pldw followed by pld to the casual reader.

Sure, I'll fix that up.

Thanks again for your feedback,

Will

From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Nov 2013 10:27:41 +0100
Subject: [GIT PULL] prefetch support for 3.13
In-Reply-To: <20131111112554.GE28302@mudshark.cambridge.arm.com>
References: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
 <20131111090810.GI14892@pengutronix.de>
 <20131111112554.GE28302@mudshark.cambridge.arm.com>
Message-ID: <20131119092741.GC28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 11:25:54AM +0000, Will Deacon wrote:
> On Mon, Nov 11, 2013 at 09:08:10AM +0000, Uwe Kleine-K?nig wrote:
> > Hello Will,
> > 
> > On Wed, Oct 09, 2013 at 06:13:13PM +0100, Will Deacon wrote:
> > > The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
> > > 
> > >   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/prefetch
> > > 
> > > for you to fetch changes up to d779c07dd72098a7416d907494f958213b7726f3:
> > > 
> > >   ARM: bitops: prefetch the destination word for write prior to strex (2013-09-30 16:42:56 +0100)
> > > 
> > > ----------------------------------------------------------------
> > > Will Deacon (6):
> > >       ARM: prefetch: remove redundant "cc" clobber
> > >       ARM: smp_on_up: move inline asm ALT_SMP patching macro out of spinlock.h
> > >       ARM: prefetch: add support for prefetchw using pldw on SMP ARMv7+ CPUs
> > >       ARM: locks: prefetch the destination word for write prior to strex
> > >       ARM: atomics: prefetch the destination word for write prior to strex
> > >       ARM: bitops: prefetch the destination word for write prior to strex
> > Hello Will,
> > 
> > it seems the last patch breaks on efm32:
> > 
> > arch/arm/lib/changebit.S: Assembler messages:
> > arch/arm/lib/changebit.S:15: Error: architectural extension `mp' is not allowed for the current base architecture
> 
> I see gas is being as helpful as ever. Something like the (untested) patch
> below should fix the issue.
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
> index e0c68d5bb7dc..52886b89706c 100644
> --- a/arch/arm/lib/bitops.h
> +++ b/arch/arm/lib/bitops.h
> @@ -10,7 +10,7 @@ UNWIND(       .fnstart        )
>         and     r3, r0, #31             @ Get bit offset
>         mov     r0, r0, lsr #5
>         add     r1, r1, r0, lsl #2      @ Get word offset
> -#if __LINUX_ARM_ARCH__ >= 7
> +#if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
>         .arch_extension mp
>         ALT_SMP(W(pldw) [r1])
>         ALT_UP(W(nop))
> 
It does fix compilation and I booted successfully on my efm32-tree +
next-20131119 + this patch + the patch for the be signal stuff.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

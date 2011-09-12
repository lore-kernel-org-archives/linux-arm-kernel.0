From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 12 Sep 2011 11:33:13 +0100
Subject: [RFC PATCH 5/5] ARM: entry: Fix Thumb-2 undef handling for
	multi-CPU kernels
In-Reply-To: <201109011652.12711.arnd@arndb.de>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
	<1312971223-28165-6-git-send-email-dave.martin@linaro.org>
	<201109011652.12711.arnd@arndb.de>
Message-ID: <20110912103313.GA2020@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2011 at 04:52:12PM +0200, Arnd Bergmann wrote:
> On Wednesday 10 August 2011, Dave Martin wrote:
> > When v6 and >=v7 boards are supported in the same kernel, the
> > __und_usr code currently makes a build-time assumption that Thumb-2
> > instructions occurring in userspace don't need to be supported.
> > Strictly speaking this is incorrect.
> > 
> > This patch fixes the above case by doing a run-time check on the
> > CPU architecture in these cases.  This only affects kernels which
> > support v6 and >=v7 CPUs together: plain v6 and plain v7 kernels
> > are unaffected.
> 
> I think this patch broke random configurations (!THUMB2 && v7) for me:
> 
> > @@ -439,7 +440,27 @@ __und_usr:
> >  #endif
> >  	beq	call_fpe
> >  	@ Thumb instruction
> > -#if __LINUX_ARM_ARCH__ >= 7
> > +#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7
> > +/*
> > + * Thumb-2 instruction handling.  Note that because pre-v6 and >= v6 platforms
> > + * can never be supported in a single kernel, this code is not applicable at
> > + * all when __LINUX_ARM_ARCH__ < 6.  This allows simplifying assumptions to be
> > + * made about .arch directives.
> > + */
> > +#if __LINUX_ARM_ARCH__ < 7
> > +/* If the target CPU may not be Thumb-2-capable, a run-time check is needed: */
> > +#define NEED_CPU_ARCHITECTURE
> > +	ldr	r5, .LCcpu_architecture
> > +	ldr	r5, [r5]
> > +	cmp	r5, #CPU_ARCH_ARMv7
> > +	blo	__und_usr_unknown
> > +/*
> > + * The following code won't get run unless the running CPU really is v7, so
> > + * coding round the lack of ldrht on older arches is pointless.  Temporarily
> > + * override the assembler target arch with the minimum required instead:
> > + */
> > +	.arch	armv6t2
> > +#endif
> >  2:
> >   ARM(	ldrht	r5, [r4], #2	)
> 
> 
> This fixes it, please fold into the patch or apply on top.
> 
> 	Arnd
> 
> 8<---
> ARM: entry: refix Fix Thumb-2 undef handling for multi-CPU kernels
> 
> In some configurations labels become obsolete, so don't generate fixups for them.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 9ad50c4..b145f16 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -497,7 +497,7 @@ ENDPROC(__und_usr)
>  	.popsection
>  	.pushsection __ex_table,"a"
>  	.long	1b, 4b
> -#if __LINUX_ARM_ARCH__ >= 7
> +#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7
>  	.long	2b, 4b
>  	.long	3b, 4b
>  #endif

Arnd, do you want to go ahead and send this patch to Russell's patch
system?

Feel free to add my Reviewed-by.

Cheers
---Dave

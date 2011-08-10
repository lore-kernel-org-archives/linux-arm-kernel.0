From: tixy@yxit.co.uk (Tixy)
Date: Wed, 10 Aug 2011 12:55:52 +0100
Subject: [RFC PATCH 5/5] ARM: entry: Fix Thumb-2 undef handling for
	multi-CPU kernels
In-Reply-To: <1312971223-28165-6-git-send-email-dave.martin@linaro.org>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
	<1312971223-28165-6-git-send-email-dave.martin@linaro.org>
Message-ID: <1312977352.7800.43.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-10 at 11:13 +0100, Dave Martin wrote:
> +#if __LINUX_ARM_ARCH__ < 7
> +/* If the target CPU may not be Thumb-2-capable, a run-time check is needed: */
> +#define NEED_CPU_ARCHITECTURE
> +	ldr	r5, .LCcpu_architecture
> +	ldr	r5, [r5]
> +	cmp	r5, #CPU_ARCH_ARMv7
> +	blo	__und_usr_unknown
> +/*
> + * The following code won't get run unless the running CPU really is v7, so
> + * coding round the lack of ldrht on older arches is pointless.  Temporarily
> + * override the assembler target arch with the minimum required instead:
> + */
> +	.arch	armv6t2
> +#endif
>  2:
>   ARM(	ldrht	r5, [r4], #2	)
>   THUMB(	ldrht	r5, [r4]	)
> @@ -449,7 +470,16 @@ __und_usr:
>  3:	ldrht	r0, [r4]
>  	add	r2, r2, #2			@ r2 is PC + 2, make it PC + 4
>  	orr	r0, r0, r5, lsl #16
> +
> +#if __LINUX_ARM_ARCH__ < 7
> +/* If the target arch was overridden, change it back: */
> +#ifdef CONFIG_CPU_32v6K
> +	.arch	armv6k
>  #else
> +	.arch	armv6
> +#endif

Are we confident that there will be no other v6 architectures supported
in future? Looks like a bit of a hazard otherwise.

Looking at the assembler manual, MIPS and PowerPC have push/pop
operations for changing things like arch settings, pity ARM doesn't.

-- 
Tixy

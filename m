From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Dec 2017 13:55:30 +0000
Subject: [PATCH v2 16/18] arm64: entry: Add fake CPU feature for
 unmapping the kernel at EL0
In-Reply-To: <1512059986-21325-17-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-17-git-send-email-will.deacon@arm.com>
Message-ID: <20171201135530.cthh2fsh5msqwrzc@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 04:39:44PM +0000, Will Deacon wrote:
> -#ifndef CONFIG_UNMAP_KERNEL_AT_EL0
> -	eret
> -#else
>  	.if	\el == 0
> +alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0

Since we patch this eret ...

> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +alternative_if ARM64_UNMAP_KERNEL_AT_EL0
>  	bne	4f
>  	msr	far_el1, x30
>  	tramp_alias	x30, tramp_exit_native
> @@ -334,10 +336,11 @@ alternative_else_nop_endif
>  4:
>  	tramp_alias	x30, tramp_exit_compat
>  	br	x30
> +alternative_else_nop_endif
> +#endif

... we don't need the alternative here. This code won't be executed when
not needed, and the alternative just bloats the kernel.

We can/should keep the ifdef, though.

Thanks,
Mark.

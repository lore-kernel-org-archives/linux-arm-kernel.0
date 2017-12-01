From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Dec 2017 13:53:01 +0000
Subject: [PATCH v2 13/18] arm64: entry: Hook up entry trampoline to
 exception vectors
In-Reply-To: <1512059986-21325-14-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-14-git-send-email-will.deacon@arm.com>
Message-ID: <20171201135300.novwsr5yxveeeq7m@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 04:39:41PM +0000, Will Deacon wrote:
>  	.macro kernel_ventry, el, label, regsize = 64
>  	.align 7
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +	.if	\el == 0
> +	.if	\regsize == 64
> +	mrs	x30, tpidrro_el0
> +	msr	tpidrro_el0, xzr
> +	.else
> +	mov	x30, xzr

I guess that's just to prevent acccidental leaks if we dump registers
somewhere, since we used x30 as a scratch register?

> +	.macro tramp_alias, dst, sym
> +	mov_q	\dst, TRAMP_VALIAS
> +	add	\dst, \dst, #(\sym - .entry.tramp.text)
> +	.endm

I didn't realise you could refer to sections like this; neat!

Otherwise, looks fine to me.

Thanks,
Mark.

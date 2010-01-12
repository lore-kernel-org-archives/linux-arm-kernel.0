From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jan 2010 18:09:36 +0000
Subject: [PATCH] Fix wrong dmb
In-Reply-To: <20100112170206.GA5633@n2100.arm.linux.org.uk>
References: <20100112170206.GA5633@n2100.arm.linux.org.uk>
Message-ID: <1263319776.29654.118.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-12 at 17:02 +0000, Russell King - ARM Linux wrote:
> The __kuser_cmpxchg code uses an ARMv6 dmb instruction, rather than
> one based upon the architecture being built for.  Switch to using
> the macro provided for this purpose, which also eliminates the
> need for an ifdef.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> diff --git a/arch/arm/kernel/entry-armv.S
> b/arch/arm/kernel/entry-armv.S
> index d2903e3..6c5cf36 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -957,9 +957,7 @@ kuser_cmpxchg_fixup:
> 
>  #else
> 
> -#ifdef CONFIG_SMP
> -       mcr     p15, 0, r0, c7, c10, 5  @ dmb
> -#endif
> +       smp_dmb
>  1:     ldrex   r3, [r2]
>         subs    r3, r3, r0
>         strexeq r3, r1, [r2]

Looks fine as well.

-- 
Catalin

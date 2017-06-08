From: sstabellini@kernel.org (Stefano Stabellini)
Date: Thu, 8 Jun 2017 11:12:02 -0700 (PDT)
Subject: [PATCH v2] xen: avoid type warning in xchg_xen_ulong
In-Reply-To: <20170608085323.2209174-1-arnd@arndb.de>
References: <20170608085323.2209174-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.10.1706081110190.26108@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Jun 2017, Arnd Bergmann wrote:
> The improved type-checking version of container_of() triggers a warning for
> xchg_xen_ulong, pointing out that 'xen_ulong_t' is unsigned, but atomic64_t
> contains a signed value:
> 
> drivers/xen/events/events_2l.c: In function 'evtchn_2l_handle_events':
> drivers/xen/events/events_2l.c:187:1020: error: call to '__compiletime_assert_187' declared with attribute error: pointer type mismatch in container_of()
> 
> This adds a cast to work around the warning.
> 
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Fixes: 85323a991d40 ("xen: arm: mandate EABI and use generic atomic operations.")
> Fixes: daa2ac80834d ("kernel.h: handle pointers to arrays better in container_of()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

I'll queue it up on xentip for Linux 4.13.


> ---
> v2: found the correct warning message and updated the changelog
> ---
>  arch/arm/include/asm/xen/events.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
> index 71e473d05fcc..620dc75362e5 100644
> --- a/arch/arm/include/asm/xen/events.h
> +++ b/arch/arm/include/asm/xen/events.h
> @@ -16,7 +16,7 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
>  	return raw_irqs_disabled_flags(regs->ARM_cpsr);
>  }
>  
> -#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
> +#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((long long*)(ptr),\
>  							    atomic64_t,	\
>  							    counter), (val))
>  
> -- 
> 2.9.0
> 

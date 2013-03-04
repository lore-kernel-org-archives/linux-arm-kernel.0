From: robherring2@gmail.com (Rob Herring)
Date: Sun, 03 Mar 2013 20:45:33 -0600
Subject: [PATCH LINUX v5] xen: event channel arrays are xen_ulong_t and
 not unsigned long
In-Reply-To: <1361360886-2956-1-git-send-email-ian.campbell@citrix.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361360886-2956-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <51340ACD.70904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2013 05:48 AM, Ian Campbell wrote:
> On ARM we want these to be the same size on 32- and 64-bit.
> 
> This is an ABI change on ARM. X86 does not change.
> 
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> Cc: Jan Beulich <JBeulich@suse.com>
> Cc: Keir (Xen.org) <keir@xen.org>
> Cc: Tim Deegan <tim@xen.org>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: xen-devel at lists.xen.org
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
> Changes since V4
>   Rebase onto v3.8
>   Fix wording of comment
>   Fix bitmask length passed to find_first_bit, need sizeof*8 for bits not just
>   sizeof. Use BITS_PER_EVTCHN_WORD and provide a convenience wrapper.
> Changes since V3
>   s/read_evtchn_pending_sel/xchg_xen_ulong/ in a comment.
> Changes since V2
>   Add comments about the correct bitops to use, and on the ordering/barrier
>   requirements on xchg_xen_ulong.
> Changes since V1
>   use find_first_set not __ffs
>   fix some more unsigned long -> xen_ulong_t
>   use more generic xchg_xen_ulong instead of ...read_evtchn...
> ---
>  arch/arm/include/asm/xen/events.h |   22 +++++++
>  arch/x86/include/asm/xen/events.h |    3 +
>  drivers/xen/events.c              |  115 +++++++++++++++++++++---------------
>  include/xen/interface/xen.h       |    8 +-
>  4 files changed, 96 insertions(+), 52 deletions(-)
> 

I'm seeing some some build failures on randconfig builds with this change:

/tmp/ccJaIZOW.s: Assembler messages:
/tmp/ccJaIZOW.s:831: Error: even register required -- `ldrexd r5,r6,[r4]'

This is with ubuntu 12.04 cross compiler (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5)).

This register restriction is on ARM, but not Thumb builds. Comparing
this to atomic64_cmpxchg, I don't see how to fix this. Perhaps Will or
Nico have thoughts.

> diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
> index 94b4e90..5c27696 100644
> --- a/arch/arm/include/asm/xen/events.h
> +++ b/arch/arm/include/asm/xen/events.h
> @@ -15,4 +15,26 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
>  	return raw_irqs_disabled_flags(regs->ARM_cpsr);
>  }
>  
> +/*
> + * We cannot use xchg because it does not support 8-byte
> + * values. However it is safe to use {ldr,dtd}exd directly because all
> + * platforms which Xen can run on support those instructions.

Why does atomic64_cmpxchg not work here?

> + */
> +static inline xen_ulong_t xchg_xen_ulong(xen_ulong_t *ptr, xen_ulong_t val)
> +{
> +	xen_ulong_t oldval;
> +	unsigned int tmp;
> +
> +	wmb();

Based on atomic64_cmpxchg implementation, you could use smp_mb here
which avoids an outer cache flush.

> +	asm volatile("@ xchg_xen_ulong\n"
> +		"1:     ldrexd  %0, %H0, [%3]\n"
> +		"       strexd  %1, %2, %H2, [%3]\n"
> +		"       teq     %1, #0\n"
> +		"       bne     1b"
> +		: "=&r" (oldval), "=&r" (tmp)
> +		: "r" (val), "r" (ptr)
> +		: "memory", "cc");

And a smp_mb is needed here.

Rob

> +	return oldval;
> +}

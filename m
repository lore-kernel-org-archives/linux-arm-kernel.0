From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 4 Jun 2013 10:24:26 +0100
Subject: [PATCH v2 2/5] arm64/xen: introduce asm/xen header files on arm64
In-Reply-To: <1370273624-26976-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1306031157020.4589@kaball.uk.xensource.com>
 <1370273624-26976-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1370337866.24512.90.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-06-03 at 16:33 +0100, Stefano Stabellini wrote:
> asm/xen/hypercall.h, asm/xen/hypervisor.h, asm/xen/interface.h and
> asm/xen/page.h are indentical so to avoid code duplication we are just

"identical"

> including the original arm header files here.
> 
> asm/xen/events.h is slightly different, so introduce a different file
> here (use xchg to implement xchg_xen_ulong and pass regs->pstate to
> raw_irqs_disabled_flags).
> 
> Also introduce asm/hypervisor.h and asm/sync_bitops.h.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>

[...]
> +/* sync_bitops functions are equivalent to the SMP implementation of the
> + * original functions, independently from CONFIG_SMP being defined.
> + *
> + * We need them because _set_bit etc are not SMP safe if !CONFIG_SMP. But
> + * under Xen you might be communicating with a completely external entity
> + * who might be on another CPU (e.g. two uniprocessor guests communicating
> + * via event channels and grant tables). So we need a variant of the bit
> + * ops which are SMP safe even on a UP kernel.
> + */
> +
> +#define sync_set_bit(nr, p)            set_bit(nr, p)

Oh, arm64 seems to have optimised bitops now, which means I can ditch
the skanky versions in Xen in favour of these. Nice.

Ian.

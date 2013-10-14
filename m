From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Oct 2013 16:32:23 +0200
Subject: [PATCH v3 06/14] ARM: mvebu: Low level functions to disable
 cache snooping
In-Reply-To: <1381759106-15004-7-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
 <1381759106-15004-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20131014163223.14dba62b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:18 +0200, Gregory CLEMENT wrote:
> When going to deep idle we need to disable the SoC snooping by
> "hand". Playing with the coherency fabric requires to use assembly
> code to be sure that the compiler doesn't reorder the instructions nor
> do wrong optimization.
> 
> This function will be called by the low level (in assembly) part of
> the CPU idle functions.

So, this is this opposite of adding the CPU into the coherency fabric,
as is done in ll_set_cpu_coherent(), right? If that's the case, then
the function should be named to be symmetrical with
ll_set_cpu_coherent(), i.e something like ll_set_cpu_uncoherent(), or
rename the two functions to ll_coherency_fabric_register() /
ll_coherency_fabric_unregister() or something.

> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency_ll.S | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
> index 1526b94..3fb426e 100644
> --- a/arch/arm/mach-mvebu/coherency_ll.S
> +++ b/arch/arm/mach-mvebu/coherency_ll.S
> @@ -73,6 +73,28 @@ ENTRY(ll_set_cpu_coherent)
>  	mov	pc, lr
>  ENDPROC(ll_set_cpu_coherent)
>  
> +/*
> + * r0: if r0==0 => physical addres, else virtual address

addres -> address

Address of what?

> + */
> +ENTRY(armada_370_xp_disable_snoop_ena)
> +	ldr	r0, =(coherency_base)

So it takes an argument that tells whether it should use a physical or
a virtual address, but at the first instruction you overwrite r0. Seems
like the function assumes it's called with the MMU enabled, and the
comment about the argument is wrong.

> +	ldr	r0, [r0]
> +	/* Enable SnoopEna - Exclusive */

An empty new line before the comment would be useful, but honestly I
don't see the relation with the comment. The function is about
disabling the snooping (i.e removing the CPU from the coherency
fabric), but the comment says it enables snooping. Not clear.

> +	mrc	15, 0, r1, cr0, cr0, 5
> +	and	r1, r1, #15
> +	mov	r2, #(1 << 24)
> +	lsl	r2, r2, r1

Some more comment here would be useful: we're reading the current CPU
hardware ID, and creating the bitfield that we need to remove this CPU
from the coherency fabric.

> +
> +1:
> +	ldrex	r1, [r0]
> +	bic	r1, r1, r2
> +	strex	r3, r1, [r0]
> +	cmp	r3, #0
> +	bne 1b

And here we actually remove it from the coherency fabric, with a loop
needed to make sure we don't get cheated by other CPUs doing the same
thing at the same time.

> +
> +	mov pc, lr
> +ENDPROC(armada_370_xp_disable_snoop_ena)
> +
>  	.align 2
>  3:
> -	.long	coherency_phys_base - .
> +		.long	coherency_phys_base - .

This change is unrelated and unnecessary.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

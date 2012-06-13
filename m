From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Jun 2012 10:34:33 +0100
Subject: [RFC/PATCH v5 7/7] ARM: ARM11 MPCore: Make cpu_v6_set_pte_ext
 preempt safe
In-Reply-To: <1339533618-15969-8-git-send-email-gdavis@mvista.com>
References: <1318945654-548-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-8-git-send-email-gdavis@mvista.com>
Message-ID: <20120613093433.GD29492@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 09:40:18PM +0100, gdavis at mvista.com wrote:
> From: George G. Davis <gdavis@mvista.com>
> 
> If preemption and subsequent task migration occurs during calls to
> cpu_v6_set_pte_ext on ARM11 MPCore machines, global memory state
> can become inconsistent.  To prevent inconsistent memory state on
> these machines, disable interrupts in cpu_v6_set_pte_ext.
> 
> Signed-off-by: George G. Davis <gdavis@mvista.com>
> ---
>  arch/arm/mm/proc-macros.S |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 2d8ff3a..7e32603 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -168,8 +168,11 @@
>  	tstne	r1, #L_PTE_PRESENT
>  	moveq	r3, #0
>  
> +	mrs	r2, cpsr
> +	cpsid	i
>  	str	r3, [r0]
>  	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
> +	msr	cpsr_c, r2
>  	.endm

We have save_and_disable_irqs and restore_irqs (and _notrace variants)
macros in asm/assembler.h.

-- 
Catalin

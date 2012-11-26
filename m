From: robherring2@gmail.com (Rob Herring)
Date: Mon, 26 Nov 2012 15:37:19 -0600
Subject: [PATCH 4/9] ARM: GIC: remove direct use of gic_raise_softirq
In-Reply-To: <1353466713-18967-5-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
 <1353466713-18967-5-git-send-email-robherring2@gmail.com>
Message-ID: <50B3E10F.9070500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 11/20/2012 08:58 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation of moving gic code to drivers/irqchip, remove the direct
> platform dependencies on gic_raise_softirq. Move the setup of
> smp_cross_call into the gic code. All platforms are using IPI#0 for
> core wakeup, so create a common wakeup ipi function.

snip

> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index 2e3be16..7933eb1 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -79,6 +79,7 @@ extern void cpu_die(void);
>  
>  extern void arch_send_call_function_single_ipi(int cpu);
>  extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
> +extern void arch_send_wakeup_ipi(int cpu);

I found there is already an arch_send_wakeup_ipi_mask() in your for-next
tree, so I have rebased this to use it instead. Is your for-next branch
stable for 3.8 and if not can you make commit b62655f4c6f3e4d21934e
(ARM: 7571/1: SMP: add function arch_send_wakeup_ipi_mask()) available
in a stable branch.

Rob

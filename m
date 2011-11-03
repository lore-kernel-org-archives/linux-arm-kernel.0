From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 Nov 2011 12:35:18 +0800
Subject: [PATCH 2/2] ARM: mcx: fix local timer interrupt handling
In-Reply-To: <1320255049-12447-3-git-send-email-marc.zyngier@arm.com>
References: <1320255049-12447-1-git-send-email-marc.zyngier@arm.com>
	<1320255049-12447-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAAQ0ZWQQs_2HWAYz-Y+zUiS=+X0dcGiY9E1ZabsrwA4Djs4U=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 November 2011 01:30, Marc Zyngier <marc.zyngier@arm.com> wrote:
> As local timer interrupts are now handled as normal interrupts,
> remove the special case in the GIC handler.
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I also noticed this problem and had a patch fixing it.  But due to the
tight Linaro Connect agenda, I have not got the chance to send it out.
 Glad to see this patch fixing the problem.

Acked-and-tested-by: Shawn Guo <shawn.guo@linaro.org>

> ---
> ?arch/arm/plat-mxc/gic.c | ? 11 ++---------
> ?1 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/gic.c b/arch/arm/plat-mxc/gic.c
> index b3b8eed..12f8f81 100644
> --- a/arch/arm/plat-mxc/gic.c
> +++ b/arch/arm/plat-mxc/gic.c
> @@ -28,21 +28,14 @@ asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
> ? ? ? ? ? ? ? ?if (irqnr == 1023)
> ? ? ? ? ? ? ? ? ? ? ? ?break;
>
> - ? ? ? ? ? ? ? if (irqnr > 29 && irqnr < 1021)
> + ? ? ? ? ? ? ? if (irqnr > 15 && irqnr < 1021)
> ? ? ? ? ? ? ? ? ? ? ? ?handle_IRQ(irqnr, regs);
> ?#ifdef CONFIG_SMP
> - ? ? ? ? ? ? ? else if (irqnr < 16) {
> + ? ? ? ? ? ? ? else {
> ? ? ? ? ? ? ? ? ? ? ? ?writel_relaxed(irqstat, gic_cpu_base_addr +
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?GIC_CPU_EOI);
> ? ? ? ? ? ? ? ? ? ? ? ?handle_IPI(irqnr, regs);
> ? ? ? ? ? ? ? ?}
> ?#endif
> -#ifdef CONFIG_LOCAL_TIMERS
> - ? ? ? ? ? ? ? else if (irqnr == 29) {
> - ? ? ? ? ? ? ? ? ? ? ? writel_relaxed(irqstat, gic_cpu_base_addr +
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? GIC_CPU_EOI);
> - ? ? ? ? ? ? ? ? ? ? ? handle_local_timer(regs);
> - ? ? ? ? ? ? ? }
> -#endif
> ? ? ? ?} while (1);
> ?}
> --
> 1.7.0.4
>
>
>



-- 
Regards,
Shawn

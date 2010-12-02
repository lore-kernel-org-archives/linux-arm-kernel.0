From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 2 Dec 2010 20:50:13 +0900
Subject: [PATCH] ARM: GIC irq desciptor bug fix
In-Reply-To: <1291270659-24903-1-git-send-email-cxie4@marvell.com>
References: <1291270659-24903-1-git-send-email-cxie4@marvell.com>
Message-ID: <AANLkTinxHBSm3WVThN56fH0fePCwJ65ZWdL4g7nnFjJO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I posted the similar patch. but looks better.

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Dec 2, 2010 at 3:17 PM,  <Chao@marvell.com> wrote:
> From: cxie4 <cxie4@marvell.com>
>
> gic_set_cpu will directly use irq_desc[]. If CONFIG_SPARSE_IRQ is enabled, there is no
> irq_desc[]. So we need use irq_to_desc(irq) to get the descriptor for irq.
>
> Signed-off-by: cxie4 <cxie4@marvell.com>
> ---
> ?arch/arm/common/gic.c | ? ?8 +++++++-
> ?1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 7dfa9a8..6599acb 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -160,9 +160,15 @@ static int gic_set_cpu(unsigned int irq, const struct cpumask *mask_val)
> ? ? ? ?unsigned int shift = (irq % 4) * 8;
> ? ? ? ?unsigned int cpu = cpumask_first(mask_val);
> ? ? ? ?u32 val;
> + ? ? ? struct irq_desc *desc;
>
> ? ? ? ?spin_lock(&irq_controller_lock);
> - ? ? ? irq_desc[irq].node = cpu;
> + ? ? ? desc = irq_to_desc(irq);
> + ? ? ? if (desc == NULL) {
> + ? ? ? ? ? ? ? spin_unlock(&irq_controller_lock);
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> + ? ? ? desc->node = cpu;
> ? ? ? ?val = readl(reg) & ~(0xff << shift);
> ? ? ? ?val |= 1 << (cpu + shift);
> ? ? ? ?writel(val, reg);
> --
> 1.6.3.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

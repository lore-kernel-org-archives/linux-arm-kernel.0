From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Apr 2014 11:41:00 +0100
Subject: [PATCH v4 14/14] virt: arm: support hip04 gic
In-Reply-To: <1398668032-8335-15-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Mon, 28 Apr 2014 07:53:52 +0100")
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
 <1398668032-8335-15-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <8738gxvirn.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28 2014 at  7:53:52 am BST, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> In ARM standard GIC, GICH_APR offset is 0xf0 & GICH_LR0 offset is 0x100.
> In HiP04 GIC, GICH_APR offset is 0x70 & GICH_LR0 offset is 0x80.
> So add the support of HiP04 SoC in VGIC.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/kvm/interrupts_head.S  | 24 ++++++++++++++++++++----
>  include/linux/irqchip/arm-gic.h |  3 +++
>  virt/kvm/arm/vgic.c             | 15 ++++++++++++++-
>  3 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 76af9302..b27e43f 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -419,7 +419,9 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	ldr	r7, [r2, #GICH_EISR1]
>  	ldr	r8, [r2, #GICH_ELRSR0]
>  	ldr	r9, [r2, #GICH_ELRSR1]
> -	ldr	r10, [r2, #GICH_APR]
> +	ldr	r10, =gich_apr
> +	ldr	r10, [r10]
> +	ldr	r10, [r2, r10]

I think you slightly missed the point of my earlier review. I don't want
to see another variable containing this offset. We already have nr_lr,
and I'd like you to combine this offset into the same field. Use the
bottom bits for the number of list registers, and the top bits for the
offset. You can then use a bit manipulation instruction to extract the
information you want. Rename the field to something sensible like
hw_config.

>  
>  	str	r3, [r11, #VGIC_CPU_HCR]
>  	str	r4, [r11, #VGIC_CPU_VMCR]
> @@ -435,7 +437,11 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	str	r5, [r2, #GICH_HCR]
>  
>  	/* Save list registers */
> -	add	r2, r2, #GICH_LR0
> +	ldr	r10, =gich_apr
> +	ldr	r10, [r10]
> +	/* the offset between GICH_APR & GICH_LR0 is 0x10 */
> +	add	r10, r10, #0x10
> +	add	r2, r2, r10
>  	add	r3, r11, #VGIC_CPU_LR
>  	ldr	r4, [r11, #VGIC_CPU_NR_LR]
>  1:	ldr	r6, [r2], #4
> @@ -469,10 +475,16 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  
>  	str	r3, [r2, #GICH_HCR]
>  	str	r4, [r2, #GICH_VMCR]
> -	str	r8, [r2, #GICH_APR]
> +	ldr	r6, =gich_apr
> +	ldr	r6, [r6]
> +	str	r8, [r2, r6]
>  
>  	/* Restore list registers */
> -	add	r2, r2, #GICH_LR0
> +	ldr	r6, =gich_apr
> +	ldr	r6, [r6]
> +	/* the offset between GICH_APR & GICH_LR0 is 0x10 */
> +	add	r6, r6, #0x10
> +	add	r2, r2, r6
>  	add	r3, r11, #VGIC_CPU_LR
>  	ldr	r4, [r11, #VGIC_CPU_NR_LR]
>  1:	ldr	r6, [r3], #4
> @@ -618,3 +630,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  .macro load_vcpu
>  	mrc	p15, 4, vcpu, c13, c0, 2	@ HTPIDR
>  .endm
> +
> +	.global gich_apr
> +gich_apr:
> +	.long	GICH_APR
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index 55933aa..dd0785a 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -49,6 +49,8 @@
>  #define GICH_ELRSR1 			0x34
>  #define GICH_APR			0xf0
>  #define GICH_LR0			0x100
> +#define HIP04_GICH_APR			0x70
> +/* GICH_LR0 offset in HiP04 is 0x80 */
>  
>  #define GICH_HCR_EN			(1 << 0)
>  #define GICH_HCR_UIE			(1 << 1)
> @@ -78,6 +80,7 @@
>  struct device_node;
>  
>  extern struct irq_chip gic_arch_extn;
> +extern unsigned int gich_apr;
>  
>  void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
>  		    u32 offset, struct device_node *);
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 47b2983..6bf31db 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1470,17 +1470,30 @@ static struct notifier_block vgic_cpu_nb = {
>  	.notifier_call = vgic_cpu_notify,
>  };
>  
> +static const struct of_device_id of_vgic_ids[] = {
> +	{
> +		.compatible = "arm,cortex-a15-gic",
> +		.data = (void *)GICH_APR,
> +	}, {
> +		.compatible = "hisilicon,hip04-gic",
> +		.data = (void *)HIP04_GICH_APR,
> +	}, {
> +	},
> +};
> +
>  int kvm_vgic_hyp_init(void)
>  {
>  	int ret;
>  	struct resource vctrl_res;
>  	struct resource vcpu_res;
> +	const struct of_device_id *match;
>  
> -	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
> +	vgic_node = of_find_matching_node_and_match(NULL, of_vgic_ids, &match);
>  	if (!vgic_node) {
>  		kvm_err("error: no compatible vgic node in DT\n");
>  		return -ENODEV;
>  	}

This looks much better.

> +	gich_apr = (unsigned int)match->data;
>  
>  	vgic_maint_irq = irq_of_parse_and_map(vgic_node, 0);
>  	if (!vgic_maint_irq) {

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.

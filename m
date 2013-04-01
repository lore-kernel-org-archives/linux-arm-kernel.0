From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 01 Apr 2013 16:44:17 +0400
Subject: [PATCH 2/3 v2] ARM: shmobile: r8a7778: add
 r8a7778_init_irq_extpin()
In-Reply-To: <87d2uf56kt.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
 <87d2uf56kt.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <51598121.9010005@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-04-2013 6:27, Kuninori Morimoto wrote:

> This patch adds r8a7778_init_irq_extpin() for IRQ0 - IRQ3.
> But this patch doesn't enable DT settings on r8a7778.dts,
> because R8A7778 chip external IRQ depends on
> IRQ0 - IRQ3 pin encoding which came from platform board
> implementation.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 57d6b0e..2882305 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
[...]
> @@ -110,6 +111,49 @@ void __init r8a7778_add_standard_devices(void)
>   	r8a7778_register_tmu(1);
>   }
>
> +static struct renesas_intc_irqpin_config irqpin_platform_data = {
> +	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
> +	.sense_bitfield_width = 2,
> +};
> +
> +static struct resource irqpin_resources[] = {
> +	DEFINE_RES_MEM(0xfe78001c, 4), /* ICR1 */
> +	DEFINE_RES_MEM(0xfe780010, 4), /* INTPRI */
> +	DEFINE_RES_MEM(0xfe780024, 4), /* INTREQ */
> +	DEFINE_RES_MEM(0xfe780044, 4), /* INTMSK0 */
> +	DEFINE_RES_MEM(0xfe780064, 4), /* INTMSKCLR0 */

    Hm, why this can't be passed as a single large memory resource?

> +	DEFINE_RES_IRQ(gic_iid(0x3b)), /* IRQ0 */
> +	DEFINE_RES_IRQ(gic_iid(0x3c)), /* IRQ1 */
> +	DEFINE_RES_IRQ(gic_iid(0x3d)), /* IRQ2 */
> +	DEFINE_RES_IRQ(gic_iid(0x3e)), /* IRQ3 */
> +};
> +
> +void __init r8a7778_init_irq_extpin(int irlm)
> +{
> +	void __iomem *icr0 = ioremap_nocache(0xfe780000, PAGE_SIZE);

    4 bytes seems enough.

> +	unsigned long tmp;
> +
> +	if (!icr0) {
> +		pr_warn("r8a7778: unable to setup external irq pin mode\n");
> +		return;
> +	}
> +
> +	tmp = ioread32(icr0);
> +	if (irlm)
> +		tmp |= 1 << 23; /* IRQ0 -> IRQ3 as individual pins */
> +	else
> +		tmp &= ~(1 << 23); /* IRL mode - not supported */
> +	tmp |= (1 << 21); /* LVLMODE = 1 */

    () not needed here.

WBR, Sergei

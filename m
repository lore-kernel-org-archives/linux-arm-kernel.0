From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Aug 2011 10:00:35 -0500
Subject: [PATCH 2/3] ARM: GIC: add gic_reinit() function to help ARM resume
In-Reply-To: <1314690017-17590-3-git-send-email-shawn.guo@linaro.org>
References: <1314690017-17590-1-git-send-email-shawn.guo@linaro.org>
	<1314690017-17590-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <4E5CFB13.8060008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On 08/30/2011 02:40 AM, Shawn Guo wrote:
> If ARM core gets powered off during suspend, GIC controller has to be
> reinitialized by resume procedure.  This patch adds a helper function
> for resume procedure to reinitialize GIC.

Is re-initializing rather than save/restore registers the right thing to
do here? Won't you lose things like edge or level triggered settings?
It's always been fuzzy to what should be done with interrupt masks in
suspend. Is every driver expected to disable and re-enable their
interrupts or this should be maintained thru a suspend cycle?

> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/common/gic.c               |   15 +++++++++++++--
>  arch/arm/include/asm/hardware/gic.h |    1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 666b278..bf0f6d8 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -255,7 +255,7 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>  	irq_set_chained_handler(irq, gic_handle_cascade_irq);
>  }
>  
> -static void __init gic_dist_init(struct gic_chip_data *gic,
> +static void gic_dist_init(struct gic_chip_data *gic,
>  	unsigned int irq_start)
>  {
>  	unsigned int gic_irqs, irq_limit, i;
> @@ -326,7 +326,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
>  	writel_relaxed(1, base + GIC_DIST_CTRL);
>  }
>  
> -static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
> +static void gic_cpu_init(struct gic_chip_data *gic)

I don't think you need to change this. With hotplug, this section will
be kept.

Rob

>  {
>  	void __iomem *dist_base = gic->dist_base;
>  	void __iomem *base = gic->cpu_base;
> @@ -349,6 +349,17 @@ static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
>  	writel_relaxed(1, base + GIC_CPU_CTRL);
>  }
>  
> +void gic_reinit(unsigned int gic_nr, unsigned int irq_start)
> +{
> +	struct gic_chip_data *gic;
> +
> +	BUG_ON(gic_nr >= MAX_GIC_NR);
> +
> +	gic = &gic_data[gic_nr];
> +	gic_dist_init(gic, irq_start);
> +	gic_cpu_init(gic);
> +}
> +
>  void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
>  	void __iomem *dist_base, void __iomem *cpu_base)
>  {
> diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
> index 435d3f8..9338326 100644
> --- a/arch/arm/include/asm/hardware/gic.h
> +++ b/arch/arm/include/asm/hardware/gic.h
> @@ -37,6 +37,7 @@ extern void __iomem *gic_cpu_base_addr;
>  extern struct irq_chip gic_arch_extn;
>  
>  void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
> +void gic_reinit(unsigned int gic_nr, unsigned int irq_start);
>  void gic_secondary_init(unsigned int);
>  void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
>  void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);

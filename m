From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Sep 2015 17:26:00 +0100
Subject: [PATCH v4 4/5] irqchip, gicv3-its: Add HW revision detection
 and configuration
In-Reply-To: <1439576885-15621-5-git-send-email-rric@kernel.org>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-5-git-send-email-rric@kernel.org>
Message-ID: <55EDBA98.3020903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 14/08/15 19:28, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> Some GIC revisions require an individual configuration to esp. add
> workarounds for HW bugs. This patch implements generic code to parse
> the hw revision provided by an IIDR register value and runs specific
> code if hw matches. There are functions that read the IIDR registers
> for GICV3 and ITS (GICD_IIDR/GITS_IIDR) and then go through a list of
> init functions to be called for specific versions.
> 
> A MIDR register value may also be used, this is especially useful for
> hw detection from a guest.

I don't think this sentence is relevant anymore.

> 
> The patch is needed to implement workarounds for HW errata in Cavium's
> ThunderX GICV3.
> 
> v4:
>  * only enable hw detection for its in its_enable_quirks()
>  * removed gicv3_check_capabilities()
> 
> v3:
>  * use arm64 errata framework for midr check
> 
> v2:
>  * adding MIDR check
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-common.c | 11 +++++++++++
>  drivers/irqchip/irq-gic-common.h |  9 +++++++++
>  drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
> index 9448e391cb71..ee789b07f2d1 100644
> --- a/drivers/irqchip/irq-gic-common.c
> +++ b/drivers/irqchip/irq-gic-common.c
> @@ -21,6 +21,17 @@
>  
>  #include "irq-gic-common.h"
>  
> +void gic_check_capabilities(u32 iidr, const struct gic_capabilities *cap,
> +			void *data)

Let's call a duck a duck, and replace all occurrences of
capabilit{y,ies} with "quirk".

> +{
> +	for (; cap->desc; cap++) {
> +		if (cap->iidr != (cap->mask & iidr))
> +			continue;
> +		cap->init(data);
> +		pr_info("%s\n", cap->desc);
> +	}
> +}
> +
>  int gic_configure_irq(unsigned int irq, unsigned int type,
>  		       void __iomem *base, void (*sync_access)(void))
>  {
> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> index 35a9884778bd..ca12635bbe3c 100644
> --- a/drivers/irqchip/irq-gic-common.h
> +++ b/drivers/irqchip/irq-gic-common.h
> @@ -20,10 +20,19 @@
>  #include <linux/of.h>
>  #include <linux/irqdomain.h>
>  
> +struct gic_capabilities {
> +	const char *desc;
> +	void (*init)(void *data);
> +	u32 iidr;
> +	u32 mask;
> +};
> +
>  int gic_configure_irq(unsigned int irq, unsigned int type,
>                         void __iomem *base, void (*sync_access)(void));
>  void gic_dist_config(void __iomem *base, int gic_irqs,
>  		     void (*sync_access)(void));
>  void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
> +void gic_check_capabilities(u32 iidr, const struct gic_capabilities *cap,
> +			void *data);
>  
>  #endif /* _IRQ_GIC_COMMON_H */
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 06131db7a198..697421e834ee 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -36,6 +36,7 @@
>  #include <asm/cputype.h>
>  #include <asm/exception.h>
>  
> +#include "irq-gic-common.h"
>  #include "irqchip.h"
>  
>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1 << 0)
> @@ -1390,6 +1391,18 @@ static int its_force_quiescent(void __iomem *base)
>  	}
>  }
>  
> +static const struct gic_capabilities its_errata[] = {
> +	{
> +	}
> +};
> +
> +static void its_enable_quirks(struct its_node *its)
> +{
> +	u32 iidr = readl_relaxed(its->base + GITS_IIDR);
> +
> +	gic_check_capabilities(iidr, its_errata, its);
> +}
> +
>  static int its_probe(struct device_node *node, struct irq_domain *parent)
>  {
>  	struct resource res;
> @@ -1448,6 +1461,8 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
>  	}
>  	its->cmd_write = its->cmd_base;
>  
> +	its_enable_quirks(its);
> +
>  	err = its_alloc_tables(its);
>  	if (err)
>  		goto out_free_cmd;
> 

Otherwise looks good to me.

	M.
-- 
Jazz is not dead. It just smells funny...

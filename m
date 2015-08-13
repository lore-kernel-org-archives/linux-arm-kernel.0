From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Aug 2015 16:06:42 +0100
Subject: [PATCH v2 2/5] irqchip, gicv3: Add HW revision detection and
 configuration
In-Reply-To: <1439477277-6157-3-git-send-email-rric@kernel.org>
References: <1439477277-6157-1-git-send-email-rric@kernel.org>
 <1439477277-6157-3-git-send-email-rric@kernel.org>
Message-ID: <55CCB282.8070405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/08/15 15:47, Robert Richter wrote:
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
> 
> The patch is needed to implement workarounds for HW errata in Cavium's
> ThunderX GICV3.
> 
> V2:
>  * adding MIDR check
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-common.c | 13 +++++++++++++
>  drivers/irqchip/irq-gic-common.h | 11 +++++++++++
>  drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++++++++
>  drivers/irqchip/irq-gic-v3.c     | 14 ++++++++++++++
>  4 files changed, 53 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
> index 9448e391cb71..886c09e645bf 100644
> --- a/drivers/irqchip/irq-gic-common.c
> +++ b/drivers/irqchip/irq-gic-common.c
> @@ -21,6 +21,19 @@
>  
>  #include "irq-gic-common.h"
>  
> +void gic_check_capabilities(u32 iidr, const struct gic_capabilities *cap,
> +			void *data)
> +{
> +	for (; cap->desc; cap++) {
> +		if (cap->midr != (cap->midr_mask & read_cpuid_id()))
> +			continue;
> +		if (cap->iidr != (cap->iidr_mask & iidr))
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
> index 35a9884778bd..e9a3e2800005 100644
> --- a/drivers/irqchip/irq-gic-common.h
> +++ b/drivers/irqchip/irq-gic-common.h
> @@ -20,10 +20,21 @@
>  #include <linux/of.h>
>  #include <linux/irqdomain.h>
>  
> +struct gic_capabilities {
> +	const char *desc;
> +	void (*init)(void *data);
> +	u32 iidr;
> +	u32 iidr_mask;
> +	u32 midr;
> +	u32 midr_mask;
> +};

Sorry to ask the obvious, but why should we implement another MIDR check
that is private to the GIC driver, while we already have an
infrastructure that deals with that kind of things?

Also, the GIC CPU interface is very much part of the CPU, not part the
GIC itself. I'd rather see a CPU erratum being handler at the same
location as all the other errata.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

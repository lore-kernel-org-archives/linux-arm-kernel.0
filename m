From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 15 Sep 2011 13:25:52 +0530
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <1316017900-19918-6-git-send-email-robherring2@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
Message-ID: <CAJuYYwSFu2HC+u2NY41+yw9tEyy85RKa4Dpm3SL+jbwS_OOA0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 14 September 2011 22:01, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> This adds gic initialization using device tree data. The initialization
> functions are intended to be called by a generic OF interrupt
> controller parsing function once the right pieces are in place.
>
> PPIs are handled using 3rd cell of interrupts properties to specify the cpu
> mask the PPI is assigned to.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> ?Documentation/devicetree/bindings/arm/gic.txt | ? 53 ++++++++++++++++++++++++
> ?arch/arm/common/gic.c ? ? ? ? ? ? ? ? ? ? ? ? | ? 55 +++++++++++++++++++++++--
> ?arch/arm/include/asm/hardware/gic.h ? ? ? ? ? | ? 10 +++++
> ?3 files changed, 114 insertions(+), 4 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

[...]


> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index d1ccc72..14de380 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c

[...]

> +void __init gic_of_init(struct device_node *node, struct device_node *parent)
> +{
> + ? ? ? void __iomem *cpu_base;
> + ? ? ? void __iomem *dist_base;
> + ? ? ? int irq;
> + ? ? ? struct irq_domain *domain = &gic_data[gic_cnt].domain;
> +
> + ? ? ? if (WARN_ON(!node))
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? dist_base = of_iomap(node, 0);
> + ? ? ? WARN(!dist_base, "unable to map gic dist registers\n");
> +
> + ? ? ? cpu_base = of_iomap(node, 1);
> + ? ? ? WARN(!cpu_base, "unable to map gic cpu registers\n");
> +
> + ? ? ? domain->nr_irq = gic_irq_count(dist_base);
> + ? ? ? domain->irq_base = irq_alloc_descs(-1, 0, domain->nr_irq, numa_node_id());

For exynos4, all the interrupts originating from GIC are statically
mapped to start from 32 in the linux virq space (GIC SPI interrupts
start from 64). In the above code, since irq_base would be 0 for
exynos4, the interrupt mapping is not working correctly. In your
previous version of the patch, you have given a option to the platform
code to choose the offset. Could that option be added to this series
also. Or a provision to use platform specific translate function
instead of the irq_domain_simple translator.

Thanks,
Thomas.

[...]

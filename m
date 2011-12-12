From: robherring2@gmail.com (Rob Herring)
Date: Sun, 11 Dec 2011 21:42:22 -0600
Subject: [RESEND][PATCH] ARM: Exynos: Add irq domain and device tree
 support for interrupt combiner
In-Reply-To: <1323586114-24486-1-git-send-email-thomas.abraham@linaro.org>
References: <1323586114-24486-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4EE5781E.2060702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2011 12:48 AM, Thomas Abraham wrote:
> A common irq domain for the interrupts managed by the interrupt combiners is
> setup. All the instances of irq combiner reference the common irq domain for
> translating hardware interrupts to linux irq number.
> 
> In case of device tree based boot, a interrupt specifier translator is setup
> that can translate interrupt specifiers for device nodes which use combiner
> as their interrupt parent.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> Please ignore the previous post patch since that patch has a compilation error
> when CONFIG_OF was not defined.
> 
> This patch is based on the following tree.
> http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next
> 
>  .../bindings/arm/samsung/interrupt-combiner.txt    |   27 +++++++++
>  arch/arm/mach-exynos/cpu.c                         |   29 ++++++---
>  arch/arm/mach-exynos/irq-combiner.c                |   62 +++++++++++++++++---
>  3 files changed, 100 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt b/Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt
> new file mode 100644
> index 0000000..6c960dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt
> @@ -0,0 +1,27 @@
> +* Samsung Exynos Interrupt Combiner Controller
> +
> +Samsung's Exynos4 architecture includes a interrupt combiner which can combine
> +interrupt sources as a group and provide a single interrupt request for the
> +group. The interrupt request from each group are connected to a parent interrupt
> +controller, such as GIC in case of Exynos4210.
> +
> +Required properties:
> +- compatible: should be "samsung,exynos4210-combiner".
> +- #interrupt-cells: should be <2>. The meaning of the cells are
> +	* First Cell: Combiner Group Number.
> +	* Second Cell: Interrupt number within the group.
> +- reg: Base address and size of interrupt combiner registers.
> +- interrupt-controller: Identifies the node as an interrupt controller.
> +
> +Optional properties:
> +- interrupt-parent: pHandle of the parent interrupt controller, if not
> +  inherited from the parent node.
> +
> +Example:
> +
> +	combiner:interrupt-controller at 10440000 {
> +		compatible = "samsung,exynos4120-combiner";
> +		#interrupt-cells = <2>;
> +		interrupt-controoler;

s/controoler/controller/

> +		reg = <0x10440000 0x1000>;
> +	};

[snip]

> +
> +int __init combiner_init_irq_domain(unsigned int irq_base, unsigned int nr_irq,

Make irq_base signed.

> +					struct device_node *np)
> +{
> +	struct irq_domain *domain = &combiner_irq_domain;
> +
> +	domain->irq_base = irq_alloc_descs(irq_base, irq_base, nr_irq, 0);

This should be irq_alloc_descs(irq_base, 1,

So that dynamic allocation can work when irq_base is -1.

> +	if (domain->irq_base < 0) {
> +		pr_err("failed to alloc irq descs, combiner init failed\n");
> +		return -EBUSY;

On failure, just warn and do:

domain->irq_base = irq_base

instead of returning unless all platforms using this are completely
converted over to support dynamic Linux virq mapping.

Also you should update your platforms' to set mdesc.nr_irq to
NR_IRQS_LEGACY. And test with SPARSE_IRQ turned on.

Rob

> +	}
> +	domain->nr_irq = nr_irq;
> +	domain->ops = &combiner_irq_domain_ops;
> +	domain->of_node = np;
> +	irq_domain_add(domain);
> +	return 0;
> +}

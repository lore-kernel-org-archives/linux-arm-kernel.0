From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 25 May 2012 19:05:18 -0600
Subject: [PATCH v3 1/7] ARM: davinci,
 intc: Add OF support for TI interrupt controller
In-Reply-To: <1330945804-3379-2-git-send-email-hs@denx.de>
References: <1330945804-3379-1-git-send-email-hs@denx.de>
 <1330945804-3379-2-git-send-email-hs@denx.de>
Message-ID: <20120526010518.C82F03E2164@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Mar 2012 12:09:58 +0100, Heiko Schocher <hs@denx.de> wrote:
> Add a function to initialize the Common Platform Interrupt Controller
> (cp_intc) from TI used on OMAP-L1x SoCs using a device tree node.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>
> 
> ---
> - changes for v2:
> - add comment from Grant Likely:
>   - migrate the whole interrupt controller to natively use an
>     irq_domain. Rebased complete patchserie to:
>     git://git.secretlab.ca/git/linux-2.6.git irqdomain/next
> 
>     commit 3a806bfcde2cc3e4853f2807b2e3c94e7ccaf450
>     Author: Grant Likely <grant.likely@secretlab.ca>
>     Date:   Fri Jan 27 06:44:34 2012 -0700
> 
>     irq_domain: mostly eliminate slow-path revmap lookups
> - changes for v3:
>   - add comments from Sergei Shtylyov:
>     - rename compatible" prop to "ti,cp_intc"

Nit: DT preference is to use '-' instead of '_'

>     - cp_intc_init() is now also for the of case
>       the name of the init function (it calls the
>       "new" __cp_intc_init() function, which was
>       the "old" cp_intc_init()). Through this
>       rework the changes for OF is better visible.
>       As the OF case uses the irq_domain rework from
>       Grant Likely, maybe the none OF case can use
>       this also, but this should be tested on a hw ...
>   - rebased to:
>     git://git.secretlab.ca/git/linux-2.6.git irqdomain/next
> 
>     commit 280ad7fda5f95211857fda38960f2b6fdf6edd3e
>     Author: Grant Likely <grant.likely@secretlab.ca>
>     Date:   Fri Feb 24 14:58:54 2012 -0700
> 
>     mfd: twl-core: Add IRQ_DOMAIN dependency
> 
>  .../devicetree/bindings/arm/davinci/intc.txt       |   27 ++++++
>  arch/arm/mach-davinci/cp_intc.c                    |   87 +++++++++++++++++--
>  2 files changed, 104 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/davinci/intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/davinci/intc.txt b/Documentation/devicetree/bindings/arm/davinci/intc.txt
> new file mode 100644
> index 0000000..dfd6a560
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/davinci/intc.txt
> @@ -0,0 +1,27 @@
> +* TI Common Platform Interrupt Controller
> +
> +Common Platform Interrupt Controller (cp_intc) is used on
> +OMAP-L1x SoCs and can support several configurable number
> +of interrupts.
> +
> +Main node required properties:
> +
> +- compatible : should be:
> +	"ti,cp_intc"
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The type shall be a <u32> and the value shall be 1.

Is there any configuration for irq inputs (edge/level) or are they
fixed mode?  If configurable, then you'll want another cell for flags.

> +
> +  The cell contains the interrupt number in the range [0-128].
> +- ti,intc-size: Number of interrupts handled by the interrupt controller.
> +- reg: physical base address and size of the intc registers map.
> +
> +Example:
> +
> +	intc: interrupt-controller at 1 {
> +		compatible = "ti,cp_intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		ti,intc-size = <101>;
> +		reg = <0xfffee000 0x2000>;
> +	};
> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index f83152d..585114a 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -9,9 +9,14 @@
>   * kind, whether express or implied.
>   */
>  
> +#include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  
>  #include <mach/common.h>
>  #include <mach/cp_intc.h>
> @@ -99,18 +104,45 @@ static struct irq_chip cp_intc_irq_chip = {
>  	.irq_set_wake	= cp_intc_set_wake,
>  };
>  
> -void __init cp_intc_init(void)
> +static struct irq_domain *cp_intc_domain;
> +
> +static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
> +			  irq_hw_number_t hw)
>  {
> -	unsigned long num_irq	= davinci_soc_info.intc_irq_num;
> +	pr_debug("cp_intc_host_map(%d, 0x%lx)\n", virq, hw);
> +
> +	irq_set_chip(virq, &cp_intc_irq_chip);
> +	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
> +	irq_set_handler(virq, handle_edge_irq);
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops cp_intc_host_ops = {
> +	.map = cp_intc_host_map,
> +	.xlate = irq_domain_xlate_onetwocell,
> +};
> +
> +int __init __cp_intc_init(struct device_node *node,
> +		struct device_node *parent)
> +{
> +	u32 num_irq		= davinci_soc_info.intc_irq_num;
>  	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
>  	u32 *host_map		= davinci_soc_info.intc_host_map;
>  	unsigned num_reg	= BITS_TO_LONGS(num_irq);
> -	int i;
> +	int i, irq_base;
>  
>  	davinci_intc_type = DAVINCI_INTC_TYPE_CP_INTC;
> -	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_8K);
> +	if (node) {
> +		davinci_intc_base = of_iomap(node, 0);
> +		if (of_property_read_u32(node, "ti,intc-size", &num_irq))
> +			pr_warn("unable to get intc-size, default to %d\n",
> +				num_irq);
> +	} else {
> +		davinci_intc_base = ioremap(davinci_soc_info.intc_base,
> +					SZ_8K);
> +	}
>  	if (WARN_ON(!davinci_intc_base))
> -		return;
> +		return -EINVAL;
>  
>  	cp_intc_write(0, CP_INTC_GLOBAL_ENABLE);
>  
> @@ -165,13 +197,48 @@ void __init cp_intc_init(void)
>  		for (i = 0; host_map[i] != -1; i++)
>  			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
>  
> -	/* Set up genirq dispatching for cp_intc */
> -	for (i = 0; i < num_irq; i++) {
> -		irq_set_chip(i, &cp_intc_irq_chip);
> -		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
> -		irq_set_handler(i, handle_edge_irq);
> +	if (node) {
> +		irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
> +		if (irq_base < 0) {
> +			pr_warn("Couldn't allocate IRQ numbers\n");
> +			irq_base = 0;
> +		}
> +
> +		/* create a legacy host */
> +		cp_intc_domain = irq_domain_add_legacy(node, num_irq,
> +					irq_base, 0, &cp_intc_host_ops, NULL);
> +		if (cp_intc_domain == NULL) {
> +			pr_err("CP INTC: failed to allocate irq host!\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		/* Set up genirq dispatching for cp_intc */
> +		for (i = 0; i < num_irq; i++) {
> +			irq_set_chip(i, &cp_intc_irq_chip);
> +			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
> +			irq_set_handler(i, handle_edge_irq);
> +		}

Instead of the else clause here, even the non-DT mode should still
call irq_domain_add.  irq_domain is not just for DT.  It gets the
driver away from manually managing its irq mappings.

>  	}
>  
>  	/* Enable global interrupt */
>  	cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static struct of_device_id irq_match[] __initdata = {
> +	{ .compatible = "ti,cp_intc", .data = __cp_intc_init, },
> +	{ }
> +};
> +
> +void __init cp_intc_init(void)
> +{
> +	of_irq_init(irq_match);
> +}
> +#else
> +void __init cp_intc_init(void)
> +{
> +	__cp_intc_init(NULL, NULL);
>  }
> +#endif

Nack on this hunk because it means you have either a DT kernel or a
non-DT kernel.  Turning on CONFIG_OF must not break booting on a
non-DT platform.  This is a policy decision to improve test coverage.
Instead the init hook should check at runtime if a DT is available,
and if it is call of_irq_init.  Otherwise call __cp_initc_init()
directly.

g.

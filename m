From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 1 Feb 2012 21:54:59 -0700
Subject: [RFC PATCH 1/7] ARM: davinci, intc: Add OF support for TI
 interrupt controller
In-Reply-To: <1327308967-8092-2-git-send-email-hs@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-2-git-send-email-hs@denx.de>
Message-ID: <20120202045459.GI15343@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 09:56:01AM +0100, Heiko Schocher wrote:
> Add a function to initialize the davinci interrupt controller (INTC)
> using a device tree node.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  .../devicetree/bindings/arm/davinci/intc.txt       |   26 ++++++++++
>  arch/arm/mach-davinci/cp_intc.c                    |   51 ++++++++++++++++++++
>  arch/arm/mach-davinci/include/mach/cp_intc.h       |    1 +
>  3 files changed, 78 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/davinci/intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/davinci/intc.txt b/Documentation/devicetree/bindings/arm/davinci/intc.txt
> new file mode 100644
> index 0000000..dac2f69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/davinci/intc.txt
> @@ -0,0 +1,26 @@
> +* TI Davinci Interrupt Controller
> +
> +davinci are using a TI interrupt controller that can support several
> +configurable number of interrupts.
> +
> +Main node required properties:
> +
> +- compatible : should be:
> +	"ti,davinci-intc"
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The type shall be a <u32> and the value shall be 1.
> +
> +  The cell contains the interrupt number in the range [0-128].
> +- ti,intc-size: Number of interrupts handled by the interrupt controller.
> +- reg: physical base address and size of the intc registers map.
> +
> +Example:
> +
> +	intc: interrupt-controller at 1 {
> +		compatible = "ti,davinci-intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		ti,intc-size = <101>;
> +		reg = <0xfffee000 0x2000>;
> +	};
> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index f83152d..2c6e2e4 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -11,7 +11,11 @@
>  
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
> @@ -175,3 +179,50 @@ void __init cp_intc_init(void)
>  	/* Enable global interrupt */
>  	cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
>  }
> +
> +#ifdef CONFIG_OF
> +int __init dv_intc_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	struct resource res;
> +	u32 nr_irqs;
> +
> +	if (WARN_ON(!node))
> +		return -ENODEV;
> +
> +	if (of_address_to_resource(node, 0, &res)) {
> +		WARN(1, "unable to get intc registers\n");
> +		return -EINVAL;
> +	}
> +
> +	davinci_soc_info.intc_base = res.start;
> +	if (WARN_ON(!davinci_soc_info.intc_base))
> +		return -EINVAL;
> +
> +	if (of_property_read_u32(node, "ti,intc-size", &nr_irqs)) {
> +		WARN(1, "unable to get intc-size\n");
> +		return -EINVAL;
> +	}
> +	davinci_soc_info.intc_irq_num = nr_irqs;
> +	davinci_soc_info.intc_type = DAVINCI_INTC_TYPE_CP_INTC;
> +
> +	cp_intc_init();
> +	irq_domain_add_simple(node, 0);

Take a look at the irq_domain patches that will be (probably) merged
in v3.4.  Instead of calling irq_domain_add_simple(), you should
migrate the whole interrupt controller to natively use an irq_domain
for hwirq <--> irq mapping.

g.

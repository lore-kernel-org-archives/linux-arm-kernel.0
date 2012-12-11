From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 11 Dec 2012 07:24:30 +0100
Subject: [PATCH 2/3] ARM: Orion: Bind the orion bridge interrupt
 controller through DT
In-Reply-To: <1355188683-18208-2-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1355188683-18208-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1355188683-18208-2-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20121211062430.GD25466@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 06:18:02PM -0700, Jason Gunthorpe wrote:
> This adds the common DT code and board support for kirkwood and dove
> 
> - Add the marvell,orion-bridge-intc DT node to the DTSI file
> - Make the call to orion_bridge_irq_init happen only in the non-DT
>   case
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  .../devicetree/bindings/arm/mrvl/intc.txt          |   21 ++++++++++++++++++++
>  arch/arm/boot/dts/dove.dtsi                        |   10 +++++++++
>  arch/arm/boot/dts/kirkwood.dtsi                    |   12 +++++++++++
>  arch/arm/mach-dove/common.c                        |    4 ---
>  arch/arm/mach-dove/irq.c                           |    5 ++++
>  arch/arm/mach-kirkwood/common.c                    |    4 ---
>  arch/arm/mach-kirkwood/irq.c                       |    5 ++++
>  arch/arm/plat-orion/irq.c                          |   20 +++++++++++++++++++
>  8 files changed, 73 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/intc.txt b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> index 8b53273..cf633f1 100644
> --- a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> +++ b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> @@ -58,3 +58,24 @@ Example:
>                  reg = <0xfed20204 0x04>,
>  		      <0xfed20214 0x04>;
>          };
> +
> +* Marvell Orion Bridge Interrupt controller
> +
> +Required properties
> +- compatible :  Should be "marvell,orion-bridge-intc".
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. Supported value is <1>.
> +- interrupt-controller : Declare this node to be an interrupt controller.
> +- interrupts: The interrupt number the bridge is attached to on the main
> +              controller.
> +- reg : Interrupt cause address.
> +
> +Example:
> +
> +	bridge_intc: bridge_intc at 20110 {
> +		compatible = "marvell,orion-bridge-intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		interrupts = <1>;
> +		reg = <0x20110 0x08>;
> +        };
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 5a00022..b726ba8 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -67,6 +67,8 @@
>  			status = "disabled";
>  		};
>  
> +		/* The interrupt controller stanzas are in an
> +		 * order that matches irqs.h */
>  		gpio0: gpio at d0400 {
>  			compatible = "marvell,orion-gpio";
>  			#gpio-cells = <2>;
> @@ -93,6 +95,14 @@
>  			ngpio = <8>;
>  		};
>  
> +		bridge_intc: bridge_intc at 20110 {
> +			compatible = "marvell,orion-bridge-intc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupts = <0>;
> +			reg = <0x20110 0x08>;
> +		};
> +
>  		spi0: spi at 10600 {
>  			compatible = "marvell,orion-spi";
>  			#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 4e5b815..854e532 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -19,6 +19,8 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  
> +		/* The interrupt controller stanzas are in an
> +		 * order that matches irqs.h */
>  		gpio0: gpio at 10100 {
>  			compatible = "marvell,orion-gpio";
>  			#gpio-cells = <2>;
> @@ -37,6 +39,14 @@
>  			interrupts = <39>, <40>, <41>;
>  		};
>  
> +		bridge_intc: bridge_intc at 20110 {
> +			compatible = "marvell,orion-bridge-intc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupts = <1>;
> +			reg = <0x20110 0x08>;
> +		};
> +
>  		serial at 12000 {
>  			compatible = "ns16550a";
>  			reg = <0x12000 0x100>;
> @@ -73,6 +83,8 @@
>  
>  		wdt at 20300 {
>  			compatible = "marvell,orion-wdt";
> +			interrupt-parent = <&bridge_intc>;
> +			interrupts = <3>;
>  			reg = <0x20300 0x28>;
>  			status = "okay";
>  		};
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index 6bad21b..b570211 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -243,10 +243,6 @@ static int __init dove_find_tclk(void)
>  static void __init dove_timer_init(void)
>  {
>  	dove_tclk = dove_find_tclk();
> -	if (orion_bridge_irq_init(IRQ_DOVE_BRIDGE,
> -				  IRQ_DOVE_BRIDGE_START,
> -				  BRIDGE_CAUSE, NULL))
> -		panic("Unable to setup bridge irqs");
>  	orion_time_init(IRQ_DOVE_BRIDGE_TIMER1, dove_tclk);
>  }
>  
> diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
> index bc4344a..bcb193f 100644
> --- a/arch/arm/mach-dove/irq.c
> +++ b/arch/arm/mach-dove/irq.c
> @@ -139,4 +139,9 @@ void __init dove_init_irq(void)
>  		set_irq_flags(i, IRQF_VALID);
>  	}
>  	irq_set_chained_handler(IRQ_DOVE_PMU, pmu_irq_handler);
> +
> +	if (orion_bridge_irq_init(IRQ_DOVE_BRIDGE,
> +				  IRQ_DOVE_BRIDGE_START,
> +				  BRIDGE_CAUSE, NULL))
> +		panic("Unable to setup bridge irqs");
>  }
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index ccd3ed5..7398f8b 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -535,10 +535,6 @@ static void __init kirkwood_timer_init(void)
>  {
>  	kirkwood_tclk = kirkwood_find_tclk();
>  
> -	if (orion_bridge_irq_init(IRQ_KIRKWOOD_BRIDGE,
> -				  IRQ_KIRKWOOD_BRIDGE_START,
> -				  BRIDGE_CAUSE, NULL))
> -		panic("Unable to setup bridge irqs");
>  	orion_time_init(IRQ_KIRKWOOD_BRIDGE_TIMER1, kirkwood_tclk);
>  }
>  
> diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
> index 8847035..a1388ef 100644
> --- a/arch/arm/mach-kirkwood/irq.c
> +++ b/arch/arm/mach-kirkwood/irq.c
> @@ -41,4 +41,9 @@ void __init kirkwood_init_irq(void)
>  			IRQ_KIRKWOOD_GPIO_START, gpio0_irqs);
>  	orion_gpio_init(NULL, 32, 18, GPIO_HIGH_VIRT_BASE, 0,
>  			IRQ_KIRKWOOD_GPIO_START + 32, gpio1_irqs);
> +
> +	if (orion_bridge_irq_init(IRQ_KIRKWOOD_BRIDGE,
> +				  IRQ_KIRKWOOD_BRIDGE_START,
> +				  BRIDGE_CAUSE, NULL))
> +		panic("Unable to setup bridge irqs");
>  }
> diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
> index a903012..2dcccda 100644
> --- a/arch/arm/plat-orion/irq.c
> +++ b/arch/arm/plat-orion/irq.c
> @@ -131,9 +131,29 @@ static int __init orion_add_irq_domain(struct device_node *np,
>  	return 0;
>  }
>  
> +static int __init orion_add_bridge_irq_domain(
> +	struct device_node *np, struct device_node *interrupt_parent)
> +{
> +	void __iomem *base;
> +	int bridge_irq;
> +
> +	base = of_iomap(np, 0);
> +	if (!base)
> +		return -ENODEV;
> +	bridge_irq = irq_of_parse_and_map(np, 0);
> +	/* FIXME: irq_of_parse_and_map returns 0 on error, but on Dove the
> +	 * bridge IRQ is 0.
> +	if (!bridge_irq)
> +		return -ENODEV;*/
> +
> +	return orion_bridge_irq_init(bridge_irq, -1, base, np);

Hi Jason

So does this mean for Dove it will currently always fail?

   Thanks
	Andrew

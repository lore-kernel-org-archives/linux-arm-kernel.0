From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Jul 2012 14:54:23 +0000
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <4FF5A15A.8070309@googlemail.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <20120705130819.GV17534@lunn.ch> <4FF5A15A.8070309@googlemail.com>
Message-ID: <201207051454.24475.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 July 2012, Sebastian Hesselbarth wrote:
> Andrew,
> 
> is it possible to group all gpio banks into one DT description?
> For mach-dove it could be something like:
> 
> gpio: gpio-controller {
>         compatible = "marvell, orion-gpio";
>         ...
> 
>         bank0 at d0400 {
>                 reg = <0xd0400 0x40>;
>                 ngpio = <8>;
>                 mask-offset = <0>;
>                 interrupts = <12>;
>         };
> 
>         bank1 at d0400 {
>                 reg = <0xd0400 0x40>;
>                 ngpio = <8>;
>                 mask-offset = <8>;
>                 interrupts = <13>;
>         };

This way you have multiple nodes with the same register
and different names, which is not how it normally works.

> 
> This would have the advantage that DT describes gpio-to-irq dependencies.
> Moreover, nodes that reference gpios can do gpios = <&gpio 71 0>; instead of
> gpios = <&gpio3 7 0>;

Is that desired?

The device tree representation should match what is in the data sheet
normally. If they are in a single continuous number range, then we should
probably have a single device node with multiple register ranges
rather than one device node for each 32-bit register. Looking at
arch/arm/plat-orion/gpio.c I think that is not actually the case though
and having separate banks is more logical.

Something completely different I just noticed in the original patch:

> @@ -90,6 +74,27 @@ static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
>       }
>  }
>  
> +static int __initdata gpio0_irqs[4] = {
> +     IRQ_DOVE_GPIO_0_7,
> +     IRQ_DOVE_GPIO_8_15,
> +     IRQ_DOVE_GPIO_16_23,
> +     IRQ_DOVE_GPIO_24_31,
> +};
> +
> +static int __initdata gpio1_irqs[4] = {
> +     IRQ_DOVE_HIGH_GPIO,
> +     0,
> +     0,
> +     0,
> +};

I think the latter one needs to be

+static int __initdata gpio1_irqs[4] = {
+     IRQ_DOVE_HIGH_GPIO,
+     IRQ_DOVE_HIGH_GPIO,
+     IRQ_DOVE_HIGH_GPIO,
+     IRQ_DOVE_HIGH_GPIO,
+};

so we register all four parts to the same primary IRQ. The
same is true for the devicetree representation.

	Arnd

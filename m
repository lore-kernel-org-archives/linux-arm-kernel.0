From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 27 May 2016 17:23:00 +0300
Subject: interrupts properties and API usage with GPIO controllers/Device
 Tree
In-Reply-To: <57461CDC.603@gmail.com>
References: <57461CDC.603@gmail.com>
Message-ID: <57485844.3050807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2016 12:45 AM, Florian Fainelli wrote:
> Hi Linus, Gregory,
> 
> Recently came across an use case that looks like the following:
> 
> gpio0: gpio at deadbeef {
> 	compatible = "brcm,brcmstb-gpio";
> 	#interrrupt-cells = <2>;
> 	#gpio-cells = <2>;
> 	gpio-controller;
> 	interrupt-controller;
> 	...
> };
> 
> test at cafeb00b {
> 	interrupt-parent = <&gpio0>;
> 	interrupts = <99 3>;
> };
> 
> The driver consuming the test node's interrupts property tries to get
> the interrupt by using platform_get_irq() or of_irq_parse_and_map() and
> in the case of the gpio-brcmstb.c, this fails because the interrupt is
> out of range  as flagged by kernel/irq/irqdomain.c::irq_domain_associate.
> 
> Unlike other GPIO provider drivers gpio-brcmstb.c, this driver registers
> one gpiolib irqchip per each of its banks, and still uses the generic
> map/unmap functions for its irq_domain_ops, so there is no way we can
> provide a valid mapping outside of the gpio_to_irq() function
> unfortunately since gpiochip_irq_map() does

And this is not working :( Each irq_domain has to be assigned to separate DT node,
otherwise IRQ mapping will not work (most probably will work, but only for bank 0)

Such kind of GPIO controllers are incompatible with gpiochip_irqchip_add() and required
to have one, common irq_domain for all internal banks.

like 	irq_domain = irq_domain_add_xxx(dev->of_node, ngpio, irq, 0,
							&davinci_gpio_irq_ops,
							chips);

ngpio = 120 in case of bcm7445.dtsi
and custom .map() function need to be implemented 

More or less similar situation is with davinci_gpio.

> 
> So here are a few questions for either of you:
> 
> - is this a valid API and Device Tree use case: call
> of_irq_parse_and_map on an "interrupts" property which has not been
> acquired using the GPIO API and then gpio_to_irq? 

this is valid use case

> While gpio_to_irq()
> works, are not we losing the second specifier in the interrupt cells
> about what kind of interrupt type this is?
> 
> - would it be acceptable to export gpiochip_irq_map and
> gpiochip_irq_export to make them accessible as helpers so we could just
> wrap things a bit around or should I just open code the same things and
> allow gpiochip_irqchip_add to be passed custom irq_domain_ops for instance?
> 

Yah, custom implementation might be needed.

Another interesting, related question (as for me) is "Is there a limitation
 that gpio bank can have only 32 GPIO pins (from gpiolib point of view)?" 

-- 
regards,
-grygorii

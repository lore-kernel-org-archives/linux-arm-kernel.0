From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Sep 2016 15:15:17 +0100
Subject: irq_create_fwspec_mapping() in 4.8-rc2
In-Reply-To: <483F737F-9868-4E8A-A831-AA3F6F410AFF@gmail.com>
References: <483F737F-9868-4E8A-A831-AA3F6F410AFF@gmail.com>
Message-ID: <57C98975.5020607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[cc-ing the maintainers of the code usually helps]

On 02/09/16 07:51, Andras Szemzo wrote:
> Hi,
> 
> I try to use 4.8-rc2 on my armv7m board, and I have a problem with GPIO IRQ.
> In my device-tree, I define the ethernet PHY IRQ like this:
> 
>  pioC: gpio at 0x400e1200 {
>     compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>     reg = <0x400e1200 0x200>;
>     interrupts = <12>;
>     #gpio-cells = <2>;
>     gpio-controller;
>     interrupt-controller;
>     #interrupt-cells = <2>;
>     clocks = <&pioC_clk>;
> };
> ...
> ethernet-phy at 1 {
>      reg = <1>;
>      interrupt-parent = <&pioC>;
>      interrupts = <11 IRQ_TYPE_EDGE_FALLING>;

So this is the interrupt that gets a mismatch.

>      reset-gpios = <&pioC 10 GPIO_ACTIVE_HIGH>;
> };
> 
> with the 4.8-rc2 kernel at boot it fails with error:
> 
> irq: type mismatch, failed to map hwirq-11 for /soc/pinctrl at 0x400e0e00/gpio at 0x400e1200!
> 
> This error comes from kernel/irq/irq_domain.c, irq_create_fwspec_mapping().
> 
> My quick hack was to replace this function from 4.6.0 (where with the same device-tree, same kernel config it works) 
> and everything works as expected.
> 
> Maybe this hack is hiding a problem from somewhere else, but I can?t figure out what I missed.

Is there any other device in your system that uses the same interrupt?
Where can I see your full DT file?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

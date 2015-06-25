From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 25 Jun 2015 10:39:02 +0100
Subject: imx6 GPIO1 interrupts
In-Reply-To: <CAMB+bfKULf-2wJbw8LH7r345_EvTOktS6zBJnNzAh69dZPtStw@mail.gmail.com>
References: <CAMB+bfKULf-2wJbw8LH7r345_EvTOktS6zBJnNzAh69dZPtStw@mail.gmail.com>
Message-ID: <558BCC36.3070708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[I only saw this thanks to Uwe who just replied...]
On 19/02/15 18:09, Joshua Clayton wrote:
> Freescale imx6 has gpios use shared irqs that trigger across 16 pins
> at a time. These are supported in the mainline kernel.
> 
> The first 8 pins on GPIO1 also have their own interrupts on the GIC.
> I have a kluge sort of working,  and am wondering what it would take
> for me to fully support these in a way that might be mainlined.
> 
> What I am doing:
> (error checking removed for brevity)
> 
>         /* request the shared gpio irq to set the correct edge bits */
>         gpiod = gpiod_get(my->dev, "diffirq");
>         ret = gpiod_direction_input(gpiod);
>         fake_irq = gpiod_to_irq(gpiod);
>         ret = request_irq(fake_irq, no_action, 0, "gpio irq", mydev);
> 
>         /* Use the ARM GPIO4 irq */
>         mydev->irq = irq_of_parse_and_map(mydev->dev->of_node, 0);
> 
>         ret = request_irq(mydev->irq, my_irq_handler, 0, "my fpga", mydev);
> 
>         disable_irq(mydev->irq);
>         enable_irq(mydev->irq);
> 
> This seems to work, but both irq appear in /proc/interrupts, and if I
> try to change the affinity of the hard irq the gpio irq gets all the
> traffic (or something)
> 
> Looking at the code in drivers/gpio/gpio-mxc.c, it seems like almost
> all the code for full hardware irq support is already there, but just
> out of reach to my brain. I think I just need the hardware irq to call
> gpio_set_irq_type() for its set_type function.
> 
> What is the proper way to do this? Do I need another virtual irq_chip
> for the 8 gpio1 irqs? Can something like that be set up in the gpio
> probe, or do I need to catch it earlier when the GIC is being
> probed/initialized?
> 
> ...or am I way off base here?

This looks like something very similar to drivers/irqchip/irq-mtk-sysirq.c.

You may have to adapt your DT to make the devices point to the GPIO
block as an interrupt controller though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

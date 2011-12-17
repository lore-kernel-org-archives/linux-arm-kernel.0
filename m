From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 17 Dec 2011 11:44:39 -0500 (EST)
Subject: label string for kirkwood gpiochip
In-Reply-To: <4EEA06C8.5010302@keymile.com>
References: <4EE9FC0D.10009@keymile.com>
 <alpine.LFD.2.02.1112150920430.2907@xanadu.home>
 <4EEA06C8.5010302@keymile.com>
Message-ID: <alpine.LFD.2.02.1112171142320.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Dec 2011, Holger Brunck wrote:

> On 12/15/2011 03:22 PM, Nicolas Pitre wrote:
> >>
> >> The newer kernel version handles the gpiochip on kirkwood in a different way.
> >> The orion_gpio_init function in arch/arm/mach-kirkwood/irq.c was called twice.
> >> Once for first 32 gpios and a second time for the remaining 18 gpios. This
> >> causes that the gpio framework shows two gpiochips in the sysfs with the same
> >> label (orion_gpio).
> >>
> >> [@km_kirkwood /]# cat /sys/class/gpio/gpiochip0/label
> >> orion_gpio
> >> [@km_kirkwood /]# cat /sys/class/gpio/gpiochip32/label
> >> orion_gpio
> >>
> >> So my question is simply, shouldn't be the string for a gpiochip unique in the
> >> system and therefore this should be fixed or was this intended?
> > 
> > I don't think that was intended.
> > 
> 
> Ok, how should this be done? We could add an additional  param chip_label to
> 
> void __init orion_gpio_init(int gpio_base, int ngpio,
>                             u32 base, int mask_offset, int secondary_irq_base);
> 
> and fix the callers accordingly or we could add a simple static counter in
> orion_gpio_init and add a suffix _0, _1, _2 to the label to make it unique
> without touching the clients...

The later would be less intrusive at this point.

Eventually this should be hooked into the pinctrl subsystem.


Nicolas

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Aug 2014 11:36:35 +0100
Subject: [RESEND PATCH v2 1/4] irqchip: gic: Change irq type check when
 extension is present
In-Reply-To: <1409133344.25382.37.camel@coredoba.hi.pengutronix.de>
References: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1407895884-18131-2-git-send-email-srv_yingjoe.chen@mediatek.com>
 <53F724F5.3040004@arm.com>
 <1409133344.25382.37.camel@coredoba.hi.pengutronix.de>
Message-ID: <53FDB4B3.6000400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On 27/08/14 10:55, Jan L?bbe wrote:
> Marc,
> 
> On Fri, 2014-08-22 at 12:09 +0100, Marc Zyngier wrote:
>> Here, you're using it to program something that sits between the
>> device and the GIC. This is a separate block, with its own hardware
>> configuration, that modifies the interrupt signal. This should be
>> reflected in the device-tree and the code paths.
>>
>> You can probably model this as a separate irqchip for the few
>> interrupts that require this, or have it configured at boot time
>> (assuming the configuration never changes).
> 
> It seems to me that using a separate irqchip for a simple inverter would
> add the run-time overhead of passing through wrapper functions on every
> IRQ. Do you have an idea how this could be avoided without using the
> gic_arch_extn feature?

Well, from the rather vague description, it could be slightly more than
a simple inverter, like being able to generate interrupts on both rising
and falling edges. Sorry, but this is not the GIC as ARM has architected it.

Yes, the additional irqchip adds some overhead. But the DT has to
reflect the fact that there is something on the interrupt path that does
some form of conversion.

> As in the DT the actual IRQ polarity should be used, simply configuring
> the HW IRQ polarity in the bootloader is not enough without telling the
> GIC driver which polarity is supported on which IRQ, right?

Looking a bit closer at things, what you describe in DT is the IRQ
polarity the interrupt controller sees. Nothing else should interpret
that field.

So it is legal (IMO) to have a device with an interrupt specifier
describing a rising edge interrupt, and yet have the device generating a
falling edge, with Mediatek's special sauce doing the conversion in between.

Something will have to configure the polarity widget though, but that
can be left outside of the GIC.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 13 Nov 2017 19:25:32 +0100
Subject: spi->irq == 0 on module reload of driver using IRQF_TRIGGER_LOW
In-Reply-To: <87k1yuttaa.fsf@on-the-bus.cambridge.arm.com>
References: <21FDD1B8-E8F6-4DCE-9D30-D82B713B0008@martin.sperl.org>
 <20171112141349.6b4b3852@why.wild-wind.fr.eu.org>
 <CD4EBEF8-DDFD-40C3-A03E-7EC964B32357@martin.sperl.org>
 <20171112154101.483d21d2@why.wild-wind.fr.eu.org>
 <6CD8E928-2143-4295-A5B3-4B95026E7261@martin.sperl.org>
 <87k1yuttaa.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <75149D40-6A6E-4EC9-8D13-49FF2ED92597@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 13.11.2017, at 10:35, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> On Sun, Nov 12 2017 at  5:49:39 pm GMT, <kernel@martin.sperl.org> wrote:
>>> On 12.11.2017, at 16:41, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> +
>>>> +            can0: mcp2517fd at 0 {
>>>> +                reg = <0>;
>>>> +                compatible = "microchip,mcp2517fd";
>>>> +                pinctrl-names = "default";
>>>> +                pinctrl-0 = <&can0_pins>;
>>>> +                spi-max-frequency = <12500000>;
>>>> +                interrupt-parent = <&gpio>;
>>>> +                interrupts = <16 0x2>;
>>> 
>>> This indicates a falling edge. No wonder the kernel is confused (I
>>> don't know why this isn't enforced the first time though, probably an
>>> issue in the GPIO irqchip driver...). Replacing this 2 with a 8 should
>>> allow you to make some progress.
>> 
>> Thanks for the clarification - with that change it works!
>> 
>> For a better understanding:
>> Isn?t the interrupt type to use more of a driver decision than a
>> HW implementation detail that needs to get defined in the device tree?
> 
> Absolutely *not*. The signalling of an interrupt is completely HW
> dependent, and the driver *must* use abide by the HW rule. That's
> because edge and level interrupts signal entirely different things:
> 
> - An edge interrupt signals a an event. Something has happened, and many
>  of these events can be signalled independently without the CPU doing
>  anything.
> 
> - A level interrupt indicates a change of state, and this state persist
>  until the CPU has services the interrupt.
> 
> That's the difference between receiving a SMS each time you pay
> something your bank card, and receiving a phone call from your bank
> because your account is overdrawn.

So for all practical purposes any typical active low interrupt line 
connected to a GPIO should be configured as TRIGGER_LOW in the
device tree.

Under this assumption:

There are actually quite a few drivers that are having a /INT
line, but are configured in the DT bindings as 2 - hence 
TRIGGER_FALLING.

Two of those are:
* Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
* Documentation/devicetree/bindings/net/microchip,enc28j60.txt

The enc28j60 does use flags = 0, which seems could be ok, as it is
not requesting some specific kind of irq, while the other
is using flags = IRQF_ONESHOT | IRQF_TRIGGER_FALLING, which is
incorrect.

That was one of the reasons why I was adding this subsequent question
for clarification.

So I wonder how one would go about correcting those devices...

> 
>> In my case I probably could write some more code that would allow edge
>> interrupts to work (without race-conditions on spi transfers - probably
>> by using spi_async to reenable interrupts on the HW device), but it
>> would not be as straight-forward and a bit more complex.
> 
> And more or less wrong, given that the spec sheet calls out "active low"
> interrupts.
It would have been a workaround which would not have been accepted
anyway.

>> Summary: Essentially the driver has to match the interrupt type -
>> otherwise it will fail (on second initialization).
> 
> And even that is not quite right. The driver should fail straight
> away. on the first request. I don't have the HW to track it down, but
> I'd appreciate it if you could have a look and enlighten me.

When I have finished this driver I am working on right now, then
I may look into it in detail.

But if I remember the bits and pieces I have been looking at before
asking this question: I remember that there is some code in 
irq_create_fwspec_mapping that allows for first time initialization.

The best I can do is:
* in __setup_irq:
  * the Trigger-type flags are set to ?defaults? if none are set
  * otherwise the flags are used without matching them against
    what is configured in the device tree.
  * so there is no validation happening in case the types disagree.

Something like this patch would trigger an error on first try 
(unless flags = 0 or flags = ?correct?):

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ea41820ab12e..c2dd1b4b879a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1136,8 +1136,15 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
         * If the trigger type is not specified by the caller,
         * then use the default for this interrupt.
         */
-       if (!(new->flags & IRQF_TRIGGER_MASK))
-               new->flags |= irqd_get_trigger_type(&desc->irq_data);
+       flags = irqd_get_trigger_type(&desc->irq_data);
+       if (!(new->flags & IRQF_TRIGGER_MASK)) {
+               new->flags |= flags;
+       } else if ((new->flags & IRQF_TRIGGER_MASK) != flags) {
+               pr_err("Requested trigger type %i does not match default %lu\n",
+                      new->flags & IRQF_TRIGGER_MASK,
+                      flags);
+               return -EINVAL;
+       }

        /*
         * Check whether the interrupt nests into another interrupt

Patch is against 4.9.57 - please ignore the whitespace issue as it
is a simple console cut/paste. 

It does not trigger anything else on my system, but there may
be other use-cases that would fail because of this.

Here some of the debugging output (see the irq_flags module parameter)
root at raspcm:~# rmmod mcp2517fd; dmesg -c; modprobe mcp2517fd irq_flags=2; dmesg -c; grep mcp2517fd /proc/interrupts
rmmod: ERROR: Module mcp2517fd is not currently loaded
[   36.329522] genirq: Requested trigger type 2 does not match default 8
[   36.329556] mcp2517fd spi0.0: failed to acquire irq 176 - -22
[   36.329611] mcp2517fd: probe of spi0.0 failed with error -22
root at raspcm:~# rmmod mcp2517fd; dmesg -c; modprobe mcp2517fd irq_flags=0; dmesg -c; grep mcp2517fd /proc/interrupts
176:          0  pinctrl-bcm2835  16 Level     mcp2517fd
root at raspcm:~# rmmod mcp2517fd; dmesg -c; modprobe mcp2517fd irq_flags=8; dmesg -c; grep mcp2517fd /proc/interrupts
176:          0  pinctrl-bcm2835  16 Level     mcp2517fd

Hope this analysis helps...

Martin

From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 28 Jan 2014 12:02:23 +0100
Subject: [PATCH v3 1/3] ARM: sun7i/sun6i: irqchip: Add irqchip driver
 for NMI controller
In-Reply-To: <20140128104044.GC3867@lukather>
References: <1389453548-10665-1-git-send-email-carlo.caione@gmail.com>
 <1389453548-10665-2-git-send-email-carlo.caione@gmail.com>
 <20140116123940.GE31779@lukather>
 <CAOQ7t2ay6UM-YAUSypRzC=_oSY=0L5RhD6FziG96j4aoK6RHsQ@mail.gmail.com>
 <20140128104044.GC3867@lukather>
Message-ID: <52E78E3F.6080902@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 01/28/2014 11:40 AM, Maxime Ripard wrote:

Jumping in here to try and clarify things, or so I hope at least :)

> On Fri, Jan 17, 2014 at 09:54:55AM +0100, Carlo Caione wrote:
>>>> +/* + * Ack level interrupts right before unmask + * + * In case of level-triggered interrupt, IRQ line must be acked before it + * is unmasked or else a double-interrupt is triggered + */ + +static void sunxi_sc_nmi_ack_and_unmask(struct irq_data *d) +{ +     struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d); +     struct irq_chip_type *ct = irq_data_get_chip_type(d); +     u32 mask = d->mask; + +     if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) +             ct->chip.irq_ack(d); + +     irq_gc_lock(gc); +     irq_reg_writel(mask, gc->reg_base + ct->regs.mask); +
>>>> irq_gc_unlock(gc); +}
>>> 
>>> Hmmm, handle_level_irq seems to be doing exactly that already. It first masks and acks the interrupts, and then unmask it, so we should be fine, don't we?
>> 
>> We don't, or at least handle_level_irq doesn't work for all the cases.
> 
> This is what I find weird :)
> 
>> Let's say (i.e. this is the cubieboard2 case) that to the irqchip is connected to the IRQ line of a PMIC accessed by I2C. In this case we cannot mask/ack the interrupt on the originating device in the hard interrupt handler (in which handle_level_irq is) since we need to access the I2C bus in an non-interrupt context.
> 
> We agree here.
> 
>> ACKing the IRQ in handle_level_irq at this point is pretty much useless since we still have to ACK the IRQs on the originating device and this will be done in a IRQ thread started after the hard IRQ handler.
> 
> Ok, so what you're saying is that you want to adress this case:
> 
> handle_level_irq |          device    device | mask ack handler irq acked unmask |  |    |    |         |       | v  v    v    v         v       v
> 
> NMI -> GIC: +--------+     +----------------- ---------------+        +-----+
> 
> PMIC -> NMI: +-+           +-+ ------------+ +-----------+ +--------------------
> 
> Right?

No, the IRQ from the PMIC is a level sensitive IRQ, so it would look like this:

> handle_level_irq |          device    device | mask ack handler irq acked unmask |  |    |    |         |       | v  v    v    v         v       v
> 
> NMI -> GIC: +------------------------------+ ---------------+                              +--
> 
> PMIC -> NMI: +-------------------------+ ------------+                         +----------

The PMIC irq line won't go low until an i2c write to its irq status
registers write-clears all status bits for which the corresponding
bit in the irq-mask register is set.

And the only reason the NMI -> GIC also goes low is because the unmask
operation writes a second ack to the NMI controller in the unmask
callback of the NMI controller driver.

Note that we cannot use edge triggered interrupts here because the PMIC
has the typical setup with multiple irq status bits driving a single
irq line, so the irq handler does read irq-status, handle stuff,
write-clear irq-status. And if any other irq-status bits get set
between the read and write-clear the PMIC -> NMI line will stay
high, as it should since there are more interrupts to handle.

> But in this case, you would have two events coming from your device (the two rising edges), so you'd expect two interrupts. And in the case of a level triggered interrupt, the device would keep the interrupt line active until it's unmasked, so we wouldn't end up with this either.
> 
>> sunxi_sc_nmi_ack_and_unmask is therefore called (by irq_finalize_oneshot) after the IRQ thread has been executed. After the IRQ thread has ACKed the IRQs on the originating device we can finally ACK and unmask again the NMI.
> 
> And what happens if you get a new interrupt right between the end of the handler and the unmask?

The implicit ack done by the unmask will be ignored if the NMI line is still
high, just like the initial ack is ignored (which is why we need the mask),
and when the unmask completes the irq will immediately retrigger, as it should.


<snip>

>>> I really wonder whether it makes sense to have a generic chip here. It seems to be much more complicated than it should. It's only about a single interrupt interrupt chip here.
>> 
>> I agree but is there any other way to manage the NMI without the driver of the device connected to NMI having to worry about acking/masking/unmasking/ etc..?
> 
> Yes, just declare a "raw" irqchip. Pretty much like we do on irq-sun4i for example.

Hmm, I'm not going to say that using a raw irqchip here is a bad idea, it
sounds like it would be better.

But I don't think this will solve the need the mask / umask. The problem is
we need to do an i2c write to clear the interrupt source, which needs to
be done from a thread / workqueue. So when the interrupt handler finishes
the source won't be cleared yet, and AFAIK then only way to deal with this
is to mask the interrupt until we've cleared the interrupt source.

I agree that ideally we would be able to hide all this inside the NMI
controller driver, but I'm not sure if we can.

Regards,

Hans
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLnjj8ACgkQF3VEtJrzE/skqACgjGLU2QLQUq9o0pU1DuuWIUpx
YngAoJmbmCGEhkRBy5xFmKuXapilqzmM
=BoL/
-----END PGP SIGNATURE-----

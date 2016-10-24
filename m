From: slash.tmp@free.fr (Mason)
Date: Mon, 24 Oct 2016 18:12:56 +0200
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <580BF1D4.2030509@free.fr>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com> <580A60ED.3030307@free.fr>
 <20161021201448.3f4a0a7a@arm.com> <580A70B9.8060507@free.fr>
 <alpine.DEB.2.20.1610212147420.4855@nanos> <580A7A2B.5000702@free.fr>
 <20161022123713.6dc788b3@arm.com> <580BF1D4.2030509@free.fr>
Message-ID: <580E3308.4050507@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/2016 01:10, Mason wrote:

> Maybe the fact that disable_irq locks the system up is an orthogonal
> issue that needs to be fixed anyway.

disable_irq_nosync() eventually calls irq_disable()

void irq_disable(struct irq_desc *desc)
{
	irq_state_set_disabled(desc);
	if (desc->irq_data.chip->irq_disable) {
		desc->irq_data.chip->irq_disable(&desc->irq_data);
		irq_state_set_masked(desc);
	} else if (irq_settings_disable_unlazy(desc)) {
		mask_irq(desc);
	}
}

irq_disable() is a NOP on my platform, because the intc driver does
not implement irq_disable, and the second test is false as well in
this instance.

The function's description is interesting.

/**
 * irq_disable - Mark interrupt disabled
 * @desc:	irq descriptor which should be disabled
 *
 * If the chip does not implement the irq_disable callback, we
 * use a lazy disable approach. That means we mark the interrupt
 * disabled, but leave the hardware unmasked. That's an
 * optimization because we avoid the hardware access for the
 * common case where no interrupt happens after we marked it
 * disabled. If an interrupt happens, then the interrupt flow
 * handler masks the line at the hardware level and marks it
 * pending.
 *
 * If the interrupt chip does not implement the irq_disable callback,
 * a driver can disable the lazy approach for a particular irq line by
 * calling 'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'. This can
 * be used for devices which cannot disable the interrupt at the
 * device level under certain circumstances and have to use
 * disable_irq[_nosync] instead.
 */

(I assume "chip" and "interrupt chip" refer to the same abstraction.)

I took a look at commit e9849777d0e27, but my brain dumped core on
the notions of "disabling unlazy" and "disabling a disable".

  * IRQ_DISABLE_UNLAZY          - Disable lazy irq disable


For the record, setting the IRQ_DISABLE_UNLAZY flag for this device
makes the system lock-up disappear.

Regards.

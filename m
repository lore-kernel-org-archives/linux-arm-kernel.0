From: slash.tmp@free.fr (Mason)
Date: Tue, 25 Oct 2016 15:56:11 +0200
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <534c4588-f220-25a3-e7aa-84484f348bd1@arm.com>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com> <580A60ED.3030307@free.fr>
 <20161021201448.3f4a0a7a@arm.com> <580A70B9.8060507@free.fr>
 <alpine.DEB.2.20.1610212147420.4855@nanos> <580A7A2B.5000702@free.fr>
 <20161022123713.6dc788b3@arm.com> <580BF1D4.2030509@free.fr>
 <580E3308.4050507@free.fr> <alpine.DEB.2.20.1610241847580.5002@nanos>
 <580F17E7.5060603@laposte.net> <580F1992.2070602@free.fr>
 <534c4588-f220-25a3-e7aa-84484f348bd1@arm.com>
Message-ID: <580F647B.5000202@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/2016 12:45, Marc Zyngier wrote:
> On 25/10/16 09:36, Mason wrote:
>> On 25/10/2016 10:29, Sebastian Frias wrote:
>>
>>> On 10/24/2016 06:55 PM, Thomas Gleixner wrote:
>>>
>>>> On Mon, 24 Oct 2016, Mason wrote:
>>>>
>>>>> For the record, setting the IRQ_DISABLE_UNLAZY flag for this device
>>>>> makes the system lock-up disappear.
>>>>
>>>> The way how lazy irq disabling works is:
>>>>
>>>> 1) Interrupt is marked disabled in software, but the hardware is not masked
>>>>
>>>> 2) If the interrupt fires befor the interrupt is reenabled, then it's
>>>>    masked at the hardware level in the low level interrupt flow handler.
>>>
>>> Would you mind explaining what is the intention behind?
>>> Because it does not seem obvious why there isn't a direct map between
>>> "disable_irq*()" and "mask_irq()"
>>
>> I had a similar, but slightly different question:
>>
>> What is the difference between struct irq_chip's
>>
>>  * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
>>  * @irq_disable:	disable the interrupt
>>  * @irq_mask:		mask an interrupt source
> 
> One important difference between disable and mask is that disable is
> perfectly allowed not to care about pending signals, whereas mask must
> preserve an interrupt becoming pending whilst masked.

(For my information)

Is it correct to say that "mask" is supposed to defer any interrupt
until sometime later; while "disable" will simply discard incoming
interrupts, losing them forever.

Is the irq_mask() call-back exposed via some module-visible API?

include/linux/interrupt.h documents mostly enable/disable variants.

extern void disable_irq_nosync(unsigned int irq);
extern bool disable_hardirq(unsigned int irq);
extern void disable_irq(unsigned int irq);
extern void disable_percpu_irq(unsigned int irq);
extern void enable_irq(unsigned int irq);
extern void enable_percpu_irq(unsigned int irq, unsigned int type);
extern bool irq_percpu_is_enabled(unsigned int irq);
extern void irq_wake_thread(unsigned int irq, void *dev_id);

Regards.

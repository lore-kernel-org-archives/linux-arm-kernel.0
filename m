From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 03 Apr 2011 11:21:00 +0530
Subject: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module
	support
In-Reply-To: <BANLkTi=DjoDndvnhJyBSUGChdPuAKDL3mg@mail.gmail.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>	<1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com>	<BANLkTimWTX9HKhpkkjODCSEiuBNuV-rN-g@mail.gmail.com>	<4D96EEF4.8000500@ti.com>
	<BANLkTi=DjoDndvnhJyBSUGChdPuAKDL3mg@mail.gmail.com>
Message-ID: <4D980AC4.2050903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2011 1:17 AM, Colin Cross wrote:
> On Sat, Apr 2, 2011 at 2:40 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> On 4/2/2011 11:40 AM, Colin Cross wrote:

[....]

>>>> +#ifdef CONFIG_PM
>>>> +/*
>>>> + * Architecture specific set_wake extension
>>>> + */
>>>> +static int wakeupgen_set_wake(struct irq_data *d, unsigned int on)
>>>> +{
>>>> +       spin_lock(&wakeupgen_lock);
>>>> +       if (on)
>>>> +               _wakeupgen_set(d->irq);
>>>> +       else
>>>> +               _wakeupgen_clear(d->irq);
>>>> +       spin_unlock(&wakeupgen_lock);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +#else
>>>> +#define wakeupgen_set_wake     NULL
>>>> +#endif
>>>
>>> I don't think these are correct, and it probably only works at all due
>>> to lazy disabling of interrupts during suspend.
>>>
>>> First, unless I'm missing some code somewhere, all interrupts are
>>> still enabled during suspend.  Any interrupt that has had enable_irq
>>> on it resulted in a call to wakeupgen_unmask, but when disable_irq is
>>> called on all the interrupts during suspend, masking is delayed until
>>> an interrupt is delivered.  If no interrupt is delivered, all enabled
>>> irqs will still be enabled in the wakeupgen module in suspend, and
>>> they will all wake the device out of suspend.
>>>
>> During suspend it's expected that the drivers disables there interrupts
>> as part of suspend hooks. One can used "set_wake" API's to
>> enable/disable wakeups from suspend.
>
> But because of lazy masking, disabling an interrupt is not the same as
> masking.  None of the interrupts will get masked, and they will all
> act as wakeup interrupts, even if enable_irq_wake was never called on
> it.
>
>>
>>> Second, it is possible for a wake interrupt that should be enabled to
>>> end up disabled in suspend.  Consider the following calls that occur
>>> in a driver during its suspend handler:
>>>
>>> enable_irq_wake
>>>    ...
>>>    wakeupgen_unmask (irq is now unmasked)
>>> disable_irq (lazy disable, wakeupgen_mask is not called, irq is still
>>> unmasked)
>>> <irq occurs>
>>> handle_level_irq
>>>    ...
>>>    wakeupgen_mask (irq is now masked)
>>>
>>> The irq will never get unmasked because it is marked disabled, and the
>>> irq will not wake the device from suspend.
>>>
>>> wakeupgen_set_wake needs to set or clear bits in memory, and then
>>> those suspend masks need to be copied into the wakeupgen registers
>>> very late in suspend, after interrupts have been disabled at the cpu.
>>> I think syscore_ops is the right place.
>>>
>> This is a good point about lazy disabling. Copy to memory happens
>> already as part of save in SAR layout.
>> Will think over this one. Thanks for bringing this point here.
>
> The key is that mask/unmask and set_wake must act on different mask
> data - mask/unmask must take effect immediately, so they must write to
> the mask registers, but set_wake takes effect only during suspend, so
> it must write to a copy of the mask registers that gets switched in
> during suspend.
>
Right. I shall fix the set_wake() API to take care of lazy
disabling of IRQs.

Regards
Santosh

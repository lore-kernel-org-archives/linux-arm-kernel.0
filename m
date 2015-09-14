From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Sep 2015 16:23:42 +0100
Subject: [PATCH 2/2] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <CAL4ahLdOtJ=W2xZbORYFi9ocnqB3oX0OzfC9zGiarBezjuxGwQ@mail.gmail.com>
References: <1441963332-13329-1-git-send-email-yvo@apm.com>
 <2971356.lYN9OVO6Id@wuerfel>
 <CAL4ahLfRdfC=nReqqic=1vahgtD3-E_ncqnNhHsGw04P_HjvVA@mail.gmail.com>
 <2516438.vcQPNoorc9@wuerfel>
 <CAL4ahLdOtJ=W2xZbORYFi9ocnqB3oX0OzfC9zGiarBezjuxGwQ@mail.gmail.com>
Message-ID: <55F6E67E.1080609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/15 16:06, Y Vo wrote:
> On Mon, Sep 14, 2015 at 9:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Monday 14 September 2015 16:39:43 Y Vo wrote:
>>> On Mon, Sep 14, 2015 at 4:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Saturday 12 September 2015 12:55:55 Y Vo wrote:
>>>>> On Fri, Sep 11, 2015 at 11:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>> On Friday 11 September 2015 22:06:58 Y Vo wrote:
>>>>>
>>>>> Example for configure GPIO_DS13 as interrupt and use as button with
>>>>> the current gpio driver:
>>>>>         gpio-keys {
>>>>>                 compatible = "gpio-keys";
>>>>>                 button at 1 {
>>>>>                         label = "POWER";
>>>>>                         linux,code = <116>;
>>>>>                         linux,input-type = <0x1>;
>>>>>                         interrupts = <0x0 0x2d 0x1>;
>>>>>                 };
>>>>>         };
>>>>
>>>> Wait, this looks wrong: the gpio driver doesn't actually see
>>>> the connection here and won't be able to configure the interrupt
>>>> correctly. The interrupt is already owned by the gpio driver, so
>>>> you cannot use it in the button node.
>>>
>>> In summary:
>>> - Our GPIO doesn't support interrupt controller.
>>> - There are 6 pins which used the external interrupt from GIC, so all
>>> setup for those irqs are from gic driver. The GPIO driver only
>>> configure to wire those lines.
>>>
>>> For your concern:
>>> - That's correct: if we use that defined, the gpio driver never saw
>>> the connection here (That's why it already is configued at the
>>> beginning).
>>> - At the first time, we tried to use the define: <&sbgpio 13 1>, it
>>> means using the GPIO_DS13, it will go into the GPIO driver to setup,
>>> but there is another problem which I have sent out to all of you:
>>> + It will go into gpio_keys_setup_key (gpio_keys.c driver) function,
>>> then set the irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>>> but the gic only support IRQ_TYPE_LEVEL_HIGH && IRQF_TRIGGER_RISING,
>>> so it always returns failed at gpio_keys_setup_key function. Please
>>> see the gic_set_type at gic driver.
>>
>> Hmm, I see now how the event handling in the gpio-keys driver differs
>> between irq mode and gpio mode, where gpio mode relies on getting
>> a separate event for the release. This is certainly something that
>> could be changed in the gpio-keys driver as an extension, but that
>> seems to be what Laxman Dewangan did when he introduced the irq-mode.
>>
>>> static int gic_set_type(struct irq_data *d, unsigned int type)
>>> {
>>>         void __iomem *base = gic_dist_base(d);
>>>         unsigned int gicirq = gic_irq(d);
>>>
>>>         /* Interrupt configuration for SGIs can't be changed */
>>>         if (gicirq < 16)
>>>                 return -EINVAL;
>>>
>>>         /* SPIs have restrictions on the supported types */
>>>         if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
>>>                             type != IRQ_TYPE_EDGE_RISING)
>>>                 return -EINVAL;
>>>
>>>         return gic_configure_irq(gicirq, type, base, NULL);
>>> }
>>> + Another issue: in order gpio_key works it needs the status of GPIO.
>>> For our chip, when the GPIO is configued as interrupt, we need to
>>> access to GIC register to read the real status, it is not acceptable
>>> to implement accessing GIC registers at gpio driver. The function
>>> irq_get_irqchip_state(..) also doesn't work in our chip too. Because
>>> it needs to access different offset.
>>
>> I thought we had solved that problem long ago when you first
>> submitted the driver.
>>
>> Did 1b7047edfcfb25 ("genirq: Allow the irqchip state of an IRQ to be
>> save/restored") not address the problem for you? You were on
>> Cc to that patch and should have spoken up when the code that was
>> merged was not sufficient.
> 
> Yes, I am in this mail-list too, but I also had a issue on this, I
> think you are still in my submitted for this.
> Currently, irq_get|set_irqchip_state(..) supports access to
> GIC_DIST_ENABLE_SET, GIC_DIST_ACTIVE_SET, GIC_DIST_PENDING_SET. But
> our hw only has the valid value at SPISR register ("[PATCH v4 2/3]
> irqchip: GIC: Add support for irq_{get,set}_irqchip_state"), so I
> still can not use it.

And I asked Feng Kan to explain *why* it doesn't work, but nobody ever
bothered giving me a straight answer on that:

https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg892972.html

The GIC400 TRM explicitly states that reading GICD_SPISRn is the same as
reading GICD_ICPENDRn. if that doesn't work for you please explain why.

If I can get a reasonable explanation on *why* it doesn't work, then we
can look at having an X-Gene specific workaround.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

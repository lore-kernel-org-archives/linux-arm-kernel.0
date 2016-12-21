From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 21 Dec 2016 22:24:07 +0200
Subject: [PATCH 2/2] mfd: mc13xxx: Pass the IRQF_TRIGGER_HIGH flag.
In-Reply-To: <CAM=E1R7mBa7PSyshR+VwbeCqqDytkTknNksWQmf3Yk2r0_nHZw@mail.gmail.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
 <1482211233.10253607@f408.i.mail.ru>
 <CAM=E1R5=k5NXurdV=6TzE9bPH5M3zyFpUjuJpGd9ECKrdjaj7w@mail.gmail.com>
 <1482300049.831956101@f373.i.mail.ru>
 <CAM=E1R7mBa7PSyshR+VwbeCqqDytkTknNksWQmf3Yk2r0_nHZw@mail.gmail.com>
Message-ID: <1bec9023-1869-2847-bea6-adebc5af0093@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/21/2016 09:41 PM, Magnus Lilja wrote:
> Hi,
> 
> On 21 December 2016 at 07:00, Alexander Shiyan <shc_work@mail.ru> wrote:
>>> ???????, 20 ??????? 2016, 22:35 +03:00 ?? Magnus Lilja <lilja.magnus@gmail.com>:
>>>
>>> On 20 December 2016 at 06:20, Alexander Shiyan < shc_work@mail.ru > wrote:
>>>>> ???????, 20 ??????? 2016, 0:28 +03:00 ?? Magnus Lilja < lilja.magnus@gmail.com >:
>>>>>
>>>>> All supported mc13xxx devices have active high interrupt outputs. Make sure
>>>>> to configure the interrupt as active high by passing the IRQF_TRIGGER_HIGH
>>>>> flag. This is required at least on the i.MX31 PDK board.
>>>>>
>>>>> Signed-off-by: Magnus Lilja <  lilja.magnus@gmail.com >
>>>>> ---
>>>>>
>>>>> drivers/mfd/mc13xxx-core.c | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
>>>>> index d7f54e4..4cbe6b7 100644
>>>>> --- a/drivers/mfd/mc13xxx-core.c
>>>>> +++ b/drivers/mfd/mc13xxx-core.c
>>>>> @@ -440,7 +440,7 @@ int mc13xxx_common_init(struct device *dev)
>>>>> mc13xxx->irq_chip.irqs = mc13xxx->irqs;
>>>>> mc13xxx->irq_chip.num_irqs = ARRAY_SIZE(mc13xxx->irqs);
>>>>>
>>>>> -ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq, IRQF_ONESHOT,
>>>>> +ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq, IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
>>>>>   0, &mc13xxx->irq_chip, &mc13xxx->irq_data);
>>>>> if (ret)
>>>>> return ret;
>>>>
>>>> IRQ line can be passed through inverter to IC.
>>>> On my opinion the best way to handle all possible situations is parse
>>>> devicetree IRQ flags and pass to the driver.
>>>
>>> My guess is that most boards follow the evaluation boards/kits and
>>> don't have an inverter so I think the default should be TRIG_HIGH
>>> since that will make most boards work automatically. But I can have a
>>> look at making it configurable (with and without the use of device
>>> tree), but for the device tree stuff I would need pointers to similar
>>> code since my experience with that is none.
>>> Any pointers to similar code?
>>
>> Hello.
>>
>> Perhaps I'm wrong and the desired active level has setup at the IRQ code level.
> 
> Don't think I understand what you mean here.
> 
>> Otherwise, I think you need to use something like the following:
>>
>> unsigned flags = irqd_get_trigger_type(irq_get_irq_data(irq));
>> flags = (flags == IRQ_TYPE_NONE) ? IRQF_TRIGGER_HIGH : flags;
>> ret = regmap_add_irq_chip(..., IRQF_ONESHOT | flags, ...);
> 
> That would work but I don't know how one would set the trigger type in
> case of not using device trees.

you may look at drivers/mfd/palmas.c and include/linux/mfd/palmas.h
to get an idea how irq flags are passed through the platform data in
a similar case.

> But that would only be a problem if a board really has an inverter on
> the IRQ line so that can be solved later,

Correct, I would recommend to postpone adding any extensions to the driver
platform data, which by the way is found in include/linux/mfd/mc13xxx.h

The extension can be added only when it becomes needed.

> and might be not necessary to solve if mx31 boards are converted to
> device tree usage.
> 
> I guess that get trigger_type can be set via the device tree magic
> when using device trees.
> 

FWIW I ran the v4.9-rc kernel with device trees on i.MX31 Lite board
with MC13783, and what I can confirm is that in my case the proposed
change is not needed at all. Thus I'm going to verify shortly that
the commit does not break the currently correct runtime behaviour on
my board.

--
With best wishes,
Vladimir

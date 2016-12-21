From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 21 Dec 2016 09:00:49 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIG1mZDogbWMxM3h4eDogUGFzcyB0aGUgSVJRRl9U?=
 =?UTF-8?B?UklHR0VSX0hJR0ggZmxhZy4=?=
In-Reply-To: <CAM=E1R5=k5NXurdV=6TzE9bPH5M3zyFpUjuJpGd9ECKrdjaj7w@mail.gmail.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
 <1482211233.10253607@f408.i.mail.ru>
 <CAM=E1R5=k5NXurdV=6TzE9bPH5M3zyFpUjuJpGd9ECKrdjaj7w@mail.gmail.com>
Message-ID: <1482300049.831956101@f373.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>???????, 20 ??????? 2016, 22:35 +03:00 ?? Magnus Lilja <lilja.magnus@gmail.com>:
>
>On 20 December 2016 at 06:20, Alexander Shiyan < shc_work@mail.ru > wrote:
>>>???????, 20 ??????? 2016, 0:28 +03:00 ?? Magnus Lilja < lilja.magnus@gmail.com >:
>>>
>>>All supported mc13xxx devices have active high interrupt outputs. Make sure
>>>to configure the interrupt as active high by passing the IRQF_TRIGGER_HIGH
>>>flag. This is required at least on the i.MX31 PDK board.
>>>
>>>Signed-off-by: Magnus Lilja <  lilja.magnus@gmail.com >
>>>---
>>>
>>> drivers/mfd/mc13xxx-core.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
>>>index d7f54e4..4cbe6b7 100644
>>>--- a/drivers/mfd/mc13xxx-core.c
>>>+++ b/drivers/mfd/mc13xxx-core.c
>>>@@ -440,7 +440,7 @@ int mc13xxx_common_init(struct device *dev)
>>> mc13xxx->irq_chip.irqs = mc13xxx->irqs;
>>> mc13xxx->irq_chip.num_irqs = ARRAY_SIZE(mc13xxx->irqs);
>>>
>>>-ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq, IRQF_ONESHOT,
>>>+ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq, IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
>>>   0, &mc13xxx->irq_chip, &mc13xxx->irq_data);
>>> if (ret)
>>> return ret;
>>
>> IRQ line can be passed through inverter to IC.
>> On my opinion the best way to handle all possible situations is parse
>> devicetree IRQ flags and pass to the driver.
>
>My guess is that most boards follow the evaluation boards/kits and
>don't have an inverter so I think the default should be TRIG_HIGH
>since that will make most boards work automatically. But I can have a
>look at making it configurable (with and without the use of device
>tree), but for the device tree stuff I would need pointers to similar
>code since my experience with that is none.
>Any pointers to similar code?

Hello.

Perhaps I'm wrong and the desired active level has setup at the IRQ code level.
Otherwise, I think you need to use something like the following:

unsigned flags = irqd_get_trigger_type(irq_get_irq_data(irq));
flags = (flags == IRQ_TYPE_NONE) ? IRQF_TRIGGER_HIGH : flags;
ret = regmap_add_irq_chip(..., IRQF_ONESHOT | flags, ...);

Please fix me.
Thanks.

---

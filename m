From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 21 Nov 2015 00:05:06 +0900
Subject: [PATCH] extcon: palmas: add support for using VBUSDET output
In-Reply-To: <87io4wenz5.fsf@saruman.tx.rr.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
 <1447351034-21150-1-git-send-email-balbi@ti.com>
 <564EB0A6.4060407@samsung.com> <564EB332.5090406@samsung.com>
 <87io4wenz5.fsf@saruman.tx.rr.com>
Message-ID: <CAGTfZH1LStzFc8O==n8trw232=nqyEmPhrXyE4bgM88oApPsWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Fri, Nov 20, 2015 at 11:37 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> Hi Chanwoo,
>
> Chanwoo Choi <cw00.choi@samsung.com> writes:
>> Hi Felipe,
>>
>> On 2015? 11? 20? 14:33, Chanwoo Choi wrote:
>>> Hi Felipe,
>>>
>>> Looks good to me. But I have one comment.
>>>
>>> On 2015? 11? 13? 02:57, Felipe Balbi wrote:
>>>> TPS659038 can remux its GPIO_1 as VBUSDET output,
>>>> which can be tied to a SoC GPIO and used as a VBUS
>>>> interrupt.
>>>>
>>>> Beagle X15 uses that, in fact, and without it, I
>>>> could not get USB peripheral working with that
>>>> board.
>>>>
>>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>> ---
>>>>  drivers/extcon/extcon-palmas.c | 22 ++++++++++++++++++++--
>>>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
>>>> index 93c30a885740..7985d092c069 100644
>>>> --- a/drivers/extcon/extcon-palmas.c
>>>> +++ b/drivers/extcon/extcon-palmas.c
>>>> @@ -296,10 +296,28 @@ static int palmas_usb_probe(struct platform_device *pdev)
>>>>     }
>>>>
>>>>     if (palmas_usb->enable_vbus_detection) {
>>>> +           int irq = platform_get_irq(pdev, 0);
>>>> +
>>>> +           if (irq > 0) {
>>>> +                   /* remux GPIO_1 as VBUSDET */
>>>> +                   status = palmas_update_bits(palmas, PALMAS_PU_PD_OD_BASE,
>>>> +                                   PALMAS_PRIMARY_SECONDARY_PAD1,
>>>> +                                   PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_MASK,
>>>> +                                   (1 << 3));
>>>
>>> PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_SHIFT is appropriate instead of
>>> using '3'.
>
> good point :-)
>
>>>> +                   if (status < 0) {
>>>> +                           dev_err(&pdev->dev, "can't remux GPIO1\n");
>>>> +                           return status;
>>>> +                   }
>>>> +
>>>> +                   palmas_usb->vbus_irq = irq;
>>>> +           } else {
>>>> +                   irq = regmap_irq_get_virq(palmas->irq_data,
>>>> +                                   PALMAS_VBUS_IRQ);
>>>> +                   palmas_usb->vbus_irq = irq;
>>>> +           }
>>>> +
>>>>             palmas_usb->vbus_otg_irq = regmap_irq_get_virq(palmas->irq_data,
>>>>                                                    PALMAS_VBUS_OTG_IRQ);
>>>> -           palmas_usb->vbus_irq = regmap_irq_get_virq(palmas->irq_data,
>>>> -                                                      PALMAS_VBUS_IRQ);
>>>>             status = devm_request_threaded_irq(palmas_usb->dev,
>>>>                             palmas_usb->vbus_irq, NULL,
>>>>                             palmas_vbus_irq_handler,
>>>>
>>>
>>> Thanks,
>>> Chanwoo Choi
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>> If you are OK about following patch, I'll apply it on extcon branch.
>
> that's perfect, thanks for fixing it :-)

Applied it.

Thanks,
Chanwoo Choi

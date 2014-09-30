From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 30 Sep 2014 19:56:02 +0530
Subject: [PATCH v3 3/6] pinctrl: exynos: Add irq_chip instance for Exynos7
 wakeup interrupts
In-Reply-To: <5429E12B.5020708@gmail.com>
References: <1411967712-8321-1-git-send-email-a.kesavan@samsung.com>
 <1411967712-8321-4-git-send-email-a.kesavan@samsung.com>
 <5429E12B.5020708@gmail.com>
Message-ID: <CAM4voamO1y4J=_AuEgANt6VyBgwLx9L-u--3SJK7YULCQonoDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Tue, Sep 30, 2014 at 4:16 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Abhilash,
>
> Just two minor issues inline. I leave them up to Linus to decide.
>
> Linus, if you don't mind them, feel free to apply this patch with my Ack.
>
> On 29.09.2014 07:15, Abhilash Kesavan wrote:
>> Exynos7 uses different offsets for wakeup interrupt configuration registers.
>> So a new irq_chip instance for Exynos7 wakeup interrupts is added. The irq_chip
>> selection is now based on the wakeup interrupt controller compatible string.
>
> [snip]
>
>> @@ -469,12 +488,18 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
>>       struct samsung_pin_bank *bank;
>>       struct exynos_weint_data *weint_data;
>>       struct exynos_muxed_weint_data *muxed_data;
>> +     struct exynos_irq_chip *exynos_wkup_irq_chip;
>
> Quite an awful name for a local variable. "irq_chip" alone would be enough.
>
>>       unsigned int muxed_banks = 0;
>>       unsigned int i;
>>       int idx, irq;
>>
>>       for_each_child_of_node(dev->of_node, np) {
>> -             if (of_match_node(exynos_wkup_irq_ids, np)) {
>> +             const struct of_device_id *match;
>> +
>> +             match = of_match_node(exynos_wkup_irq_ids, np);
>> +             if (match) {
>> +                     exynos_wkup_irq_chip = kmemdup(match->data,
>> +                             sizeof(struct exynos_irq_chip), GFP_KERNEL);
>
> sizeof(*exynos_wkup_irq_chip) (or irq_chip considering my comment above)
> could be used instead.

Thanks for the acks. Will post a new version with these nits fixed.
>
> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

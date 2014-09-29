From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 29 Sep 2014 10:50:14 +0530
Subject: [PATCH v2 2/5] pinctrl: exynos: Add irq_chip instance for Exynos7
 wakeup interrupts
In-Reply-To: <54218882.1050401@gmail.com>
References: <1411460169-30536-1-git-send-email-a.kesavan@samsung.com>
 <1411460169-30536-3-git-send-email-a.kesavan@samsung.com>
 <54218882.1050401@gmail.com>
Message-ID: <CAM4voakz5JpKV9sK8EHWDmBTFxy8YDCFejGz_VbZ0bamtVmteQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Tue, Sep 23, 2014 at 8:19 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 23.09.2014 10:16, Abhilash Kesavan wrote:
> [snip]
>> @@ -383,9 +377,11 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
>>  /*
>>   * irq_chip for wakeup interrupts
>>   */
>> -static struct exynos_irq_chip exynos_wkup_irq_chip = {
>> +static struct exynos_irq_chip *exynos_wkup_irq_chip;
>> +
> [snip]
>> @@ -459,7 +480,7 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
>>  static int exynos_wkup_irq_map(struct irq_domain *h, unsigned int virq,
>>                                       irq_hw_number_t hw)
>>  {
>> -     irq_set_chip_and_handler(virq, &exynos_wkup_irq_chip.chip,
>> +     irq_set_chip_and_handler(virq, &exynos_wkup_irq_chip->chip,
>>                                       handle_level_irq);
>>       irq_set_chip_data(virq, h->host_data);
>>       set_irq_flags(virq, IRQF_VALID);
>> @@ -491,7 +512,12 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
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
> That's not exactly what I had in my mind.
>
> You just changed the code to write to another global variable. This is
> not the best practice and might cause hard to track issues in future,
> when extending the driver.
>
> From what I can see, the best solution would be to add .irq_chip field
> to samsung_pin_bank struct. Then exynos_wkup_irq_map() could access it
> through h->host_data pointer and exynos_irq_demux_eint16_31() could also
> retrieve the irq chip through bank struct without the need too add chip
> field to exynos_muxed_weint_data struct.
>
> As a side effect, it would be possible to consolidate
> exynos_wkup_irqd_ops with exynos_gpio_irqd_ops, which currently only
> differ in irq chip passed as argument to irq_set_chip_and_handler() in
> .map() callback.

I have posted v3 adding a new irq_chip field to the samsung_pin_bank
structure as per your suggestion. Please take a look.

Regards,
Abhilash
>
> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

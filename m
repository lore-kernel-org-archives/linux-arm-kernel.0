From: anurupvasu@gmail.com (Anurup M)
Date: Thu, 2 Mar 2017 10:50:08 +0530
Subject: [PATCH v4 10/11] drivers: perf: hisi: Handle counter overflow IRQ
 in MN PMU
In-Reply-To: <58AFA2CC.206@gmail.com>
References: <1487530282-42731-1-git-send-email-anurup.m@huawei.com>
 <20170220112918.GG9003@leverpostej> <58AC2966.3060200@gmail.com>
 <20170221120334.GB8605@leverpostej> <58AFA2CC.206@gmail.com>
Message-ID: <58B7AB88.9030306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 24 February 2017 08:34 AM, Anurup M wrote:
>>>>> +static int hisi_mn_init_irqs_fdt(struct device *dev,
>>>>> +                struct hisi_pmu *mn_pmu)
>>>>> +{
>>>>> +    struct hisi_mn_data *mn_data = mn_pmu->hwmod_data;
>>>>> +    struct hisi_djtag_client *client = mn_data->client;
>>>>> +    int irq = -1, num_irqs, i;
>>>>> +
>>>>> +    num_irqs = of_irq_count(dev->of_node);
>>>> Surely we expect a specific number of interrupts?
>>>>
>>>>> +    for (i = 0; i < num_irqs; i++) {
>>>>> +        irq = of_irq_get(dev->of_node, i);
>>>>> +        if (irq < 0)
>>>>> +            dev_info(dev, "No IRQ resource!\n");
>>>>> +    }
>>>> Why are we throwing these away?
>>>>
>>>>> +
>>>>> +    if (irq < 0)
>>>>> +        return 0;
>>>>> +
>>>>> +    /* The last entry in the IRQ list to be chosen
>>>>> +     * This is as per mbigen-v2 IRQ mapping
>>>>> +     */
>>>>> +    return hisi_mn_init_irq(irq, mn_pmu, client);
>>>> I don't understand this comment.
>>>>
>>>> Why do we only use the list IRQ?
>>>>
>>>> What does this have to do with the mbigen?
>>>>
>>>> No ordering requirement was described in the DT binding.
>>> There is a defect in the mbigen hardware to handle the IRQ mapping
>>> for MN.
>>> Due to this the IRQ property
>>> of MN is made as a list and we read all IRQs and use only the last one.
>>> I shall mention it in the comment and also add note in the DT bindings.
>> You'll need to elaborate on that a bit further; I don't understand.
>>
>> If the interrupts aren't usable, there's arguably not much point listing
>> them in the DT.
>>
>> Regardless, the order of the list *must* be specified in the DT binding.
>
> I'm sorry for creating this confusion. It was a wrong workaround due 
> to my misunderstanding of the
> IRQ mapping.
> The MN will use a single IRQ for overflow in HiP07. I shall update it 
> and resend.
> But in HiP05/06 there is no support for this IRQ, So I shall modify to 
> use polling when IRQ is not available.
>

On further tests it is confirmed that the MN interrupt line is broken in 
hardware. so the driver
will only use poll method. I shall remove the IRQ support and resubmit 
adding poll method.

Thanks,
Anurup

> Thanks,
> Anurup
>
>> Thanks,
>> Mark.

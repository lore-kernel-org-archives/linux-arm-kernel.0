From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Thu, 10 Mar 2011 20:43:09 -0800
Subject: [Qualcomm PM8921 MFD v2 2/6] mfd: pm8xxx: Add irq support
In-Reply-To: <alpine.LFD.2.00.1103101126100.2787@localhost6.localdomain6>
References: <1299564590-30116-1-git-send-email-adharmap@codeaurora.org>
	<1299564590-30116-3-git-send-email-adharmap@codeaurora.org>
	<alpine.LFD.2.00.1103081201520.2787@localhost6.localdomain6>
	<4D770E47.6050402@codeaurora.org>
	<alpine.LFD.2.00.1103101126100.2787@localhost6.localdomain6>
Message-ID: <4D79A85D.8000301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:
> On Tue, 8 Mar 2011, Abhijeet Dharmapurikar wrote:
>> Thomas Gleixner wrote:
>>> On Mon, 7 Mar 2011, adharmap at codeaurora.org wrote:
>>>> +	if (pdata->irq_pdata) {
>>> So if pdata->irq_pdata == NULL you return success. Is that correct ?
>> Yes. The board configuration may choose not to use pmic interrupts.
> 
> Ok.
>  
>>> Also please return early on (!pdata->irq_pdata) and avoid that extra
>>> indent level for the real code path.
>> I did not do that because there are other subdevices that I will be adding in
>> the later patches. I cannot return early. well I will change it for this
>> patch.
> 
> Maybe splitting out the various init subsections into different
> functions which are called from here might be a good thing.
>  
>>>> +static void pm8xxx_irq_ack(struct irq_data *d)
>>>> +{
>>>> +	const struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
>>>> +	unsigned int pmirq = d->irq - chip->irq_base;
>>>> +	u8	block, config;
>>>> +
>>>> +	block = pmirq / 8;
>>>> +
>>>> +	config = PM_IRQF_WRITE | chip->config[pmirq] | PM_IRQF_CLR;
>>>> +	/* Keep the mask */
>>>> +	if (!(chip->irqs_allowed[block] & (1 << (pmirq % 8))))
>>>> +		config |= PM_IRQF_MASK_FE | PM_IRQF_MASK_RE;
>>> What's the point of this exercise? ack is called before mask and it
>> The register design is such that we cannot only clear the interrupt. One has
>> to write to the trigger bits while clearing it. Now trigger bits define
>> whether the interrupt is masked or unmasked. If unmasked they define whether
>> the interrupt rising/falling/level high/level low triggered.
>> So the code remembers which interrupts are masked and for them it clears and
>> rewrite the masked status in trigger bits. For unmasked ones it clears and
>> writes to the trigger bits essentially configuring them same way as it was
>> before. That is why the if satement to check interrupt was masked earlier,
>> chip->irqs_allowed[] maintains which interrupt are unmasked.
>>
>>> ack is called before mask and it
>>> should never be called when the interrupt is masked.
>> I didnt quite understand this comment. handle_level_irq calls mask_ack which
>> masks the interrupt and then acks it. In this case the ack is called after the
> 
> Indeed, sorry. So the right way to deal with that is to provide a
> mask_ack() callback which does it in the correct order for your
> HW. That way you avoid all the local state storage.


Yes however while updating the code I noticed that I would need to keep 
account of all the interrupts enabled and all the interrupts marked 
wakeup. This aids in switching to the wakeup set in the suspend callback 
and the enabled set in the resume callback. I will update the resume 
callback to enable the interrupts in irqs_allowed(the local state 
storage) in the next patch (my current patch does not do that).

IOW I need to keep the local state storage.


> 
> Thanks,
> 
> 	tglx


-- 
--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.

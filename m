From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 9 Feb 2015 18:37:04 +0800
Subject: [PATCH v2] ASoC: atmel_ssc_dai: Allow more rates
In-Reply-To: <8ce66bb3bcba46358e1283dcf02eb7f9@EMAIL.axentia.se>
References: <1423050745-6372-1-git-send-email-peda@lysator.liu.se>
 <54D824F8.9030804@atmel.com>
 <896ef5e9484a494e9e50cbed38919c5f@EMAIL.axentia.se>
 <54D871E7.40902@atmel.com>
 <5c8e49d8b0b3491b856eae50f4594f4f@EMAIL.axentia.se>
 <54D880E3.7070004@atmel.com>
 <8ce66bb3bcba46358e1283dcf02eb7f9@EMAIL.axentia.se>
Message-ID: <54D88DD0.6080305@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 02/09/2015 06:25 PM, Peter Rosin wrote:
> Bo Shen wrote:
>> Hi Peter,
>>
>
> Hi!
>
>> On 02/09/2015 05:07 PM, Peter Rosin wrote:
>>> Bo Shen wrote:
>>>> Hi Peter,
>>>>
>>>> On 02/09/2015 04:09 PM, Peter Rosin wrote:
>>>>
>>>> [Snip]
>>>>
>>>>>>>
>>>>>>>      /*-------------------------------------------------------------------------*\
>>>>>>>       * DAI functions
>>>>>>> @@ -200,6 +290,7 @@ static int atmel_ssc_startup(struct
>>>> snd_pcm_substream *substream,
>>>>>>>      	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
>>>>>>>      	struct atmel_pcm_dma_params *dma_params;
>>>>>>>      	int dir, dir_mask;
>>>>>>> +	int ret;
>>>>>>>
>>>>>>>      	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
>>>>>>>      		ssc_readl(ssc_p->ssc->regs, SR)); @@ -207,6 +298,7
>> @@
>>>> static
>>>>>>> int atmel_ssc_startup(struct snd_pcm_substream *substream,
>>>>>>>      	/* Enable PMC peripheral clock for this SSC */
>>>>>>>      	pr_debug("atmel_ssc_dai: Starting clock\n");
>>>>>>>      	clk_enable(ssc_p->ssc->clk);
>>>>>>> +	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk) * 2;
>>>>>>
>>>>>> Why the mck_rate is calculated in this form?
>>>>>
>>>>> What did you have in mind? Add another clock to the ssc node in the
>>>>> device tree?
>>>>>
>>>>> IIUC, the device tree (at least normally) has the ssc clk as the
>>>>> peripheral clock divided by 2, but the ssc specifies (when capturing
>>>>> in the CBM/CFS
>>>>> case) the rate limit as the peripheral clock divided by 3 (i.e. ssc clk / 1.5).
>>>>> Since the SSC spec expresses the rate limit in terms of the
>>>>> peripheral clock, this was what I came up with. I didn't want to require dt
>> changes...
>>>>
>>>> You make a misunderstand for the mck for ssc peripheral. The mck here
>>>> is not the system mck, it only related with the ssc, it is the PMC output.
>>>> For example, in device tree, the ssc clock divided by 2, then the pmc
>>>> output for ssc is "system mck / 2", so the ssc mck is "system mck / 2".
>>>> If divided by 4, then the ssc mck is "system / 4"
>>>
>>> I think the reason for my misunderstanding might be that in the
>>> 3.10-at91 tree, the ssc clk is twice the rate compared to what it is
>>> in the 3.18-at91 tree. This made me assume that the ssc clk had
>>
>> I think maybe you didn't use the latest linux-3.10-at91 code. In that code, we
>> also divided by 2 in device tree.
>
> That's a rather confusing statement. The clock tree isn't even managed
> by the device tree in linux-3.10-at91. Sure, there's the 12MHz system
> master clock in sama5d3.dtsi, but that's about it. The rest of the clocks
> are in arch/arm/mach-at91/sama5d3.c. And the part about ssc0/ssc1
> hasn't been updated since it was added in 3.9. What am I missing?

I am not sure what the kernel you are talking about now.

In linux-3.10-at91 branch on github.com/linux4sam/linux-at91. In the 
<arch/arm/mach-at91/sama5d3.c>

--->8---
static struct clk ssc0_clk = {
         .name           = "ssc0_clk",
         .pid            = SAMA5D3_ID_SSC0,
         .type           = CLK_TYPE_PERIPHERAL,
         .div            = AT91_PMC_PCR_DIV2,
};
static struct clk ssc1_clk = {
         .name           = "ssc1_clk",
         .pid            = SAMA5D3_ID_SSC1,
         .type           = CLK_TYPE_PERIPHERAL,
         .div            = AT91_PMC_PCR_DIV2,
};
---8<---

That means, the clock output from PMC is "system clock / 2" which will 
be fed to ssc (here we call it SSC peripheral clock = "system clock / 2").

>>> been changed to mean the rate after the fixed divider by two that is
>>> activated as soon as the ssc clock divider (given by SSC_CMR) is
>>> activated, and that it was a simple matter of multiplying by two to
>>> get to the MCK rate. I further assumed that "Master Clock" in the
>>> "Serial Clock Ratio Considerations" section was this MCK. Maybe the
>>> mistake was to involve the peripheral clock at all?
>>>
>>> Ok, so I may have misunderstood, but in that case what does that mean
>>> in terms of finding the "Master Clock" rate that is mentioned in the
>>> "Serial Clock Ratio Considerations" section? Is it perhaps the rate of
>>> the parent clock of the given ssc clk? Or, given the above
>>> explanation, is it correct to simply multiply by two as I have done?
>>
>> The "Master Clock" actually is the same as "Peripheral clock".
>>
>> Thanks for your information, I will send this to our datasheet team to update
>> this part.
>
> You are still not saying how to get to the "Master Clock" rate (i.e. the
> "Master Clock" that is mentioned in the "Serial Clock Ratio Considerations"
> section. You are only implying that multiplying the ssc clock rate with 2 is
> wrong for some reason.

I mean in that section you mentioned. The "Master Clock" is the same as 
"Peripheral Clock". So, you get the SSC peripheral clock is what the 
clock ("Master Clock") you try to get ( clk_get_rate(ssc_p->ssc->clk)).

> Are you saying that the ssc clock is supposed to be this "Master Clock"?
>
> Cheers,
> Peter
>

Best Regards,
Bo Shen

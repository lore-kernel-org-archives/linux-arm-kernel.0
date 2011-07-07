From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 07 Jul 2011 14:23:34 +0300
Subject: [PATCH 3/4] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <CALZhoSRG5Lsx7twK9A4h0hnj0vsJiWFad_u+Z3kHQ-eH5_waCQ@mail.gmail.com>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>	<1309771536-10597-4-git-send-email-leiwen@marvell.com>	<4E1411BB.4010000@compulab.co.il>	<CALZhoSQgoMS7bSRx1V-tMX+aG4idF6Z-Xr3CorFSXwPMHvacXw@mail.gmail.com>	<4E157561.6060600@compulab.co.il>
	<CALZhoSRG5Lsx7twK9A4h0hnj0vsJiWFad_u+Z3kHQ-eH5_waCQ@mail.gmail.com>
Message-ID: <4E159736.5030706@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/11 12:06, Lei Wen wrote:

> Hi Igor,
>
> On Thu, Jul 7, 2011 at 4:59 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> On 07/07/11 09:26, Lei Wen wrote:
>>
>>> Hi Igor && Daniel,
>>>
>>> On Wed, Jul 6, 2011 at 3:41 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>>> On 07/04/11 12:25, Lei Wen wrote:
>>>>
>>>>>  #ifdef CONFIG_PM
>>>>> @@ -1203,8 +1259,12 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
>>>>>  {
>>>>>       struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
>>>>>
>>>>> -     nand_writel(info, NDTR0CS0, info->host->ndtr0cs0);
>>>>> -     nand_writel(info, NDTR1CS0, info->host->ndtr1cs0);
>>>>> +     /*
>>>>> +      * Directly set the chip select to a invalid value,
>>>>> +      * then the driver would reset the timing according
>>>>> +      * to current chip select at the beginning of cmdfunc
>>>>> +      */
>>>>> +     info->cs = 0xff;
>>>> Thinking of this for the second (or third) time,
>>>> If you have keep config enabled and have only one nand chip,
>>>> this will brake the keep config...
>>>>
>>>> Daniel,
>>>>
>>>> have you tested the suspend/resume with this patch?
>>>> (and keep_config on?)
>>>>
>>> Do you still have concern with this change?
>>> If not, I would push the next round of patch set including merging
>>> patch 3 and 4.
>> Though I can't test it right now, but yes it looks like it breaks
>> the keep_config after the resume (actually it disables the keep_config silently).
>>
>> I think you need here some kind of check if keep_config is enabled.
>> keep_config is enabled means that only one chip select is used for NAND
>> and you don't need to reset the timings.
> It would not break anything.
> The value rewrite to timing register is the one that save in the
> pxa3xx_nand_detect_config.
> And it is the same behavior before this patch apply.

Right. I've missed this. Thanks for the explanation.

-- 
Regards,
Igor.

From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 17 May 2013 10:28:52 +0530
Subject: [PATCH] ARM: davinci: dma: Convert to devm_* api
In-Reply-To: <5194DC6A.8080609@cogentembedded.com>
References: <1368687502-15551-1-git-send-email-prabhakar.csengg@gmail.com>
 <5194DC6A.8080609@cogentembedded.com>
Message-ID: <CA+V-a8v89gGuGuZB75-LnYNP7G765RnaY9uwviNwPmY-vQzPVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thanks for the review.

On Thu, May 16, 2013 at 6:47 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 16-05-2013 10:58, Lad Prabhakar wrote:
>
>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>
>
>> Use devm_ioremap_resource instead of reques_mem_region()/ioremap() and
>> devm_request_irq() instead of request_irq().
>
>
>> This ensures more consistent error values and simplifies error paths.
>
>
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> ---
>>   NOte:- Boot tested on Logic-PD OMAP-L138 EVM
>
>
>>   arch/arm/mach-davinci/dma.c |   63
>> ++++++++++++++++--------------------------
>>   1 files changed, 24 insertions(+), 39 deletions(-)
>
>
>> diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
>> index 45b7c71..aeda496 100644
>> --- a/arch/arm/mach-davinci/dma.c
>> +++ b/arch/arm/mach-davinci/dma.c
>
> [...]
>
>> @@ -1422,25 +1421,16 @@ static int __init edma_probe(struct
>> platform_device *pdev)
>>                         found = 1;
>>                 }
>>
>> -               len[j] = resource_size(r[j]);
>> -
>> -               r[j] = request_mem_region(r[j]->start, len[j],
>> -                       dev_name(&pdev->dev));
>> -               if (!r[j]) {
>> -                       status = -EBUSY;
>> -                       goto fail1;
>> -               }
>> -
>> -               edmacc_regs_base[j] = ioremap(r[j]->start, len[j]);
>> -               if (!edmacc_regs_base[j]) {
>> +               edmacc_regs_base[j] = devm_ioremap_resource(&pdev->dev,
>> r[j]);
>> +               if (IS_ERR(edmacc_regs_base[j])) {
>>                         status = -EBUSY;
>
>
>    And you call that "more consistent error values"? Why not:
>
>                         status = PTR_ERR(edmacc_regs_base[j]);
>
Yes missed it will fix it in v2.

>
>>                 edma_cc[j] = kzalloc(sizeof(struct edma), GFP_KERNEL);
>
>
>    Maybe it's worth using devm_kzalloc() too?
>
OK

Regards,
--Prabhakar Lad

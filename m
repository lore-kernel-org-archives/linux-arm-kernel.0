From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 18 Nov 2013 21:32:36 +0200
Subject: [PATCH 10/12] mtd: nand: davinci: don't set timings if AEMIF
 is used
In-Reply-To: <528A1F4D.6050404@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-11-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8D53@DNCE04.ent.ti.com>
 <528253B7.2060408@ti.com> <5289FB9C.6060204@ti.com> <528A1F4D.6050404@ti.com>
Message-ID: <528A6B54.3080609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 04:08 PM, Santosh Shilimkar wrote:
> On Monday 18 November 2013 06:35 AM, Grygorii Strashko wrote:
>> On 11/12/2013 06:13 PM, Santosh Shilimkar wrote:
>>> On Monday 11 November 2013 12:10 PM, Khoronzhuk, Ivan wrote:
>>>> If Davinci AEMIF is used we don't need to set timings and bus width.
>>>> It is done by AEMIF driver (drivers/memory/davinci-aemfi.c).
>>>>
>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>>> ---
>>>>    drivers/mtd/nand/davinci_nand.c |   22 +++++++++++++++-------
>>>>    1 file changed, 15 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
>>>> index 4705214..879e915 100644
>>>> --- a/drivers/mtd/nand/davinci_nand.c
>>>> +++ b/drivers/mtd/nand/davinci_nand.c
>>>> @@ -742,27 +742,35 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
>>>>                   goto err_clk_enable;
>>>>           }
>>>>
>>>> +#if !IS_ENABLED(CONFIG_TI_DAVINCI_AEMIF)
>>>>
>>> Instead above #if, just use a variable.
>>>      bool aemif = IS_ENABLED(CONFIG_TI_DAVINCI_AEMIF) and then skip
>>> the below code. #if block in the middle of the code looks ugly.
>>
>> Yes, this is the hack.
>> The problem is that this part of code contains the call of Davinci platform function davinci_aemif_setup_timing() which is not accessible if Kernel is built for Keystone only.
>> That's why "#if" has been used.
>>
>> This part of code has to be removed together with Davinci aemif platform code (aemif.c), once Davinci will be converted to DT and use
>> new driver.
>>
>> The corresponding comment can be added here. Is it ok?
>>
> Thats more or less what I proposed in another reply. Lets clearly
> document it on why such a check was added.
>
> Regards,
> Santosh
>

Ok, I'll add more explanation on it.

-- 
Regards,
Ivan Khoronzhuk

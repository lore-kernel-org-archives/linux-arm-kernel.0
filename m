From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 18 Nov 2013 21:35:22 +0200
Subject: [PATCH 10/12] mtd: nand: davinci: don't set timings if AEMIF
 is used
In-Reply-To: <5284DFE7.70308@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-11-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8D53@DNCE04.ent.ti.com>
 <528307F0.6000805@ti.com> <52838941.4060207@ti.com> <5284ABB9.70608@ti.com>
 <5284DFE7.70308@ti.com>
Message-ID: <528A6BFA.3030007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2013 04:36 PM, Santosh Shilimkar wrote:
> On Thursday 14 November 2013 05:53 AM, Nori, Sekhar wrote:
>> On Wednesday 13 November 2013 07:44 PM, Santosh Shilimkar wrote:
>>> On Wednesday 13 November 2013 12:02 AM, Sekhar Nori wrote:
>>>> On Monday 11 November 2013 10:40 PM, Khoronzhuk, Ivan wrote:
>>>>> If Davinci AEMIF is used we don't need to set timings and bus width.
>>>>> It is done by AEMIF driver (drivers/memory/davinci-aemfi.c).
>>>>>
>>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>>>> ---
>>>>>   drivers/mtd/nand/davinci_nand.c |   22 +++++++++++++++-------
>>>>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
>>>>> index 4705214..879e915 100644
>>>>> --- a/drivers/mtd/nand/davinci_nand.c
>>>>> +++ b/drivers/mtd/nand/davinci_nand.c
>>>>> @@ -742,27 +742,35 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
>>>>>                  goto err_clk_enable;
>>>>>          }
>>>>>
>>>>> +#if !IS_ENABLED(CONFIG_TI_DAVINCI_AEMIF)
>>>>
>>>> This is a hack! Just because AEMIF driver is enabled, it does not
>>>> guarantee that the timings have been setup by it. Instead of configuring
>>>> timings in two drivers, why not just convert everyone over to use the
>>>> new driver. Dont worry about breaking old platforms, I will help test
>>>> and ack them.
>>>>
>>> How about you take a stab at and convert the DaVinci code over to make
>>> use of new driver. We are trying to re-use as much as possible from the
>>> common drivers and also making an option so that the DaVinci arch can
>>> move over to these drivers if they want to.
>>
>> Sure I could.
>>
> Thanks
>
>> Ivan,
>>
>> The AEMIF driver does not use platfrom_data currently. Is that something
>> you can add or you want me to take a stab at that as well?
>>
> The AEMIF new driver is device tree only and thats the direction. So the
> better thing would be to convert Davinci to DT and then make use of this
> new driver. Thats how most of the new drivers used on arm socs are
> moving. Adding platform data to new driver is a step in backward
> direction so I would want to avoid that.
>
> Once you start using new driver the $subject patch code skipping
> is trivial. Till then I would like to proceed with current approach
> which allows Nand support for Keystone.
>
> Regards,
> Santosh
>

Agree with Santosh

-- 
Regards,
Ivan Khoronzhuk

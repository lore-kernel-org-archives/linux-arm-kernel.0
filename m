From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 14 Nov 2013 16:23:45 +0530
Subject: [PATCH 10/12] mtd: nand: davinci: don't set timings if AEMIF
 is used
In-Reply-To: <52838941.4060207@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-11-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8D53@DNCE04.ent.ti.com>
 <528307F0.6000805@ti.com> <52838941.4060207@ti.com>
Message-ID: <5284ABB9.70608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 November 2013 07:44 PM, Santosh Shilimkar wrote:
> On Wednesday 13 November 2013 12:02 AM, Sekhar Nori wrote:
>> On Monday 11 November 2013 10:40 PM, Khoronzhuk, Ivan wrote:
>>> If Davinci AEMIF is used we don't need to set timings and bus width.
>>> It is done by AEMIF driver (drivers/memory/davinci-aemfi.c).
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>> ---
>>>  drivers/mtd/nand/davinci_nand.c |   22 +++++++++++++++-------
>>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
>>> index 4705214..879e915 100644
>>> --- a/drivers/mtd/nand/davinci_nand.c
>>> +++ b/drivers/mtd/nand/davinci_nand.c
>>> @@ -742,27 +742,35 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
>>>                 goto err_clk_enable;
>>>         }
>>>
>>> +#if !IS_ENABLED(CONFIG_TI_DAVINCI_AEMIF)
>>
>> This is a hack! Just because AEMIF driver is enabled, it does not
>> guarantee that the timings have been setup by it. Instead of configuring
>> timings in two drivers, why not just convert everyone over to use the
>> new driver. Dont worry about breaking old platforms, I will help test
>> and ack them.
>>
> How about you take a stab at and convert the DaVinci code over to make
> use of new driver. We are trying to re-use as much as possible from the
> common drivers and also making an option so that the DaVinci arch can
> move over to these drivers if they want to.

Sure I could.

Ivan,

The AEMIF driver does not use platfrom_data currently. Is that something
you can add or you want me to take a stab at that as well?

Thanks,
Sekhar

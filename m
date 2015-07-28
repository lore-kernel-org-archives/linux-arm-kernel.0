From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 28 Jul 2015 08:51:45 +0800
Subject: [PATCH] mmc: sdhci-of-arasan: Get quirks from device tree
In-Reply-To: <55B64BFF.8030909@metafoo.de>
References: <1437984249-18332-1-git-send-email-shawn.lin@rock-chips.com>
 <55B64BFF.8030909@metafoo.de>
Message-ID: <55B6D221.8090600@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/7/27 23:19, Lars-Peter Clausen wrote:
> On 07/27/2015 10:04 AM, Shawn Lin wrote:
>> This patch adds the interface to get quirks from dts, and
>> there is no need to assign different quirks by condition statement
>> of arasan IP version.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c 
>> b/drivers/mmc/host/sdhci-of-arasan.c
>> index ef5a7d2..db07788 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -132,6 +132,7 @@ static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, 
>> sdhci_arasan_suspend,
>>   static int sdhci_arasan_probe(struct platform_device *pdev)
>>   {
>>       int ret;
>> +    u32 quirktab[2];
>>       struct clk *clk_xin;
>>       struct sdhci_host *host;
>>       struct sdhci_pltfm_host *pltfm_host;
>> @@ -172,6 +173,12 @@ static int sdhci_arasan_probe(struct 
>> platform_device *pdev)
>>           goto clk_disable_all;
>>       }
>>
>> +    if (of_property_read_u32_array(pdev->dev.of_node,
>> +                       "arasan,quirks", &quirktab[0], 2)) {
>> +        host->quirks |= quirktab[0];
>> +        host->quirks2 |= quirktab[1];
>> +    }
>
> The quirks are part of the Linux internal API, making them part of the 
> public ABI is not necessarily the best idea. It means they become 
> fixed, you can't remove any quirk types, can't change any quirk type, 
> nor can add new quirk types.
>
Thank for your kindly reply, Lars.  It seems I have lots to learn if I 
want to get involved in upstream :)
So this patch is inappropriate for kernel.
> - Lars
>
>
>
>

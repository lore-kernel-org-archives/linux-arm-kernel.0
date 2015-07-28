From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 28 Jul 2015 09:07:14 +0800
Subject: [PATCH] mmc: sdhci-of-arasan: Get quirks from device tree
In-Reply-To: <55B5EA96.6020604@monstr.eu>
References: <1437984249-18332-1-git-send-email-shawn.lin@rock-chips.com>
 <55B5EA96.6020604@monstr.eu>
Message-ID: <55B6D5C2.4080907@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/7/27 16:23, Michal Simek wrote:
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
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index ef5a7d2..db07788 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -132,6 +132,7 @@ static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>>   static int sdhci_arasan_probe(struct platform_device *pdev)
>>   {
>>   	int ret;
>> +	u32 quirktab[2];
>>   	struct clk *clk_xin;
>>   	struct sdhci_host *host;
>>   	struct sdhci_pltfm_host *pltfm_host;
>> @@ -172,6 +173,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>   		goto clk_disable_all;
>>   	}
>>   
>> +	if (of_property_read_u32_array(pdev->dev.of_node,
>> +				       "arasan,quirks", &quirktab[0], 2)) {
> This is not documented anywhere that's why you should send binding to DT
> mailing list and get ACK for it.
Thanks, Michal. You'r right, and  forgive me, a green hand, for my 
inappropriate patch.
>> +		host->quirks |= quirktab[0];
>> +		host->quirks2 |= quirktab[1];
>> +	}
>> +
>>   	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
>>   		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>>   		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>>
> Also is there any binding which is done in this way?
Thanks.
BTW:
I got a FPGA board w/ a sdhci-arasn emmc controller & PHY IP which can 
support emmc version 5.1.
But I cannot find any documented details from  IP databook for the 
vendor version, such as "sdhci-4.9a".
The only one is "ACS eMMC5.1 PHY IP uses TSMC ESD I/O protection 
structures TMSC  product name
tphn28hpcgv2od3 Version 120a". Is "sdhci-120a" the version if  I add a 
compatib node?
Kindly hope you can elaborate more ?)
> Thanks,
> Michal
>

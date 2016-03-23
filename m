From: blogic@openwrt.org (John Crispin)
Date: Wed, 23 Mar 2016 10:07:28 +0100
Subject: [PATCH] net: mediatek: fix checking for NULL instead of IS_ERR()
 in .probe
In-Reply-To: <56F25B42.5030005@gmail.com>
References: <1458687964-9690-1-git-send-email-vz@mleia.com>
 <56F25B42.5030005@gmail.com>
Message-ID: <56F25CD0.5070806@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/03/2016 10:00, Matthias Brugger wrote:
> 
> 
> On 23/03/16 00:06, Vladimir Zapolskiy wrote:
>> devm_ioremap_resource() returns ERR_PTR() value on error, it never
>> returns NULL, fix it and propagate the returned error upwards.
>>
>> Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623
>> ethernet")
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> 

Acked-by: John Crispin <blogic@openwrt.org>

Thanks for the fix !


>>   drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>> b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>> index 7f2126b..e0b68af 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>> @@ -1690,8 +1690,8 @@ static int mtk_probe(struct platform_device *pdev)
>>           return -ENOMEM;
>>
>>       eth->base = devm_ioremap_resource(&pdev->dev, res);
>> -    if (!eth->base)
>> -        return -EADDRNOTAVAIL;
>> +    if (IS_ERR(eth->base))
>> +        return PTR_ERR(eth->base);
>>
>>       spin_lock_init(&eth->page_lock);
>>
>>

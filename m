From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 8 Jul 2016 14:47:21 +0200
Subject: [PATCH v7 2/4] soc: mediatek: Init MT8173 scpsys driver earlier
In-Reply-To: <1467782540.26485.11.camel@mtksdaap41>
References: <1463390894-32062-1-git-send-email-jamesjj.liao@mediatek.com>
 <1463390894-32062-3-git-send-email-jamesjj.liao@mediatek.com>
 <34025ec4-19d3-8b25-d669-50c6f19159cd@gmail.com>
 <1467782540.26485.11.camel@mtksdaap41>
Message-ID: <577FA0D9.8070408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/07/16 07:22, James Liao wrote:
> On Sat, 2016-07-02 at 18:35 +0200, Matthias Brugger wrote:
>>
>> On 05/16/2016 11:28 AM, James Liao wrote:
>>> Some power domain comsumers may init before module_init.
>>> So the power domain provider (scpsys) need to be initialized
>>> earlier too.
>>>
>>> Take an example for our IOMMU (M4U) and SMI. SMI is a bridge
>>> between IOMMU and multimedia HW. SMI is responsible to
>>> enable/disable iommu and help transfer data for each multimedia
>>> HW. Both of them have to wait until the power and clocks are
>>> enabled.
>>>
>>> So scpsys driver should be initialized before SMI, and SMI should
>>> be initialized before IOMMU, and then init IOMMU consumers
>>> (display/vdec/venc/camera etc.).
>>>
>>> IOMMU is subsys_init by default. So we need to init scpsys driver
>>> before subsys_init.
>>>
>>> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
>>> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>>> ---
>>>   drivers/soc/mediatek/mtk-scpsys.c | 19 ++++++++++++++++++-
>>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
>>> index 5870a24..00c0adb 100644
>>> --- a/drivers/soc/mediatek/mtk-scpsys.c
>>> +++ b/drivers/soc/mediatek/mtk-scpsys.c
>>> @@ -617,4 +617,21 @@ static struct platform_driver scpsys_drv = {
>>>   		.of_match_table = of_match_ptr(of_scpsys_match_tbl),
>>>   	},
>>>   };
>>> -builtin_platform_driver(scpsys_drv);
>>> +
>>> +static int __init scpsys_drv_init(void)
>>> +{
>>> +	return platform_driver_register(&scpsys_drv);
>>> +}
>>> +
>>> +/*
>>> + * There are some Mediatek drivers which depend on the power domain driver need
>>> + * to probe in earlier initcall levels. So scpsys driver also need to probe
>>> + * earlier.
>>> + *
>>> + * IOMMU(M4U) and SMI drivers for example. SMI is a bridge between IOMMU and
>>> + * multimedia HW. IOMMU depends on SMI, and SMI is a power domain consumer,
>>> + * so the proper probe sequence should be scpsys -> SMI -> IOMMU driver.
>>> + * IOMMU drivers are initialized during subsys_init by default, so we need to
>>> + * move SMI and scpsys drivers to subsys_init or earlier init levels.
>>> + */
>>> +subsys_initcall(scpsys_drv_init);
>>>
>>
>> Can't we achieve this with probe deferring? I'm not really keen on
>> coding the order of the different drivers like this.
>
> Hi Matthias,
>
> Some drivers such as IOMMU don't support probe deferring. So scpsys need
> to init before them by changing init level.
>

SMI larbs return EPROBE_DEFER if it can't find the PM provider for it's 
domain, so this part should not be the problem. The larbs get added as 
components in the probe, when the PM provider is present.

The iommu driver uses the larbs as components. As long as not all 
components are present the iommu does not bind them. So from what I see 
this should work without any problem.

Can you please specify where the iommu dirver has a problem. Maybe we 
need to fix the driver rather then scpsys.

Regards,
Matthias

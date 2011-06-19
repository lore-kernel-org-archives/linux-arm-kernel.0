From: robherring2@gmail.com (Rob Herring)
Date: Sun, 19 Jun 2011 10:09:15 -0500
Subject: [PATCH 2/3] net/fec: add device tree support
In-Reply-To: <201106191411.32137.arnd@arndb.de>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>	<1308410354-21387-3-git-send-email-shawn.guo@linaro.org>	<4DFDDFF4.8000305@snapgear.com>
	<201106191411.32137.arnd@arndb.de>
Message-ID: <4DFE111B.8010001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2011 07:11 AM, Arnd Bergmann wrote:
> On Sunday 19 June 2011 13:39:32 Greg Ungerer wrote:
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id fec_dt_ids[] = {
>>> +     { .compatible = "fsl,fec", .data =&fec_devtype[0], },
>>> +     {},
>>> +};
>>> +
>>> +static const struct of_device_id *
>>> +fec_get_of_device_id(struct platform_device *pdev)
>>> +{
>>> +     return of_match_device(fec_dt_ids,&pdev->dev);
>>> +}
>>> +#else
>>> +#define fec_dt_ids NULL
>>> +static inline struct of_device_id *
>>> +fec_get_of_device_id(struct platform_device *pdev)
>>> +{
>>> +     return NULL;
>>> +}
>>> +#endif
>>> +
>>>   static unsigned char macaddr[ETH_ALEN];
>>>   module_param_array(macaddr, byte, NULL, 0);
>>>   MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>>> @@ -1363,6 +1385,11 @@ fec_probe(struct platform_device *pdev)
>>>       struct net_device *ndev;
>>>       int i, irq, ret = 0;
>>>       struct resource *r;
>>> +     const struct of_device_id *of_id;
>>> +
>>> +     of_id = fec_get_of_device_id(pdev);
>>
>> fec_get_of_device_id() is defined inside of "#ifdef CONFIG_OF". This
>> use of it will break compilation when this is not defined.
>>
> 
> 
> Why? Note the #else path defining an empty function.
> 

None of this is necessary in the first place. Just call of_match_device
directly. There is already an empty function to return NULL when
CONFIG_OF is not defined.

Rob

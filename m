From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 12 Jun 2012 12:46:50 -0500
Subject: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E997E0F@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
 <4FD6555D.4000508@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997E0F@DBDE01.ent.ti.com>
Message-ID: <4FD7808A.1040806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/12/2012 02:09 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> This change is required only till driver migration of all platforms
> are done, after it, this hackish patch has to be reverted. This has
> been done so that existing interface will work for each patch of
> this series as well as till all boards are migrated.
> 
> On Tue, Jun 12, 2012 at 02:00:21, Hunter, Jon wrote:
> 
>>>  __init int omap_gpmc_init(struct gpmc_pdata *pdata)
>>>  {
>>>  	struct omap_hwmod *oh;
>>> -	struct platform_device *pdev;
>>> +	static struct platform_device *pdev;
>>>  	char *name = "omap-gpmc";
>>>  	char *oh_name = "gpmc";
>>>  
>>> @@ -912,6 +912,12 @@ __init int omap_gpmc_init(struct gpmc_pdata *pdata)
>>>  		return -ENODEV;
>>>  	}
>>>  
>>> +	if (pdev != NULL) {
>>> +		clk_put(gpmc_l3_clk);
>>> +		omap_device_delete(pdev->archdata.od);
>>> +		platform_device_unregister(pdev);
>>> +	}
>>> +
>>
>> I am not sure if I am missing something, but it appears that pdev will
>> always be NULL here as it is a local uninitialised variable.
> 
> omap_gpmc_init will be called by board files once again, at that time,
> existing omap device will be destroyed (resulting in driver remove being
> executed, and inverse of omap_device_build is not available, hence
> doing circus as above). Again omap device will be created, this time
> with details about gpmc peripherals (first time, there were no
> peripheral details provided, and this was done for old interface to work
> with same driver), once this happens new interface will starting it's job.
> 
> This kind of change was required as old interface works at arch_init

Ok, make sense. Then please label with a FIXME.

>  > +static int __init gpmc_pre_init(void)
>>> +{
>>> +	static struct gpmc_device_pdata *gpmc_device_data[1];
>>> +	struct gpmc_pdata gpmc_data = {
>>> +		.device_pdata	= gpmc_device_data,
>>> +	};
>>> +
>>> +	return omap_gpmc_init(&gpmc_data);
>>> +}
>>> +postcore_initcall(gpmc_pre_init);
>>> +
>>
>> Not sure I see the point in the above function. Why not declare the
>> gpmc_device_data struct as static in the file and access it directly
>> instead of passing it in omap_gpmc_init(). The postcore_init can then
>> call omap_gpmc_init() directly.
> 
> Can be done, but it is not necessary to make it available outside the
> function

Ok, I see that this is necessary until all boards are migrated. However,
please label with a FIXME to make it clear that this is to be removed.

Jon

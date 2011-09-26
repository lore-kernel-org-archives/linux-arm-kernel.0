From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 26 Sep 2011 14:13:04 +0200
Subject: [PATCH 10/11] arm/dts: OMAP4: Add a main ocp entry bound to l3-noc
	driver
In-Reply-To: <20110923225825.GB6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
	<1316809399-19579-11-git-send-email-b-cousson@ti.com>
	<20110923225825.GB6324@atomide.com>
Message-ID: <4E806C50.80300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/24/2011 12:58 AM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [110923 12:50]:
>> Used the main OCP node to add bindings with the l3_noc driver.
>> Remove l3_noc static device creation if DT is populated.
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -16,6 +16,7 @@
>>   #include<linux/clk.h>
>>   #include<linux/err.h>
>>   #include<linux/slab.h>
>> +#include<linux/of.h>
>>
>>   #include<mach/hardware.h>
>>   #include<mach/irqs.h>
>> @@ -77,6 +78,10 @@ static int __init omap4_l3_init(void)
>>   	struct platform_device *pdev;
>>   	char oh_name[L3_MODULES_MAX_LEN];
>>
>> +	/* If dtb is there, the devices will be created dynamically */
>> +	if (of_have_populated_dt())
>> +		return -ENODEV;
>> +
>>   	/*
>>   	 * To avoid code running on other OMAPs in
>>   	 * multi-omap builds
>
> How about just remove omap3_l3_init and omap4_l3_init completely
> instead?
>
> There should not be any need for the platform glue code if the
> driver, it's OK for us to require that either DT is passed from
> the bootloader or as appended DT as soon as the appended DT patches
> are merged.

Yeah, but we should still allow the others board files to work in case 
DT is not passed by the bootloader. Otherwise the DT support need to be 
added to every other boards, and in that case that generic board become 
useless. The effort / duplication will be much important if we start 
hacking every boards with some DT code in them.

Whereas that code is simple and will be removed easily when the DT 
migration will be completed.

Regards,
Benoit

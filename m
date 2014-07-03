From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 3 Jul 2014 10:17:12 +0000
Subject: [PATCH 4/5] ARM: imx: Add initial support for Freescale LS1021A
In-Reply-To: <20140702112125.GE14665@leverpostej>
References: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
 <1404291772-2644-5-git-send-email-jingchang.lu@freescale.com>
 <20140702112125.GE14665@leverpostej>
Message-ID: <cb01fef2c4d44711b04a321fddae33d4@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Mark Rutland [mailto:mark.rutland at arm.com]
>Sent: Wednesday, July 02, 2014 7:21 PM
>To: Lu Jingchang-B35083
>Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org;
>devicetree at vger.kernel.org; Lu Jingchang-B35083
>Subject: Re: [PATCH 4/5] ARM: imx: Add initial support for Freescale
>LS1021A
>
>On Wed, Jul 02, 2014 at 10:02:51AM +0100, Jingchang Lu wrote:
>> From: Jingchang Lu <b35083@freescale.com>
>>
>> diff --git a/arch/arm/mach-imx/mach-ls1021a.c
>> b/arch/arm/mach-imx/mach-ls1021a.c
>> new file mode 100644
>> index 0000000..d1a9bb9
>> --- /dev/null
>> +++ b/arch/arm/mach-imx/mach-ls1021a.c
>> @@ -0,0 +1,49 @@
>> +/*
>> + * Copyright 2013-2014 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> +modify
>> + * it under the terms of the GNU General Public License as published
>> +by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/of_platform.h>
>> +#include <asm/mach/arch.h>
>> +
>> +#include "common.h"
>> +
>> +static const struct of_device_id of_ls1021a_match_table[] = {
>> +	{
>> +		.compatible =	"simple-bus",
>> +	},
>> +	{
>> +		.compatible     = "fsl,ifc",
>> +	},
>> +	{
>> +		.compatible	= "fsl,fpga-qixis",
>> +	},
>> +	{
>> +		.compatible	= "fsl,qe",
>> +	},
>> +	{}
>> +};
>
>Are any of thse not always-on (or default-on) MMIO busses?
>
>Is there any reason for not giving them their own drivers?
>
Normally these are always-on. The child nodes are handled by different drivers,
so to make the devices being added by the of system, they are claimed here.
Thanks.
>> +
>> +static void __init ls1021a_init_machine(void) {
>> +	mxc_arch_reset_init_dt();
>
>This looks to only be used to set up a watchdog timer. Is there any reason
>this logic can't be moved to the watchdog timer driver?
>
>> +
>> +DT_MACHINE_START(LS1021A, "Freescale LS1021A") #ifdef CONFIG_ZONE_DMA
>> +	.dma_zone_size	= SZ_128M,
>> +#endif
>> +	.init_machine   = ls1021a_init_machine,
>> +	.dt_compat	= ls1021a_dt_compat,
>> +	.restart	= mxc_restart,
>
>AFAICT, that jsut uses the WDT for restart. Why can't the watchdog driver
>register itself as a restart device?
>
>That would bring us close to an empty machine descriptor, and enable reuse
>of the WDT and those busses.
>
>Thanks,
>Mark.
Yes, we use the watchdog timer for restart, just as i.MX and Vybrid, the WDT as a
common driver it is still work for watchdog. Thanks.

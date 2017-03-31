From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 31 Mar 2017 09:03:34 +0200
Subject: [PATCH V2 2/2] thermal: broadcom: add Northstar thermal driver
In-Reply-To: <20170324143535.GA31953@broadcom.com>
References: <20170318155632.18099-1-zajec5@gmail.com>
 <20170323223045.15786-1-zajec5@gmail.com>
 <20170323223045.15786-2-zajec5@gmail.com>
 <20170324143535.GA31953@broadcom.com>
Message-ID: <d678d252-a95a-58c0-8098-4401c67040a1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2017 03:35 PM, Jon Mason wrote:
> On Thu, Mar 23, 2017 at 11:30:45PM +0100, Rafa? Mi?ecki wrote:
>> diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
>> new file mode 100644
>> index 000000000000..acf3a4de62a4
>> --- /dev/null
>> +++ b/drivers/thermal/broadcom/ns-thermal.c
>> @@ -0,0 +1,98 @@
>> +/*
>> + * Copyright (C) 2017 Rafa? Mi?ecki <rafal@milecki.pl>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/thermal.h>
>> +
>> +#define PVTMON_CONTROL0					0x00
>> +#define PVTMON_CONTROL0_SEL_MASK			0x0000000e
>> +#define PVTMON_CONTROL0_SEL_TEMP_MONITOR		0x00000000
>> +#define PVTMON_CONTROL0_SEL_TEST_MODE			0x0000000e
>> +#define PVTMON_STATUS					0x08
>> +
>> +struct ns_thermal {
>> +	void __iomem *pvtmon;
>> +};
>> +
>> +static int ns_thermal_get_temp(void *data, int *temp)
>> +{
>> +	struct ns_thermal *ns_thermal = data;
>> +	u32 val;
>> +
>> +	val = readl(ns_thermal->pvtmon + PVTMON_CONTROL0);
>> +	if ((val & PVTMON_CONTROL0_SEL_MASK) != PVTMON_CONTROL0_SEL_TEMP_MONITOR) {
>> +		val &= ~PVTMON_CONTROL0_SEL_MASK;
>> +		val |= PVTMON_CONTROL0_SEL_TEMP_MONITOR;
>
> I think this is slightly confusing here.  If this was off, ORing in 0
> will not enable it.  I think we need to flip the #define to make it
> PVTMON_CONTROL0_SEL_TEMP_MONITOR_DISABLE (or a less crappy name).
> then use this line here to toggle it.  Something like
>
>                 val &= ~PVTMON_CONTROL0_SEL_TEMP_MONITOR_DISABLE;

I don't understand this, can you help me further?

OR-ing with 0 is only a cosmetic thing obviously - just to make it clear which
value we expect to be set in bits 1:3. The important part is:
val &= ~PVTMON_CONTROL0_SEL_MASK;

AFAIU selecting any mode other than TEMP_MONITOR will disable monitor access.
AFAIU even switchint to TEST_MODE will prevent access to temp, so I don't see
how we could use PVTMON_CONTROL0_SEL_TEMP_MONITOR_DISABLE. It could be any
value other than 0.

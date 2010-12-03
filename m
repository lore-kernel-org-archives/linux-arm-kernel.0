From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Dec 2010 14:48:25 +0100
Subject: [PATCH 3/4] plat-s5p: Add platform support for MIPI-CSI2 devices
In-Reply-To: <012501cb92a6$0cf6fa10$26e4ee30$%kim@samsung.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-4-git-send-email-s.nawrocki@samsung.com>
	<012501cb92a6$0cf6fa10$26e4ee30$%kim@samsung.com>
Message-ID: <4CF8F529.1010603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/03/2010 05:53 AM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
>>
>> There may be up to 2 MIPI-CSI2 interfaces depending on SoC version.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/plat-s5p/Kconfig                 |   10 ++++++++
>>  arch/arm/plat-s5p/Makefile                |    2 +
>>  arch/arm/plat-s5p/dev-csis0.c             |   34
>> +++++++++++++++++++++++++++++
>>  arch/arm/plat-s5p/dev-csis1.c             |   33
>> ++++++++++++++++++++++++++++
>>  arch/arm/plat-samsung/include/plat/csis.h |   28 +++++++++++++++++++++++
>>  arch/arm/plat-samsung/include/plat/devs.h |    3 ++
>>  6 files changed, 110 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/plat-s5p/dev-csis0.c
>>  create mode 100644 arch/arm/plat-s5p/dev-csis1.c
>>  create mode 100644 arch/arm/plat-samsung/include/plat/csis.h
>>
>> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
>> index 65dbfa8..2fb0c88 100644
>> --- a/arch/arm/plat-s5p/Kconfig
>> +++ b/arch/arm/plat-s5p/Kconfig
>> @@ -56,3 +56,13 @@ config S5P_DEV_ONENAND
>>  	bool
>>  	help
>>  	  Compile in platform device definition for OneNAND controller
>> +
>> +config S5P_DEV_CSIS0
>> +	bool
>> +	help
>> +	  Compile in platform device definitions for MIPI-CSI2 interface 0
> 
> MIPI-CSI2...you mean MIPI-CSI version 2. We _really_ need to separate the
> version here?

Yup, version 2. Maybe that was not a best place for such an information..

> How about just for MIPI-CSIS channel 0 ?

Ok, will change that, sounds better.

> 
>> +
>> +config S5P_DEV_CSIS1
>> +	bool
>> +	help
>> +	  Compile in platform device definitions for MIPI-CSI2 interface 1
> 
> MIPI-CSIS channel 1 ?
> 
>> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
>> index de65238..2b73173 100644
>> --- a/arch/arm/plat-s5p/Makefile
>> +++ b/arch/arm/plat-s5p/Makefile
>> @@ -28,3 +28,5 @@ obj-$(CONFIG_S5P_DEV_FIMC0)	+= dev-fimc0.o
>>  obj-$(CONFIG_S5P_DEV_FIMC1)	+= dev-fimc1.o
>>  obj-$(CONFIG_S5P_DEV_FIMC2)	+= dev-fimc2.o
>>  obj-$(CONFIG_S5P_DEV_ONENAND)	+= dev-onenand.o
>> +obj-$(CONFIG_S5P_DEV_CSIS0)	+= dev-csis0.o
>> +obj-$(CONFIG_S5P_DEV_CSIS1)	+= dev-csis1.o
>> diff --git a/arch/arm/plat-s5p/dev-csis0.c b/arch/arm/plat-s5p/dev-csis0.c
>> new file mode 100644
>> index 0000000..2b1ba43
>> --- /dev/null
>> +++ b/arch/arm/plat-s5p/dev-csis0.c
>> @@ -0,0 +1,34 @@
>> +/*
>> + * Copyright (C) 2010 Samsung Electronics
>> + *
>> + * S5P series device definition for MIPI-CSI device 0
> 
> MIPI-CSIS channel 0
OK.
> 
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <mach/map.h>
>> +
>> +static struct resource s5p_csis_resource[] = {
> 
> Hmm...s5p_mipi_csis0_resource is more helpful even though static.

I personally hate inserting indexes into variables' name, but will
change this.

> 
>> +	[0] = {
>> +		.start = S5P_PA_CSIS0,
>> +		.end   = S5P_PA_CSIS0 + SZ_4K - 1,
> 
> Please refer to previous my comments about the name.

OK, will use S5P_PA_MIPI_CSIS0..
> 
>> +		.flags = IORESOURCE_MEM,
>> +	},
>> +	[1] = {
>> +		.start = IRQ_MIPICSI0,
>> +		.end   = IRQ_MIPICSI0,
> 
> Same.

and IRQ_MIPI_CSIS0 here.
> 
>> +		.flags = IORESOURCE_IRQ,
>> +	}
>> +};
>> +
>> +struct platform_device s5p_device_mipi_csis0 = {
>> +	.name		  = "s5p-mipi-csis",
>> +	.id		  = 0,
>> +	.num_resources	  = 2,
> 
> = ARRAY_SIZE(s5p_mipi_csis0_resource),
> 
>> +	.resource	  = &s5p_csis_resource[0],
> 
> = s5p_mipi_csis0_resource,
OK.
> 
>> +};
>> diff --git a/arch/arm/plat-s5p/dev-csis1.c b/arch/arm/plat-s5p/dev-csis1.c
>> new file mode 100644
>> index 0000000..7f21ea8
>> --- /dev/null
>> +++ b/arch/arm/plat-s5p/dev-csis1.c
>> @@ -0,0 +1,33 @@
>> +/*
>> + * Copyright (C) 2010 Samsung Electronics
>> + *
>> + * S5P series device definition for MIPI-CSI device 1
> 
> MIPI-CSIS channel 1
OK.
> 
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <mach/map.h>
>> +
>> +static struct resource s5p_csis_resource[] = {
>> +	[0] = {
>> +		.start = S5P_PA_CSIS1,
>> +		.end   = S5P_PA_CSIS1 + SZ_4K - 1,
> 
> Name.
> 
>> +		.flags = IORESOURCE_MEM,
>> +	},
>> +	[1] = {
>> +		.start = IRQ_MIPICSI1,
>> +		.end   = IRQ_MIPICSI1,
> 
> Name.
> 
>> +		.flags = IORESOURCE_IRQ,
>> +	},
>> +};
>> +struct platform_device s5p_device_mipi_csis1 = {
>> +	.name		  = "s5p-mipi-csis",
>> +	.id		  = 1,
>> +	.num_resources	  = 2,
> 
> Same as above.
> 
>> +	.resource	  = &s5p_csis_resource[0],
> 
> Same.
> 
>> +};
>> diff --git a/arch/arm/plat-samsung/include/plat/csis.h b/arch/arm/plat-
>> samsung/include/plat/csis.h
>> new file mode 100644
>> index 0000000..6ea3a40
>> --- /dev/null
>> +++ b/arch/arm/plat-samsung/include/plat/csis.h
> 
> Do you think really needed this for "plat-samsung" not just "plat-s5p"?

No, in fact I have tried both. Eventually I left it in plat-samsung since
I believe we could have a common MIPI CSIS driver for the s3c and s5p SoCs.
I have got v4l2_subdev based driver ready and tested on s5pv210 and s5pv310
but have never tried if it works on s3c SoCs. So for now I think it could be
better to move csis.h to "plat-s5p" as you suggested.
I am going to incorporate that change in next patch version.

> 
>> @@ -0,0 +1,28 @@
>> +/*
>> + * Copyright (C) 2010 Samsung Electronics Co., Ltd
>> + *
>> + * S5P series MIPI CSI2 device support
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef PLAT_CSIS_H_
>> +#define PLAT_CSIS_H_ __FILE__
>> +
>> +/**
>> + * struct s3c_platform_csis - default platform data for MIPI CSI2
> interface
> 
> ...
> 
>> + * @clock_rate: bus clock frequency
> 
> clk_rate as Jamie Iles's comment.

All right, I missed somehow the comment about the clock yesterday.
Thanks Jamie!

> 
>> + * @nlanes: number of MIPI data lanes used
> 
> How about just "lanes".

Ok, I don't mind changing that. It was supposed to mean n(umber of)lanes.

> 
>> + * @alignment: MIPI data alignment in bits
>> + * @hs_settle: HSYNC settle time (see CSIS_DPHYCTRL register description)
> 
> Actually, not mentioned HS-RX settle time in CSIS_DPHYCTRL register of
> datasheet.

Ups, my fault. But...  bits 27..31 in CSIS_DPHYCTRL are for HS-RX settle time,
aren't they?
The description is not in the datasheet but I believe it *should* be there.
I hoped someone updates the datasheet eventually. I have even reported it to
one of your colleagues, who helped me in solving the HS-RX settle related
issues. Missing details in the specs are real pain during development.
It is often impossible to get anything working without a reference code.

> 
> + * @hs_settle: HS-RX settle time.
Ok, thanks.

-- 
Sylwester Nawrocki
Linux Platform Group
Samsung Poland R&D Center

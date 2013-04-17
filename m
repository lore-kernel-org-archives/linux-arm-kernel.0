From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 17 Apr 2013 09:23:02 +0200
Subject: [V3 patch 19/19] ARM: imx: cpuidle: use init/exit common routine
In-Reply-To: <20130417071511.GB3338@S2101-09.ap.freescale.net>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-20-git-send-email-daniel.lezcano@linaro.org>
 <20130417071511.GB3338@S2101-09.ap.freescale.net>
Message-ID: <516E4DD6.2090900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2013 09:15 AM, Shawn Guo wrote:
> Thanks for working on this, Daniel.
> 
> The imx6q change looks good to me.  But I have a comment on imx5 changes
> below.
> 
> On Fri, Apr 12, 2013 at 02:36:05PM +0200, Daniel Lezcano wrote:
>> diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpuidle-imx5.c
>> new file mode 100644
>> index 0000000..ba4565f
>> --- /dev/null
>> +++ b/arch/arm/mach-imx/cpuidle-imx5.c
>> @@ -0,0 +1,40 @@
>> +/*
>> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/cpuidle.h>
>> +#include <linux/module.h>
>> +#include <asm/system_misc.h>
>> +#include <asm/proc-fns.h>
>> +
>> +#include "hardware.h"
>> +
>> +static int imx5_cpuidle_enter(struct cpuidle_device *dev,
>> +			      struct cpuidle_driver *drv, int index)
>> +{
>> +	arm_pm_idle();
> 
> The existing imx5 cpuidle code has an tzic_enable_wake() call before
> going to idle.  I think it's there for some reason.

The idle function for imx5 is untouched, it is called through
arm_pm_idle instead.

The arm_pm_idle is initialized in imx5_pm_common_init:

arm_pm_idle = imx5_pm_idle;

The imx5_pm_idle function calls imx5_do_pm_idle which in turns calls
tzic_enable_wake and cpu_do_idle.



[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Wed, 8 May 2013 07:26:04 +0000
Subject: [PATCH V2 1/2] ARM/MVF600: add Vybrid Family platform support
In-Reply-To: <20130503074105.GA31873@S2101-09.ap.freescale.net>
References: <1367480285-26159-1-git-send-email-b35083@freescale.com>
 <1367480285-26159-2-git-send-email-b35083@freescale.com>
 <20130503074105.GA31873@S2101-09.ap.freescale.net>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851B455F@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Friday, May 03, 2013 3:41 PM
>To: Lu Jingchang-B35083
>Cc: linux-arm-kernel at lists.infradead.org; s.hauer at pengutronix.de
>Subject: Re: [PATCH V2 1/2] ARM/MVF600: add Vybrid Family platform support
>
>> --git a/arch/arm/mach-imx/mach-mvf600.c
>> b/arch/arm/mach-imx/mach-mvf600.c new file mode 100644 index
>> 0000000..56d3fb0
>> --- /dev/null
>> +++ b/arch/arm/mach-imx/mach-mvf600.c
>> @@ -0,0 +1,118 @@
>> +/*
>> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> +modify
>> + * it under the terms of the GNU General Public License as published
>> +by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/sched.h>
>> +#include <linux/delay.h>
>> +#include <linux/pm.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/init.h>
>> +#include <linux/clk.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqchip/arm-gic.h>
>> +#include <asm/memory.h>
>> +#include <asm/irq.h>
>> +#include <asm/setup.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach/time.h>
>> +#include <asm/hardware/cache-l2x0.h>
>> +#include <asm/system_misc.h>
>
>Please check if you really need all these headers.
>
>> +
>> +#include "common.h"
>> +
>> +
>> +void mvf_restart(char mode, const char *cmd) {
>> +	struct device_node *np;
>> +	void __iomem *wdog_base;
>> +	struct clk *wdog_clk;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-wdt");
>> +	wdog_base = of_iomap(np, 0);
>> +	if (!wdog_base)
>> +		goto soft;
>> +
>> +	wdog_clk = of_clk_get_by_name(np, "wdog");
>> +	if (!IS_ERR(wdog_clk))
>> +		clk_prepare_enable(wdog_clk);
>> +
>> +	/* enable wdog */
>> +	writew_relaxed(1 << 2, wdog_base);
>> +
>> +	/* wait for reset to assert ... */
>> +	mdelay(500);
>> +
>> +	pr_err("Watchdog reset failed to assert reset\n");
>> +
>> +	/* delay to allow the serial port to show the message */
>> +	mdelay(50);
>> +
>> +soft:
>> +	/* we'll take a jump through zero as a poor second */
>> +	soft_restart(0);
>> +}
>
>If mvf600 uses the same wdt IP block as imx, we should make this restart
>routine a common function to be used on mvf600, imx6q and imx6sl etc.
>
[Lu Jingchang-B35083] 
    Do you have plan to update the mxc_restart() function in system.c? We once used that common function for mvf600. But now this function cannot be used for mvf600 as the new clock framwork used.
    On the other hand, even we udpated the clk_get for the the common mxc_restart() funciton. different with i.MX6, the MVF600 need to enable the clock before using the wdt module, we still need some clue code for i.mx and mvf600. So I suggest keep the restart function for mvf600 currently. Thanks.

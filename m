From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Mon, 21 Mar 2011 14:53:21 +0000
Subject: [PATCHv4 3/3] ARM: mx51: Add support for low power suspend on MX51
In-Reply-To: <20110318152502.GO29758@n2100.arm.linux.org.uk>
References: <1300461684-21775-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1300461684-21775-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1300461684-21775-3-git-send-email-Dinh.Nguyen@freescale.com>
	<20110318152502.GO29758@n2100.arm.linux.org.uk>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA1BC0AF@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

>-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner at vger.kernel.org] On Behalf Of
>Russell King - ARM Linux
>Sent: Friday, March 18, 2011 10:25 AM
>To: Nguyen Dinh-R00091
>Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; s.hauer at pengutronix.de;
>u.kleine-koenig at pengutronix.de; arnaud.patard at rtp-net.org; Vaidyanathan Ranjani-RA5478; Zhang Lily-
>R58066; festevam at gmail.com
>Subject: Re: [PATCHv4 3/3] ARM: mx51: Add support for low power suspend on MX51
>
>On Fri, Mar 18, 2011 at 10:21:24AM -0500, Dinh.Nguyen at freescale.com wrote:
>> +#include <linux/suspend.h>
>> +#include <linux/clk.h>
>> +#include <asm/mach/map.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/tlb.h>
>> +#include <mach/system.h>
>> +#include "crm_regs.h"
>
>Why does the code below require asm/mach/map.h ?

map.h can be replaced by linux/io.h for the __raw_writel().

>Why does it require asm/tlb.h ?

asm/tlb is for the local_flush_tlb_all() call.

Thanks for your review.

Dinh
>
>> +
>> +static struct clk *gpc_dvfs_clk;
>> +
>> +static int mx5_suspend_enter(suspend_state_t state)
>> +{
>> +	if (gpc_dvfs_clk == NULL)
>> +		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
>> +
>> +	if (gpc_dvfs_clk) {
>> +		clk_enable(gpc_dvfs_clk);
>> +		switch (state) {
>> +		case PM_SUSPEND_MEM:
>> +			mx5_cpu_lp_set(STOP_POWER_OFF);
>> +			break;
>> +		case PM_SUSPEND_STANDBY:
>> +			mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (state == PM_SUSPEND_MEM) {
>> +			local_flush_tlb_all();
>> +			flush_cache_all();
>> +
>> +			/*clear the EMPGC0/1 bits */
>> +			__raw_writel(0, MXC_SRPG_EMPGC0_SRPGCR);
>> +			__raw_writel(0, MXC_SRPG_EMPGC1_SRPGCR);
>> +		}
>> +		cpu_do_idle();
>> +		clk_disable(gpc_dvfs_clk);
>> +	}else {
>> +		printk(KERN_ERR "Cannot enter SRPG suspend -no gpc_dvfs clock!\n");
>> +		return -EPERM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int mx5_pm_valid(suspend_state_t state)
>> +{
>> +	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
>> +}
>> +
>> +static const struct platform_suspend_ops mx5_suspend_ops = {
>> +	.valid = mx5_pm_valid,
>> +	.enter = mx5_suspend_enter,
>> +};
>> +
>> +static int __init mx5_pm_init(void)
>> +{
>> +	if (cpu_is_mx51())
>> +		suspend_set_ops(&mx5_suspend_ops);
>> +
>> +	return 0;
>> +}
>> +device_initcall(mx5_pm_init);
>> --
>> 1.6.0.4
>>
>>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo at vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 14 Oct 2013 14:00:54 -0400
Subject: [PATCH v2 4/4] ARM: keystone: add PM bus support for clock
 management
In-Reply-To: <87hacj92ra.fsf@linaro.org>
References: <1377819404-9671-1-git-send-email-santosh.shilimkar@ti.com>
 <1377819404-9671-5-git-send-email-santosh.shilimkar@ti.com>
 <5257431A.5090301@ti.com> <87hacj92ra.fsf@linaro.org>
Message-ID: <525C3156.7090908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 October 2013 01:32 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On Thursday 29 August 2013 07:36 PM, Santosh Shilimkar wrote:
>>> Add runtime PM core support to Keystone SOCs by using the pm_clk
>>> infrastructure of the PM core. Patch is based on Kevin's pm_domain
>>> work on DaVinci SOCs.
>>>
>>> Keystone SOC doesn't have depedency to enable clocks in early
>>> in the boot and hence the clock and PM bus initialisation is done
>>> at subsys_init() level.
>>>
>>> Cc: Kevin Hilman <khilman@linaro.org>
>>>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>> For record, updated patch end of the email as discussed here [1]
> 
> Unfortunately, this one broke boot for muilti_v7_defconfig:
> 
>    http://lists.linaro.org/pipermail/kernel-build-reports/2013-October/000652.html
>
Damn. Sorry about that.

 
> [...]
> 
>> +int __init keystone_pm_runtime_init(void)
>> +{
>> +	of_clk_init(NULL);
>> +	pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
>> +
>> +	return 0;
>> +}
>> +subsys_initcall(keystone_pm_runtime_init);
> 
> The reason is this initcall which runs on *all* platforms, so needs some
> sort of platform specific check.  
> 
> The patch below does the trick, but I'm not sure if you want to match on
> something more specific for this check.  If you're OK, with this, I'll
> add it to next/soc with your ack.
> 
> Kevin
> 
> From 435ed298c804048548276b60fd5efdf697f6b82f Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@linaro.org>
> Date: Mon, 14 Oct 2013 10:30:11 -0700
> Subject: [PATCH] ARM: keystone: fix PM domain initcall to be keystone only
> 
> initcalls need to have platform specific checks so they are not run in
> multi-platform builds.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Looks right. Thanks a lot Kevin.

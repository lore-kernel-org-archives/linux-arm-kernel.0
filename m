From: xf@rock-chips.com (Feng Xiao)
Date: Thu, 24 Mar 2016 11:01:40 +0800
Subject: [PATCH v2] cpufreq: rockchip: add driver
In-Reply-To: <20160323044033.GQ5272@vireshk-i7>
References: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
 <1458699487-58470-1-git-send-email-xf@rock-chips.com>
 <20160323044033.GQ5272@vireshk-i7>
Message-ID: <56F35894.3020106@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all,
      I found that it could match the cpufreq-dt driver succesfully only 
with the following changes.
--- a/arch/arm64/boot/dts/rockchip/rk3366.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3366.dtsi
@@ -139,6 +139,10 @@
                 };
         };

+       cpufreq-dt {   //the node name must be cpufreq-dt
+               compatible = "rockchip,cpufreq";  //  the compatible 
name is insignificant
+       };
+

This was supported by the commit 07e461cd7e73a84f0e3757932b93cc80976fd749

commit 07e461cd7e73a84f0e3757932b93cc80976fd749
Author: Grant Likely <grant.likely@linaro.org>
Date:   Wed May 21 15:40:31 2014 +0900

     of: Ensure unique names without sacrificing determinism

     The way the driver core is implemented, every device using the same bus
     type is required to have a unique name because a symlink to each device
     is created in the appropriate /sys/bus/*/devices directory, and two
     identical names causes a collision.

     The current code handles the requirement by using an globally
     incremented counter that is appended to the device name. It works, but
     it means any change to device registration will change the assigned
     numbers. Instead, if we build up the name by using information from the
     parent nodes, then it can be guaranteed to be unique without adding a
     random number to the end of it.

     Signed-off-by: Grant Likely <grant.likely@linaro.org>
     Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
     Cc: Rob Herring <robh@kernel.org>

If so, do I need to continue to add the new cpufreq driver ?

? 2016/3/23 12:40, Viresh Kumar ??:
> On 23-03-16, 10:18, Feng Xiao wrote:
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 14b1f93..1786315 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -97,6 +97,16 @@ config ARM_OMAP2PLUS_CPUFREQ
>>   	depends on ARCH_OMAP2PLUS
>>   	default ARCH_OMAP2PLUS
>>   
>> +config ARM_ROCKCHIP_CPUFREQ
>> +	tristate "Rockchip CPUfreq driver"
> Since you are allowing it to be built as a module ...
>
>> +	depends on ARCH_ROCKCHIP && CPUFREQ_DT
>> +	select PM_OPP
>> +	help
>> +	  This adds the CPUFreq driver support for Rockchip SoCs.
>> +	  The driver will directly use cpufreq-dt driver as backend.
>> +
>> +	  If in doubt, say N.
>> +++ b/drivers/cpufreq/rockchip-cpufreq.c
>> +static int __init rockchip_cpufreq_driver_init(void)
>> +{
>> +	struct platform_device *pdev;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(rockchip_compat); i++) {
>> +		if (of_machine_is_compatible(rockchip_compat[i])) {
>> +			pdev = platform_device_register_simple("cpufreq-dt",
>> +							       -1, NULL, 0);
>> +			return PTR_ERR_OR_ZERO(pdev);
>> +		}
>> +	}
>> +
>> +	return -ENODEV;
>> +}
>> +module_init(rockchip_cpufreq_driver_init);
> You need a module exit as well to remove the device. Otherwise following
> sequence will give you errors:
>
> insmod rockchip-cpufreq.ko
> rmmod rockchip-cpufreq.ko
> insmod rockchip-cpufreq.ko //Errors on this..
>
> So, either don't allow it to be built as a module or fix the module-exit path.
>

From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 07 Nov 2013 09:34:08 +0100
Subject: [RFC PATCH 2/3] ARM: imx: cpuidle: Convert imx6q driver to
 platform_driver
In-Reply-To: <20131107080743.GB6500@S2101-09.ap.freescale.net>
References: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
 <1382978973-4034-2-git-send-email-daniel.lezcano@linaro.org>
 <20131107080743.GB6500@S2101-09.ap.freescale.net>
Message-ID: <527B5080.9030003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2013 09:07 AM, Shawn Guo wrote:
> On Mon, Oct 28, 2013 at 09:49:32AM -0700, Daniel Lezcano wrote:
>> +static struct platform_device imx6q_cpuidle_device = {
>> +	.name = "cpuidle-imx6q",
>> +	.dev = {
>> +		.platform_data = imx6q_pm_idle,
>> +	},
>> +};
>> +
>>   void __init imx6q_pm_init(void)
>>   {
>> +	/*
>> +	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
>> +	 * to run cpuidle on them.
>> +	 */
>> +	if (imx6q_revision() > IMX_CHIP_REVISION_1_1) {
>> +
>> +		/* Need to enable SCU standby for entering WAIT modes */
>> +		imx_scu_standby_enable();
>> +
>> +		/* Set chicken bit to get a reliable WAIT mode support */
>> +		imx6q_set_chicken_bit();
>
> So this is a behavior change.  Before the patch, these two functions
> will not get called if CONFIG_CPU_IDLE is not enabled.  We only want to
> call them when cpuidle driver is instantiated.

Yep, I will look at changing that.

Thanks for the review !

  -- Daniel

>> +
>> +		platform_device_register(&imx6q_cpuidle_device);
>> +	}
>> +
>>   	suspend_set_ops(&imx6q_pm_ops);
>>   }
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

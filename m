From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 6 Jul 2016 09:49:53 +0200
Subject: [PATCH 2/3] pinctrl: Add STM32F746 MCU support
In-Reply-To: <20160705140218.GD26134@windriver.com>
References: <1467726017-20041-1-git-send-email-alexandre.torgue@st.com>
 <1467726017-20041-3-git-send-email-alexandre.torgue@st.com>
 <20160705140218.GD26134@windriver.com>
Message-ID: <577CB821.7000206@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 07/05/2016 04:02 PM, Paul Gortmaker wrote:
> [[PATCH 2/3] pinctrl: Add STM32F746 MCU support] On 05/07/2016 (Tue 15:40) Alexandre TORGUE wrote:
>
>> From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>
>> This patch which adds STM32F746 pinctrl and GPIO support, relies on the
>> generic STM32 pinctrl driver.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>>
>> diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
>> index 0f28841..4c40dae 100644
>> --- a/drivers/pinctrl/stm32/Kconfig
>> +++ b/drivers/pinctrl/stm32/Kconfig
>> @@ -13,4 +13,10 @@ config PINCTRL_STM32F429
>>   	default MACH_STM32F429
>>   	select PINCTRL_STM32
>>
>> +config PINCTRL_STM32F746
>> +	bool "STMicroelectronics STM32F746 pin control" if COMPILE_TEST && !MACH_STM32F746
>          ^^^^
>
>> +	depends on OF
>> +	default MACH_STM32F746
>> +	select PINCTRL_STM32
>> +
>> +	),
>> +};
>> +
>
> [...]
>
>> +static const struct of_device_id stm32f746_pctrl_match[] = {
>> +	{
>> +		.compatible = "st,stm32f746-pinctrl",
>> +		.data = &stm32f746_match_data,
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32f746_pctrl_match);
>    ^^^^^^^^^^^^^^^^^^^^
>
>> +
>> +static struct platform_driver stm32f746_pinctrl_driver = {
>> +	.probe = stm32_pctl_probe,
>> +	.driver = {
>> +		.name = "stm32f746-pinctrl",
>> +		.of_match_table = stm32f746_pctrl_match,
>> +	},
>> +};
>> +
>> +static int __init stm32f746_pinctrl_init(void)
>> +{
>> +	return platform_driver_register(&stm32f746_pinctrl_driver);
>> +}
>> +
>> +module_init(stm32f746_pinctrl_init);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("STM32F746 Pinctrl Driver");
>> +MODULE_AUTHOR("Maxime Coquelin <mcoquelin.stm32@gmail.com>");
>
> ...and here as well.  Please don't use modular support functions and
> infrastructure for code that is only built-in.  Either make sure it can
> be modular and use a tristate Kconfig, or delete all the MODULE_<tags>
> and use device_initcall() to register the driver.

Thanks for remark. I will send a v2 removing modular stuff.

Regards

Alex

>
> Thanks,
> Paul.
> --
>
>> --
>> 1.9.1
>>

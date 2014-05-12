From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 12 May 2014 10:12:59 +0530
Subject: [PATCH 0/4] Add framework to support clkout
In-Reply-To: <536D9F88.9000505@samsung.com>
References: <1399640410-30957-1-git-send-email-tushar.behera@linaro.org>
 <536D9F88.9000505@samsung.com>
Message-ID: <53705153.4020606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2014 09:09 AM, Pankaj Dubey wrote:
> Hi Tushar,
> 
[ ... ]
>> Also we need to find a suitable place to call early_syscon_init(), after
>> the device tree has been unflattened and before clock initialization.
>>
>> While testing, I called this before of_clk_init() in
>> arch/arm/kernel/time.c,
>> but that place is too generic. Calling anywhere from exynos.c is not
>> working ATM.
> 
> IMO we do not need to, or if I am not wrong we should not change time.c.
> 

The above solution is definitely a hack and just to test my stuff. The
below solution looks good.

> It's possible if we have exynos specific init_time with following changes.
> FYI, In my patch series for Exynos PMU [1], currently I am handling this in
> exynos_dt_machine_init. But definitely it can be handled as below and it
> works
> without any side effect and I have tested it. Only reason I do not
> adopted this
> as for Exynos PMU patch support I had other options. But if required and if
> following change is acceptable I can include this in my next version of
> Exynos
> PMU patch series.
> 
> [1]: https://lkml.org/lkml/2014/4/30/18
> 
> 
> +static void __init exynos_init_time(void)
> +{
> +    /* Nothing to do timer specific
> +     * as early_syscon_init requires DT to be unflattened and
> +     * system should be able to allocate memory we need to
> +     * postpone until init_time, but it should be done before
> +     * init_machine. Because before init_machine, secondary
> +     * core boot starts and it uses PMU registers.
> +     */
> +
> +    exynos_map_pmu();
> +

Instead of calling early_syscon_init() from within exynos_map_pmu(), it
would be good to call it explicitly here before exynos_map_pmu().

> +    of_clk_init(NULL);
> +    clocksource_of_init();
> +
> +}
> +

-- 
Tushar Behera

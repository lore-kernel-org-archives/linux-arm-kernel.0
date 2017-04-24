From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Apr 2017 09:37:09 +0530
Subject: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
In-Reply-To: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
Message-ID: <20170424040709.GG26900@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-04-17, 13:11, Fabio Estevam wrote:
> Hi,
> 
> Running 4.11-rc7 on a imx6q-sabresd board I notice that egalax
> touchscreen stops generating evtest events after a random period of
> time.
> 
> This problem can be avoided if I unselect CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND:
> 
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -54,7 +54,6 @@ CONFIG_CMA=y
>  CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
>  CONFIG_KEXEC=y
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_ARM_IMX6Q_CPUFREQ=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_VFP=y
> 
> With this change evtest always capture all touchscreen events. No
> single failure is seen.
> 
> I could see the same behavior with all mainline kernels I tested (4.9 and 4.10).
> 
> Any ideas as to how fix this bug when CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y?

So as Rafael pointed out the problem doesn't happen if you stay at the max
frequencies, but otherwise.

You need to investigate on why that is the case. You can go to the cpufreq sysfs
directory and see what frequencies are getting selected, etc..

Give me output of this for now:

grep . /sys/devices/system/cpu/cpufreq/policy0/*
grep . /sys/devices/system/cpu/cpufreq/policy0/stats/*

-- 
viresh

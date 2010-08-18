From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 19 Aug 2010 08:30:48 +0900
Subject: [PATCH v7 6/6] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <1281419049-11562-7-git-send-email-myungjoo.ham@samsung.com>
References: <1281419049-11562-1-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-2-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-3-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-4-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-5-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-6-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-7-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <000001cb3f2d$7a5acb80$6f106280$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> S5PV210 CPUFREQ Support.
> 
> This CPUFREQ may work without PMIC's DVS support. However, it is not
> as effective without DVS support as supposed. AVS is not supported in
> this version.
> 
> Note that CLK_SRC of some clocks including ARMCLK, G3D, G2D, MFC,
> and ONEDRAM are modified directly without updating clksrc_src
> representations of the clocks.  Because CPUFREQ reverts the CLK_SRC
> to the supposed values, this does not affect the consistency as long as
> there are no other modules that modifies clock sources of ARMCLK, G3D,
> G2D, MFC, and ONEDRAM (and only CPUFREQ should have the control). As
> soon as clock framework is settled, we may update source clocks
> (.parent field) of those clocks accordingly later.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> --
> v2:
> 	- Ramp-up delay is removed. (let regulator framework do the job)
> 	- Provide proper max values for regulator_set_voltage
> 	- Removed unneccesary #ifdef's.
> 	- Removed unnecessary initialiser for CLK_OUT
> v3:
> 	- Style corrections (pr_info/pr_err, ...)
> 	- Revised dvs_conf struct
> v4:
> 	- Renamed cpufreq-s5pv210.c -> cpufreq.c
> 	- Style corrections (less #ifdef's, comments)
> 	- Removed unncessary codes
> 	- Remove #ifdef for WORKAROUND, use s5pv210_workaround()
> 	- Renamed some static variables (get rid of s5pv210 prefix)
> 	- Added machine dependency to Kconfig/Makefile
> 	- DMC0, DMC1 refresh counter is not updated by a hardcoded value,
but
> 	with the value given as the default and relative clock speeds.
Besides,
> 	the algorithm to update DMC0/1 refresh counter is reformed.
> v5:
> 	- Remove unnecessary USE_FREQ_TABLE
> 	- Renamed functions
> 	- s5pv210_cpufreq_target's initialization revised. (first_run)
> 	- "workaround" --> "revision"
> 	- CLK_*_STAT register entries use macros: they are used mutiple
> 	  times.
> v6:
> 	- Restyled evt0-related codes.
> v7:
> 	- Updated evt0-check method.
> 	- Enable CPUFREQ Only for Aquila/Goni
> 	- Style patch (inline functions)
> 
> ---
>  arch/arm/Kconfig                              |    1 +
>  arch/arm/mach-s5pv210/Kconfig                 |    6 +
>  arch/arm/mach-s5pv210/Makefile                |    2 +
>  arch/arm/mach-s5pv210/cpufreq.c               |  792
> +++++++++++++++++++++++++
>  arch/arm/mach-s5pv210/include/mach/cpu-freq.h |   38 ++
>  5 files changed, 839 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/cpufreq.c
>  create mode 100644 arch/arm/mach-s5pv210/include/mach/cpu-freq.h
> 

(snip)

> +#ifdef CONFIG_PM
> +static int previous_frequency;
> +
> +static int s5pv210_cpufreq_suspend(struct cpufreq_policy *policy,
> +		pm_message_t pmsg)
> +{
> +	int ret = 0;
> +	pr_info("cpufreq: Entering suspend.\n");
> +
> +	previous_frequency = cpufreq_get(0);
> +	ret = __cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ,
> +			DISABLE_FURTHER_CPUFREQ);
> +	return ret;
> +}
> +
> +static int s5pv210_cpufreq_resume(struct cpufreq_policy *policy)
> +{
> +	int ret = 0;
> +	u32 rate;
> +	int level = CPUFREQ_TABLE_END;
> +	int i = 0;
> +
> +	pr_info("cpufreq: Waking up from a suspend.\n");
> +
> +	__cpufreq_driver_target(cpufreq_cpu_get(0), previous_frequency,
> +			ENABLE_FURTHER_CPUFREQ);
> +
> +	/* Clock information update with wakeup value */
> +	rate = clk_get_rate(mpu_clk);
> +
> +	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
> +		if (freq_table[i].frequency * 1000 == rate) {
> +			level = freq_table[i].index;
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	if (level == CPUFREQ_TABLE_END) { /* Not found */
> +		pr_err("[%s:%d] clock speed does not match: "
> +				"%d. Using L1 of 800MHz.\n",
> +				__FILE__, __LINE__, rate);
> +		level = L1;
> +	}
> +
> +	memcpy(&s3c_freqs.old, &clk_info[level],
> +			sizeof(struct s3c_freq));
> +	previous_arm_volt = dvs_conf[level].arm_volt;
> +	return ret;
> +}
> +#endif
> +

(snip)

Hi,

Did you test on the board?

The following error occurs.

--
...
cpufreq: Entering suspend.
BUG: sleeping function called from invalid context at kernel/rwsem.c:21
in_atomic(): 0, irqs_disabled(): 128, pid: 13, name: suspend
[<c002c91c>] (unwind_backtrace+0x0/0xec) from [<c0295dd0>]
(down_read+0x18/0x28)
[<c0295dd0>] (down_read+0x18/0x28) from [<c01e8524>]
(lock_policy_rwsem_read+0x2c/0x50)
[<c01e8524>] (lock_policy_rwsem_read+0x2c/0x50) from [<c01e85d4>]
(cpufreq_get+0x20/0x50)
[<c01e85d4>] (cpufreq_get+0x20/0x50) from [<c0031e5c>]
(s5pv210_cpufreq_suspend+0x14/0x40)
[<c0031e5c>] (s5pv210_cpufreq_suspend+0x14/0x40) from [<c01e78c8>]
(cpufreq_suspend+0x50/0x84)
[<c01e78c8>] (cpufreq_suspend+0x50/0x84) from [<c0175464>]
(sysdev_suspend+0x84/0x28c)
[<c0175464>] (sysdev_suspend+0x84/0x28c) from [<c0071324>]
(suspend_devices_and_enter+0xe0/0x1a0)
[<c0071324>] (suspend_devices_and_enter+0xe0/0x1a0) from [<c007148c>]
(enter_state+0xa8/0xd4)
[<c007148c>] (enter_state+0xa8/0xd4) from [<c0072914>] (suspend+0x60/0x124)
[<c0072914>] (suspend+0x60/0x124) from [<c0058260>]
(worker_thread+0x15c/0x1ec)
[<c0058260>] (worker_thread+0x15c/0x1ec) from [<c005b58c>]
(kthread+0x78/0x80)
[<c005b58c>] (kthread+0x78/0x80) from [<c0027f64>]
(kernel_thread_exit+0x0/0x8)
...
--

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

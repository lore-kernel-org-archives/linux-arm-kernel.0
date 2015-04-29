From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 29 Apr 2015 09:35:28 -0700
Subject: [PATCH 05/11] ARM: imx6: set initial power mode in pm function
In-Reply-To: <20150429060446.GA27573@dragon> (Shawn Guo's message of "Wed, 29
 Apr 2015 14:04:58 +0800")
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
 <1430058672-9267-6-git-send-email-shawn.guo@linaro.org>
 <CAMAWPa8cyybpdgO+Po=7YUnCFkrnyHKKihgddzrUpHfAW=7brA@mail.gmail.com>
 <20150429060446.GA27573@dragon>
Message-ID: <7h383ix57z.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@linaro.org> writes:

> Hi Kevin,
>
> On Tue, Apr 28, 2015 at 11:42:48AM -0700, Kevin Hilman wrote:
>> Hi Shawn,
>> 
>> On Sun, Apr 26, 2015 at 7:31 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > Rather than setting initial low-power mode in every single i.MX6 clock
>> > initialization function, we should really do that in pm code.  Let's
>> > move imx6q_set_lpm(WAIT_CLOCKED) call into imx6_pm_common_init().
>> >
>> > While at it, let's rename the function to imx6_set_lpm() since it's
>> > actually common for all i.MX6 SoCs.
>> >
>> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> 
>> Some boot failures on imx6[1] (multi_v7_defconfig) were bisected down
>> to this patch.  A simple revert doesn't build, so I was unable tot
>> test a direct revert.  However, from the boot failures you can see
>> that while multi_v7_defconfig boots fail, the imx_v6_v7_defconfig
>> boots fine.
>
> This reminds me that cpuidle support is not turned on in
> imx_v6_v7_defconfig.  I will send a patch to enable it for testing
> coverage.
>
>> Disabling CONFIG_CPU_IDLE in multi_v7_defconfig allows
>> this to start booting again on my wandboard quad, so I think there is
>> something wrong with the cpuidle changes.
>
> I just tracked down the issue, and sent a fix like below.

Thanks for the quick fix.

> The kernelci.org boot automation farm helps.  Thanks.

Glad it's useful.  We're doing a build/boot test of your fix now, and
will keep you updated.

In the mean time..., 

> ----8<-------------------------------
> From 056a5da1b56a057762eccd52b5b6b920c7f56b14 Mon Sep 17 00:00:00 2001
> From: Shawn Guo <shawn.guo@linaro.org>
> Date: Wed, 29 Apr 2015 13:07:03 +0800
> Subject: [PATCH] ARM: imx6: initialize CCM_CLPCR_LPM into RUN mode earlier
>
> Commit 4631960d26da ("ARM: imx6: set initial power mode in pm function")
> moves imx6_set_lpm() from clock init function into
> imx6_pm_common_init().  This causes a hang when cpuidle support is
> enabled.  The reason for that is ARM core clock is shut down
> unexpectedly by WAIT mode.  It happens with the following call stack:
>
>     cpuidle_register_governor()
>         cpuidle_switch_governor()
>             cpuidle_uninstall_idle_handler()
>                 synchronize_sched()
>                     wait_rcu_gp()
>                         wait_for_completion()
>
> When wait_for_completion() is called as above, all cores are idle/WFI.
> Hence, the reset value of CCM_CLPCR_LPM - WAIT mode, will trigger a
> hardware shutdown of the ARM core clock.
>
> To fix the regression, we need to ensure that CCM_CLPCR_LPM is
> initialized into RUN mode earlier than cpuidle governor registration,
> which is a postcore_initcall.  This patch creates function
> imx6_pm_ccm_init() to map CCM block and initialize CCM_CLPCR_LPM into
> RUN mode, and have the function called from machine .init_irq hook,
> which should be early enough.
>
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Fixes: 4631960d26da ("ARM: imx6: set initial power mode in pm function")
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

...I did a quick test of this locally on my wandboard-quad, and it's now
booting with multi_v7_defconfig too.

Tested-by: Kevin Hilman <khilman@linaro.org>

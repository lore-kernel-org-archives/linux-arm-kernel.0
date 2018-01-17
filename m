From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 17 Jan 2018 07:25:46 +0100
Subject: Power domain clock warnings on recent next
In-Reply-To: <20180116200728.tjad7tzz3uvsmgg3@kozik-lap>
References: <CGME20180116200735epcas4p4455aea99ad21c4c45260d4752d789add@epcas4p4.samsung.com>
 <20180116200728.tjad7tzz3uvsmgg3@kozik-lap>
Message-ID: <f1bf1c15-0bba-4cf6-42a2-80a3982dbae1@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2018-01-16 21:07, Krzysztof Kozlowski wrote:
> Hi everyone,
>
> Anyone already noticed or started bisecting warnings coming from
> clk_core_disable_lock/exynos_pd_power on recent linux-next?

Yes, I've noticed it early this week and prepared a patch:
https://www.spinics.net/lists/arm-kernel/msg628881.html

> On next-20180116, Odroid XU3 and HC1 (Exynso5422):
>
> [    0.882736] EXYNOS5420 PMU initialized
> [    0.891979] ------------[ cut here ]------------
> [    0.892220] WARNING: CPU: 0 PID: 59 at ../drivers/clk/clk.c:811 clk_core_disable_lock+0x18/0x24
> [    0.892383] Modules linked in:
> [    0.892476] CPU: 0 PID: 59 Comm: kworker/0:1 Not tainted 4.15.0-rc8-next-20180116 #1121
> [    0.892629] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    0.892763] Workqueue: pm genpd_power_off_work_fn
> [    0.892891] [<c0111f90>] (unwind_backtrace) from [<c010e360>] (show_stack+0x10/0x14)
> [    0.893051] [<c010e360>] (show_stack) from [<c0a19860>] (dump_stack+0x98/0xc4)
> [    0.893209] [<c0a19860>] (dump_stack) from [<c012662c>] (__warn+0xf8/0x110)
> [    0.893353] [<c012662c>] (__warn) from [<c012675c>] (warn_slowpath_null+0x40/0x48)
> [    0.893511] [<c012675c>] (warn_slowpath_null) from [<c04b9a98>] (clk_core_disable_lock+0x18/0x24)
> [    0.893689] [<c04b9a98>] (clk_core_disable_lock) from [<c04ba820>] (clk_core_disable_unprepare+0xc/0x20)
> [    0.893874] [<c04ba820>] (clk_core_disable_unprepare) from [<c04ba87c>] (__clk_set_parent_after+0x48/0x4c)
> [    0.894063] [<c04ba87c>] (__clk_set_parent_after) from [<c04bb57c>] (clk_core_set_parent_nolock+0x27c/0x5e8)
> [    0.894253] [<c04bb57c>] (clk_core_set_parent_nolock) from [<c04bb920>] (clk_set_parent+0x38/0x6c)
> [    0.894438] [<c04bb920>] (clk_set_parent) from [<c04c9ea8>] (exynos_pd_power+0x88/0x1e4)
> [    0.894603] [<c04c9ea8>] (exynos_pd_power) from [<c0587ed8>] (genpd_power_off+0x160/0x274)
> [    0.894771] [<c0587ed8>] (genpd_power_off) from [<c0588a10>] (genpd_power_off_work_fn+0x2c/0x40)
> [    0.894953] [<c0588a10>] (genpd_power_off_work_fn) from [<c01465b4>] (process_one_work+0x2d4/0x8f0)
> [    0.895132] [<c01465b4>] (process_one_work) from [<c0147860>] (worker_thread+0x38/0x584)
> [    0.895297] [<c0147860>] (worker_thread) from [<c014d794>] (kthread+0x138/0x168)
> [    0.895450] [<c014d794>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
>
>
> Later there is also a lockdep warning but it looks like second issue:

Right, this deplock issue is already known for over 2 months. It is a 
false positive:
https://www.spinics.net/lists/linux-samsung-soc/msg61425.html

>
> [    5.932966] ======================================================
> [    5.937199] usb 5-1: new high-speed USB device number 2 using xhci-hcd
> [    5.939073] WARNING: possible circular locking dependency detected
> [    5.939110] 4.15.0-rc8-next-20180116 #1121 Tainted: G        W
> [    5.958143] ------------------------------------------------------
> [    5.964299] kworker/0:1/59 is trying to acquire lock:
> [    5.969304]  (&genpd->mlock){+.+.}, at: [<6abc3872>] genpd_runtime_resume+0x104/0x260
> [    5.977155]
> [    5.977155] but task is already holding lock:
> [    5.982926]  (prepare_lock){+.+.}, at: [<74cef905>] clk_prepare_lock+0x10/0xf8
> [    5.990143]
> [    5.990143] which lock already depends on the new lock.
> [    5.990143]
> [    5.998309]
> [    5.998309] the existing dependency chain (in reverse order) is:
> [    6.005739]
> [    6.005739] -> #1 (prepare_lock){+.+.}:
> [    6.011042]        mutex_lock_nested+0x1c/0x24
> [    6.015419]        clk_prepare_lock+0x50/0xf8
> [    6.019755]        clk_unprepare+0x1c/0x2c
> [    6.023841]        exynos_pd_power+0x1a8/0x1e4
> [    6.028246]        genpd_power_off+0x160/0x274
> [    6.032664]        genpd_power_off_work_fn+0x2c/0x40
> [    6.037630]        process_one_work+0x2d4/0x8f0
> [    6.042104]        worker_thread+0x38/0x584
> [    6.046268]        kthread+0x138/0x168
> [    6.049981]        ret_from_fork+0x14/0x20
> [    6.054044]          (null)
> [    6.056794]
> [    6.056794] -> #0 (&genpd->mlock){+.+.}:
> [    6.062238]        __mutex_lock+0x7c/0xa68
> [    6.066278]        mutex_lock_nested+0x1c/0x24
> [    6.070703]        genpd_runtime_resume+0x104/0x260
> [    6.075557]        __rpm_callback+0xc0/0x21c
> [    6.079792]        rpm_callback+0x20/0x80
> [    6.083774]        rpm_resume+0x558/0x7dc
> [    6.087762]        __pm_runtime_resume+0x60/0x98
> [    6.092367]        clk_core_prepare+0x44/0x490
> [    6.096783]        clk_prepare+0x20/0x30
> [    6.100674]        amba_get_enable_pclk+0x2c/0x60
> [    6.105363]        amba_device_try_add+0x8c/0x20c
> [    6.110041]        amba_deferred_retry_func+0x40/0xbc
> [    6.115080]        process_one_work+0x2d4/0x8f0
> [    6.119569]        worker_thread+0x38/0x584
> [    6.123727]        kthread+0x138/0x168
> [    6.127444]        ret_from_fork+0x14/0x20
> [    6.131510]          (null)
> [    6.134263]
> [    6.134263] other info that might help us debug this:
> [    6.134263]
> [    6.142328]  Possible unsafe locking scenario:
> [    6.142328]
> [    6.148178]        CPU0                    CPU1
> [    6.152656]        ----                    ----
> [    6.157160]   lock(prepare_lock);
> [    6.160439]                                lock(&genpd->mlock);
> [    6.166365]                                lock(prepare_lock);
> [    6.172168]   lock(&genpd->mlock);
> [    6.175517]
> [    6.175517]  *** DEADLOCK ***
> [    6.175517]
> [    6.181475] 4 locks held by kworker/0:1/59:
> [    6.185580]  #0:  ((wq_completion)"events"){+.+.}, at: [<f71c19aa>] process_one_work+0x210/0x8f0
> [    6.194407]  #1:  ((deferred_retry_work).work){+.+.}, at: [<f71c19aa>] process_one_work+0x210/0x8f0
> [    6.203422]  #2:  (deferred_devices_lock){+.+.}, at: [<3e940c1f>] amba_deferred_retry_func+0x1c/0xbc
> [    6.212522]  #3:  (prepare_lock){+.+.}, at: [<74cef905>] clk_prepare_lock+0x10/0xf8
> [    6.220128]
> [    6.220128] stack backtrace:
> [    6.224438] CPU: 0 PID: 59 Comm: kworker/0:1 Tainted: G        W        4.15.0-rc8-next-20180116 #1121
> [    6.233757] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    6.239791] Workqueue: events amba_deferred_retry_func
> [    6.244929] [<c0111f90>] (unwind_backtrace) from [<c010e360>] (show_stack+0x10/0x14)
> [    6.252670] [<c010e360>] (show_stack) from [<c0a19860>] (dump_stack+0x98/0xc4)
> [    6.259877] [<c0a19860>] (dump_stack) from [<c0181478>] (print_circular_bug.constprop.17+0x210/0x32c)
> [    6.269077] [<c0181478>] (print_circular_bug.constprop.17) from [<c01848f8>] (__lock_acquire+0x155c/0x1ac8)
> [    6.278786] [<c01848f8>] (__lock_acquire) from [<c0185884>] (lock_acquire+0xe0/0x2bc)
> [    6.286558] [<c0185884>] (lock_acquire) from [<c0a31788>] (__mutex_lock+0x7c/0xa68)
> [    6.294181] [<c0a31788>] (__mutex_lock) from [<c0a32190>] (mutex_lock_nested+0x1c/0x24)
> [    6.302161] [<c0a32190>] (mutex_lock_nested) from [<c05885dc>] (genpd_runtime_resume+0x104/0x260)
> [    6.311008] [<c05885dc>] (genpd_runtime_resume) from [<c057c6c4>] (__rpm_callback+0xc0/0x21c)
> [    6.319484] [<c057c6c4>] (__rpm_callback) from [<c057c840>] (rpm_callback+0x20/0x80)
> [    6.327185] [<c057c840>] (rpm_callback) from [<c057c2a8>] (rpm_resume+0x558/0x7dc)
> [    6.334721] [<c057c2a8>] (rpm_resume) from [<c057c58c>] (__pm_runtime_resume+0x60/0x98)
> [    6.342706] [<c057c58c>] (__pm_runtime_resume) from [<c04b7f6c>] (clk_core_prepare+0x44/0x490)
> [    6.351297] [<c04b7f6c>] (clk_core_prepare) from [<c04ba304>] (clk_prepare+0x20/0x30)
> [    6.359081] [<c04ba304>] (clk_prepare) from [<c04b52f4>] (amba_get_enable_pclk+0x2c/0x60)
> [    6.367229] [<c04b52f4>] (amba_get_enable_pclk) from [<c04b5510>] (amba_device_try_add+0x8c/0x20c)
> [    6.376164] [<c04b5510>] (amba_device_try_add) from [<c04b56f8>] (amba_deferred_retry_func+0x40/0xbc)
> [    6.385361] [<c04b56f8>] (amba_deferred_retry_func) from [<c01465b4>] (process_one_work+0x2d4/0x8f0)
> [    6.394457] [<c01465b4>] (process_one_work) from [<c0147860>] (worker_thread+0x38/0x584)
> [    6.402497] [<c0147860>] (worker_thread) from [<c014d794>] (kthread+0x138/0x168)
> [    6.409852] [<c014d794>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

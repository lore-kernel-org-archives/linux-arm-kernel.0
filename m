From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 30 Jan 2018 10:01:01 +0100
Subject: [PATCH v2] clk: Properly update prepare/enable count on orphan
 clock reparent
In-Reply-To: <20180127004917.GI28313@codeaurora.org>
References: <CGME20180126091902eucas1p2b3ad9978e3ab09bd7a2bd9123c9eecaa@eucas1p2.samsung.com>
 <20180126091845.11902-1-m.szyprowski@samsung.com>
 <20180127004917.GI28313@codeaurora.org>
Message-ID: <7c7810e0-efcb-c837-1b18-328e59c3b2df@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen

On 2018-01-27 01:49, Stephen Boyd wrote:
> On 01/26, Marek Szyprowski wrote:
>> If orphaned clock has been already prepared/enabled (for example if it or
>> one of its children has CLK_IS_CRITICAL flag), then the prepare/enable
>> counters of the newly assigned parent are not updated correctly. This
>> might later cause warnings during changing clock parents.
> This doesn't feel right. Perhaps we should delay enabling a clk
> if it's CRITICAL until we adopt an orphaned clk. Good news is we
> have orphan status tracking now so this should be pretty simple.

Not really. It won't be so simple, because we would need to track the
status of the whole clock sub-tree for enabling critical clocks. Even
then we would need to delay enabling them until the real top clock is
registered.

> Otherwise migrating the count up is complicated and requires us
> to call the prepare/enable ops on a critical clk and then keep
> doing that each time it gets re-parented. Do you have this case,
> where some clk is marked as CRITICAL, and then we need to migrate
> that enable/prepare count to the parent?

Yes, this is the case of Exynos5422-based boards, where we have a
bunch of critical clocks, which are reparented from internal PLL to
external oscillator when respective power domain is suspended.

It took me a while to gather all the needed information from the
debug logs. Here is one example of such clock tree:

fin_pll (clk1, top clock, external pll)
 ??? fout_dpll (clk2)
 ??? ??? mout_sclk_dpll (clk3)
 ??? ??? ??? mout_aclk300_disp1 (clk4)
 ??? ??? ??? ??? dout_aclk300_disp1 (clk5)
 ??? ??? ??? ??? ??? mout_sw_aclk300_disp1 (clk6)
 ??? ??? ??? ??? ??? ??? mout_user_aclk300_disp1 (clk7)
 ??? ??? ??? ??? ??? ??? ??? aclk300_disp1 (clk8, critical)

Before turning off power domains, aclk300_disp1 is reparented
directly to fin_pll (this is a hardware requirement). When power
domain is turned on again, aclk300_disp1 is reparented back to
mout_user_aclk300_disp1.

Clocks are registered in the following order:
1, 2, 7, 3, 6, 5, 8, 4.

In this case when critical clock is registered, clk4 is not yet
available, so clocks 1-3 won't get proper prepare/enable count.
Then this causes a warning during reparenting clk8 to clk1:

 ?------------[ cut here ]------------
 ?WARNING: CPU: 0 PID: 59 at drivers/clk/clk.c:811 
clk_core_disable_lock+0x18/0x24
 ?Modules linked in:
 ?CPU: 0 PID: 59 Comm: kworker/0:1 Not tainted 
4.15.0-next-20180130-dirty #131
 ?Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
 ?Workqueue: pm genpd_power_off_work_fn
 ?[<c01114e4>] (unwind_backtrace) from [<c010dbc0>] (show_stack+0x10/0x14)
 ?[<c010dbc0>] (show_stack) from [<c09b7b94>] (dump_stack+0x90/0xc8)
 ?[<c09b7b94>] (dump_stack) from [<c0124ff8>] (__warn+0xe4/0x110)
 ?[<c0124ff8>] (__warn) from [<c0125064>] (warn_slowpath_null+0x40/0x48)
 ?[<c0125064>] (warn_slowpath_null) from [<c048e650>] 
(clk_core_disable_lock+0x18/0x24)
 ?[<c048e650>] (clk_core_disable_lock) from [<c048f51c>] 
(clk_core_disable_unprepare+0xc/0x20)
 ?[<c048f51c>] (clk_core_disable_unprepare) from [<c048faec>] 
(__clk_set_parent_after+0x48/0x4c)
 ?[<c048faec>] (__clk_set_parent_after) from [<c048fd28>] 
(clk_core_set_parent_nolock+0x238/0x5d0)
 ?[<c048fd28>] (clk_core_set_parent_nolock) from [<c04902e4>] 
(clk_set_parent+0x38/0x6c)
 ?[<c04902e4>] (clk_set_parent) from [<c049d760>] 
(exynos_pd_power+0x74/0x1cc)
 ?[<c049d760>] (exynos_pd_power) from [<c0552064>] 
(genpd_power_off+0x164/0x264)
 ?[<c0552064>] (genpd_power_off) from [<c0552430>] 
(genpd_power_off_work_fn+0x2c/0x40)
 ?[<c0552430>] (genpd_power_off_work_fn) from [<c014355c>] 
(process_one_work+0x1d0/0x7bc)
 ?[<c014355c>] (process_one_work) from [<c0143bb4>] 
(worker_thread+0x34/0x4dc)
 ?[<c0143bb4>] (worker_thread) from [<c014a348>] (kthread+0x128/0x164)
 ?[<c014a348>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
 ?Exception stack(0xeeb01fb0 to 0xeeb01ff8)
 ?1fa0:???????????????????????????????????? 00000000 00000000 00000000 
00000000
 ?1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
 ?1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 ?---[ end trace 48eea511a44c78ef ]---
 ?------------[ cut here ]------------
 ?WARNING: CPU: 0 PID: 59 at drivers/clk/clk.c:684 
clk_core_disable_unprepare+0x18/0x20
 ?Modules linked in:
 ?CPU: 0 PID: 59 Comm: kworker/0:1 Tainted: G??????? W 
4.15.0-next-20180130-dirty #131
 ?Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
 ?Workqueue: pm genpd_power_off_work_fn
 ?[<c01114e4>] (unwind_backtrace) from [<c010dbc0>] (show_stack+0x10/0x14)
 ?[<c010dbc0>] (show_stack) from [<c09b7b94>] (dump_stack+0x90/0xc8)
 ?[<c09b7b94>] (dump_stack) from [<c0124ff8>] (__warn+0xe4/0x110)
 ?[<c0124ff8>] (__warn) from [<c0125064>] (warn_slowpath_null+0x40/0x48)
 ?[<c0125064>] (warn_slowpath_null) from [<c048f528>] 
(clk_core_disable_unprepare+0x18/0x20)
 ?[<c048f528>] (clk_core_disable_unprepare) from [<c048faec>] 
(__clk_set_parent_after+0x48/0x4c)
 ?[<c048faec>] (__clk_set_parent_after) from [<c048fd28>] 
(clk_core_set_parent_nolock+0x238/0x5d0)
 ?[<c048fd28>] (clk_core_set_parent_nolock) from [<c04902e4>] 
(clk_set_parent+0x38/0x6c)
 ?[<c04902e4>] (clk_set_parent) from [<c049d760>] 
(exynos_pd_power+0x74/0x1cc)
 ?[<c049d760>] (exynos_pd_power) from [<c0552064>] 
(genpd_power_off+0x164/0x264)
 ?[<c0552064>] (genpd_power_off) from [<c0552430>] 
(genpd_power_off_work_fn+0x2c/0x40)
 ?[<c0552430>] (genpd_power_off_work_fn) from [<c014355c>] 
(process_one_work+0x1d0/0x7bc)
 ?[<c014355c>] (process_one_work) from [<c0143bb4>] 
(worker_thread+0x34/0x4dc)
 ?[<c0143bb4>] (worker_thread) from [<c014a348>] (kthread+0x128/0x164)
 ?[<c014a348>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
 ?Exception stack(0xeeb01fb0 to 0xeeb01ff8)
 ?1fa0:???????????????????????????????????? 00000000 00000000 00000000 
00000000
 ?1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
 ?1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 ?---[ end trace 48eea511a44c78f0 ]---

Please note that this pattern happens for other critical clocks too.

> Hopefully it isn't the worser case, where the clk is handed out
> to some consumer but it's still orphaned at that point, and then
> we have little control over the migration of state to the parent.

Well, in my opinion my patch is simplest fix for the regression
introduced by commit f8f8f1d04494 ("clk: Don't touch hardware when
reparenting during registration"). It also doesn't have any side-effects
as it affects only the situation when orphaned clock has been already
prepared/enabled, what in practice means it or one of its children has
critical flag. Reworking critical clock handling will be much more
complicated.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

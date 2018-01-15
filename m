From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 15 Jan 2018 12:52:14 +0100
Subject: [PATCH] clk: Properly update prepare/enable count on orphan clock
 reparent
References: <CGME20180115115231eucas1p1499f46ca64b65598d03a182ed5670f28@eucas1p1.samsung.com>
Message-ID: <20180115115214.10303-1-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If orphaned clock has been already prepared/enabled (for example if it or
one of its children has CLK_IS_CRITICAL flag), then the prepare/enable
counters of the newly assigned parent are not updated correctly. This
might later cause warnings during changing clock parents.

This patch fixes following warning on Exynos5422-based boards:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 59 at drivers/clk/clk.c:811 clk_core_disable_lock+0x18/0x24
Modules linked in:
CPU: 0 PID: 59 Comm: kworker/0:1 Not tainted 4.15.0-rc7-next-20180115 #106
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
Workqueue: pm genpd_power_off_work_fn
[<c0111504>] (unwind_backtrace) from [<c010dbec>] (show_stack+0x10/0x14)
[<c010dbec>] (show_stack) from [<c09b3f34>] (dump_stack+0x90/0xc8)
[<c09b3f34>] (dump_stack) from [<c0125060>] (__warn+0xe4/0x110)
[<c0125060>] (__warn) from [<c01250cc>] (warn_slowpath_null+0x40/0x48)
[<c01250cc>] (warn_slowpath_null) from [<c048d584>] (clk_core_disable_lock+0x18/0x24)
[<c048d584>] (clk_core_disable_lock) from [<c048e490>] (clk_core_disable_unprepare+0xc/0x20)
[<c048e490>] (clk_core_disable_unprepare) from [<c048ea60>] (__clk_set_parent_after+0x48/0x4c)
[<c048ea60>] (__clk_set_parent_after) from [<c048ec88>] (clk_core_set_parent_nolock+0x224/0x5b4)
[<c048ec88>] (clk_core_set_parent_nolock) from [<c048f23c>] (clk_set_parent+0x38/0x6c)
[<c048f23c>] (clk_set_parent) from [<c049c41c>] (exynos_pd_power+0x74/0x1cc)
[<c049c41c>] (exynos_pd_power) from [<c0550768>] (genpd_power_off+0x164/0x264)
[<c0550768>] (genpd_power_off) from [<c0550b34>] (genpd_power_off_work_fn+0x2c/0x40)
[<c0550b34>] (genpd_power_off_work_fn) from [<c01432e4>] (process_one_work+0x1d0/0x7bc)
[<c01432e4>] (process_one_work) from [<c014393c>] (worker_thread+0x34/0x4dc)
[<c014393c>] (worker_thread) from [<c014a0d0>] (kthread+0x128/0x164)
[<c014a0d0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xeeb01fb0 to 0xeeb01ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 503c239fb760f17a ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 59 at drivers/clk/clk.c:684 clk_core_disable_unprepare+0x18/0x20
Modules linked in:
CPU: 0 PID: 59 Comm: kworker/0:1 Tainted: G        W        4.15.0-rc7-next-20180115 #106
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
Workqueue: pm genpd_power_off_work_fn
[<c0111504>] (unwind_backtrace) from [<c010dbec>] (show_stack+0x10/0x14)
[<c010dbec>] (show_stack) from [<c09b3f34>] (dump_stack+0x90/0xc8)
[<c09b3f34>] (dump_stack) from [<c0125060>] (__warn+0xe4/0x110)
[<c0125060>] (__warn) from [<c01250cc>] (warn_slowpath_null+0x40/0x48)
[<c01250cc>] (warn_slowpath_null) from [<c048e49c>] (clk_core_disable_unprepare+0x18/0x20)
[<c048e49c>] (clk_core_disable_unprepare) from [<c048ea60>] (__clk_set_parent_after+0x48/0x4c)
[<c048ea60>] (__clk_set_parent_after) from [<c048ec88>] (clk_core_set_parent_nolock+0x224/0x5b4)
[<c048ec88>] (clk_core_set_parent_nolock) from [<c048f23c>] (clk_set_parent+0x38/0x6c)
[<c048f23c>] (clk_set_parent) from [<c049c41c>] (exynos_pd_power+0x74/0x1cc)
[<c049c41c>] (exynos_pd_power) from [<c0550768>] (genpd_power_off+0x164/0x264)
[<c0550768>] (genpd_power_off) from [<c0550b34>] (genpd_power_off_work_fn+0x2c/0x40)
[<c0550b34>] (genpd_power_off_work_fn) from [<c01432e4>] (process_one_work+0x1d0/0x7bc)
[<c01432e4>] (process_one_work) from [<c014393c>] (worker_thread+0x34/0x4dc)
[<c014393c>] (worker_thread) from [<c014a0d0>] (kthread+0x128/0x164)
[<c014a0d0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xeeb01fb0 to 0xeeb01ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 503c239fb760f17b ]---
------------[ cut here ]------------

Fixes: f8f8f1d04494 ("clk: Don't touch hardware when reparenting during registration")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0f686a9dac3e..d33c087d7868 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2982,6 +2982,10 @@ static int __clk_core_init(struct clk_core *core)
 		if (parent) {
 			/* update the clk tree topology */
 			flags = clk_enable_lock();
+			if (orphan->prepare_count)
+				clk_core_prepare(parent);
+			if (orphan->enable_count)
+				clk_core_enable(parent);
 			clk_reparent(orphan, parent);
 			clk_enable_unlock(flags);
 			__clk_recalc_accuracies(orphan);
-- 
2.15.0

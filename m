From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 15 May 2017 21:59:16 +0800
Subject: [PATCH 2/9] clk: reparent orphans after critical clocks enabled
In-Reply-To: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1494856763-6543-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The orphan clocks reparent operation should be moved after the critical
clocks enabled, otherwise it may get a chance to disable a newly registered
critical clock which triggers the following warning.

[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/clk/clk.c:597 clk_core_disable+0xb4/0xe0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.11.0-rc1-00056-gdff1f66-dirty #1373
[    0.000000] Hardware name: Generic DT based system
[    0.000000] Backtrace:
[    0.000000] [<c010c4bc>] (dump_backtrace) from [<c010c764>] (show_stack+0x18/0x1c)
[    0.000000]  r6:600000d3 r5:00000000 r4:c0e26358 r3:00000000
[    0.000000] [<c010c74c>] (show_stack) from [<c040599c>] (dump_stack+0xb4/0xe8)
[    0.000000] [<c04058e8>] (dump_stack) from [<c0125c94>] (__warn+0xd8/0x104)
[    0.000000]  r10:c0c21cd0 r9:c048aa78 r8:00000255 r7:00000009 r6:c0c1cd90 r5:00000000
[    0.000000]  r4:00000000 r3:c0e01d34
[    0.000000] [<c0125bbc>] (__warn) from [<c0125d74>] (warn_slowpath_null+0x28/0x30)
[    0.000000]  r9:00000000 r8:ef00bf80 r7:c165ac4c r6:ef00bf80 r5:ef00bf80 r4:ef00bf80
[    0.000000] [<c0125d4c>] (warn_slowpath_null) from [<c048aa78>] (clk_core_disable+0xb4/0xe0)
[    0.000000] [<c048a9c4>] (clk_core_disable) from [<c048be88>] (clk_core_disable_lock+0x20/0x2c)
[    0.000000]  r4:000000d3 r3:c0e0af00
[    0.000000] [<c048be68>] (clk_core_disable_lock) from [<c048c224>] (clk_core_disable_unprepare+0x14/0x28)
[    0.000000]  r5:00000000 r4:ef00bf80
[    0.000000] [<c048c210>] (clk_core_disable_unprepare) from [<c048c270>] (__clk_set_parent_after+0x38/0x54)
[    0.000000]  r4:ef00bd80 r3:000010a0
[    0.000000] [<c048c238>] (__clk_set_parent_after) from [<c048daa8>] (clk_register+0x4d0/0x648)
[    0.000000]  r6:ef00d500 r5:ef00bf80 r4:ef00bd80 r3:ef00bfd4
[    0.000000] [<c048d5d8>] (clk_register) from [<c048dc30>] (clk_hw_register+0x10/0x1c)
[    0.000000]  r9:00000000 r8:00000003 r7:00000000 r6:00000824 r5:00000001 r4:ef00d500
[    0.000000] [<c048dc20>] (clk_hw_register) from [<c048e698>] (_register_divider+0xcc/0x120)
[    0.000000] [<c048e5cc>] (_register_divider) from [<c048e730>] (clk_register_divider+0x44/0x54)
[    0.000000]  r10:00000004 r9:00000003 r8:00000001 r7:00000000 r6:00000003 r5:00000001
[    0.000000]  r4:f0810030
[    0.000000] [<c048e6ec>] (clk_register_divider) from [<c0d3ff58>] (imx7ulp_clocks_init+0x558/0xe98)
[    0.000000]  r7:c0e296f8 r6:c165c808 r5:00000000 r4:c165c808
[    0.000000] [<c0d3fa00>] (imx7ulp_clocks_init) from [<c0d24db0>] (of_clk_init+0x118/0x1e0)
[    0.000000]  r10:00000001 r9:c0e01f68 r8:00000000 r7:c0e01f60 r6:ef7f8974 r5:ef0035c0
[    0.000000]  r4:00000006
[    0.000000] [<c0d24c98>] (of_clk_init) from [<c0d04a50>] (time_init+0x2c/0x38)
[    0.000000]  r10:efffed40 r9:c0d61a48 r8:c0e78000 r7:c0e07900 r6:ffffffff r5:c0e78000
[    0.000000]  r4:00000000
[    0.000000] [<c0d04a24>] (time_init) from [<c0d00b8c>] (start_kernel+0x218/0x394)
[    0.000000] [<c0d00974>] (start_kernel) from [<6000807c>] (0x6000807c)
[    0.000000]  r10:00000000 r9:410fc075 r8:6000406a r7:c0e0c930 r6:c0d61a44 r5:c0e07918
[    0.000000]  r4:c0e78294
[    0.000000] ---[ end trace 0000000000000000 ]---

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fc58c52..e2955b1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2471,25 +2471,6 @@ static int __clk_core_init(struct clk_core *core)
 	core->rate = core->req_rate = rate;
 
 	/*
-	 * walk the list of orphan clocks and reparent any that newly finds a
-	 * parent.
-	 */
-	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
-		struct clk_core *parent = __clk_init_parent(orphan);
-
-		/*
-		 * we could call __clk_set_parent, but that would result in a
-		 * redundant call to the .set_rate op, if it exists
-		 */
-		if (parent) {
-			__clk_set_parent_before(orphan, parent);
-			__clk_set_parent_after(orphan, parent, NULL);
-			__clk_recalc_accuracies(orphan);
-			__clk_recalc_rates(orphan, 0);
-		}
-	}
-
-	/*
 	 * optional platform-specific magic
 	 *
 	 * The .init callback is not used by any of the basic clock types, but
@@ -2511,6 +2492,26 @@ static int __clk_core_init(struct clk_core *core)
 	}
 
 	kref_init(&core->ref);
+
+	/*
+	 * walk the list of orphan clocks and reparent any that newly finds a
+	 * parent.
+	 */
+	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
+		struct clk_core *parent = __clk_init_parent(orphan);
+
+		/*
+		 * we could call __clk_set_parent, but that would result in a
+		 * redundant call to the .set_rate op, if it exists
+		 */
+		if (parent) {
+			__clk_set_parent_before(orphan, parent);
+			__clk_set_parent_after(orphan, parent, NULL);
+			__clk_recalc_accuracies(orphan);
+			__clk_recalc_rates(orphan, 0);
+		}
+	}
+
 out:
 	clk_prepare_unlock();
 
-- 
2.7.4

From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Thu, 20 Jul 2017 02:29:26 +0200
Subject: [PATCH 9/9] ARM: tegra: fix sleeping while atomic in CPU idle
In-Reply-To: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <0a0600cdbcc9a71134105043c3e2ace84bab7c5a.1500510157.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes unnecessary lock causing following BUG splat:

BUG: sleeping function called from invalid context at /linux/kernel/locking/mutex.c:747
in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
no locks held by swapper/0/0.
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W 4.13.0-rc1mq-00016-gbf3f627c6b2b #1
Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[<b0110a14>] (unwind_backtrace) from [<b010c710>] (show_stack+0x18/0x1c)
[<b010c710>] (show_stack) from [<b068ada8>] (dump_stack+0x84/0x98)
[<b068ada8>] (dump_stack) from [<b014ff54>] (___might_sleep+0x158/0x17c)
[<b014ff54>] (___might_sleep) from [<b06a15c4>] (__mutex_lock+0x34/0x9a0)
[<b06a15c4>] (__mutex_lock) from [<b06a30dc>] (mutex_lock_nested+0x24/0x2c)
[<b06a30dc>] (mutex_lock_nested) from [<b041f6d8>] (tegra_powergate_is_powered+0x40/0xa4)
[<b041f6d8>] (tegra_powergate_is_powered) from [<b04197e8>] (tegra30_cpu_rail_off_ready+0x28/0x6c)
[<b04197e8>] (tegra30_cpu_rail_off_ready) from [<b011c73c>] (tegra30_idle_lp2+0x70/0x114)
[<b011c73c>] (tegra30_idle_lp2) from [<b0516080>] (cpuidle_enter_state+0x12c/0x47c)
[<b0516080>] (cpuidle_enter_state) from [<b0163394>] (do_idle+0x1b4/0x204)
[<b0163394>] (do_idle) from [<b016368c>] (cpu_startup_entry+0x20/0x24)
[<b016368c>] (cpu_startup_entry) from [<b0900dd8>] (start_kernel+0x39c/0x3a8)

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 drivers/soc/tegra/pmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index e233dd5dcab3..3e6ec9fdba41 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -526,9 +526,7 @@ int tegra_powergate_is_powered(unsigned int id)
 	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
 
-	mutex_lock(&pmc->powergates_lock);
 	status = tegra_powergate_state(id);
-	mutex_unlock(&pmc->powergates_lock);
 
 	return status;
 }
-- 
2.11.0

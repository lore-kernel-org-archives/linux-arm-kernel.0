From: andre.przywara@arm.com (Andre Przywara)
Date: Thu,  4 May 2017 00:57:37 +0100
Subject: [PATCH] pinctrl: use non-devm kmalloc versions for free functions
Message-ID: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a pinctrl driver gets interrupted during its probe process
(returning -EPROBE_DEFER), the devres system cleans up all allocated
resources. During this process it calls pinmux_generic_free_functions()
and pinctrl_generic_free_groups(), which in turn use managed kmalloc
calls for temporarily allocating some memory. Now those calls seem to
get added to the devres list, but are apparently not covered by the
cleanup process, because this is actually just running and iterating the
existing list. This leads to those mallocs being left with the device,
which the devres manager complains about when the driver eventually gets
probed again:
[    0.825239] ------------[ cut here ]------------
[    0.825256] WARNING: CPU: 1 PID: 89 at drivers/base/dd.c:349 driver_probe_device+0x2ac/0x2e8
[    0.825258] Modules linked in:
[    0.825262]
[    0.825270] CPU: 1 PID: 89 Comm: kworker/1:1 Not tainted 4.11.0 #307
[    0.825272] Hardware name: Pine64+ (DT)
[    0.825283] Workqueue: events deferred_probe_work_func
[    0.825288] task: ffff80007c19c100 task.stack: ffff80007c16c000
[    0.825292] PC is at driver_probe_device+0x2ac/0x2e8
[    0.825296] LR is at driver_probe_device+0x108/0x2e8
[    0.825300] pc : [<ffff000008559234>] lr : [<ffff000008559090>] pstate: 20000045
....
This warning is triggered because the devres list is not empty. In this
case the allocations were using 0 bytes, so no real leaks, but still this
ugly warning.
Looking more closely at these *cleanup* functions, devm_kzalloc() is actually
not needed, because the memory is just allocated temporarily and can be
freed just before returning from this function.
So fix this issue by using the bog standard kcalloc() call instead of
devm_kzalloc() and kfree()ing the memory at the end.

This fixes above warnings on boot, which can be observed on *some* builds
for the Pine64, where the pinctrl driver gets loaded early, but it missing
resources, so gets deferred and is loaded again (successfully) later.
kernelci caught this as well [1].

Signed-off-by: Andre Przywara <andre.przywara@arm.com>

[1] https://storage.kernelci.org/net-next/master/v4.11-rc8-2122-gc08bac03d289/arm64/defconfig/lab-baylibre-seattle/boot-sun50i-a64-pine64-plus.html
---
Hi,

not sure this is the right fix, I am open to suggestions.

Cheers,
Andre.

 drivers/pinctrl/core.c   | 5 +++--
 drivers/pinctrl/pinmux.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 32822b0d..5198415 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -690,8 +690,8 @@ static void pinctrl_generic_free_groups(struct pinctrl_dev *pctldev)
 	void **slot;
 	int i = 0;
 
-	indices = devm_kzalloc(pctldev->dev, sizeof(*indices) *
-			       pctldev->num_groups, GFP_KERNEL);
+	indices = kcalloc(pctldev->num_groups, sizeof(*indices),
+			  GFP_KERNEL);
 	if (!indices)
 		return;
 
@@ -704,6 +704,7 @@ static void pinctrl_generic_free_groups(struct pinctrl_dev *pctldev)
 		radix_tree_delete(&pctldev->pin_group_tree, indices[i]);
 		devm_kfree(pctldev->dev, group);
 	}
+	kfree(indices);
 
 	pctldev->num_groups = 0;
 }
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 29ad315..6a70339 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -836,8 +836,8 @@ void pinmux_generic_free_functions(struct pinctrl_dev *pctldev)
 	void **slot;
 	int i = 0;
 
-	indices = devm_kzalloc(pctldev->dev, sizeof(*indices) *
-			       pctldev->num_functions, GFP_KERNEL);
+	indices = kcalloc(pctldev->num_functions, sizeof(*indices),
+			  GFP_KERNEL);
 	if (!indices)
 		return;
 
@@ -850,6 +850,7 @@ void pinmux_generic_free_functions(struct pinctrl_dev *pctldev)
 		radix_tree_delete(&pctldev->pin_function_tree, indices[i]);
 		devm_kfree(pctldev->dev, function);
 	}
+	kfree(indices);
 
 	pctldev->num_functions = 0;
 }
-- 
2.8.2

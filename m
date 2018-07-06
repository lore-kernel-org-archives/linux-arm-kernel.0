From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  6 Jul 2018 14:36:42 +0200
Subject: [PATCH] soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused
Message-ID: <20180706123651.2792927-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everyone gets these #ifdefs wrong, leading to another warning here:

drivers/soc/ti/wkup_m3_ipc.c:547:12: error: 'wkup_m3_ipc_resume' defined but not used [-Werror=unused-function]
 static int wkup_m3_ipc_resume(struct device *dev)
drivers/soc/ti/wkup_m3_ipc.c:539:12: error: 'wkup_m3_ipc_suspend' defined but not used [-Werror=unused-function]
 static int wkup_m3_ipc_suspend(struct device *dev)

The easiest way to get it right is to remove all the #ifdefs and
let the compiler drop the unused functions silently after we
mark them as __maybe_unused.

Fixes: 7a872b6fb7fd ("soc: ti: wkup_m3_ipc: Add rtc_only with ddr in self refresh mode support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/ti/wkup_m3_ipc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 6840688236b9..f5cb8c0af09f 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -535,8 +535,7 @@ static int wkup_m3_ipc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int wkup_m3_ipc_suspend(struct device *dev)
+static int __maybe_unused wkup_m3_ipc_suspend(struct device *dev)
 {
 	/*
 	 * Nothing needs to be done on suspend even with rtc_only flag set
@@ -544,7 +543,7 @@ static int wkup_m3_ipc_suspend(struct device *dev)
 	return 0;
 }
 
-static int wkup_m3_ipc_resume(struct device *dev)
+static int __maybe_unused wkup_m3_ipc_resume(struct device *dev)
 {
 	if (m3_ipc_state->is_rtc_only) {
 		rproc_shutdown(m3_ipc_state->rproc);
@@ -559,7 +558,6 @@ static int wkup_m3_ipc_resume(struct device *dev)
 static const struct dev_pm_ops wkup_m3_ipc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(wkup_m3_ipc_suspend, wkup_m3_ipc_resume)
 };
-#endif
 
 static const struct of_device_id wkup_m3_ipc_of_match[] = {
 	{ .compatible = "ti,am3352-wkup-m3-ipc", },
@@ -574,9 +572,7 @@ static struct platform_driver wkup_m3_ipc_driver = {
 	.driver = {
 		.name = "wkup_m3_ipc",
 		.of_match_table = wkup_m3_ipc_of_match,
-#ifdef CONFIG_PM
 		.pm = &wkup_m3_ipc_pm_ops,
-#endif
 	},
 };
 
-- 
2.9.0

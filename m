From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Jan 2013 12:03:52 +0000
Subject: [PATCH 16/24] ab8500-bm: Flush all work queues before suspending
In-Reply-To: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
References: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358769840-4763-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Flush all workqueues at suspend time to avoid suspending during work.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Reviewed-by: Marcus COOPER <marcus.xm.cooper@stericsson.com>
Reviewed-on: http://gerrit.lud.stericsson.com/gerrit/61915
---
 drivers/power/ab8500_charger.c |   11 +++++++++++
 drivers/power/ab8500_fg.c      |    5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index da965ee..a632b94 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -2866,6 +2866,17 @@ static int ab8500_charger_suspend(struct platform_device *pdev,
 	if (delayed_work_pending(&di->check_hw_failure_work))
 		cancel_delayed_work(&di->check_hw_failure_work);
 
+	flush_delayed_work(&di->attach_work);
+	flush_delayed_work(&di->usb_charger_attached_work);
+	flush_delayed_work(&di->ac_charger_attached_work);
+	flush_delayed_work(&di->check_usbchgnotok_work);
+	flush_delayed_work(&di->check_vbat_work);
+	flush_delayed_work(&di->kick_wd_work);
+
+	flush_work(&di->usb_link_status_work);
+	flush_work(&di->ac_work);
+	flush_work(&di->detect_usb_type_work);
+
 	return 0;
 }
 #else
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 0378aab..1a78116 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -2410,6 +2410,11 @@ static int ab8500_fg_suspend(struct platform_device *pdev,
 	struct ab8500_fg *di = platform_get_drvdata(pdev);
 
 	flush_delayed_work(&di->fg_periodic_work);
+	flush_work(&di->fg_work);
+	flush_work(&di->fg_acc_cur_work);
+	flush_delayed_work(&di->fg_reinit_work);
+	flush_delayed_work(&di->fg_low_bat_work);
+	flush_delayed_work(&di->fg_check_hw_failure_work);
 
 	/*
 	 * If the FG is enabled we will disable it before going to suspend
-- 
1.7.9.5

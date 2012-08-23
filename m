From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Aug 2012 13:32:50 +0300
Subject: [PATCH v3 10/23] serial: omap: set dev->drvdata before enabling
 pm_runtime
In-Reply-To: <1345717983-18179-1-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
Message-ID: <1345717983-18179-11-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

by the time we call our first pm_runtme_get_sync()
after enable pm_runtime, our resume method might
be called. To avoid problems, we must make sure
that our dev->drvdata is set correctly before
our resume method gets called.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index e07afb3..9f709d4 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1300,6 +1300,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	serial_omap_uart_wq = create_singlethread_workqueue(up->name);
 	INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
 
+	platform_set_drvdata(pdev, up);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 			omap_up_info->autosuspend_timeout);
@@ -1319,7 +1320,6 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
-	platform_set_drvdata(pdev, up);
 	return 0;
 
 err_add_port:
-- 
1.7.12.rc3

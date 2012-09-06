From: balbi@ti.com (Felipe Balbi)
Date: Thu,  6 Sep 2012 15:45:31 +0300
Subject: [PATCH v4 12/21] serial: omap: fix sequence of pm_runtime_* calls.
In-Reply-To: <1346935540-1792-1-git-send-email-balbi@ti.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
Message-ID: <1346935540-1792-13-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ruchika Kharwar <ruchika@ti.com>

pm_runtime_enable() needs to be invoked before
pm_runtime_use_autosuspend(), and
pm_runtime_set_autosuspend_delay() functions.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 99042b0..f5dcb5a 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1333,12 +1333,12 @@ static int serial_omap_probe(struct platform_device *pdev)
 	INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
 
 	platform_set_drvdata(pdev, up);
+	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 			omap_up_info->autosuspend_timeout);
 
 	pm_runtime_irq_safe(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
 	omap_serial_fill_features_erratas(up);
-- 
1.7.12.rc3

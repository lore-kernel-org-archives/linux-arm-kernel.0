From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 21 Oct 2014 16:50:21 +0800
Subject: [PATCH] serial: of-serial: fix uninitialized kmalloc variable
Message-ID: <1413881421-9554-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The info pointer points to an uninitialized kmalloced space.
If a device doesn't have clk property, then info->clk may
have unpredicated value and cause call trace. So use kzalloc
to make sure it is NULL initialized.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 drivers/tty/serial/of_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 8bc2563..56982da4 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -158,7 +158,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	if (of_find_property(ofdev->dev.of_node, "used-by-rtas", NULL))
 		return -EBUSY;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (info == NULL)
 		return -ENOMEM;
 
-- 
1.8.0

From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  3 May 2011 12:46:46 +0400
Subject: [PATCH] gpio-vbus: ask for vbus_draw regulator before registering
	xceiv
In-Reply-To: <20110502233852.GA10108@kroah.com>
References: <20110502233852.GA10108@kroah.com>
Message-ID: <1304412406-9466-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ask for vbus_draw regulator before registering tranceiver to disallow possible
race between registration and set_power/etc.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/otg/gpio_vbus.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/otg/gpio_vbus.c b/drivers/usb/otg/gpio_vbus.c
index 221c444..52733d9 100644
--- a/drivers/usb/otg/gpio_vbus.c
+++ b/drivers/usb/otg/gpio_vbus.c
@@ -279,6 +279,13 @@ static int __init gpio_vbus_probe(struct platform_device *pdev)
 	}
 	INIT_WORK(&gpio_vbus->work, gpio_vbus_work);
 
+	gpio_vbus->vbus_draw = regulator_get(&pdev->dev, "vbus_draw");
+	if (IS_ERR(gpio_vbus->vbus_draw)) {
+		dev_dbg(&pdev->dev, "can't get vbus_draw regulator, err: %ld\n",
+			PTR_ERR(gpio_vbus->vbus_draw));
+		gpio_vbus->vbus_draw = NULL;
+	}
+
 	/* only active when a gadget is registered */
 	err = otg_set_transceiver(&gpio_vbus->otg);
 	if (err) {
@@ -287,13 +294,6 @@ static int __init gpio_vbus_probe(struct platform_device *pdev)
 		goto err_otg;
 	}
 
-	gpio_vbus->vbus_draw = regulator_get(&pdev->dev, "vbus_draw");
-	if (IS_ERR(gpio_vbus->vbus_draw)) {
-		dev_dbg(&pdev->dev, "can't get vbus_draw regulator, err: %ld\n",
-			PTR_ERR(gpio_vbus->vbus_draw));
-		gpio_vbus->vbus_draw = NULL;
-	}
-
 	return 0;
 err_otg:
 	free_irq(irq, &pdev->dev);
-- 
1.7.4.4

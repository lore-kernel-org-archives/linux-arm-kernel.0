From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 15 Aug 2013 18:51:52 +0200
Subject: [PATCH v2 6/8] usb: phy: omap: get rid of omap_get_control_dev()
In-Reply-To: <1376572512-9561-7-git-send-email-rogerq@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
 <1376572512-9561-7-git-send-email-rogerq@ti.com>
Message-ID: <20130815165152.GB10982@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros | 2013-08-15 16:15:10 [+0300]:

>diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
>index 078c46f..d144c14 100644
>--- a/drivers/usb/phy/phy-omap-control.c
>+++ b/drivers/usb/phy/phy-omap-control.c
>@@ -187,11 +167,19 @@ void omap_control_usb_set_mode(struct device *dev,
> {
> 	struct omap_control_usb	*ctrl_usb;
> 
>-	if (IS_ERR(dev) || control_usb->type != OMAP_CTRL_TYPE_OMAP)
>+	if (IS_ERR(dev) || !dev)
> 		return;
> 
> 	ctrl_usb = dev_get_drvdata(dev);
> 
>+	if (!ctrl_usb) {
>+		dev_err(dev, "Invalid control usb device\n");
>+		return;
>+	}
>+
>+	if (ctrl_usb->type != OMAP_CTRL_TYPE_OMAP)
>+		return;
>+

I don't like that part where you can call this function even before the
driver probed the device. This shouldn't happen since you have hard module
dependency and the proper compatible string in your device. But this
kind of thing won't happen in the am335x reset driver.

Sebastian

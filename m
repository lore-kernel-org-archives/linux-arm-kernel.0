From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Oct 2017 22:27:43 +0200
Subject: Backlight on Nokia N900 was Re: 4.13 (and probably all recent)
 kernels refuse to boot on one Nokia N950, work or another
In-Reply-To: <20171026093115.4bc6ctxjx72ng7ld@earth>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
Message-ID: <20171027202743.GA17874@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I got "uncompressing Linux 4.13" on serial console now, debug LEDs
> > blinking, and if I use a flashlight, I see output on the screen, too.
> > 
> > (What do I need to do to get the backlight working?)
> 
> Glad you got it working :) For backlight you can add this
> in drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c:
> 
> add the following code at the end of dsicm_probe:
> 
> -----------------------------------------------------------
> mutex_unlock(&ddata->lock);
> mutex_lock(&ddata->lock);
> ddata->in->ops.dsi->bus_lock(ddata->in);
> r = dsicm_wake_up(ddata);
> if (!r)
>     r = dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 100);
> ddata->in->ops.dsi->bus_unlock(ddata->in);
> mutex_unlock(&ddata->lock);
> -----------------------------------------------------------

Ok, I tried that, and did not help. I also tried removing first
mutex_unlock(), since that's unbalanced and strange. Did not work. So
I commented it out with #if 0, and tried more hacks, but no luck :-(.

(I still see the display.. but no backlight so reading it is
.. difficult.)

Best regards,
								Pavel

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 8f74633..c0bbb42 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -668,6 +668,7 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 		goto err;
 
 	r = dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 0xff);
+	mdelay(1000);
 	if (r)
 		goto err;
 
@@ -703,6 +704,8 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 
 	in->ops.dsi->enable_hs(in, ddata->channel, true);
 
+	r = dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 0xff);
+
 	return 0;
 err:
 	dev_err(&ddata->pdev->dev, "error while enabling panel, issuing HW reset\n");
@@ -1396,6 +1399,15 @@ static int dsicm_probe(struct platform_device *pdev)
 		goto err_bl;
 	}
 
+#if 0	
+	mutex_lock(&ddata->lock);
+	ddata->in->ops.dsi->bus_lock(ddata->in);
+	r = dsicm_wake_up(ddata);
+	if (!r)
+		r = dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 100);
+	ddata->in->ops.dsi->bus_unlock(ddata->in);
+	mutex_unlock(&ddata->lock);
+#endif
 	return 0;
 
 err_bl:



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171027/ed7485d3/attachment.sig>

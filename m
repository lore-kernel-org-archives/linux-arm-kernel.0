From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 30 Oct 2017 08:51:35 +0100
Subject: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
In-Reply-To: <20171026093115.4bc6ctxjx72ng7ld@earth>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
Message-ID: <20171030075135.GB32041@amd>
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

That one did not work; but after some help from Filip, this did:

Best regards,
									Pavel

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index b5ea8e5..2cb74cc 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -385,7 +385,7 @@ static int dsicm_bl_update_status(struct backlight_device *dev)
 
 		r = dsicm_wake_up(ddata);
 		if (!r)
-			r = dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, level);
+			r = dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 0xff /* level */);
 
 		in->ops.dsi->bus_unlock(in);
 	}


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171030/88422386/attachment.sig>

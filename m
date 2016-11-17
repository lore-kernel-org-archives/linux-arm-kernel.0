From: brian.starkey@arm.com (Brian Starkey)
Date: Thu, 17 Nov 2016 12:24:57 +0000
Subject: [PATCH 1/2] drm/i2c: tda998x: allow interrupt to be shared
In-Reply-To: <E1c6xls-0006wf-Jg@rmk-PC.armlinux.org.uk>
References: <E1c6xls-0006wf-Jg@rmk-PC.armlinux.org.uk>
Message-ID: <20161117122457.GC21156@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Nov 16, 2016 at 10:48:52AM +0000, Russell King wrote:
>The TDA998x contains two different I2C devices - there is the HDMI
>encoder, and the TDA9950 CEC engine.  These two share the same interrupt
>signal.
>
>In order to allow a driver for the CEC engine to work, we need to be
>able to share the interrupt with the CEC driver, so convert the handler
>and registration to allow this to happen.
>
>Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>---
>This patch follows on from:
>   "drm/i2c: tda998x: power down pre-filter and color conversion"
>which is now part of my drm-tda998x-devel branch, a branch which will
>shortly be part of linux-next.  This patch and the following patch are
>not part of that branch yet.
>
>I don't believe I received any testing for the power-down patch above
>either, so if I can have some tested-bys/reviewed-bys for it and these
>two patches, that'd be great.  Thanks.

I tested these two and the power-down one on mali-dp and hdlcd. The
output, hotplugging and EDID continued to work; so you can have my
tested-by and reviewed-by for all 3.

Cheers,
Brian

>
>As my Juno has now been fixed, I've been able to test these two patches
>on the HDLCD on Juno and Dove Cubox.
>
> drivers/gpu/drm/i2c/tda998x_drv.c | 52 ++++++++++++++++++++-------------------
> 1 file changed, 27 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
>index bf5eec0c1b4f..74fb59a35269 100644
>--- a/drivers/gpu/drm/i2c/tda998x_drv.c
>+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
>@@ -634,28 +634,30 @@ static irqreturn_t tda998x_irq_thread(int irq, void *data)
> 	bool handled = false;
>
> 	sta = cec_read(priv, REG_CEC_INTSTATUS);
>-	cec = cec_read(priv, REG_CEC_RXSHPDINT);
>-	lvl = cec_read(priv, REG_CEC_RXSHPDLEV);
>-	flag0 = reg_read(priv, REG_INT_FLAGS_0);
>-	flag1 = reg_read(priv, REG_INT_FLAGS_1);
>-	flag2 = reg_read(priv, REG_INT_FLAGS_2);
>-	DRM_DEBUG_DRIVER(
>-		"tda irq sta %02x cec %02x lvl %02x f0 %02x f1 %02x f2 %02x\n",
>-		sta, cec, lvl, flag0, flag1, flag2);
>-
>-	if (cec & CEC_RXSHPDINT_HPD) {
>-		if (lvl & CEC_RXSHPDLEV_HPD)
>-			tda998x_edid_delay_start(priv);
>-		else
>-			schedule_work(&priv->detect_work);
>-
>-		handled = true;
>-	}
>+	if (sta & CEC_INTSTATUS_HDMI) {
>+		cec = cec_read(priv, REG_CEC_RXSHPDINT);
>+		lvl = cec_read(priv, REG_CEC_RXSHPDLEV);
>+		flag0 = reg_read(priv, REG_INT_FLAGS_0);
>+		flag1 = reg_read(priv, REG_INT_FLAGS_1);
>+		flag2 = reg_read(priv, REG_INT_FLAGS_2);
>+		DRM_DEBUG_DRIVER(
>+			"tda irq sta %02x cec %02x lvl %02x f0 %02x f1 %02x f2 %02x\n",
>+			sta, cec, lvl, flag0, flag1, flag2);
>+
>+		if (cec & CEC_RXSHPDINT_HPD) {
>+			if (lvl & CEC_RXSHPDLEV_HPD)
>+				tda998x_edid_delay_start(priv);
>+			else
>+				schedule_work(&priv->detect_work);
>+
>+			handled = true;
>+		}
>
>-	if ((flag2 & INT_FLAGS_2_EDID_BLK_RD) && priv->wq_edid_wait) {
>-		priv->wq_edid_wait = 0;
>-		wake_up(&priv->wq_edid);
>-		handled = true;
>+		if ((flag2 & INT_FLAGS_2_EDID_BLK_RD) && priv->wq_edid_wait) {
>+			priv->wq_edid_wait = 0;
>+			wake_up(&priv->wq_edid);
>+			handled = true;
>+		}
> 	}
>
> 	return IRQ_RETVAL(handled);
>@@ -1542,7 +1544,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
>
> 	/* initialize the optional IRQ */
> 	if (client->irq) {
>-		int irqf_trigger;
>+		unsigned long irq_flags;
>
> 		/* init read EDID waitqueue and HDP work */
> 		init_waitqueue_head(&priv->wq_edid);
>@@ -1552,11 +1554,11 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
> 		reg_read(priv, REG_INT_FLAGS_1);
> 		reg_read(priv, REG_INT_FLAGS_2);
>
>-		irqf_trigger =
>+		irq_flags =
> 			irqd_get_trigger_type(irq_get_irq_data(client->irq));
>+		irq_flags |= IRQF_SHARED | IRQF_ONESHOT;
> 		ret = request_threaded_irq(client->irq, NULL,
>-					   tda998x_irq_thread,
>-					   irqf_trigger | IRQF_ONESHOT,
>+					   tda998x_irq_thread, irq_flags,
> 					   "tda998x", priv);
> 		if (ret) {
> 			dev_err(&client->dev,
>-- 
>2.7.4
>

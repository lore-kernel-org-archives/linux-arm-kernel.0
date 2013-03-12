From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 12 Mar 2013 17:03:18 +0800
Subject: [RFC PATCH 2/3] usb: udc: delete the vbus indicator at individual
 driver
In-Reply-To: <1363078999-7361-1-git-send-email-peter.chen@freescale.com>
References: <1363078999-7361-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363078999-7361-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the common struct usb_gadget own it.

CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: Li Yang <leoli@freescale.com>
CC: Roland Stigge <stigge@antcom.de>
CC: Yu Xu <yuxu@marvell.com>
CC: Chao Xie <chao.xie@marvell.com>
CC: Eric Miao <eric.y.miao@gmail.com>
CC: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci.h         |    2 --
 drivers/usb/chipidea/udc.c        |    8 ++++----
 drivers/usb/gadget/at91_udc.c     |   16 ++++++++--------
 drivers/usb/gadget/at91_udc.h     |    1 -
 drivers/usb/gadget/fsl_udc_core.c |    4 ++--
 drivers/usb/gadget/fsl_usb2_udc.h |    1 -
 drivers/usb/gadget/lpc32xx_udc.c  |    1 +
 drivers/usb/gadget/mv_u3d.h       |    1 -
 drivers/usb/gadget/mv_u3d_core.c  |   14 +++++++-------
 drivers/usb/gadget/mv_udc.h       |    1 -
 drivers/usb/gadget/mv_udc_core.c  |   14 +++++++-------
 drivers/usb/gadget/omap_udc.c     |    4 ++--
 drivers/usb/gadget/omap_udc.h     |    1 -
 drivers/usb/gadget/pch_udc.c      |   10 ++++------
 drivers/usb/gadget/pxa25x_udc.c   |    6 +++---
 drivers/usb/gadget/pxa25x_udc.h   |    1 -
 drivers/usb/gadget/pxa27x_udc.c   |    8 ++++----
 drivers/usb/gadget/pxa27x_udc.h   |    1 -
 drivers/usb/gadget/s3c2410_udc.c  |    6 +++---
 drivers/usb/gadget/s3c2410_udc.h  |    1 -
 20 files changed, 45 insertions(+), 56 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index e25d126..e4c1f63 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -126,7 +126,6 @@ struct hw_bank {
  * @suspended: suspended by host
  * @test_mode: the selected test mode
  * @platdata: platform specific information supplied by parent device
- * @vbus_active: is VBUS active
  * @transceiver: pointer to USB PHY, if any
  * @hcd: pointer to usb_hcd for ehci host driver
  */
@@ -160,7 +159,6 @@ struct ci13xxx {
 	u8				test_mode;
 
 	struct ci13xxx_platform_data	*platdata;
-	int				vbus_active;
 	/* FIXME: some day, we'll not use global phy */
 	bool				global_phy;
 	struct usb_phy			*transceiver;
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 2f45bba..ee6b0a0 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1383,7 +1383,7 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 		return -EOPNOTSUPP;
 
 	spin_lock_irqsave(&ci->lock, flags);
-	ci->vbus_active = is_active;
+	_gadget->vbus_active = is_active;
 	if (ci->driver)
 		gadget_ready = 1;
 	spin_unlock_irqrestore(&ci->lock, flags);
@@ -1566,8 +1566,8 @@ static int ci13xxx_start(struct usb_gadget *gadget,
 	ci->driver = driver;
 	pm_runtime_get_sync(&ci->gadget.dev);
 	if (ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) {
-		if (ci->vbus_active) {
-			if (ci->platdata->flags & CI13XXX_REGS_SHARED) {
+		if (gadget->vbus_active) {
+			if (ci->platdata->flags & CI13XXX_REGS_SHARED)
 				hw_device_reset(ci, USBMODE_CM_DC);
 				hw_enable_vbus_intr(ci);
 			}
@@ -1598,7 +1598,7 @@ static int ci13xxx_stop(struct usb_gadget *gadget,
 	spin_lock_irqsave(&ci->lock, flags);
 
 	if (!(ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) ||
-			ci->vbus_active) {
+			gadget->vbus_active) {
 		hw_device_state(ci, 0);
 		if (ci->platdata->notify_event)
 			ci->platdata->notify_event(ci,
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 45dd292..9508d40 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -173,9 +173,9 @@ static int proc_udc_show(struct seq_file *s, void *unused)
 	seq_printf(s, "%s: version %s\n", driver_name, DRIVER_VERSION);
 
 	seq_printf(s, "vbus %s, pullup %s, %s powered%s, gadget %s\n\n",
-		udc->vbus ? "present" : "off",
+		udc->gadget.vbus_active ? "present" : "off",
 		udc->enabled
-			? (udc->vbus ? "active" : "enabled")
+			? (udc->gadget.vbus_active ? "active" : "enabled")
 			: "disabled",
 		udc->selfpowered ? "self" : "VBUS",
 		udc->suspended ? ", suspended" : "",
@@ -209,7 +209,7 @@ static int proc_udc_show(struct seq_file *s, void *unused)
 	proc_irq_show(s, "imr   ", at91_udp_read(udc, AT91_UDP_IMR));
 	proc_irq_show(s, "isr   ", at91_udp_read(udc, AT91_UDP_ISR));
 
-	if (udc->enabled && udc->vbus) {
+	if (udc->enabled && udc->gadget.vbus_active) {
 		proc_ep_show(s, &udc->ep[0]);
 		list_for_each_entry (ep, &udc->gadget.ep_list, ep.ep_list) {
 			if (ep->ep.desc)
@@ -892,7 +892,7 @@ static void pullup(struct at91_udc *udc, int is_on)
 {
 	int	active = !udc->board.pullup_active_low;
 
-	if (!udc->enabled || !udc->vbus)
+	if (!udc->enabled || !udc->gadget.vbus_active)
 		is_on = 0;
 	DBG("%sactive\n", is_on ? "" : "in");
 
@@ -944,7 +944,7 @@ static int at91_vbus_session(struct usb_gadget *gadget, int is_active)
 
 	/* VDBG("vbus %s\n", is_active ? "on" : "off"); */
 	spin_lock_irqsave(&udc->lock, flags);
-	udc->vbus = (is_active != 0);
+	gadget->vbus_active = (is_active != 0);
 	if (udc->driver)
 		pullup(udc, is_active);
 	else
@@ -1586,7 +1586,7 @@ static struct at91_udc controller = {
 static void at91_vbus_update(struct at91_udc *udc, unsigned value)
 {
 	value ^= udc->board.vbus_active_low;
-	if (value != udc->vbus)
+	if (value != udc->gadget.vbus_active)
 		at91_vbus_session(&udc->gadget, value);
 }
 
@@ -1817,7 +1817,7 @@ static int at91udc_probe(struct platform_device *pdev)
 		 * Get the initial state of VBUS - we cannot expect
 		 * a pending interrupt.
 		 */
-		udc->vbus = gpio_get_value_cansleep(udc->board.vbus_pin) ^
+		udc->gadget.vbus_active = gpio_get_value_cansleep(udc->board.vbus_pin) ^
 			udc->board.vbus_active_low;
 
 		if (udc->board.vbus_polled) {
@@ -1837,7 +1837,7 @@ static int at91udc_probe(struct platform_device *pdev)
 		}
 	} else {
 		DBG("no VBUS detection, assuming always-on\n");
-		udc->vbus = 1;
+		udc->gadget.vbus_active = 1;
 	}
 	retval = usb_add_gadget_udc(dev, &udc->gadget);
 	if (retval)
diff --git a/drivers/usb/gadget/at91_udc.h b/drivers/usb/gadget/at91_udc.h
index e647d1c..6f8c7a4 100644
--- a/drivers/usb/gadget/at91_udc.h
+++ b/drivers/usb/gadget/at91_udc.h
@@ -115,7 +115,6 @@ struct at91_udc {
 	struct usb_gadget		gadget;
 	struct at91_ep			ep[NUM_ENDPOINTS];
 	struct usb_gadget_driver	*driver;
-	unsigned			vbus:1;
 	unsigned			enabled:1;
 	unsigned			clocked:1;
 	unsigned			suspended:1;
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 04d5fef..c343bbf 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -1195,7 +1195,7 @@ static int fsl_wakeup(struct usb_gadget *gadget)
 
 static int can_pullup(struct fsl_udc *udc)
 {
-	return udc->driver && udc->softconnect && udc->vbus_active;
+	return udc->driver && udc->softconnect && udc->gadget.vbus_active;
 }
 
 /* Notify controller that VBUS is powered, Called by whatever
@@ -1208,7 +1208,7 @@ static int fsl_vbus_session(struct usb_gadget *gadget, int is_active)
 	udc = container_of(gadget, struct fsl_udc, gadget);
 	spin_lock_irqsave(&udc->lock, flags);
 	VDBG("VBUS %s", is_active ? "on" : "off");
-	udc->vbus_active = (is_active != 0);
+	udc->gadget.vbus_active = (is_active != 0);
 	if (can_pullup(udc))
 		fsl_writel((fsl_readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
 				&dr_regs->usbcmd);
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index c6703bb..f17ce58 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -483,7 +483,6 @@ struct fsl_udc {
 	spinlock_t lock;
 	struct usb_phy *transceiver;
 	unsigned softconnect:1;
-	unsigned vbus_active:1;
 	unsigned stopped:1;
 	unsigned remote_wakeup:1;
 	unsigned already_stopped:1;
diff --git a/drivers/usb/gadget/lpc32xx_udc.c b/drivers/usb/gadget/lpc32xx_udc.c
index aa04089..13270a9 100644
--- a/drivers/usb/gadget/lpc32xx_udc.c
+++ b/drivers/usb/gadget/lpc32xx_udc.c
@@ -2550,6 +2550,7 @@ static int lpc32xx_vbus_session(struct usb_gadget *gadget, int is_active)
 
 	spin_lock_irqsave(&udc->lock, flags);
 
+	gadget->vbus_active = is_active;
 	/* Doesn't need lock */
 	if (udc->driver) {
 		udc_clk_set(udc, 1);
diff --git a/drivers/usb/gadget/mv_u3d.h b/drivers/usb/gadget/mv_u3d.h
index e32a787..16a6955 100644
--- a/drivers/usb/gadget/mv_u3d.h
+++ b/drivers/usb/gadget/mv_u3d.h
@@ -274,7 +274,6 @@ struct mv_u3d {
 	unsigned int		errors;
 
 	unsigned		softconnect:1;
-	unsigned		vbus_active:1;	/* vbus is active or not */
 	unsigned		remote_wakeup:1; /* support remote wakeup */
 	unsigned		clock_gating:1;	/* clock gating or not */
 	unsigned		active:1;	/* udc is active or not */
diff --git a/drivers/usb/gadget/mv_u3d_core.c b/drivers/usb/gadget/mv_u3d_core.c
index b5cea27..95236db 100644
--- a/drivers/usb/gadget/mv_u3d_core.c
+++ b/drivers/usb/gadget/mv_u3d_core.c
@@ -1159,15 +1159,15 @@ static int mv_u3d_vbus_session(struct usb_gadget *gadget, int is_active)
 
 	spin_lock_irqsave(&u3d->lock, flags);
 
-	u3d->vbus_active = (is_active != 0);
+	u3d->gadget.vbus_active = (is_active != 0);
 	dev_dbg(u3d->dev, "%s: softconnect %d, vbus_active %d\n",
-		__func__, u3d->softconnect, u3d->vbus_active);
+		__func__, u3d->softconnect, u3d->gadget.vbus_active);
 	/*
 	 * 1. external VBUS detect: we can disable/enable clock on demand.
 	 * 2. UDC VBUS detect: we have to enable clock all the time.
 	 * 3. No VBUS detect: we have to enable clock all the time.
 	 */
-	if (u3d->driver && u3d->softconnect && u3d->vbus_active) {
+	if (u3d->driver && u3d->softconnect && u3d->gadget.vbus_active) {
 		retval = mv_u3d_enable(u3d);
 		if (retval == 0) {
 			/*
@@ -1218,9 +1218,9 @@ static int mv_u3d_pullup(struct usb_gadget *gadget, int is_on)
 	spin_lock_irqsave(&u3d->lock, flags);
 
 	dev_dbg(u3d->dev, "%s: softconnect %d, vbus_active %d\n",
-		__func__, u3d->softconnect, u3d->vbus_active);
+		__func__, u3d->softconnect, u3d->gadget.vbus_active);
 	u3d->softconnect = (is_on != 0);
-	if (u3d->driver && u3d->softconnect && u3d->vbus_active) {
+	if (u3d->driver && u3d->softconnect && u3d->gadget.vbus_active) {
 		retval = mv_u3d_enable(u3d);
 		if (retval == 0) {
 			/*
@@ -1231,7 +1231,7 @@ static int mv_u3d_pullup(struct usb_gadget *gadget, int is_on)
 			mv_u3d_ep0_reset(u3d);
 			mv_u3d_controller_start(u3d);
 		}
-	} else if (u3d->driver && u3d->vbus_active) {
+	} else if (u3d->driver && u3d->gadget.vbus_active) {
 		/* stop all the transfer in queue*/
 		mv_u3d_stop_activity(u3d, u3d->driver);
 		mv_u3d_controller_stop(u3d);
@@ -1976,7 +1976,7 @@ static int mv_u3d_probe(struct platform_device *dev)
 	}
 
 	if (!u3d->clock_gating)
-		u3d->vbus_active = 1;
+		u3d->gadget.vbus_active = 1;
 
 	/* enable usb3 controller vbus detection */
 	u3d->vbus_valid_detect = 1;
diff --git a/drivers/usb/gadget/mv_udc.h b/drivers/usb/gadget/mv_udc.h
index 9073436..6d848b4 100644
--- a/drivers/usb/gadget/mv_udc.h
+++ b/drivers/usb/gadget/mv_udc.h
@@ -206,7 +206,6 @@ struct mv_udc {
 
 	int			errors;
 	unsigned		softconnect:1,
-				vbus_active:1,
 				remote_wakeup:1,
 				softconnected:1,
 				force_fs:1,
diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index c8cf959..a553c36 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -1204,12 +1204,12 @@ static int mv_udc_vbus_session(struct usb_gadget *gadget, int is_active)
 	udc = container_of(gadget, struct mv_udc, gadget);
 	spin_lock_irqsave(&udc->lock, flags);
 
-	udc->vbus_active = (is_active != 0);
+	u3d->gadget.vbus_active = (is_active != 0);
 
 	dev_dbg(&udc->dev->dev, "%s: softconnect %d, vbus_active %d\n",
-		__func__, udc->softconnect, udc->vbus_active);
+		__func__, udc->softconnect, u3d->gadget.vbus_active);
 
-	if (udc->driver && udc->softconnect && udc->vbus_active) {
+	if (udc->driver && udc->softconnect && u3d->gadget.vbus_active) {
 		retval = mv_udc_enable(udc);
 		if (retval == 0) {
 			/* Clock is disabled, need re-init registers */
@@ -1244,9 +1244,9 @@ static int mv_udc_pullup(struct usb_gadget *gadget, int is_on)
 	udc->softconnect = (is_on != 0);
 
 	dev_dbg(&udc->dev->dev, "%s: softconnect %d, vbus_active %d\n",
-			__func__, udc->softconnect, udc->vbus_active);
+			__func__, udc->softconnect, u3d->gadget.vbus_active);
 
-	if (udc->driver && udc->softconnect && udc->vbus_active) {
+	if (udc->driver && udc->softconnect && u3d->gadget.vbus_active) {
 		retval = mv_udc_enable(udc);
 		if (retval == 0) {
 			/* Clock is disabled, need re-init registers */
@@ -1254,7 +1254,7 @@ static int mv_udc_pullup(struct usb_gadget *gadget, int is_on)
 			ep0_reset(udc);
 			udc_start(udc);
 		}
-	} else if (udc->driver && udc->vbus_active) {
+	} else if (udc->driver && u3d->gadget.vbus_active) {
 		/* stop all the transfer in queue*/
 		stop_activity(udc, udc->driver);
 		udc_stop(udc);
@@ -2356,7 +2356,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 	if (udc->clock_gating)
 		mv_udc_disable_internal(udc);
 	else
-		udc->vbus_active = 1;
+		u3d->gadget.vbus_active = 1;
 
 	retval = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (retval)
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 06be85c..2d0cf7f 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -1186,7 +1186,7 @@ omap_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
 
 static int can_pullup(struct omap_udc *udc)
 {
-	return udc->driver && udc->softconnect && udc->vbus_active;
+	return udc->driver && udc->softconnect && udc->gadget.vbus_active;
 }
 
 static void pullup_enable(struct omap_udc *udc)
@@ -1253,7 +1253,7 @@ static int omap_vbus_session(struct usb_gadget *gadget, int is_active)
 	udc = container_of(gadget, struct omap_udc, gadget);
 	spin_lock_irqsave(&udc->lock, flags);
 	VDBG("VBUS %s\n", is_active ? "on" : "off");
-	udc->vbus_active = (is_active != 0);
+	gadget->vbus_active = (is_active != 0);
 	if (cpu_is_omap15xx()) {
 		/* "software" detect, ignored if !VBUS_MODE_1510 */
 		l = omap_readl(FUNC_MUX_CTRL_0);
diff --git a/drivers/usb/gadget/omap_udc.h b/drivers/usb/gadget/omap_udc.h
index cfadeb5..62cdb9d 100644
--- a/drivers/usb/gadget/omap_udc.h
+++ b/drivers/usb/gadget/omap_udc.h
@@ -166,7 +166,6 @@ struct omap_udc {
 	struct usb_phy			*transceiver;
 	struct list_head		iso;
 	unsigned			softconnect:1;
-	unsigned			vbus_active:1;
 	unsigned			ep0_pending:1;
 	unsigned			ep0_in:1;
 	unsigned			ep0_set_config:1;
diff --git a/drivers/usb/gadget/pch_udc.c b/drivers/usb/gadget/pch_udc.c
index a787a8e..f49d0d2 100644
--- a/drivers/usb/gadget/pch_udc.c
+++ b/drivers/usb/gadget/pch_udc.c
@@ -333,7 +333,6 @@ struct pch_vbus_gpio_data {
  * @registered:		driver regsitered with system
  * @suspended:		driver in suspended state
  * @connected:		gadget driver associated
- * @vbus_session:	required vbus_session state
  * @set_cfg_not_acked:	pending acknowledgement 4 setup
  * @waiting_zlp_ack:	pending acknowledgement 4 ZLP
  * @data_requests:	DMA pool for data requests
@@ -361,7 +360,6 @@ struct pch_udc_dev {
 			registered:1,
 			suspended:1,
 			connected:1,
-			vbus_session:1,
 			set_cfg_not_acked:1,
 			waiting_zlp_ack:1;
 	struct pci_pool		*data_requests;
@@ -614,7 +612,7 @@ static inline void pch_udc_vbus_session(struct pch_udc_dev *dev,
 {
 	if (is_active) {
 		pch_udc_reconnect(dev);
-		dev->vbus_session = 1;
+		dev->gadget.vbus_active = 1;
 	} else {
 		if (dev->driver && dev->driver->disconnect) {
 			spin_unlock(&dev->lock);
@@ -622,7 +620,7 @@ static inline void pch_udc_vbus_session(struct pch_udc_dev *dev,
 			spin_lock(&dev->lock);
 		}
 		pch_udc_set_disconnect(dev);
-		dev->vbus_session = 0;
+		dev->gadget.vbus_active = 0;
 	}
 }
 
@@ -2745,7 +2743,7 @@ static void pch_udc_dev_isr(struct pch_udc_dev *dev, u32 dev_intr)
 		}
 
 		vbus = pch_vbus_gpio_get_value(dev);
-		if ((dev->vbus_session == 0)
+		if ((dev->gadget.vbus_active == 0)
 			&& (vbus != 1)) {
 			if (dev->driver && dev->driver->disconnect) {
 				spin_unlock(&dev->lock);
@@ -2753,7 +2751,7 @@ static void pch_udc_dev_isr(struct pch_udc_dev *dev, u32 dev_intr)
 				spin_lock(&dev->lock);
 			}
 			pch_udc_reconnect(dev);
-		} else if ((dev->vbus_session == 0)
+		} else if ((dev->gadget.vbus_active == 0)
 			&& (vbus == 1)
 			&& !dev->vbus_gpio.intr)
 			schedule_work(&dev->vbus_gpio.irq_work_fall);
diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index 2bbcdce..1007546 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -926,7 +926,7 @@ static void udc_disable(struct pxa25x_udc *);
  */
 static int pullup(struct pxa25x_udc *udc)
 {
-	int is_active = udc->vbus && udc->pullup && !udc->suspended;
+	int is_active = udc->gadget.vbus_active && udc->pullup && !udc->suspended;
 	DMSG("%s\n", is_active ? "active" : "inactive");
 	if (is_active) {
 		if (!udc->active) {
@@ -959,7 +959,7 @@ static int pxa25x_udc_vbus_session(struct usb_gadget *_gadget, int is_active)
 	struct pxa25x_udc	*udc;
 
 	udc = container_of(_gadget, struct pxa25x_udc, gadget);
-	udc->vbus = is_active;
+	udc->gadget.vbus_active = is_active;
 	DMSG("vbus %s\n", is_active ? "supplied" : "inactive");
 	pullup(udc);
 	return 0;
@@ -2152,7 +2152,7 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 	udc_disable(dev);
 	udc_reinit(dev);
 
-	dev->vbus = 0;
+	dev->gadget.vbus_active = 0;
 
 	/* irq setup after old hardware state is cleaned up */
 	retval = request_irq(irq, pxa25x_udc_irq,
diff --git a/drivers/usb/gadget/pxa25x_udc.h b/drivers/usb/gadget/pxa25x_udc.h
index 3fe5931..3039992 100644
--- a/drivers/usb/gadget/pxa25x_udc.h
+++ b/drivers/usb/gadget/pxa25x_udc.h
@@ -103,7 +103,6 @@ struct pxa25x_udc {
 	enum ep0_state				ep0state;
 	struct udc_stats			stats;
 	unsigned				got_irq : 1,
-						vbus : 1,
 						pullup : 1,
 						has_cfr : 1,
 						req_pending : 1,
diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index f7d2579..de997c5 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -1574,7 +1574,7 @@ static int should_enable_udc(struct pxa_udc *udc)
 	int put_on;
 
 	put_on = ((udc->pullup_on) && (udc->driver));
-	put_on &= ((udc->vbus_sensed) || (IS_ERR_OR_NULL(udc->transceiver)));
+	put_on &= ((udc->gadget.vbus_active) || (IS_ERR_OR_NULL(udc->transceiver)));
 	return put_on;
 }
 
@@ -1595,7 +1595,7 @@ static int should_disable_udc(struct pxa_udc *udc)
 	int put_off;
 
 	put_off = ((!udc->pullup_on) || (!udc->driver));
-	put_off |= ((!udc->vbus_sensed) && (!IS_ERR_OR_NULL(udc->transceiver)));
+	put_off |= ((!udc->gadget.vbus_active) && (!IS_ERR_OR_NULL(udc->transceiver)));
 	return put_off;
 }
 
@@ -1640,7 +1640,7 @@ static int pxa_udc_vbus_session(struct usb_gadget *_gadget, int is_active)
 {
 	struct pxa_udc *udc = to_gadget_udc(_gadget);
 
-	udc->vbus_sensed = is_active;
+	_gadget->vbus_active = is_active;
 	if (should_enable_udc(udc))
 		udc_enable(udc);
 	if (should_disable_udc(udc))
@@ -2465,7 +2465,7 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = NULL;
-	udc->vbus_sensed = 0;
+	udc->gadget.vbus_active = 0;
 
 	the_controller = udc;
 	platform_set_drvdata(pdev, udc);
diff --git a/drivers/usb/gadget/pxa27x_udc.h b/drivers/usb/gadget/pxa27x_udc.h
index 28f2b53..184bf45 100644
--- a/drivers/usb/gadget/pxa27x_udc.h
+++ b/drivers/usb/gadget/pxa27x_udc.h
@@ -458,7 +458,6 @@ struct pxa_udc {
 	unsigned				enabled:1;
 	unsigned				pullup_on:1;
 	unsigned				pullup_resume:1;
-	unsigned				vbus_sensed:1;
 	unsigned				config:2;
 	unsigned				last_interface:3;
 	unsigned				last_alternate:3;
diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index fc07b43..ae7a7e3 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -1494,7 +1494,7 @@ static int s3c2410_udc_vbus_session(struct usb_gadget *gadget, int is_active)
 
 	dprintk(DEBUG_NORMAL, "%s()\n", __func__);
 
-	udc->vbus = (is_active != 0);
+	gadget->vbus_active = (is_active != 0);
 	s3c2410_udc_set_pullup(udc, is_active);
 	return 0;
 }
@@ -1520,7 +1520,7 @@ static irqreturn_t s3c2410_udc_vbus_irq(int irq, void *_dev)
 	if (udc_info->vbus_pin_inverted)
 		value = !value;
 
-	if (value != dev->vbus)
+	if (value != &dev->gadget.vbus)
 		s3c2410_udc_vbus_session(&dev->gadget, value);
 
 	return IRQ_HANDLED;
@@ -1887,7 +1887,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 
 		dev_dbg(dev, "got irq %i\n", irq);
 	} else {
-		udc->vbus = 1;
+		udc->gadget.vbus = 1;
 	}
 
 	if (udc_info && !udc_info->udc_command &&
diff --git a/drivers/usb/gadget/s3c2410_udc.h b/drivers/usb/gadget/s3c2410_udc.h
index 93bf225..ca5ad98 100644
--- a/drivers/usb/gadget/s3c2410_udc.h
+++ b/drivers/usb/gadget/s3c2410_udc.h
@@ -92,7 +92,6 @@ struct s3c2410_udc {
 	unsigned			req_std : 1;
 	unsigned			req_config : 1;
 	unsigned			req_pending : 1;
-	u8				vbus;
 	struct dentry			*regs_info;
 };
 #define to_s3c2410(g)	(container_of((g), struct s3c2410_udc, gadget))
-- 
1.7.0.4

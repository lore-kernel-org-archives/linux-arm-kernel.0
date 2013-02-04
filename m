From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 4 Feb 2013 11:03:54 +0800
Subject: [PATCH v6 3/8] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <1359947039-23906-1-git-send-email-peter.chen@freescale.com>
References: <1359947039-23906-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1359947039-23906-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main design flow is the same with msm otg driver, that is the id and
vbus interrupt are handled at core driver, others are handled by
individual drivers.

- At former design, when switch usb role from device->host, it will call
udc_stop, it will remove the gadget driver, so when switch role
from host->device, it can't add gadget driver any more.
At new design, when role switch occurs, the gadget just calls
usb_gadget_vbus_disconnect/usb_gadget_vbus_connect as well as
reset controller, it will not free any device/gadget structure

- Add vbus connect and disconnect to core interrupt handler, it can
notify udc driver by calling usb_gadget_vbus_disconnect
/usb_gadget_vbus_connect.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/bits.h |   10 +++
 drivers/usb/chipidea/ci.h   |    6 ++
 drivers/usb/chipidea/core.c |  182 +++++++++++++++++++++++++++++++++++++++----
 drivers/usb/chipidea/otg.c  |   28 ++++---
 drivers/usb/chipidea/otg.h  |    3 +
 drivers/usb/chipidea/udc.c  |    2 +
 6 files changed, 206 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
index 050de85..ba9c6ef 100644
--- a/drivers/usb/chipidea/bits.h
+++ b/drivers/usb/chipidea/bits.h
@@ -65,11 +65,21 @@
 #define OTGSC_ASVIS	      BIT(18)
 #define OTGSC_BSVIS	      BIT(19)
 #define OTGSC_BSEIS	      BIT(20)
+#define OTGSC_1MSIS	      BIT(21)
+#define OTGSC_DPIS	      BIT(22)
 #define OTGSC_IDIE	      BIT(24)
 #define OTGSC_AVVIE	      BIT(25)
 #define OTGSC_ASVIE	      BIT(26)
 #define OTGSC_BSVIE	      BIT(27)
 #define OTGSC_BSEIE	      BIT(28)
+#define OTGSC_1MSIE	      BIT(29)
+#define OTGSC_DPIE	      BIT(30)
+#define OTGSC_INT_EN_BITS	(OTGSC_IDIE | OTGSC_AVVIE | OTGSC_ASVIE \
+				| OTGSC_BSVIE | OTGSC_BSEIE | OTGSC_1MSIE \
+				| OTGSC_DPIE)
+#define OTGSC_INT_STATUS_BITS	(OTGSC_IDIS | OTGSC_AVVIS | OTGSC_ASVIS	\
+				| OTGSC_BSVIS | OTGSC_BSEIS | OTGSC_1MSIS \
+				| OTGSC_DPIS)
 
 /* USBMODE */
 #define USBMODE_CM            (0x03UL <<  0)
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 697e369..325d790 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -130,6 +130,7 @@ struct hw_bank {
  * @transceiver: pointer to USB PHY, if any
  * @hcd: pointer to usb_hcd for ehci host driver
  * @otg: for otg support
+ * @events: events for otg, and handled@ci_role_work
  */
 struct ci13xxx {
 	struct device			*dev;
@@ -140,6 +141,7 @@ struct ci13xxx {
 	enum ci_role			role;
 	bool				is_otg;
 	struct work_struct		work;
+	struct delayed_work		dwork;
 	struct workqueue_struct		*wq;
 
 	struct dma_pool			*qh_pool;
@@ -166,6 +168,8 @@ struct ci13xxx {
 	struct usb_phy			*transceiver;
 	struct usb_hcd			*hcd;
 	struct usb_otg      		otg;
+	bool				id_event;
+	bool				b_sess_valid_event;
 };
 
 static inline struct ci_role_driver *ci_role(struct ci13xxx *ci)
@@ -314,4 +318,6 @@ int hw_port_test_set(struct ci13xxx *ci, u8 mode);
 
 u8 hw_port_test_get(struct ci13xxx *ci);
 
+void ci_handle_vbus_change(struct ci13xxx *ci);
+
 #endif	/* __DRIVERS_USB_CHIPIDEA_CI_H */
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 57cae1f..8857b2c 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -73,6 +73,7 @@
 #include "bits.h"
 #include "host.h"
 #include "debug.h"
+#include "otg.h"
 
 /* Controller register map */
 static uintptr_t ci_regs_nolpm[] = {
@@ -199,6 +200,14 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
 	if (ci->hw_ep_max > ENDPT_MAX)
 		return -ENODEV;
 
+	/* Disable all interrupts bits */
+	hw_write(ci, OP_USBINTR, 0xffffffff, 0);
+	ci_disable_otg_interrupt(ci, OTGSC_INT_EN_BITS);
+
+	/* Clear all interrupts status bits*/
+	hw_write(ci, OP_USBSTS, 0xffffffff, 0xffffffff);
+	ci_clear_otg_interrupt(ci, OTGSC_INT_STATUS_BITS);
+
 	dev_dbg(ci->dev, "ChipIdea HDRC found, lpm: %d; cap: %p op: %p\n",
 		ci->hw_bank.lpm, ci->hw_bank.cap, ci->hw_bank.op);
 
@@ -265,24 +274,132 @@ static enum ci_role ci_otg_role(struct ci13xxx *ci)
 }
 
 /**
- * ci_role_work - perform role changing based on ID pin
- * @work: work struct
+ * hw_wait_reg: wait the register value
+ *
+ * Sometimes, it needs to wait register value before going on.
+ * Eg, when switch to device mode, the vbus value should be lower
+ * than OTGSC_BSV before connects to host.
+ *
+ * @ci: the controller
+ * @reg: register index
+ * @mask: mast bit
+ * @value: the bit value to wait
+ * @timeout: timeout to indicate an error
+ *
+ * This function returns an error code if timeout
  */
-static void ci_role_work(struct work_struct *work)
+static int hw_wait_reg(struct ci13xxx *ci, enum ci13xxx_regs reg, u32 mask,
+				u32 value, unsigned long timeout)
+{
+	unsigned long elapse = jiffies + timeout;
+
+	while (hw_read(ci, reg, mask) != value) {
+		if (time_after(jiffies, elapse)) {
+			dev_err(ci->dev, "timeout waiting for %08x in %d\n",
+					mask, reg);
+			return -ETIMEDOUT;
+		}
+		msleep(20);
+	}
+
+	return 0;
+}
+
+/* 
+ * Since there are some capacitances at vbus, the vbus may not
+ * change very quickly when we stop/start internal 5v.
+ * Below is a vbus stable timeout value, the routine will quit
+ * if the vbus gets the required value, we can think there are some
+ * problems for hardware if the vbus can't get the required value
+ * within 5 seconds.
+ */
+#define CI_VBUS_STABLE_TIMEOUT 500
+static void ci_handle_id_switch(struct ci13xxx *ci)
 {
-	struct ci13xxx *ci = container_of(work, struct ci13xxx, work);
 	enum ci_role role = ci_otg_role(ci);
 
 	if (role != ci->role) {
 		dev_dbg(ci->dev, "switching from %s to %s\n",
 			ci_role(ci)->name, ci->roles[role]->name);
 
-		ci_role_stop(ci);
-		ci_role_start(ci, role);
-		enable_irq(ci->irq);
+		/* 1. Finish the current role */
+		if (ci->role == CI_ROLE_GADGET) {
+			usb_gadget_vbus_disconnect(&ci->gadget);
+			/* host doesn't care B_SESSION_VALID event */
+			ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
+			ci_disable_otg_interrupt(ci, OTGSC_BSVIE);
+			ci->role = CI_ROLE_END;
+			/* reset controller */
+			hw_device_reset(ci, USBMODE_CM_IDLE);
+		} else if (ci->role == CI_ROLE_HOST) {
+			ci_role_stop(ci);
+			/* reset controller */
+			hw_device_reset(ci, USBMODE_CM_IDLE);
+		}
+
+		/* 2. Turn on/off vbus according to coming role */
+		if (ci_otg_role(ci) == CI_ROLE_GADGET) {
+			otg_set_vbus(&ci->otg, false);
+			/* wait vbus lower than OTGSC_BSV */
+			hw_wait_reg(ci, OP_OTGSC, OTGSC_BSV, 0,
+					CI_VBUS_STABLE_TIMEOUT);
+		} else if (ci_otg_role(ci) == CI_ROLE_HOST) {
+			otg_set_vbus(&ci->otg, true);
+			/* wait vbus higher than OTGSC_AVV */
+			hw_wait_reg(ci, OP_OTGSC, OTGSC_AVV, OTGSC_AVV,
+					CI_VBUS_STABLE_TIMEOUT);
+		}
+
+		/* 3. Begin the new role */
+		if (ci_otg_role(ci) == CI_ROLE_GADGET) {
+			ci->role = role;
+			ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
+			ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
+		} else if (ci_otg_role(ci) == CI_ROLE_HOST) {
+			ci_role_start(ci, role);
+		}
 	}
 }
 
+void ci_handle_vbus_change(struct ci13xxx *ci)
+{
+	u32 otgsc = hw_read(ci, OP_OTGSC, ~0);
+
+	if (otgsc & OTGSC_BSV)
+		usb_gadget_vbus_connect(&ci->gadget);
+	else
+		usb_gadget_vbus_disconnect(&ci->gadget);
+}
+
+/**
+ * ci_otg_work - perform otg (vbus/id) event handle
+ * @work: work struct
+ */
+static void ci_otg_work(struct work_struct *work)
+{
+	struct ci13xxx *ci = container_of(work, struct ci13xxx, work);
+
+	if (ci->id_event) {
+		ci->id_event = false;
+		ci_handle_id_switch(ci);
+	} else if (ci->b_sess_valid_event) {
+		ci->b_sess_valid_event = false;
+		ci_handle_vbus_change(ci);
+	} else
+		dev_err(ci->dev, "unexpected event occurs at %s\n", __func__);
+
+	enable_irq(ci->irq);
+}
+
+static void ci_delayed_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct ci13xxx *ci = container_of(dwork, struct ci13xxx, dwork);
+
+	otg_set_vbus(&ci->otg, true);
+
+}
+
 static ssize_t show_role(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -324,16 +441,34 @@ static irqreturn_t ci_irq(int irq, void *data)
 	if (ci->is_otg)
 		otgsc = hw_read(ci, OP_OTGSC, ~0);
 
-	if (ci->role != CI_ROLE_END)
-		ret = ci_role(ci)->irq(ci);
+	/*
+	 * Handle id change interrupt, it indicates device/host function
+	 * switch.
+	 */
+	if (ci->is_otg && (otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS)) {
+		ci->id_event = true;
+		ci_clear_otg_interrupt(ci, OTGSC_IDIS);
+		disable_irq_nosync(ci->irq);
+		queue_work(ci->wq, &ci->work);
+		return IRQ_HANDLED;
+	}
 
-	if (ci->is_otg && (otgsc & OTGSC_IDIS)) {
-		hw_write(ci, OP_OTGSC, OTGSC_IDIS, OTGSC_IDIS);
+	/*
+	 * Handle vbus change interrupt, it indicates device connection
+	 * and disconnection events.
+	 */
+	if ((otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS)) {
+		ci->b_sess_valid_event = true;
+		ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
 		disable_irq_nosync(ci->irq);
 		queue_work(ci->wq, &ci->work);
-		ret = IRQ_HANDLED;
+		return IRQ_HANDLED;
 	}
 
+	/* Handle device/host interrupt */
+	if (ci->role != CI_ROLE_END)
+		ret = ci_role(ci)->irq(ci);
+
 	return ret;
 }
 
@@ -398,6 +533,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	struct resource	*res;
 	void __iomem	*base;
 	int		ret;
+	u32		otgsc;
 
 	if (!dev->platform_data) {
 		dev_err(dev, "platform data missing\n");
@@ -443,7 +579,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	INIT_WORK(&ci->work, ci_role_work);
+	INIT_WORK(&ci->work, ci_otg_work);
+	INIT_DELAYED_WORK(&ci->dwork, ci_delayed_work);
 	ci->wq = create_singlethread_workqueue("ci_otg");
 	if (!ci->wq) {
 		dev_err(dev, "can't create workqueue\n");
@@ -466,7 +603,10 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
+		dev_dbg(dev, "support otg\n");
 		ci->is_otg = true;
+		/* if otg is supported, create struct usb_otg */
+		ci_hdrc_otg_init(ci);
 		/* ID pin needs 1ms debouce time, we delay 2ms for safe */
 		mdelay(2);
 		ci->role = ci_otg_role(ci);
@@ -483,6 +623,17 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		goto rm_wq;
 	}
 
+	otgsc = hw_read(ci, OP_OTGSC, ~0);
+	/*
+	 * if it is device mode:
+	 * - Enable vbus detect
+	 * - If it has already connected to host, notify udc
+	 */
+	if (ci->role == CI_ROLE_GADGET) {
+		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
+		ci_handle_vbus_change(ci);
+	}
+
 	platform_set_drvdata(pdev, ci);
 	ret = request_irq(ci->irq, ci_irq, IRQF_SHARED, ci->platdata->name,
 			  ci);
@@ -493,8 +644,9 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret)
 		goto rm_attr;
 
-	if (ci->is_otg)
-		hw_write(ci, OP_OTGSC, OTGSC_IDIE, OTGSC_IDIE);
+	/* Handle the situation that usb device at the MicroB to A cable */
+	if (ci->is_otg && !(otgsc & OTGSC_ID))
+		queue_delayed_work(ci->wq, &ci->dwork, msecs_to_jiffies(500));
 
 	return ret;
 
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 7dea3b3..2986d91 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -10,21 +10,28 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/gadget.h>
 #include <linux/usb/chipidea.h>
 
 #include "ci.h"
-#include "udc.h"
 #include "bits.h"
-#include "host.h"
-#include "debug.h"
+
+void ci_clear_otg_interrupt(struct ci13xxx *ci, u32 bits)
+{
+	/* Only clear request bits */
+	hw_write(ci, OP_OTGSC, OTGSC_INT_STATUS_BITS, bits);
+}
+
+void ci_enable_otg_interrupt(struct ci13xxx *ci, u32 bits)
+{
+	hw_write(ci, OP_OTGSC, bits, bits);
+}
+
+void ci_disable_otg_interrupt(struct ci13xxx *ci, u32 bits)
+{
+	hw_write(ci, OP_OTGSC, bits, 0);
+}
 
 static int ci_otg_set_peripheral(struct usb_otg *otg,
 		struct usb_gadget *periph)
@@ -55,6 +62,7 @@ int ci_hdrc_otg_init(struct ci13xxx *ci)
 	ci->otg.set_host = ci_otg_set_host;
 	if (!IS_ERR_OR_NULL(ci->transceiver))
 		ci->transceiver->otg = &ci->otg;
+	ci_enable_otg_interrupt(ci, OTGSC_IDIE);
 
 	return 0;
 }
diff --git a/drivers/usb/chipidea/otg.h b/drivers/usb/chipidea/otg.h
index b4c6b3e..fa30428 100644
--- a/drivers/usb/chipidea/otg.h
+++ b/drivers/usb/chipidea/otg.h
@@ -2,5 +2,8 @@
 #define __DRIVERS_USB_CHIPIDEA_OTG_H
 
 int ci_hdrc_otg_init(struct ci13xxx *ci);
+void ci_clear_otg_interrupt(struct ci13xxx *ci, u32 bits);
+void ci_enable_otg_interrupt(struct ci13xxx *ci, u32 bits);
+void ci_disable_otg_interrupt(struct ci13xxx *ci, u32 bits);
 
 #endif /* __DRIVERS_USB_CHIPIDEA_OTG_H */
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index d214448..83e54bb 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1371,6 +1371,7 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 			pm_runtime_get_sync(&_gadget->dev);
 			hw_device_reset(ci, USBMODE_CM_DC);
 			hw_device_state(ci, ci->ep0out->qh.dma);
+			dev_dbg(ci->dev, "Connected to host\n");
 		} else {
 			hw_device_state(ci, 0);
 			if (ci->platdata->notify_event)
@@ -1378,6 +1379,7 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 				CI13XXX_CONTROLLER_STOPPED_EVENT);
 			_gadget_stop_activity(&ci->gadget);
 			pm_runtime_put_sync(&_gadget->dev);
+			dev_dbg(ci->dev, "Disconnected from host\n");
 		}
 	}
 
-- 
1.7.0.4

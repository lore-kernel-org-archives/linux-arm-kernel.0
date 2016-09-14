From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 13 Sep 2016 17:00:39 -0700
Subject: [RFC/PATCH] usb: chipidea: Emulate OTGSC interrupt enable path
Message-ID: <20160914000039.21689-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of an extcon-usb-gpio device being used with the
chipidea driver we'll sometimes miss the BSVIS event in the OTGSC
register. Consider the case where we don't have a cable attached
and the id pin is indicating "host" mode. When we plug in the usb
cable for "device" mode a gpio goes high and indicates that we
should do the role switch and that vbus is high. When we're in
"host" mode the OTGSC register doesn't have BSVIE set.

The following scenario can happen:

CPU0
----
<extcon notifier chain>
 ci_cable_notifier()
  update id cable state
  ci_irq()
   if (ci->is_otg && (otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS)) { // true
    ci->id_event = true;
    ci_otg_queue_work()
     schedule()

<extcon notifier event> // same task as before
 ci_cable_notifier()
  update vbus cable state
   ci_irq()
    if (ci->is_otg && (otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS)) // false
   return IRQ_NONE

ci_otg_work() // switch task to the workqueue now
 if (ci->id_event)
  ci_handle_id_switch()
   ci_role_stop()
    host_stop()
   hw_wait_vbus_lower_bsv(ci); // this times out because vbus is already set
   ci_role_start()
    udc_id_switch_for_device()
     hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE, OTGSC_BSVIS | OTGSC_BSVIE);

At this point, we don't replay the vbus connect event because the
vbus event has already happened. This causes things like gadget
instances to never see vbus appear, and thus the gadget is never
started. Furthermore, we see timeout messages like:

	timeout waiting for 0000800 in OTGSC

Let's workaround this by skiping the wait for BSV when we're
using an extcon for the vbus notification and let's properly
emulate the BSVIS event that would happen when we enable the
vbus interrupt while enabling "device" mode.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

This is on top of my patch series that modifies how we handle the extcon
events here. The extcon handling looks racy in this driver even after
this patch. I think we may need to add a spinlock around the cable
state changes and the otgsc register read/write functions. The driver
doesn't seem to expect that the extcon notifiers could run in parallel
with the OTG state machine, and emulating the interrupts is "weird"
in the sense that most of the irq handler in core.c assumes that there's
only one interrupt and so we couldn't possibly be in the irq handler 
at the same time on different CPUs (which it can!).

Also, can we just remove the BSV waiting part? From what I can tell, that
is racy if someone can get the workqueue to be delayed significantly enough
to have vbus go high (again) during the role switch. I understand that we're
doing it to prevent a vbus event from happening when we switch to the device
role even though there isn't a cable attached. It just doesn't seem like it's
safe to assume a high-low-high transition won't happen and be reflected in
the status bits. It's really easy to trigger this with an extcon-usb-gpio device
like can be found on 96boards platforms like db410c.

 drivers/usb/chipidea/ci.h   |  2 ++
 drivers/usb/chipidea/core.c | 23 +++++++++++++++++------
 drivers/usb/chipidea/otg.c  | 31 ++++++++++++++++++++++++-------
 3 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 59e22389c10b..e099b8bc79e2 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -437,6 +437,8 @@ static inline void ci_ulpi_exit(struct ci_hdrc *ci) { }
 static inline int ci_ulpi_resume(struct ci_hdrc *ci) { return 0; }
 #endif
 
+irqreturn_t __ci_irq(int irq, struct ci_hdrc *ci);
+
 u32 hw_read_intr_enable(struct ci_hdrc *ci);
 
 u32 hw_read_intr_status(struct ci_hdrc *ci);
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index ba3a43bbe0ea..fbef1c961572 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -528,9 +528,8 @@ int hw_device_reset(struct ci_hdrc *ci)
 	return 0;
 }
 
-static irqreturn_t ci_irq(int irq, void *data)
+irqreturn_t __ci_irq(int irq, struct ci_hdrc *ci)
 {
-	struct ci_hdrc *ci = data;
 	irqreturn_t ret = IRQ_NONE;
 	u32 otgsc = 0;
 
@@ -574,9 +573,20 @@ static irqreturn_t ci_irq(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	/* Handle device/host interrupt */
-	if (ci->role != CI_ROLE_END)
-		ret = ci_role(ci)->irq(ci);
+	return ret;
+}
+
+static irqreturn_t ci_irq(int irq, void *data)
+{
+	irqreturn_t ret;
+	struct ci_hdrc *ci = data;
+
+	ret = __ci_irq(irq, ci);
+	if (ret == IRQ_NONE) {
+		/* Handle device/host interrupt */
+		if (ci->role != CI_ROLE_END)
+			ret = ci_role(ci)->irq(ci);
+	}
 
 	return ret;
 }
@@ -590,7 +600,8 @@ static int ci_cable_notifier(struct notifier_block *nb, unsigned long event,
 	cbl->connected = event;
 	cbl->changed = true;
 
-	ci_irq(ci->irq, ci);
+	__ci_irq(ci->irq, ci);
+
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 695f3fe3ae21..4420428c0bfd 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -84,36 +84,44 @@ u32 hw_read_otgsc(struct ci_hdrc *ci, u32 mask)
 void hw_write_otgsc(struct ci_hdrc *ci, u32 mask, u32 data)
 {
 	struct ci_hdrc_cable *cable;
+	bool raise_irq = false;
 
 	cable = &ci->platdata->vbus_extcon;
 	if (!IS_ERR(cable->edev)) {
-		if (data & mask & OTGSC_BSVIS)
-			cable->changed = false;
-
 		/* Don't enable vbus interrupt if using external notifier */
 		if (data & mask & OTGSC_BSVIE) {
+			if (cable->enabled == false && cable->changed == true)
+				raise_irq = true;
 			cable->enabled = true;
 			data &= ~OTGSC_BSVIE;
 		} else if (mask & OTGSC_BSVIE) {
 			cable->enabled = false;
 		}
+
+		if (data & mask & OTGSC_BSVIS)
+			cable->changed = false;
 	}
 
 	cable = &ci->platdata->id_extcon;
 	if (!IS_ERR(cable->edev)) {
-		if (data & mask & OTGSC_IDIS)
-			cable->changed = false;
-
 		/* Don't enable id interrupt if using external notifier */
 		if (data & mask & OTGSC_IDIE) {
+			if (cable->enabled == false && cable->changed == true)
+				raise_irq = true;
 			cable->enabled = true;
 			data &= ~OTGSC_IDIE;
 		} else if (mask & OTGSC_IDIE) {
 			cable->enabled = false;
 		}
+
+		if (data & mask & OTGSC_IDIS)
+			cable->changed = false;
 	}
 
 	hw_write(ci, OP_OTGSC, mask | OTGSC_INT_STATUS_BITS, data);
+
+	if (raise_irq)
+		__ci_irq(ci->irq, ci);
 }
 
 /**
@@ -175,7 +183,16 @@ static void ci_handle_id_switch(struct ci_hdrc *ci)
 
 		ci_role_stop(ci);
 
-		if (role == CI_ROLE_GADGET)
+		/*
+		 * BSV could be set "immediately" if we're using extcon for
+		 * VBUS because sometimes it's a single GPIO for ID and VBUS
+		 * like in the case of extcon-usb-gpio. In that case we ignore
+		 * waiting for a BSV transition. Really we can't tell when BSV
+		 * is low and the cable is connected, all we know is that the
+		 * BSV is high when we update BSV state.
+		 */
+		if (role == CI_ROLE_GADGET &&
+		    IS_ERR(ci->platdata->vbus_extcon.edev))
 			/*
 			 * wait vbus lower than OTGSC_BSV before connecting
 			 * to host
-- 
2.9.0.rc2.8.ga28705d

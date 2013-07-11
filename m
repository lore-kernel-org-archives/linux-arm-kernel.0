From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 11 Jul 2013 14:27:18 +0800
Subject: [PATCH v12 10/13] usb: chipidea: add wait vbus lower than OTGSC_BSV
 before role starts
In-Reply-To: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1373524041-10482-11-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the gadget role starts, we need to make sure the vbus is lower
than OTGSC_BSV, or there will be an vbus interrupt since we use
B_SESSION_VALID as vbus interrupt to indicate connect and disconnect.
When the host role starts, it may not be useful to wait vbus to lower
than OTGSC_BSV, but it can indicate some hardware problems like the
vbus is still higher than OTGSC_BSV after we disconnect to host some
time later (500 jiffies currently), which is obvious not correct.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci.h   |    3 +++
 drivers/usb/chipidea/core.c |   32 ++++++++++++++++++++++++++++++++
 drivers/usb/chipidea/otg.c  |    4 ++++
 3 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 3160363..df27696 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -308,4 +308,7 @@ int hw_port_test_set(struct ci_hdrc *ci, u8 mode);
 
 u8 hw_port_test_get(struct ci_hdrc *ci);
 
+int hw_wait_reg(struct ci_hdrc *ci, enum ci_hw_regs reg, u32 mask,
+				u32 value, unsigned long timeout);
+
 #endif	/* __DRIVERS_USB_CHIPIDEA_CI_H */
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 7a07300..1c39541 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -295,6 +295,38 @@ int hw_device_reset(struct ci_hdrc *ci, u32 mode)
 	return 0;
 }
 
+/**
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
+ */
+int hw_wait_reg(struct ci_hdrc *ci, enum ci_hw_regs reg, u32 mask,
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
 static irqreturn_t ci_irq(int irq, void *data)
 {
 	struct ci_hdrc *ci = data;
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index c74194d..8aa0241 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -67,6 +67,7 @@ void ci_handle_vbus_change(struct ci_hdrc *ci)
 		usb_gadget_vbus_disconnect(&ci->gadget);
 }
 
+#define CI_VBUS_STABLE_TIMEOUT 500
 static void ci_handle_id_switch(struct ci_hdrc *ci)
 {
 	enum ci_role role = ci_otg_role(ci);
@@ -76,6 +77,9 @@ static void ci_handle_id_switch(struct ci_hdrc *ci)
 			ci_role(ci)->name, ci->roles[role]->name);
 
 		ci_role_stop(ci);
+		/* wait vbus lower than OTGSC_BSV */
+		hw_wait_reg(ci, OP_OTGSC, OTGSC_BSV, 0,
+				CI_VBUS_STABLE_TIMEOUT);
 		ci_role_start(ci, role);
 	}
 }
-- 
1.7.0.4

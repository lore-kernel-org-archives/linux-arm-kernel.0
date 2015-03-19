From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 19 Mar 2015 09:19:13 +0800
Subject: [PATCH 02/12] usb: chipidea: set ITC to 0 for device mode
In-Reply-To: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
References: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1426727963-32280-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ITC (Interrupt Threshold Control) is used to set the maximum rate at which
the host/device controller will issue interrupts. The default value is 8 (1ms)
for it. EHCI core will modify it to 1, but device mode keeps it as default
value.

In some use cases like Android ADB, it only has one usb request for each
direction, and maximum payload data is only 4KB, so the speed is 4MB/s
at most, it needs controller to trigger interrupt as fast as possible
to increase the speed. The USB performance will be better if the interrupt
can be triggered faster.

Reduce ITC value is benefit for USB performance, and the interrupt number
is increased at the same time, it may increase cpu utilization too.
Most of use case cares about performance, but some may care about
cpu utilization, so, we leave a platform interface for user.
We set ITC as 0 (immediate) as default value.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/core.c  | 19 +++++++++++++++++++
 include/linux/usb/chipidea.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 74fea4f..8af9cbf 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -463,6 +463,13 @@ int hw_device_reset(struct ci_hdrc *ci)
 	/* HW >= 2.3 */
 	hw_write(ci, OP_USBMODE, USBMODE_SLOM, USBMODE_SLOM);
 
+	/*
+	 * Set interrupt interval for device mode
+	 * host set ITC according to ehci-hcd module parameter log2_irq_thresh
+	 */
+	hw_write(ci, OP_USBCMD, 0xff0000,
+		ci->platdata->gadget_itc_setting << 16);
+
 	if (hw_read(ci, OP_USBMODE, USBMODE_CM) != USBMODE_CM_DC) {
 		pr_err("cannot enter in %s device mode", ci_role(ci)->name);
 		pr_err("lpm = %i", ci->hw_bank.lpm);
@@ -560,6 +567,8 @@ static irqreturn_t ci_irq(int irq, void *data)
 static int ci_get_platdata(struct device *dev,
 		struct ci_hdrc_platform_data *platdata)
 {
+	int ret;
+
 	if (!platdata->phy_mode)
 		platdata->phy_mode = of_usb_get_phy_mode(dev->of_node);
 
@@ -591,6 +600,16 @@ static int ci_get_platdata(struct device *dev,
 	if (of_usb_get_maximum_speed(dev->of_node) == USB_SPEED_FULL)
 		platdata->flags |= CI_HDRC_FORCE_FULLSPEED;
 
+	if (of_find_property(dev->of_node, "gadget-itc-setting", NULL)) {
+		ret = of_property_read_u32(dev->of_node, "gadget-itc-setting",
+			&platdata->gadget_itc_setting);
+		if (ret) {
+			dev_err(dev,
+				"failed to get gadget-itc-setting value\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index ab94f78..e69d829 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -35,6 +35,8 @@ struct ci_hdrc_platform_data {
 	void	(*notify_event) (struct ci_hdrc *ci, unsigned event);
 	struct regulator	*reg_vbus;
 	bool			tpl_support;
+	/* interrupt threshold value for gadget */
+	u32			gadget_itc_setting;
 };
 
 /* Default offset of capability registers */
-- 
1.9.1

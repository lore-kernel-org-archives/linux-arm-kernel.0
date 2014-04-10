From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Apr 2014 16:47:19 -0700
Subject: [PATCH 11/11] pinctrl: single: Clear pin interrupts enabled by
 bootloader
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Message-ID: <1397173639-29587-12-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we set up device wake-up interrupts as pinctrl-single
interrupts, we now must use the standard request_irq and
related functions to manage them.

If the pin interrupts are enabled for some pins at boot,
the wake-up events can show up as constantly pending
at least on omaps and will hang the system unless the related
device driver clears the event at the device.

To fix this, let's clear the interrupt flags during init,
and print out a warning so the board maintainers can update
their drivers to do proper request_irq for the driver specific
wake-up events.

Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinctrl-single.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index de64596..ba1f4b1 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -808,6 +808,7 @@ static const struct pinconf_ops pcs_pinconf_ops = {
 static int pcs_add_pin(struct pcs_device *pcs, unsigned offset,
 		unsigned pin_pos)
 {
+	struct pcs_soc_data *pcs_soc = &pcs->socdata;
 	struct pinctrl_pin_desc *pin;
 	struct pcs_name *pn;
 	int i;
@@ -819,6 +820,18 @@ static int pcs_add_pin(struct pcs_device *pcs, unsigned offset,
 		return -ENOMEM;
 	}
 
+	if (pcs_soc->irq_enable_mask) {
+		unsigned val;
+
+		val = pcs->read(pcs->base + offset);
+		if (val & pcs_soc->irq_enable_mask) {
+			dev_dbg(pcs->dev, "irq enabled at boot for pin at %lx (%x), clearing\n",
+				(unsigned long)pcs->res->start + offset, val);
+			val &= ~pcs_soc->irq_enable_mask;
+			pcs->write(val, pcs->base + offset);
+		}
+	}
+
 	pin = &pcs->pins.pa[i];
 	pn = &pcs->names[i];
 	sprintf(pn->name, "%lx.%d",
-- 
1.8.1.1

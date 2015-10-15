From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 15 Oct 2015 16:27:25 +0200
Subject: [PATCH 1/2] pinctrl: sunxi: Fix irq_of_xlate for the r_pio pinctrl
 block
In-Reply-To: <1444919246-23694-1-git-send-email-hdegoede@redhat.com>
References: <1444919246-23694-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1444919246-23694-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The r_pio gpio / pin controller has a pin_base of non 0, we need to
adjust for this before calling sunxi_pinctrl_desc_find_function_by_pin.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 38e0c7b..96a58e4 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -716,6 +716,7 @@ static int sunxi_pinctrl_irq_of_xlate(struct irq_domain *d,
 				      unsigned long *out_hwirq,
 				      unsigned int *out_type)
 {
+	struct sunxi_pinctrl *pctl = d->host_data;
 	struct sunxi_desc_function *desc;
 	int pin, base;
 
@@ -723,10 +724,9 @@ static int sunxi_pinctrl_irq_of_xlate(struct irq_domain *d,
 		return -EINVAL;
 
 	base = PINS_PER_BANK * intspec[0];
-	pin = base + intspec[1];
+	pin = pctl->desc->pin_base + base + intspec[1];
 
-	desc = sunxi_pinctrl_desc_find_function_by_pin(d->host_data,
-						       pin, "irq");
+	desc = sunxi_pinctrl_desc_find_function_by_pin(pctl, pin, "irq");
 	if (!desc)
 		return -EINVAL;
 
-- 
2.5.0

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:11:08 +0200
Subject: [PATCH 15/16] usb: gadget: atmel: access the PMC using regmap
In-Reply-To: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1443629469-15086-16-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use regmap to access the PMC to avoid using at91_pmc_read and
at91_pmc_write.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-usb at vger.kernel.org
 drivers/usb/gadget/udc/atmel_usba_udc.c | 20 ++++++++++----------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  2 ++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 3dfada8d6061..40977cd832af 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -17,7 +17,9 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
@@ -1888,20 +1890,15 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 #ifdef CONFIG_OF
 static void at91sam9rl_toggle_bias(struct usba_udc *udc, int is_on)
 {
-	unsigned int uckr = at91_pmc_read(AT91_CKGR_UCKR);
-
-	if (is_on)
-		at91_pmc_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
-	else
-		at91_pmc_write(AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
+	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN,
+			   is_on ? AT91_PMC_BIASEN : 0);
 }
 
 static void at91sam9g45_pulse_bias(struct usba_udc *udc)
 {
-	unsigned int uckr = at91_pmc_read(AT91_CKGR_UCKR);
-
-	at91_pmc_write(AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
-	at91_pmc_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
+	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN, 0);
+	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN,
+			   AT91_PMC_BIASEN);
 }
 
 static const struct usba_udc_errata at91sam9rl_errata = {
@@ -1938,6 +1935,9 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		return ERR_PTR(-EINVAL);
 
 	udc->errata = match->data;
+	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
+	if (udc->errata && IS_ERR(udc->pmc))
+		return ERR_CAST(udc->pmc);
 
 	udc->num_ep = 0;
 
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index ea448a344767..3e1c9d589dfa 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -354,6 +354,8 @@ struct usba_udc {
 	struct dentry *debugfs_root;
 	struct dentry *debugfs_regs;
 #endif
+
+	struct regmap *pmc;
 };
 
 static inline struct usba_ep *to_usba_ep(struct usb_ep *ep)
-- 
2.1.4

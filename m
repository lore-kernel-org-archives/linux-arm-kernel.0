From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 8 May 2012 09:22:38 +0530
Subject: [PATCH V3 Resend 11/12] gadget/r8a66597: Remove conditional
 compilation of clk code
In-Reply-To: <cover.1336448639.git.viresh.kumar@st.com>
References: <cover.1336448639.git.viresh.kumar@st.com>
Message-ID: <1ace7c872a0a78749fec65eba9d536995785b760.1336448639.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
macros.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/gadget/r8a66597-udc.c |   11 +++--------
 drivers/usb/gadget/r8a66597-udc.h |    5 -----
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index c4401e7..f873023 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1818,12 +1818,12 @@ static int __exit r8a66597_remove(struct platform_device *pdev)
 		iounmap(r8a66597->sudmac_reg);
 	free_irq(platform_get_irq(pdev, 0), r8a66597);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-#ifdef CONFIG_HAVE_CLK
+
 	if (r8a66597->pdata->on_chip) {
 		clk_disable(r8a66597->clk);
 		clk_put(r8a66597->clk);
 	}
-#endif
+
 	device_unregister(&r8a66597->gadget.dev);
 	kfree(r8a66597);
 	return 0;
@@ -1855,9 +1855,7 @@ static int __init r8a66597_sudmac_ioremap(struct r8a66597 *r8a66597,
 
 static int __init r8a66597_probe(struct platform_device *pdev)
 {
-#ifdef CONFIG_HAVE_CLK
 	char clk_name[8];
-#endif
 	struct resource *res, *ires;
 	int irq;
 	void __iomem *reg = NULL;
@@ -1921,7 +1919,6 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	r8a66597->timer.data = (unsigned long)r8a66597;
 	r8a66597->reg = reg;
 
-#ifdef CONFIG_HAVE_CLK
 	if (r8a66597->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
 		r8a66597->clk = clk_get(&pdev->dev, clk_name);
@@ -1933,7 +1930,7 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 		}
 		clk_enable(r8a66597->clk);
 	}
-#endif
+
 	if (r8a66597->pdata->sudmac) {
 		ret = r8a66597_sudmac_ioremap(r8a66597, pdev);
 		if (ret < 0)
@@ -1993,13 +1990,11 @@ err_add_udc:
 clean_up3:
 	free_irq(irq, r8a66597);
 clean_up2:
-#ifdef CONFIG_HAVE_CLK
 	if (r8a66597->pdata->on_chip) {
 		clk_disable(r8a66597->clk);
 		clk_put(r8a66597->clk);
 	}
 clean_up_dev:
-#endif
 	device_unregister(&r8a66597->gadget.dev);
 clean_up:
 	if (r8a66597) {
diff --git a/drivers/usb/gadget/r8a66597-udc.h b/drivers/usb/gadget/r8a66597-udc.h
index 8e3de61..d2a5ad2 100644
--- a/drivers/usb/gadget/r8a66597-udc.h
+++ b/drivers/usb/gadget/r8a66597-udc.h
@@ -13,10 +13,7 @@
 #ifndef __R8A66597_H__
 #define __R8A66597_H__
 
-#ifdef CONFIG_HAVE_CLK
 #include <linux/clk.h>
-#endif
-
 #include <linux/usb/r8a66597.h>
 
 #define R8A66597_MAX_SAMPLING	10
@@ -92,9 +89,7 @@ struct r8a66597 {
 	void __iomem		*reg;
 	void __iomem		*sudmac_reg;
 
-#ifdef CONFIG_HAVE_CLK
 	struct clk *clk;
-#endif
 	struct r8a66597_platdata	*pdata;
 
 	struct usb_gadget		gadget;
-- 
1.7.9

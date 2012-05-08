From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 8 May 2012 09:22:37 +0530
Subject: [PATCH V3 Resend 10/12] gadget/m66592: Remove conditional compilation
 of clk code
In-Reply-To: <cover.1336448639.git.viresh.kumar@st.com>
References: <cover.1336448639.git.viresh.kumar@st.com>
Message-ID: <60e6ca8b7d1458bf28181bad71c6fd006fbc9e6d.1336448639.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
macros.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/gadget/m66592-udc.c |    9 +--------
 drivers/usb/gadget/m66592-udc.h |    5 -----
 2 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/m66592-udc.c b/drivers/usb/gadget/m66592-udc.c
index 3608b3b..51c24d2 100644
--- a/drivers/usb/gadget/m66592-udc.c
+++ b/drivers/usb/gadget/m66592-udc.c
@@ -1583,12 +1583,10 @@ static int __exit m66592_remove(struct platform_device *pdev)
 	iounmap(m66592->reg);
 	free_irq(platform_get_irq(pdev, 0), m66592);
 	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
-#ifdef CONFIG_HAVE_CLK
 	if (m66592->pdata->on_chip) {
 		clk_disable(m66592->clk);
 		clk_put(m66592->clk);
 	}
-#endif
 	kfree(m66592);
 	return 0;
 }
@@ -1602,9 +1600,7 @@ static int __init m66592_probe(struct platform_device *pdev)
 	struct resource *res, *ires;
 	void __iomem *reg = NULL;
 	struct m66592 *m66592 = NULL;
-#ifdef CONFIG_HAVE_CLK
 	char clk_name[8];
-#endif
 	int ret = 0;
 	int i;
 
@@ -1671,7 +1667,6 @@ static int __init m66592_probe(struct platform_device *pdev)
 		goto clean_up;
 	}
 
-#ifdef CONFIG_HAVE_CLK
 	if (m66592->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usbf%d", pdev->id);
 		m66592->clk = clk_get(&pdev->dev, clk_name);
@@ -1683,7 +1678,7 @@ static int __init m66592_probe(struct platform_device *pdev)
 		}
 		clk_enable(m66592->clk);
 	}
-#endif
+
 	INIT_LIST_HEAD(&m66592->gadget.ep_list);
 	m66592->gadget.ep0 = &m66592->ep[0].ep;
 	INIT_LIST_HEAD(&m66592->gadget.ep0->ep_list);
@@ -1731,13 +1726,11 @@ err_add_udc:
 	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
 
 clean_up3:
-#ifdef CONFIG_HAVE_CLK
 	if (m66592->pdata->on_chip) {
 		clk_disable(m66592->clk);
 		clk_put(m66592->clk);
 	}
 clean_up2:
-#endif
 	free_irq(ires->start, m66592);
 clean_up:
 	if (m66592) {
diff --git a/drivers/usb/gadget/m66592-udc.h b/drivers/usb/gadget/m66592-udc.h
index 9d9f7e3..a044ad3 100644
--- a/drivers/usb/gadget/m66592-udc.h
+++ b/drivers/usb/gadget/m66592-udc.h
@@ -13,10 +13,7 @@
 #ifndef __M66592_UDC_H__
 #define __M66592_UDC_H__
 
-#ifdef CONFIG_HAVE_CLK
 #include <linux/clk.h>
-#endif
-
 #include <linux/usb/m66592.h>
 
 #define M66592_SYSCFG		0x00
@@ -468,9 +465,7 @@ struct m66592_ep {
 struct m66592 {
 	spinlock_t		lock;
 	void __iomem		*reg;
-#ifdef CONFIG_HAVE_CLK
 	struct clk *clk;
-#endif
 	struct m66592_platdata	*pdata;
 	unsigned long		irq_trigger;
 
-- 
1.7.9

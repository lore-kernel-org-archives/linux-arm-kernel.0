From: saeed@marvell.com (Saeed Bishara)
Date: Sun,  2 May 2010 17:22:41 +0300
Subject: [PATCH 4/5] USB: manage the orion ehci clock using the clkdev
In-Reply-To: <1272810162-14858-4-git-send-email-saeed@marvell.com>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
	<1272810162-14858-3-git-send-email-saeed@marvell.com>
	<1272810162-14858-4-git-send-email-saeed@marvell.com>
Message-ID: <1272810162-14858-5-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will enable the ehci controller's clock when needed.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/usb/host/ehci-orion.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index ba659e0..92680ad 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -361,6 +361,14 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 		goto err3;
 	}
 
+#if defined(CONFIG_HAVE_CLK)
+	hcd->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(hcd->clk))
+		dev_notice(&pdev->dev, "cannot get clkdev\n");
+	else
+		clk_enable(hcd->clk);
+#endif
+
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 	hcd->regs = regs;
@@ -382,6 +390,13 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 	return 0;
 
 err4:
+#if defined(CONFIG_HAVE_CLK)
+	if (!IS_ERR(hcd->clk)) {
+		clk_disable(hcd->clk);
+		clk_put(hcd->clk);
+	}
+#endif
+
 	usb_put_hcd(hcd);
 err3:
 	iounmap(regs);
@@ -402,6 +417,12 @@ static int __exit ehci_orion_drv_remove(struct platform_device *pdev)
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
+#if defined(CONFIG_HAVE_CLK)
+	if (!IS_ERR(hcd->clk)) {
+		clk_disable(hcd->clk);
+		clk_put(hcd->clk);
+	}
+#endif
 
 	return 0;
 }
-- 
1.6.0.4

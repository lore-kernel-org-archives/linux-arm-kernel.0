From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  3 Dec 2014 12:32:00 +0100
Subject: [PATCH 01/11] usb: gadget: at91_udc: Fix clock names
In-Reply-To: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417606330-17753-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is requesting clock by their global name (those declared in the
clk_lookup list), but this only works with !CCF kernels.

Now that all SoCs have moved to CCF, fix the driver to use local names
(hclk and pclk).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/usb/gadget/udc/at91_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 0716c19..ca6a4b8 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1766,8 +1766,8 @@ static int at91udc_probe(struct platform_device *pdev)
 	udc_reinit(udc);
 
 	/* get interface and function clocks */
-	udc->iclk = clk_get(dev, "udc_clk");
-	udc->fclk = clk_get(dev, "udpck");
+	udc->iclk = clk_get(dev, "pclk");
+	udc->fclk = clk_get(dev, "hclk");
 	if (IS_ENABLED(CONFIG_COMMON_CLK))
 		udc->uclk = clk_get(dev, "usb_clk");
 	if (IS_ERR(udc->iclk) || IS_ERR(udc->fclk) ||
-- 
1.9.1

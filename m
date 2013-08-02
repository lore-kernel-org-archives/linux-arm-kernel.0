From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  2 Aug 2013 10:37:27 +0200
Subject: [PATCH v3 1/2] usb: gadget: at91_udc: add missing clk_put on fclk and
 iclk
In-Reply-To: <1375432408-28371-1-git-send-email-b.brezillon@overkiz.com>
References: <1375432408-28371-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375432647-954-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing clk_put on fclk and iclk in case the probe function
fails after these clocks have been retrieved.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/usb/gadget/at91_udc.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index fce8e4e..d145cb78 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1851,6 +1851,10 @@ fail3:
 fail2:
 	free_irq(udc->udp_irq, udc);
 fail1:
+	if (!IS_ERR(udc->fclk))
+		clk_put(udc->fclk);
+	if (!IS_ERR(udc->iclk))
+		clk_put(udc->iclk);
 	iounmap(udc->udp_baseaddr);
 fail0a:
 	if (cpu_is_at91rm9200())
-- 
1.7.9.5

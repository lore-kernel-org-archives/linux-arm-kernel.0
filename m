From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  7 Jun 2013 20:08:43 +0200
Subject: [RFC PATCH 34/50] USB: ohci-at91: prepare clk before calling enable
In-Reply-To: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1370628523-2670-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/usb/host/ohci-at91.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index a0cb44f..329d277 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -41,17 +41,17 @@ extern int usb_disabled(void);
 
 static void at91_start_clock(void)
 {
-	clk_enable(hclk);
-	clk_enable(iclk);
-	clk_enable(fclk);
+	clk_prepare_enable(hclk);
+	clk_prepare_enable(iclk);
+	clk_prepare_enable(fclk);
 	clocked = 1;
 }
 
 static void at91_stop_clock(void)
 {
-	clk_disable(fclk);
-	clk_disable(iclk);
-	clk_disable(hclk);
+	clk_disable_unprepare(fclk);
+	clk_disable_unprepare(iclk);
+	clk_disable_unprepare(hclk);
 	clocked = 0;
 }
 
-- 
1.7.9.5

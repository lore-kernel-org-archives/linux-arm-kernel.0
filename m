From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  7 Jun 2013 20:08:33 +0200
Subject: [RFC PATCH 33/50] ehci-atmel.c: prepare clk before calling enable
In-Reply-To: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1370628513-2628-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/usb/host/ehci-atmel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 6642009..015ce6e 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -37,15 +37,15 @@ static int clocked;
 
 static void atmel_start_clock(void)
 {
-	clk_enable(iclk);
-	clk_enable(fclk);
+	clk_prepare_enable(iclk);
+	clk_prepare_enable(fclk);
 	clocked = 1;
 }
 
 static void atmel_stop_clock(void)
 {
-	clk_disable(fclk);
-	clk_disable(iclk);
+	clk_disable_unprepare(fclk);
+	clk_disable_unprepare(iclk);
 	clocked = 0;
 }
 
-- 
1.7.9.5

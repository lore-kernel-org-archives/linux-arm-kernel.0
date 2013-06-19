From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 19 Jun 2013 13:20:09 +0200
Subject: [PATCH 6/8] ehci-atmel.c: prepare clk before calling enable
In-Reply-To: <1371640263-9268-1-git-send-email-b.brezillon@overkiz.com>
References: <1371640263-9268-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1371640809-9699-1-git-send-email-b.brezillon@overkiz.com>
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

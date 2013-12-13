From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:29:02 +0900
Subject: [PATCH] usb: r8a66597-hcd: Convert to clk_prepare/unprepare
In-Reply-To: <cover.1386898134.git.horms+renesas@verge.net.au>
References: <cover.1386898134.git.horms+renesas@verge.net.au>
Message-ID: <9b547a882e9ffec67bb41a4e66b4bcc0e91a2737.1386898134.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
clk_disable_unprepare() to get ready for the migration to the common
clock framework.

Cc: linux-usb at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/usb/host/r8a66597-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 2ad004a..a2fdd85 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -95,7 +95,7 @@ static int r8a66597_clock_enable(struct r8a66597 *r8a66597)
 	int i = 0;
 
 	if (r8a66597->pdata->on_chip) {
-		clk_enable(r8a66597->clk);
+		clk_prepare_enable(r8a66597->clk);
 		do {
 			r8a66597_write(r8a66597, SCKE, SYSCFG0);
 			tmp = r8a66597_read(r8a66597, SYSCFG0);
@@ -139,7 +139,7 @@ static void r8a66597_clock_disable(struct r8a66597 *r8a66597)
 	udelay(1);
 
 	if (r8a66597->pdata->on_chip) {
-		clk_disable(r8a66597->clk);
+		clk_disable_unprepare(r8a66597->clk);
 	} else {
 		r8a66597_bclr(r8a66597, PLLC, SYSCFG0);
 		r8a66597_bclr(r8a66597, XCKE, SYSCFG0);
-- 
1.8.4

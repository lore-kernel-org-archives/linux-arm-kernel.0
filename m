From: xiechao.mail@gmail.com (Chao Xie)
Date: Sun, 25 Nov 2012 23:43:16 -0500
Subject: [PATCH 03/27] usb: gadget: mv_udc: fix the clk APIs
In-Reply-To: <1353905020-29372-1-git-send-email-xiechao.mail@gmail.com>
References: <1353905020-29372-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1353905020-29372-4-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

the clock common driver changes, and arch-mmp will make use of
the common clock driver instead of its own.
So for enable clock.
first prepare the clock
then enable the clock.

for disable clock
first disable the clock
then unprepare the clock

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 drivers/usb/gadget/mv_udc_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 1104327..c78d52f 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -1009,7 +1009,7 @@ static void udc_clock_enable(struct mv_udc *udc)
 	unsigned int i;
 
 	for (i = 0; i < udc->clknum; i++)
-		clk_enable(udc->clk[i]);
+		clk_prepare_enable(udc->clk[i]);
 }
 
 static void udc_clock_disable(struct mv_udc *udc)
@@ -1017,7 +1017,7 @@ static void udc_clock_disable(struct mv_udc *udc)
 	unsigned int i;
 
 	for (i = 0; i < udc->clknum; i++)
-		clk_disable(udc->clk[i]);
+		clk_disable_unprepare(udc->clk[i]);
 }
 
 static void udc_stop(struct mv_udc *udc)
-- 
1.7.4.1

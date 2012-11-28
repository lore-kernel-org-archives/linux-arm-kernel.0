From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 27 Nov 2012 22:06:04 -0500
Subject: [V2 PATCH 05/27] usb: otg: mv_otg: fix the clk APIs
In-Reply-To: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
References: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1354071986-28032-6-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the clock common driver changes, and arch-mmp will make use of
the common clock driver instead of its own.
So for enable clock.
first prepare the clock
then enable the clock.

for disable clock
first disable the clock
then unprepare the clock

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/otg/mv_otg.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/mv_otg.c b/drivers/usb/otg/mv_otg.c
index 70e222d..ffc0689 100644
--- a/drivers/usb/otg/mv_otg.c
+++ b/drivers/usb/otg/mv_otg.c
@@ -240,7 +240,7 @@ static void otg_clock_enable(struct mv_otg *mvotg)
 	unsigned int i;
 
 	for (i = 0; i < mvotg->clknum; i++)
-		clk_enable(mvotg->clk[i]);
+		clk_prepare_enable(mvotg->clk[i]);
 }
 
 static void otg_clock_disable(struct mv_otg *mvotg)
@@ -248,7 +248,7 @@ static void otg_clock_disable(struct mv_otg *mvotg)
 	unsigned int i;
 
 	for (i = 0; i < mvotg->clknum; i++)
-		clk_disable(mvotg->clk[i]);
+		clk_disable_unprepare(mvotg->clk[i]);
 }
 
 static int mv_otg_enable_internal(struct mv_otg *mvotg)
-- 
1.7.4.1

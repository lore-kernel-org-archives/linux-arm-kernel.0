From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 08:33:20 +0200
Subject: [PATCH v2 8/8] imxfb: fix PM
In-Reply-To: <1274942000-3580-7-git-send-email-eric@eukrea.com>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>
	<1274942000-3580-2-git-send-email-eric@eukrea.com>
	<1274942000-3580-3-git-send-email-eric@eukrea.com>
	<1274942000-3580-4-git-send-email-eric@eukrea.com>
	<1274942000-3580-5-git-send-email-eric@eukrea.com>
	<1274942000-3580-6-git-send-email-eric@eukrea.com>
	<1274942000-3580-7-git-send-email-eric@eukrea.com>
Message-ID: <1274942000-3580-8-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* if the screen is blanked, the clock is already disabled, so handle
this case
* before this patch, the following log was triggered :
WARNING: at arch/arm/plat-mxc/clock.c:59 __clk_disable+0x68/0x74()
Modules linked in:
[<c002d200>] (unwind_backtrace+0x0/0xf8) from [<c0046008>] (warn_slowpath_common+0x48/0x78)
[<c0046008>] (warn_slowpath_common+0x48/0x78) from [<c0031e28>] (__clk_disable+0x68/0x74)
[<c0031e28>] (__clk_disable+0x68/0x74) from [<c0031ddc>] (__clk_disable+0x1c/0x74)
[<c0031ddc>] (__clk_disable+0x1c/0x74) from [<c0031e58>] (clk_disable+0x24/0x34)
[<c0031e58>] (clk_disable+0x24/0x34) from [<c019808c>] (imxfb_disable_controller+0x38/0x48)
[<c019808c>] (imxfb_disable_controller+0x38/0x48) from [<c01980b0>] (imxfb_suspend+0x14/0x1c)

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/video/imxfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index b4b6dec..6cbfbff 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -597,8 +597,8 @@ static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
 	struct imxfb_info *fbi = info->par;
 
 	pr_debug("%s\n", __func__);
-
-	imxfb_disable_controller(fbi);
+	if (readl(fbi->regs + LCDC_RMCR))
+		imxfb_disable_controller(fbi);
 	return 0;
 }
 
-- 
1.6.3.3

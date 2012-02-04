From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 04 Feb 2012 09:42:09 +0000
Subject: [PATCH 12/13] FB: sa11x0: fix shannon GPSR/GPCR accesses
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
Message-ID: <E1Rtc8H-0000b7-Nr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO set and clear registers should only be written, rather than
read, modified, and written.  A read-modify-write will have undesired
side effects.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index b644f0f..f3f55eb 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -798,7 +798,7 @@ static void sa1100fb_enable_controller(struct sa1100fb_info *fbi)
 
 	if (machine_is_shannon()) {
 		GPDR |= SHANNON_GPIO_DISP_EN;
-		GPSR |= SHANNON_GPIO_DISP_EN;
+		GPSR = SHANNON_GPIO_DISP_EN;
 	}
 
 	dev_dbg(fbi->dev, "DBAR1 = 0x%08lx\n", DBAR1);
@@ -816,7 +816,7 @@ static void sa1100fb_disable_controller(struct sa1100fb_info *fbi)
 	dev_dbg(fbi->dev, "Disabling LCD controller\n");
 
 	if (machine_is_shannon()) {
-		GPCR |= SHANNON_GPIO_DISP_EN;
+		GPCR = SHANNON_GPIO_DISP_EN;
 	}	
 
 	set_current_state(TASK_UNINTERRUPTIBLE);
-- 
1.7.4.4

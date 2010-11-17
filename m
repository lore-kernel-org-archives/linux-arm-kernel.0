From: fg@emlix.com (Fabian Godehardt)
Date: Wed, 17 Nov 2010 11:22:23 +0100
Subject: [PATCH] ARM: s3c2440: fix AC97 and camera clock registration
Message-ID: <1289989343-28816-1-git-send-email-fg@emlix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes 2 problems:
 - it sets the correct bitmask of the AC97 flag on the control-bit field
 - it increases the usage counter of both clocks because they get decreased
   on clock registration (a few lines later)

Maybe it is a better idea to check the usage counter on clk_disable() so
it can not reach values <0.

Signed-off-by: Fabian Godehardt <fg@emlix.com>
---
 arch/arm/mach-s3c2440/clock.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
index 3dc2426..0fc8461 100644
--- a/arch/arm/mach-s3c2440/clock.c
+++ b/arch/arm/mach-s3c2440/clock.c
@@ -93,6 +93,7 @@ static struct clk s3c2440_clk_cam = {
 	.id		= -1,
 	.enable		= s3c2410_clkcon_enable,
 	.ctrlbit	= S3C2440_CLKCON_CAMERA,
+	.usage		= 1,
 };
 
 static struct clk s3c2440_clk_cam_upll = {
@@ -108,7 +109,8 @@ static struct clk s3c2440_clk_ac97 = {
 	.name		= "ac97",
 	.id		= -1,
 	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2440_CLKCON_CAMERA,
+	.ctrlbit	= S3C2440_CLKCON_AC97,
+	.usage		= 1,
 };
 
 static int s3c2440_clk_add(struct sys_device *sysdev)
-- 
1.6.6.1

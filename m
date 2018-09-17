From: sed@free.fr (Cedric Roux)
Date: Mon, 17 Sep 2018 22:43:50 +0200
Subject: [PATCH] ARM: s3c24xx: fix usage of pr_info/pr_cont
Message-ID: <20180917204350.15192-1-sed@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes the wrong usage of pr_info introduced by the
commit e728e4f20100 ("ARM: s3c24xx: formatting cleanup in
mach-mini2440.c").

Since the idea is to print on a single line, pr_cont has to be used.

Signed-off-by: Cedric Roux <sed@free.fr>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 9f830abe701c..50d67d760efd 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -684,14 +684,14 @@ static void __init mini2440_init(void)
 		pr_info("MINI2440: LCD");
 		for (li = 0; li < ARRAY_SIZE(mini2440_lcd_cfg); li++)
 			if (li == features.lcd_index)
-				pr_info(" [%d:%dx%d]", li,
+				pr_cont(" [%d:%dx%d]", li,
 					mini2440_lcd_cfg[li].width,
 					mini2440_lcd_cfg[li].height);
 			else
-				pr_info(" %d:%dx%d", li,
+				pr_cont(" %d:%dx%d", li,
 					mini2440_lcd_cfg[li].width,
 					mini2440_lcd_cfg[li].height);
-		pr_info("\n");
+		pr_cont("\n");
 		s3c24xx_fb_set_platdata(&mini2440_fb_info);
 	}
 
-- 
2.18.0

Note: running: scripts/checkpatch.pl 000*
reports 3 warnings about the use of pr_cont.
Since this modification was required by Joe Perches, I think this patch
doest the correct thing.

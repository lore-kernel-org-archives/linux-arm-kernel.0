From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Sun, 1 Nov 2015 17:57:18 +1100
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20151101175718.130f33f2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

After merging the pm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/mach-mediatek/mediatek.c: In function 'mediatek_timer_init':
arch/arm/mach-mediatek/mediatek.c:43:2: error: implicit declaration of function 'clocksource_of_init' [-Werror=implicit-function-declaration]
  clocksource_of_init();
  ^

Caused by commit

  3722ed2380ad ("clocksource: cosmetic: Drop OF 'dependency' from symbols")

interacting with commit

  9821e545c5e0 ("ARM: mediatek: enable gpt6 on boot up to make arch timer working")

from the arm-soc tree.

I applied the following merge fix patch for today (someone should tell
Linus when theese trees are merged):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 1 Nov 2015 17:52:26 +1100
Subject: [PATCH] ARM: mediatek: fixup for clocksource_of_init API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mach-mediatek/mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index 19dc738c1abc..c88a47a3dc37 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -40,7 +40,7 @@ static void __init mediatek_timer_init(void)
 	}
 
 	of_clk_init(NULL);
-	clocksource_of_init();
+	clocksource_probe();
 };
 
 static const char * const mediatek_board_dt_compat[] = {
-- 
2.6.1

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

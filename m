From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:37 +0100
Subject: [PATCH 40/62] ARM: footbridge: make screen_info setup conditional
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-41-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The global screen_info structure is used to communicate
data about the console from platform code to the console
driver, but is only defined on ARM if either the VGA or
dummy consoles are in use.

This changes the footbridge code so we don't try to access
this structure in case it is not defined, which prevents
a possible randconfig build error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-footbridge/cats-hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-footbridge/cats-hw.c b/arch/arm/mach-footbridge/cats-hw.c
index 9669cc0..da04150 100644
--- a/arch/arm/mach-footbridge/cats-hw.c
+++ b/arch/arm/mach-footbridge/cats-hw.c
@@ -78,9 +78,11 @@ __initcall(cats_hw_init);
 static void __init
 fixup_cats(struct tag *tags, char **cmdline, struct meminfo *mi)
 {
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 	screen_info.orig_video_lines  = 25;
 	screen_info.orig_video_points = 16;
 	screen_info.orig_y = 24;
+#endif
 }
 
 MACHINE_START(CATS, "Chalice-CATS")
-- 
1.8.3.2

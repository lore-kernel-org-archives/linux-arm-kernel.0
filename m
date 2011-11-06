From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:32:13 +0000
Subject: [PATCH 2/7] ARM: restart: allow platforms more flexibility
 specifying restart mode
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6Zp-0001Mz-Qd@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change 'soft_reboot' into a more generic 'restart_mode' variable,
allowing the default restart mode to be specified.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/arch.h   |    8 ++++----
 arch/arm/kernel/setup.c            |    4 ++--
 arch/arm/mach-ebsa110/core.c       |    2 +-
 arch/arm/mach-footbridge/cats-hw.c |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 8aa397a..6fe6cf0 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -30,10 +30,10 @@ struct machine_desc {
 	unsigned int		video_start;	/* start of video RAM	*/
 	unsigned int		video_end;	/* end of video RAM	*/
 
-	unsigned int		reserve_lp0 :1;	/* never has lp0	*/
-	unsigned int		reserve_lp1 :1;	/* never has lp1	*/
-	unsigned int		reserve_lp2 :1;	/* never has lp2	*/
-	unsigned int		soft_reboot :1;	/* soft reboot		*/
+	unsigned char		reserve_lp0 :1;	/* never has lp0	*/
+	unsigned char		reserve_lp1 :1;	/* never has lp1	*/
+	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
+	char			restart_mode;	/* default restart mode	*/
 	void			(*fixup)(struct tag *, char **,
 					 struct meminfo *);
 	void			(*reserve)(void);/* reserve mem blocks	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d187d0a..2540b9c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -902,8 +902,8 @@ void __init setup_arch(char **cmdline_p)
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
 
-	if (mdesc->soft_reboot)
-		reboot_setup("s");
+	if (mdesc->restart_mode)
+		reboot_setup(&mdesc->restart_mode);
 
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index d0ce8ab..ce3ed24 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -283,7 +283,7 @@ MACHINE_START(EBSA110, "EBSA110")
 	.atag_offset	= 0x400,
 	.reserve_lp0	= 1,
 	.reserve_lp2	= 1,
-	.soft_reboot	= 1,
+	.restart_mode	= 's',
 	.map_io		= ebsa110_map_io,
 	.init_irq	= ebsa110_init_irq,
 	.timer		= &ebsa110_timer,
diff --git a/arch/arm/mach-footbridge/cats-hw.c b/arch/arm/mach-footbridge/cats-hw.c
index d5f1785..60b6774 100644
--- a/arch/arm/mach-footbridge/cats-hw.c
+++ b/arch/arm/mach-footbridge/cats-hw.c
@@ -86,7 +86,7 @@ fixup_cats(struct tag *tags, char **cmdline, struct meminfo *mi)
 MACHINE_START(CATS, "Chalice-CATS")
 	/* Maintainer: Philip Blundell */
 	.atag_offset	= 0x100,
-	.soft_reboot	= 1,
+	.restart_mode	= 's',
 	.fixup		= fixup_cats,
 	.map_io		= footbridge_map_io,
 	.init_irq	= footbridge_init_irq,
-- 
1.7.4.4

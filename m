From: nm@ti.com (Nishanth Menon)
Date: Wed, 12 Mar 2014 16:43:20 -0500
Subject: [PATCH] ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM
Message-ID: <1394660600-3771-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like IS_PM34XX_ERRATUM, IS_PM44XX_ERRATUM is valid only if
CONFIG_PM is enabled, else, disabling CONFIG_PM results in build
failure complaining about the following:
arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
:(.text+0x8a70): undefined reference to `pm44xx_errata'

Fixes: c962184 (ARM: OMAP4: PM: add errata support)
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Patch based on: v3.14-rc6
Reported originally with a randconfig defconfig: http://slexy.org/view/s21U7eF4k1

 arch/arm/mach-omap2/pm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 7bdd22a..d4d0fce 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -103,7 +103,7 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 
 #define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD	(1 << 0)
 
-#if defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
 extern u16 pm44xx_errata;
 #define IS_PM44XX_ERRATUM(id)		(pm44xx_errata & (id))
 #else
-- 
1.7.9.5

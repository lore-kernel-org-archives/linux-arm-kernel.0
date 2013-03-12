From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 17:46:55 +0100
Subject: [PATCH v2 12/13] ARM: spear: fix build error in restart.c
In-Reply-To: <1363106816-9603-1-git-send-email-arnd@arndb.de>
References: <1363106816-9603-1-git-send-email-arnd@arndb.de>
Message-ID: <1363106816-9603-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can now enable mach-spear without selecting any of the
machines in a multiplatform configuration.
Doing so causes a build error that is trivial to fix by
making both the spear13xx and the spear3xx/6xx portion of
this file conditional rather than alternatives.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear/restart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/restart.c b/arch/arm/mach-spear/restart.c
index 004f0f2..2b44500 100644
--- a/arch/arm/mach-spear/restart.c
+++ b/arch/arm/mach-spear/restart.c
@@ -26,7 +26,8 @@ void spear_restart(char mode, const char *cmd)
 		/* hardware reset, Use on-chip reset capability */
 #ifdef CONFIG_ARCH_SPEAR13XX
 		writel_relaxed(0x01, SPEAR13XX_SYS_SW_RES);
-#else
+#endif
+#if defined(CONFIG_ARCH_SPEAR3XX) || defined(CONFIG_ARCH_SPEAR6XX)
 		sysctl_soft_reset((void __iomem *)VA_SPEAR_SYS_CTRL_BASE);
 #endif
 	}
-- 
1.8.1.2

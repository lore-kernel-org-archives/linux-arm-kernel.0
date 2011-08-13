From: peterhuewe@gmx.de (Peter Huewe)
Date: Sun, 14 Aug 2011 00:34:01 +0200
Subject: [PATCH] shmobile/sh7372: Add missing CONFIG_PM guards to fix build
	failure
Message-ID: <1313274841-8322-1-git-send-email-peterhuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a build failure with the ap4evb_defconfig by adding the
missing #ifdef CONFIG_PM.

The build failure was:
arch/arm/mach-shmobile/setup-sh7372.c:852: error: 'sh7372_a4lc'
undeclared (first use in this function)
arch/arm/mach-shmobile/setup-sh7372.c:852: error: (Each undeclared
identifier is reported only once
arch/arm/mach-shmobile/setup-sh7372.c:852: error: for each function it
appears in.)

sh7372_a4lc is declared in arch/arm/mach-shmobile/pm-sh7372.c within a
 #ifdef CONFIG_PM block. Since the defconfig is missing CONFIG_PM this
results in a build failure.

KernelVersion: linux-next 20110812 (cab7d82)

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 arch/arm/mach-shmobile/setup-sh7372.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index df900bf..8455f0b 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -848,9 +848,9 @@ void __init sh7372_add_standard_devices(void)
 	sh7372_init_pm_domain(&sh7372_a3rv);
 	sh7372_init_pm_domain(&sh7372_a3ri);
 	sh7372_init_pm_domain(&sh7372_a3sg);
-
+#ifdef CONFIG_PM
 	pm_genpd_add_subdomain(&sh7372_a4lc.genpd, &sh7372_a3sg.genpd);
-
+#endif
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
-- 
1.7.3.4

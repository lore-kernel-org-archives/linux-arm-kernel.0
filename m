From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:34:19 +0200
Subject: [PATCH 1/3] ARM: shmobile: mark shmobile_init_late as __init
In-Reply-To: <1349796861-31164-1-git-send-email-arnd@arndb.de>
References: <1349796861-31164-1-git-send-email-arnd@arndb.de>
Message-ID: <1349796861-31164-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 35f2b0bd59 "ARM: shmobile: Move definition of shmobile_init_late()
to header" moved the definition of the shmobile_init_late function, but
dropped the __init annotation, which is now causing warnings because
the function calls shmobile_suspend_init, which is also marked init.

Without this patch, building kota2_defconfig results in:

WARNING: vmlinux.o(.text+0xb7c8): Section mismatch in reference from the function shmobile_init_late() to the function .init.text:shmobile_suspend_init()
The function shmobile_init_late() references
the function __init shmobile_suspend_init().
This is often because shmobile_init_late lacks a __init
annotation or the annotation of shmobile_suspend_init is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Magnus Damm <damm@opensource.se>
Cc: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index ed77ab8..d47e215 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -100,7 +100,7 @@ static inline int shmobile_cpu_is_dead(unsigned int cpu) { return 1; }
 
 extern void shmobile_smp_init_cpus(unsigned int ncores);
 
-static inline void shmobile_init_late(void)
+static inline void __init shmobile_init_late(void)
 {
 	shmobile_suspend_init();
 	shmobile_cpuidle_init();
-- 
1.7.10

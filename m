From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 23:02:55 +0200
Subject: [PATCH 6/9] ARM: SPEAr: conditionalize SMP code
In-Reply-To: <1367528578-518090-1-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
Message-ID: <1367528578-518090-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some constant definitions are only defined for spear13xx, so
we must not attempt to build SPEAr SMP support when that
SoC is not enabled.

arch/arm/mach-spear/platsmp.c:25:35:
 error: 'VA_SCU_BASE' undeclared here (not in a function)
 arch/arm/mach-spear/platsmp.c: In function 'spear13xx_smp_prepare_cpus':
 arch/arm/mach-spear/platsmp.c:111:58: error: 'SYS_LOCATION' undeclared (first use in this function)

Cc: Viresh Kumar <viresh.linux@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-spear/Makefile b/arch/arm/mach-spear/Makefile
index af9bffb..a946c19 100644
--- a/arch/arm/mach-spear/Makefile
+++ b/arch/arm/mach-spear/Makefile
@@ -7,10 +7,10 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 # Common support
 obj-y	:= restart.o time.o
 
-obj-$(CONFIG_SMP)		+= headsmp.o platsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+smp-$(CONFIG_SMP)		+= headsmp.o platsmp.o
+smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
-obj-$(CONFIG_ARCH_SPEAR13XX)	+= spear13xx.o
+obj-$(CONFIG_ARCH_SPEAR13XX)	+= spear13xx.o $(smp-y)
 obj-$(CONFIG_MACH_SPEAR1310)	+= spear1310.o
 obj-$(CONFIG_MACH_SPEAR1340)	+= spear1340.o
 
-- 
1.8.1.2

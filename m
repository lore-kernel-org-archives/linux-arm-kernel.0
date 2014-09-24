From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 24 Sep 2014 17:07:48 +0800
Subject: [PATCH] ARM: hisi: Fix platmcpm compilation when ARMv6 is selected
Message-ID: <542289E4.6000901@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling with "ARCH=arm" and "allmodconfig",
with commit: 9cdc99919a95e8b54c1998b65bb1bfdabd47d27b [2/7] ARM: hisi: enable MCPM implementation
we will get:

   /tmp/cc6DjYjT.s: Assembler messages:
   /tmp/cc6DjYjT.s:63: Error: selected processor does not support ARM mode `ubfx r1,r0,#8,#8'
   /tmp/cc6DjYjT.s:761: Error: selected processor does not support ARM mode `isb '
   /tmp/cc6DjYjT.s:762: Error: selected processor does not support ARM mode `dsb '
   /tmp/cc6DjYjT.s:769: Error: selected processor does not support ARM mode `isb '
   /tmp/cc6DjYjT.s:775: Error: selected processor does not support ARM mode `isb '
   /tmp/cc6DjYjT.s:776: Error: selected processor does not support ARM mode `dsb '
   /tmp/cc6DjYjT.s:795: Error: selected processor does not support ARM mode `isb '
   /tmp/cc6DjYjT.s:801: Error: selected processor does not support ARM mode `isb '
   /tmp/cc6DjYjT.s:802: Error: selected processor does not support ARM mode `dsb '

Fix platmcpm compilation when ARMv6 is selected.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm/mach-hisi/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-hisi/Makefile b/arch/arm/mach-hisi/Makefile
index d64831e..e6a5b4d 100644
--- a/arch/arm/mach-hisi/Makefile
+++ b/arch/arm/mach-hisi/Makefile
@@ -2,6 +2,8 @@
 # Makefile for Hisilicon processors family
 #
 
+CFLAGS_platmcpm.o	:= -march=armv7-a
+
 obj-y	+= hisilicon.o
 obj-$(CONFIG_MCPM)	+= platmcpm.o
 obj-$(CONFIG_SMP)	+= platsmp.o hotplug.o headsmp.o
-- 1.8.1.2 

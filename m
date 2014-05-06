From: vincent.stehle@laposte.net (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Tue,  6 May 2014 22:23:02 +0200
Subject: [PATCH linux-next] ARM: mvebu: Fix pmsu compilation when ARMv6 is
 selected
Message-ID: <1399407782-29091-1-git-send-email-vincent.stehle@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling for multiplatform for both ARMv6 and ARMv7, the default compiler
flags are for ARMv6, and we will get:

  /tmp/ccwDEzd0.s: Assembler messages:
  /tmp/ccwDEzd0.s:639: Error: selected processor does not support ARM mode `isb '
  /tmp/ccwDEzd0.s:645: Error: selected processor does not support ARM mode `isb '
  /tmp/ccwDEzd0.s:646: Error: selected processor does not support ARM mode `dsb '
  /tmp/ccwDEzd0.s:695: Error: selected processor does not support ARM mode `isb '
  make[1]: *** [arch/arm/mach-mvebu/pmsu.o] Error 1

Fix this in a similar manner than done previously in commit
72533b77d30c2be02672e26b5dde1263d7b4c2be, by specifying ARMv7 flags for pmsu.o.

Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
---

Hi,

This build issue can be seen with e.g. Linux next-20140506, ARCH=arm and
allmodconfig.

Best regards,

V.

 arch/arm/mach-mvebu/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 854b72a..2ecb828 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -2,6 +2,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-orion/include
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
+CFLAGS_pmsu.o			:= -march=armv7-a
 
 obj-y				 += system-controller.o mvebu-soc-id.o
 
-- 
1.9.2

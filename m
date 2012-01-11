From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Jan 2012 14:14:34 +1100
Subject: [PATCH 09/11] ep93xx: Move crunch code to mach-ep93xx directory
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <1326251676-7593-10-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The crunch code in arch/arm/kernel is specific to the EP93xx. Move it
to the mach-ep93xx directory. This removes the need for the
EP93XX_SYSCON defines to be exported to arch/arm/kernel.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/kernel/Makefile                       |    3 ---
 arch/arm/mach-ep93xx/Makefile                  |    3 +++
 arch/arm/{kernel => mach-ep93xx}/crunch-bits.S |    0
 arch/arm/{kernel => mach-ep93xx}/crunch.c      |    2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)
 rename arch/arm/{kernel => mach-ep93xx}/crunch-bits.S (100%)
 rename arch/arm/{kernel => mach-ep93xx}/crunch.c (99%)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 16eed6a..57aa6c9 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -62,9 +62,6 @@ obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
 CFLAGS_swp_emulate.o		:= -Wa,-march=armv7-a
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 
-obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
-AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
-
 obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
 obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
 obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index 574209d..0dc51f9 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -8,6 +8,9 @@ obj-			:=
 
 obj-$(CONFIG_EP93XX_DMA)	+= dma.o
 
+obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
+AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
+
 obj-$(CONFIG_MACH_ADSSPHERE)	+= adssphere.o
 obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
 obj-$(CONFIG_MACH_GESBC9312)	+= gesbc9312.o
diff --git a/arch/arm/kernel/crunch-bits.S b/arch/arm/mach-ep93xx/crunch-bits.S
similarity index 100%
rename from arch/arm/kernel/crunch-bits.S
rename to arch/arm/mach-ep93xx/crunch-bits.S
diff --git a/arch/arm/kernel/crunch.c b/arch/arm/mach-ep93xx/crunch.c
similarity index 99%
rename from arch/arm/kernel/crunch.c
rename to arch/arm/mach-ep93xx/crunch.c
index 25ef223..d05ed0b 100644
--- a/arch/arm/kernel/crunch.c
+++ b/arch/arm/mach-ep93xx/crunch.c
@@ -19,6 +19,8 @@
 #include <mach/ep93xx-regs.h>
 #include <asm/thread_notify.h>
 
+#include "soc.h"
+
 struct crunch_state *crunch_owner;
 
 void crunch_task_release(struct thread_info *thread)
-- 
1.7.0.4

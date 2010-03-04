From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Fix Versatile&Integrator includes to behave in the
	same way as Realview
References: <20100305095413.GA3897@n2100.arm.linux.org.uk>
Message-ID: <git-1267729916-7c3bc54da04080b7c4c3974b8eefeecfe43f2c83@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Realview doesn't include mach/platform.h in mach/hardware.h, so
make versatile behave in the same way.  Also, move the definition
of __io_address() into mach/hardware.h, just like Realview.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/core.c                    |    1 +
 arch/arm/mach-integrator/cpu.c                     |    1 +
 .../arm/mach-integrator/include/mach/entry-macro.S |    1 +
 arch/arm/mach-integrator/include/mach/hardware.h   |    3 ++-
 arch/arm/mach-integrator/integrator_ap.c           |    1 +
 arch/arm/mach-integrator/integrator_cp.c           |    1 +
 arch/arm/mach-integrator/leds.c                    |    1 +
 arch/arm/mach-integrator/pci_v3.c                  |    1 +
 arch/arm/mach-versatile/core.c                     |    4 ++--
 arch/arm/mach-versatile/include/mach/entry-macro.S |    1 +
 arch/arm/mach-versatile/include/mach/hardware.h    |    3 ++-
 11 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 8b390e3..096f899 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -24,6 +24,7 @@
 #include <asm/clkdev.h>
 #include <mach/clkdev.h>
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <asm/irq.h>
 #include <asm/hardware/arm_timer.h>
 #include <mach/cm.h>
diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index 44d4c2e..b761879 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/icst525.h>
 
diff --git a/arch/arm/mach-integrator/include/mach/entry-macro.S b/arch/arm/mach-integrator/include/mach/entry-macro.S
index 7649c57..3d029c9 100644
--- a/arch/arm/mach-integrator/include/mach/entry-macro.S
+++ b/arch/arm/mach-integrator/include/mach/entry-macro.S
@@ -8,6 +8,7 @@
  * warranty of any kind, whether express or implied.
  */
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <mach/irqs.h>
 
  		.macro	disable_fiq
diff --git a/arch/arm/mach-integrator/include/mach/hardware.h b/arch/arm/mach-integrator/include/mach/hardware.h
index d795642..d44af72 100644
--- a/arch/arm/mach-integrator/include/mach/hardware.h
+++ b/arch/arm/mach-integrator/include/mach/hardware.h
@@ -23,7 +23,6 @@
 #define __ASM_ARCH_HARDWARE_H
 
 #include <asm/sizes.h>
-#include <mach/platform.h>
 
 /*
  * Where in virtual memory the IO devices (timers, system controllers
@@ -48,5 +47,7 @@
 #define PCIBIOS_MIN_IO		0x6000
 #define PCIBIOS_MIN_MEM 	0x00100000
 
+#define __io_address(n)		((void __iomem *)IO_ADDRESS(n))
+
 #endif
 
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 8138a7e..018c32d 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -30,6 +30,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
 #include <asm/param.h>		/* HZ */
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 66ef86d..c66e8fa 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -25,6 +25,7 @@
 #include <asm/clkdev.h>
 #include <mach/clkdev.h>
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-integrator/leds.c b/arch/arm/mach-integrator/leds.c
index 8dcc823..28be186 100644
--- a/arch/arm/mach-integrator/leds.c
+++ b/arch/arm/mach-integrator/leds.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <asm/leds.h>
 #include <asm/system.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 148d25f..e87fe9f 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -30,6 +30,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <asm/irq.h>
 #include <asm/signal.h>
 #include <asm/system.h>
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 9ddb49b..b77bc40 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -35,7 +35,6 @@
 
 #include <asm/clkdev.h>
 #include <asm/system.h>
-#include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/hardware/arm_timer.h>
@@ -48,6 +47,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
+#include <mach/hardware.h>
+#include <mach/platform.h>
 
 #include "core.h"
 #include "clock.h"
@@ -58,7 +59,6 @@
  *
  * Setup a VA for the Versatile Vectored Interrupt Controller.
  */
-#define __io_address(n)		__io(IO_ADDRESS(n))
 #define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
 #define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
 
diff --git a/arch/arm/mach-versatile/include/mach/entry-macro.S b/arch/arm/mach-versatile/include/mach/entry-macro.S
index 8c80209..e6f7c16 100644
--- a/arch/arm/mach-versatile/include/mach/entry-macro.S
+++ b/arch/arm/mach-versatile/include/mach/entry-macro.S
@@ -8,6 +8,7 @@
  * warranty of any kind, whether express or implied.
  */
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <asm/hardware/vic.h>
 
 		.macro	disable_fiq
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
index 7aa906c..4f8f99a 100644
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ b/arch/arm/mach-versatile/include/mach/hardware.h
@@ -23,7 +23,6 @@
 #define __ASM_ARCH_HARDWARE_H
 
 #include <asm/sizes.h>
-#include <mach/platform.h>
 
 /*
  * PCI space virtual addresses
@@ -49,4 +48,6 @@
 /* macro to get at IO space when running virtually */
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
 
+#define __io_address(n)		__io(IO_ADDRESS(n))
+
 #endif

From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Nov 2011 20:32:59 +0100
Subject: [PATCH 39/41] ARM: restart: lpc32xx & u300: remove unnecessary
 printk
In-Reply-To: <20111111190014.GB4154@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6u6-0001ZD-Ll@rmk-PC.arm.linux.org.uk>
 <CACRpkda9mC6+WrbGekJD85X4t7AsuamhP5V=YcyNQLFw0Yii7A@mail.gmail.com>
 <20111111190014.GB4154@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaDAC4t5+-p+rWWYsNBNbkFmorehdJtUpRvzDXtQQR3_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 8:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Thanks. ?Could you look at what's required for Nomadik please? ?I couldn't
> see am obvious file to move the arch_reset code from mach/system.h into,
> nor could I see a local header file to put the new prototype into.

Rubini is the master of Nomadik, but I would put that into
mach-nomadik/cpu-8815.c.

As for header the functions in cpu-8815.c are broadcast
in mach-nomadik/include/mach/setup.h which is *wrong*,
so I would

- Create mach-nomadik/cpu-8815.h
- Move the cpu_8815_* function from <mach/setup.h>
  into this file.
- Replace #include <mach/setup.h> with #include "cpu-8815.h"
  in board-nhk8815.c and cpu-8815.c
- Add the reset stuff to cpu-8815.[c|h]

Feel free to fold in the below at your convenience:

>From b0f26c142e5fbc75d10e75c96f2c753b3fe7c2d9 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Nov 2011 20:30:32 +0100
Subject: [PATCH] ARM: nomadik: localize cpu-8815 header

The symbols from cpu-8815.c were being broadcast across the
entire kernel but are only really used locally in mach-nomadik
so let's localize them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/board-nhk8815.c      |    2 ++
 arch/arm/mach-nomadik/cpu-8815.c           |    1 +
 arch/arm/mach-nomadik/cpu-8815.h           |    3 +++
 arch/arm/mach-nomadik/include/mach/setup.h |    3 ---
 4 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-nomadik/cpu-8815.h

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c
b/arch/arm/mach-nomadik/board-nhk8815.c
index 0cbb74c..4518050 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -34,6 +34,8 @@
 #include <mach/nand.h>
 #include <mach/fsmc.h>

+#include "cpu-8815.h"
+
 /* Initial value for SRC control register: all timers use MXTAL/8 source */
 #define SRC_CR_INIT_MASK	0x00007fff
 #define SRC_CR_INIT_VAL		0x2aaa8000
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index dc67717..c087ea9 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -32,6 +32,7 @@
 #include <asm/hardware/cache-l2x0.h>

 #include "clock.h"
+#include "cpu-8815.h"

 #define __MEM_4K_RESOURCE(x) \
 	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
diff --git a/arch/arm/mach-nomadik/cpu-8815.h b/arch/arm/mach-nomadik/cpu-8815.h
new file mode 100644
index 0000000..e041794
--- /dev/null
+++ b/arch/arm/mach-nomadik/cpu-8815.h
@@ -0,0 +1,3 @@
+extern void cpu8815_map_io(void);
+extern void cpu8815_platform_init(void);
+extern void cpu8815_init_irq(void);
diff --git a/arch/arm/mach-nomadik/include/mach/setup.h
b/arch/arm/mach-nomadik/include/mach/setup.h
index b7897ed..bcaeaf4 100644
--- a/arch/arm/mach-nomadik/include/mach/setup.h
+++ b/arch/arm/mach-nomadik/include/mach/setup.h
@@ -12,9 +12,6 @@

 #ifdef CONFIG_NOMADIK_8815

-extern void cpu8815_map_io(void);
-extern void cpu8815_platform_init(void);
-extern void cpu8815_init_irq(void);
 extern void nmdk_timer_init(void);

 #endif /* NOMADIK_8815 */
-- 
1.7.3.2

Yours,
Linus Walleij

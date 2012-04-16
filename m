From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 16 Apr 2012 15:38:28 -0400
Subject: [PATCH] ARM: fix mach-bcmring UART declarations
Message-ID: <1334605108-28616-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This error appeared in the bcmring_defconfig build:

  CC      arch/arm/mach-bcmring/core.o
arch/arm/mach-bcmring/core.c:55: error: macro "AMBA_APB_DEVICE" requires 6 arguments, but only 5 given
arch/arm/mach-bcmring/core.c:55: warning: type defaults to 'int' in declaration of 'AMBA_APB_DEVICE'
arch/arm/mach-bcmring/core.c:56: error: macro "AMBA_APB_DEVICE" requires 6 arguments, but only 5 given
arch/arm/mach-bcmring/core.c:56: warning: type defaults to 'int' in declaration of 'AMBA_APB_DEVICE'
arch/arm/mach-bcmring/core.c:134: error: 'uartA_device' undeclared here (not in a function)
arch/arm/mach-bcmring/core.c:135: error: 'uartB_device' undeclared here (not in a function)
make[2]: *** [arch/arm/mach-bcmring/core.o] Error 1

It appeared as of commit 8ede1ae65e61282cddba39bde4142be3885a6f5a

    "ARM: amba: bcmring: use common amba device initializers"

Note that in include/linux/amba/bus.h we have:
   #define AMBA_APB_DEVICE(name, busid, id, base, irqs, data) ...

There is an a --> A case error in the busid and a missing zero
placeholder for the id field.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index 22e4e0a..adbfb19 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -52,8 +52,8 @@
 #include <mach/csp/chipcHw_inline.h>
 #include <mach/csp/tmrHw_reg.h>
 
-static AMBA_APB_DEVICE(uartA, "uarta", MM_ADDR_IO_UARTA, { IRQ_UARTA }, NULL);
-static AMBA_APB_DEVICE(uartB, "uartb", MM_ADDR_IO_UARTB, { IRQ_UARTB }, NULL);
+static AMBA_APB_DEVICE(uartA, "uartA", 0, MM_ADDR_IO_UARTA, {IRQ_UARTA}, NULL);
+static AMBA_APB_DEVICE(uartB, "uartB", 0, MM_ADDR_IO_UARTB, {IRQ_UARTB}, NULL);
 
 static struct clk pll1_clk = {
 	.name = "PLL1",
-- 
1.7.9.1

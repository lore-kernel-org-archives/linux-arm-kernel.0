From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 26 Jul 2013 12:04:10 -0500
Subject: [PATCH] ARM: debug: use generic option for ep93xx PL10x debug port
In-Reply-To: <201307171048.17430.hartleys@visionengravers.com>
References: <201307171048.17430.hartleys@visionengravers.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC5C2138@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Ping... Any comments on this?

Thanks,
Hartley

-----Original Message-----
From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of H Hartley Sweeten
Sent: Wednesday, July 17, 2013 10:48 AM
To: ARM Kernel
Cc: Russell King; Ryan Mallon
Subject: [PATCH] ARM: debug: use generic option for ep93xx PL10x debug port

The generic option DEBUG_LL_UART_PL01X is now used to select the UART
type for the kernel low-level debugging on the ep93xx platform. This
enables two config options to provide the physical and virtual base
address of the debug UART.

Use the generic options instead of providing platform specific options
to select the debug UART.

UART1 is selected with:  DEBUG_UART_PHYS = 0x808c0000
                         DEBUG_UART_VIRT = 0xfedc0000

UART2 is selected with:  DEBUG_UART_PHYS = 0x808d0000
                         DEBUG_UART_VIRT = 0xfedd0000

UART3 is selected with:  DEBUG_UART_PHYS = 0x808e0000
                         DEBUG_UART_VIRT = 0xfede0000

The selected UART must already be initialized by the bootloader. If it
isn't setup nothing will appear (which might be desired).

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Ryan Mallon <rmallon@gmail.com>
---
This applies on top of Russell King's "Clean up the debugging support".

 arch/arm/mach-ep93xx/Kconfig                   | 14 --------------
 arch/arm/mach-ep93xx/include/mach/uncompress.h | 14 ++------------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index fe3c1fa..93e54fd 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -194,20 +194,6 @@ config MACH_VISION_EP9307
 	  Say 'Y' here if you want your kernel to support the
 	  Vision Engraving Systems EP9307 SoM.
 
-choice
-	prompt "Select a UART for early kernel messages"
-
-config EP93XX_EARLY_UART1
-	bool "UART1"
-
-config EP93XX_EARLY_UART2
-	bool "UART2"
-
-config EP93XX_EARLY_UART3
-	bool "UART3"
-
-endchoice
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index b5cc77d..03c42e5 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -31,18 +31,8 @@ static void __raw_writel(unsigned int value, unsigned int ptr)
 	*((volatile unsigned int *)ptr) = value;
 }
 
-#if defined(CONFIG_EP93XX_EARLY_UART1)
-#define UART_BASE		EP93XX_UART1_PHYS_BASE
-#elif defined(CONFIG_EP93XX_EARLY_UART2)
-#define UART_BASE		EP93XX_UART2_PHYS_BASE
-#elif defined(CONFIG_EP93XX_EARLY_UART3)
-#define UART_BASE		EP93XX_UART3_PHYS_BASE
-#else
-#define UART_BASE		EP93XX_UART1_PHYS_BASE
-#endif
-
-#define PHYS_UART_DATA		(UART_BASE + 0x00)
-#define PHYS_UART_FLAG		(UART_BASE + 0x18)
+#define PHYS_UART_DATA		(CONFIG_DEBUG_UART_PHYS + 0x00)
+#define PHYS_UART_FLAG		(CONFIG_DEBUG_UART_PHYS + 0x18)
 #define UART_FLAG_TXFF		0x20
 
 static inline void putc(int c)
-- 
1.8.3.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

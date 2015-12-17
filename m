From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 17:14:57 +0100
Subject: [PATCH 09/10] ARM: debug-ll: reorder Kconfig alphanumerically
In-Reply-To: <20151217104508.GG8644@n2100.arm.linux.org.uk>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
 <1449268242-808553-10-git-send-email-arnd@arndb.de>
 <20151217104508.GG8644@n2100.arm.linux.org.uk>
Message-ID: <2266750.YuAszZRgmA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 10:45:08 Russell King - ARM Linux wrote:
> On Fri, Dec 04, 2015 at 11:30:41PM +0100, Arnd Bergmann wrote:
> > +     config DEBUG_LL_UART_EFM32
> > +             bool "Kernel low-level debugging via efm32 UART"
> > +             depends on ARCH_EFM32
> > +             help
> > +               Say Y here if you want the debug print routines to direct
> > +               their output to an UART or USART port on efm32 based
> > +               machines. Use the following addresses for DEBUG_UART_PHYS:
> > +
> > +                 0x4000c000 | USART0
> > +                 0x4000c400 | USART1
> > +                 0x4000c800 | USART2
> > +                 0x4000e000 | UART0
> > +                 0x4000e400 | UART1
> > +
> 
> NAK.  The DEBUG_LL options are _supposed_ to be at the end - this option
> was correctly positioned:

Ok, got it. I thought about this briefly when I did the reorganization but
assumed it was not intentional and just oddly named. DEBUG_LL_UART_EFM32
it a bit different from all the other options, so either location seemed
reasonable:

* like DEBUG_LL_UART_8250 and DEBUG_LL_UART_PL01X, we don't configure
  a particular address based on the platform, and the naming is consistent
  with those options.

* like all other options, it specific to one particular platform, and
  simply turning on DEBUG_LL from a defconfig file without selecting
  a particular target ends up picking the first one, and that is
  intentionally a platform specific option, so we don't have to pick
  one explicitly.

I've queued up the patch below to avoid having to rebuild the entire
next/multiplatform branch, let me know if you'd rather see that branch
rebuilt.

	Arnd

>From 06920d4eeabcd824436ace6fbd6cf49739a5812a Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Dec 2015 16:59:55 +0100
Subject: [PATCH] ARM: debug-ll: move DEBUG_LL_UART_EFM32 to correct Kconfig location

I accidentally move the DEBUG_LL_UART_EFM32 option when sorting all
other options alphanumerically, but it belongs into the same group
as DEBUG_LL_UART_8250 and DEBUG_LL_UART_PL01X.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 1dc9341 ("ARM: debug-ll: reorder Kconfig alphanumerically")

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 3626b8b..776fc7c 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -246,20 +246,6 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the UA0 serial port in the CX92755.
 
-	config DEBUG_LL_UART_EFM32
-		bool "Kernel low-level debugging via efm32 UART"
-		depends on ARCH_EFM32
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to an UART or USART port on efm32 based
-		  machines. Use the following addresses for DEBUG_UART_PHYS:
-
-		    0x4000c000 | USART0
-		    0x4000c400 | USART1
-		    0x4000c800 | USART2
-		    0x4000e000 | UART0
-		    0x4000e400 | UART1
-
 	config DEBUG_EP93XX
 		bool "Kernel low-level debugging messages via ep93xx UART"
 		depends on ARCH_EP93XX
@@ -1299,6 +1285,20 @@ choice
 		  options; the platform specific options are deprecated
 		  and will be soon removed.
 
+	config DEBUG_LL_UART_EFM32
+		bool "Kernel low-level debugging via efm32 UART"
+		depends on ARCH_EFM32
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to an UART or USART port on efm32 based
+		  machines. Use the following addresses for DEBUG_UART_PHYS:
+
+		    0x4000c000 | USART0
+		    0x4000c400 | USART1
+		    0x4000c800 | USART2
+		    0x4000e000 | UART0
+		    0x4000e400 | UART1
+
 	config DEBUG_LL_UART_PL01X
 		bool "Kernel low-level debugging via ARM Ltd PL01x Primecell UART"
 		help

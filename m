From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 15 May 2012 21:55:02 +0400
Subject: [PATCH 2/2] ARM: clps711x: Added support for CPU frequencies other
 than 73 MHz
In-Reply-To: <1337104502-5292-1-git-send-email-shc_work@mail.ru>
References: <1337104502-5292-1-git-send-email-shc_work@mail.ru>
Message-ID: <1337104502-5292-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern CPUs from CLPS711X-line can operate at frequencies other than 73 MHz.
This patch adds calculation of system clock frequency and the frequency of
UART, depending on processor speed. Kconfig option "CPU frequency" was added
for this purposes.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/Kconfig                 |    9 +++++++++
 arch/arm/mach-clps711x/include/mach/hardware.h |    3 +++
 arch/arm/mach-clps711x/include/mach/timex.h    |    4 +++-
 drivers/tty/serial/clps711x.c                  |    4 ++--
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index ea036d6..24a7279 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -45,6 +45,15 @@ config ARCH_P720T
 config ARCH_FORTUNET
 	bool "FORTUNET"
 
+config EP72XX_CPU_SPEED
+	int "CPU frequency"
+	default 73728000
+	help
+	  This is a CPU frequency. This value must be setup in bootlader,
+	  before loading kernel.
+	  The value can be one of: 18432000, 36864000, 49152000, 73728000 or
+	  90316800.
+
 config EP72XX_ROM_BOOT
 	bool "EP721x/EP731x ROM boot"
 	help
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index 13a64fc..76e3293 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -24,6 +24,9 @@
 
 #include <mach/clps711x.h>
 
+#define CPU_BUS_SPEED		(CONFIG_EP72XX_CPU_SPEED / 2)
+#define UART_BAUD_BASE		(CPU_BUS_SPEED / 10)
+
 #define CLPS711X_VIRT_BASE	IOMEM(0xff000000)
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm/mach-clps711x/include/mach/timex.h b/arch/arm/mach-clps711x/include/mach/timex.h
index ac8823c..fa5ad13 100644
--- a/arch/arm/mach-clps711x/include/mach/timex.h
+++ b/arch/arm/mach-clps711x/include/mach/timex.h
@@ -20,4 +20,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#define CLOCK_TICK_RATE 512000
+#include <mach/hardware.h>
+
+#define CLOCK_TICK_RATE		(CONFIG_EP72XX_CPU_SPEED / 144)
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index d0f719f..bae678d 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -401,7 +401,7 @@ static struct uart_port clps711x_ports[UART_NR] = {
 	{
 		.iobase		= SYSCON1,
 		.irq		= IRQ_UTXINT1, /* IRQ_URXINT1, IRQ_UMSINT */
-		.uartclk	= 3686400,
+		.uartclk	= UART_BAUD_BASE,
 		.fifosize	= 16,
 		.ops		= &clps711x_pops,
 		.line		= 0,
@@ -410,7 +410,7 @@ static struct uart_port clps711x_ports[UART_NR] = {
 	{
 		.iobase		= SYSCON2,
 		.irq		= IRQ_UTXINT2, /* IRQ_URXINT2 */
-		.uartclk	= 3686400,
+		.uartclk	= UART_BAUD_BASE,
 		.fifosize	= 16,
 		.ops		= &clps711x_pops,
 		.line		= 1,
-- 
1.7.3.4

From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Apr 2012 13:11:29 +0400
Subject: [PATCH 16/17] ARM clps711x: Replaced frequency settings to definition
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <1334999490-27177-17-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some CPUs from CLPS711X-line can operate at frequencies other than 73 MHz.
Added calculation of system clock frequency and the frequency of UART,
depending on processor speed.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/include/mach/hardware.h |    4 ++++
 arch/arm/mach-clps711x/include/mach/timex.h    |    4 +++-
 drivers/tty/serial/clps711x.c                  |    4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index 495d57b..acaf777 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -24,6 +24,10 @@
 
 #include <asm/hardware/clps7111.h>
 
+#define CPU_SPEED		(73728000)
+#define CPU_BUS_SPEED		(CPU_SPEED / 2)
+#define UART_BAUD_BASE		(CPU_BUS_SPEED / 10)
+
 #define CLPS711X_PHYS_BASE	(0x80000000)
 #define CLPS711X_VIRT_BASE	(0xff000000)
 
diff --git a/arch/arm/mach-clps711x/include/mach/timex.h b/arch/arm/mach-clps711x/include/mach/timex.h
index ac8823c..56f5ecf 100644
--- a/arch/arm/mach-clps711x/include/mach/timex.h
+++ b/arch/arm/mach-clps711x/include/mach/timex.h
@@ -20,4 +20,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#define CLOCK_TICK_RATE 512000
+#include <mach/hardware.h>
+
+#define CLOCK_TICK_RATE	(CPU_SPEED / 144)
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

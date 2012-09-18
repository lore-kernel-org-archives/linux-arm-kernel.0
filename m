From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Sep 2012 15:17:55 +0100
Subject: [PATCH v2 13/13] ARM: vexpress: Make the DEBUG_LL UART detection more
 specific
In-Reply-To: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1347977875-16855-14-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Base the UART detection heuristic on architecturally defined
MIDR register instead of implementation dependent CBAR. The
only tile using the original memory map is V2P-CA9 with Cortex
A9 r0p1, which MIDR contains 0x410fc091 value.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/include/mach/debug-macro.S |   10 ++++++----
 arch/arm/mach-vexpress/include/mach/uncompress.h  |   12 +++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index 9f509f5..0c6abbf 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -23,12 +23,14 @@
 		.macro	addruart,rp,rv,tmp
 
 		@ Make an educated guess regarding the memory map:
-		@ - the original A9 core tile, which has MPCore peripherals
-		@   located at 0x1e000000, should use UART at 0x10009000
+		@ - the original A9 core tile (based on ARM Cortex-A9 r0p1)
+		@   should use UART at 0x10009000
 		@ - all other (RS1 complaint) tiles use UART mapped
 		@   at 0x1c090000
-		mrc	p15, 4, \tmp, c15, c0, 0
-		cmp	\tmp, #0x1e000000
+		mrc	p15, 0, \rp, c0, c0, 0
+		movw	\rv, #0xc091
+		movt	\rv, #0x410f
+		cmp	\rp, \rv
 
 		@ Original memory map
 		moveq	\rp, #DEBUG_LL_UART_OFFSET
diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index 1e472eb..8b8a2ef 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -17,6 +17,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <asm/cputype.h>
+
 #define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))
 #define AMBA_UART_LCRH(base)	(*(volatile unsigned char *)((base) + 0x2c))
 #define AMBA_UART_CR(base)	(*(volatile unsigned char *)((base) + 0x30))
@@ -28,18 +30,14 @@
 static unsigned long get_uart_base(void)
 {
 #if defined(CONFIG_DEBUG_VEXPRESS_UART0_DETECT)
-	unsigned long mpcore_periph;
-
 	/*
 	 * Make an educated guess regarding the memory map:
-	 * - the original A9 core tile, which has MPCore peripherals
-	 *   located at 0x1e000000, should use UART at 0x10009000
+	 * - the original A9 core tile (based on ARM Cortex-A9 r0p1)
+	 *   should use UART at 0x10009000
 	 * - all other (RS1 complaint) tiles use UART mapped
 	 *   at 0x1c090000
 	 */
-	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (mpcore_periph));
-
-	if (mpcore_periph == 0x1e000000)
+	if (read_cpuid_id() == 0x410fc091)
 		return UART_BASE;
 	else
 		return UART_BASE_RS1;
-- 
1.7.9.5

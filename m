From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 11 Dec 2016 11:16:15 -0800
Subject: [PATCH] ARM: ep93xx: Disable TS-72xx watchdog before uncompressing
Message-ID: <20161211191615.13696-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TS-72xx/73xx boards have a CPLD watchdog which is configured to
reset the board after 8 seconds, if the kernel is large enough that this
takes about this time to decompress the kernel, we will encounter a
spurious reboot.

Do not pull ts72xx.h, but instead locally define what we need to disable
the watchdog.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-ep93xx/include/mach/uncompress.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index 03c42e5400d2..b0cf2de77f81 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -10,6 +10,7 @@
  */
 
 #include <mach/ep93xx-regs.h>
+#include <asm/mach-types.h>
 
 static unsigned char __raw_readb(unsigned int ptr)
 {
@@ -75,8 +76,19 @@ static void ethernet_reset(void)
 		;
 }
 
+#define TS72XX_WDT_CONTROL_PHYS_BASE	0x23800000
+#define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
+#define TS72XX_WDT_FEED_VAL		0x05
+
+static void __maybe_unused ts72xx_watchdog_disable(void)
+{
+	__raw_writeb(TS72XX_WDT_FEED_VAL, TS72XX_WDT_FEED_PHYS_BASE);
+	__raw_writeb(0, TS72XX_WDT_CONTROL_PHYS_BASE);
+}
 
 static void arch_decomp_setup(void)
 {
+	if (machine_is_ts72xx())
+		ts72xx_watchdog_disable();
 	ethernet_reset();
 }
-- 
2.9.3

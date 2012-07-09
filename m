From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 9 Jul 2012 21:06:25 +0200
Subject: [PATCH] ARM: at91/clock: fix PLLA overclock warning
Message-ID: <1341860785-27405-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix PLLA overclock warning in relation with datasheet numbers.
Add new > 240 MHz and > 210 MHz SoC categories.

Reported-by: Jiri Prchal <jiri.prchal@aksignal.cz>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/clock.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index de2ec6b..188c829 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -63,6 +63,12 @@ EXPORT_SYMBOL_GPL(at91_pmc_base);
 
 #define cpu_has_300M_plla()	(cpu_is_at91sam9g10())
 
+#define cpu_has_240M_plla()	(cpu_is_at91sam9261() \
+				|| cpu_is_at91sam9263() \
+				|| cpu_is_at91sam9rl())
+
+#define cpu_has_210M_plla()	(cpu_is_at91sam9260())
+
 #define cpu_has_pllb()		(!(cpu_is_at91sam9rl() \
 				|| cpu_is_at91sam9g45() \
 				|| cpu_is_at91sam9x5() \
@@ -706,6 +712,12 @@ static int __init at91_pmc_init(unsigned long main_clock)
 	} else if (cpu_has_800M_plla()) {
 		if (plla.rate_hz > 800000000)
 			pll_overclock = true;
+	} else if (cpu_has_240M_plla()) {
+		if (plla.rate_hz > 240000000)
+			pll_overclock = true;
+	} else if (cpu_has_210M_plla()) {
+		if (plla.rate_hz > 210000000)
+			pll_overclock = true;
 	} else {
 		if (plla.rate_hz > 209000000)
 			pll_overclock = true;
-- 
1.7.10

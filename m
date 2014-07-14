From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 14 Jul 2014 18:52:04 +0200
Subject: [PATCH v3 4/4] arm: pxa: add non device-tree timer link to clocksource
In-Reply-To: <1405356724-32207-1-git-send-email-robert.jarzmik@free.fr>
References: <1405356724-32207-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1405356724-32207-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As clocksource pxa_timer was moved to clocksource framework, the
pxa_timer initialization needs to be a bit amended, to pass the
necessary informations to clocksource, ie :
 - the timer interrupt (mach specific)
 - the timer registers base (ditto)
 - the timer clockrate

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

---
Since V2: Arnd's comment : moved extern declaration into .h file
---
 arch/arm/mach-pxa/generic.c | 11 +++++++++++
 include/clocksource/pxa.h   | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 include/clocksource/pxa.h

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 4225417..6f38e1a 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -25,11 +25,13 @@
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 
+#include <mach/irqs.h>
 #include <mach/reset.h>
 #include <mach/smemc.h>
 #include <mach/pxa3xx-regs.h>
 
 #include "generic.h"
+#include <clocksource/pxa.h>
 
 void clear_reset_status(unsigned int mask)
 {
@@ -57,6 +59,15 @@ unsigned long get_clock_tick_rate(void)
 EXPORT_SYMBOL(get_clock_tick_rate);
 
 /*
+ * For non device-tree builds, keep legacy timer init
+ */
+void pxa_timer_init(void)
+{
+	pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x40a00000),
+			    get_clock_tick_rate());
+}
+
+/*
  * Get the clock frequency as reflected by CCCR and the turbo flag.
  * We assume these values have been applied via a fcs.
  * If info is not 0 we also display the current settings.
diff --git a/include/clocksource/pxa.h b/include/clocksource/pxa.h
new file mode 100644
index 0000000..1efbe5a
--- /dev/null
+++ b/include/clocksource/pxa.h
@@ -0,0 +1,18 @@
+/*
+ * PXA clocksource, clockevents, and OST interrupt handlers.
+ *
+ * Copyright (C) 2014 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ */
+
+#ifndef _CLOCKSOURCE_PXA_H
+#define _CLOCKSOURCE_PXA_H
+
+extern void pxa_timer_nodt_init(int irq, void __iomem *base,
+			   unsigned long clock_tick_rate);
+
+#endif
-- 
2.0.0.rc2

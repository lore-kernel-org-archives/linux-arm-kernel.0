From: al@alarsen.net (Anders Larsen)
Date: Tue, 13 Apr 2010 13:05:32 +0200
Subject: [at91] Save power by disabling the processor clock when CPU is idle
Message-ID: <1271156732l.25331l.7l@i-dmzi_al.realan.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the processor clock when the CPU is idle.

This saves much more power than merely entering 'Wait for Interrupt' mode.
Since JTAG-debugging doesn't work when the processor clock is switched off,
make it conditional on CONFIG_DEBUG_KERNEL.

Signed-off-by: Anders Larsen <al@alarsen.net>
Cc: Andrew Victor <avictor.za@gmail.com>
---
KernelVersion: 2.6.33

 arch/arm/mach-at91/include/mach/system.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


Index: b/arch/arm/mach-at91/include/mach/system.h
===================================================================
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -24,21 +24,24 @@
 #include <mach/hardware.h>
 #include <mach/at91_st.h>
 #include <mach/at91_dbgu.h>
+#include <mach/at91_pmc.h>
 
 static inline void arch_idle(void)
 {
+#ifndef CONFIG_DEBUG_KERNEL
 	/*
 	 * Disable the processor clock.  The processor will be automatically
 	 * re-enabled by an interrupt or by a reset.
 	 */
-//	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+#else
 	/*
 	 * Set the processor (CP15) into 'Wait for Interrupt' mode.
 	 * Unlike disabling the processor clock via the PMC (above)
 	 *  this allows the processor to be woken via JTAG.
 	 */
 	cpu_do_idle();
+#endif
 }
 
 void (*at91_arch_reset)(void);

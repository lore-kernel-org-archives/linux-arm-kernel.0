From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 21 Sep 2010 20:39:40 +1000
Subject: [PATCH] arm: fix use of clock disable on idle for AT91x40 devices
Message-ID: <201009211039.o8LAde8Q024441@goober.internal.moreton.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simpler AT91x40 processors do not have the same power management
controller as the new AT91 devices. They do have a simpler power
controller module that we can use to disable the CPU clock at idle
time. Add code to support that.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-at91/include/mach/at91x40.h |    6 ++++++
 arch/arm/mach-at91/include/mach/system.h  |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91x40.h b/arch/arm/mach-at91/include/mach/at91x40.h
index d34cdb8..063ac44 100644
--- a/arch/arm/mach-at91/include/mach/at91x40.h
+++ b/arch/arm/mach-at91/include/mach/at91x40.h
@@ -52,4 +52,10 @@
 #define AT91_DBGU_CIDR	(AT91_SF + 0)	/* CIDR in PS segment */
 #define AT91_DBGU_EXID	(AT91_SF + 4)	/* EXID in PS segment */
 
+/*
+ * Support defines for the simple Power Controller module.
+ */
+#define	AT91_PS_CR	(AT91_PS + 0)	/* PS Control register */
+#define	AT91_PS_CR_CPU	(1 << 0)	/* CPU clock disable bit */
+
 #endif /* AT91X40_H */
diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index c80e090..bfbb612 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -33,7 +33,11 @@ static inline void arch_idle(void)
 	 * Disable the processor clock.  The processor will be automatically
 	 * re-enabled by an interrupt or by a reset.
 	 */
+#ifdef AT91_PS
+	at91_sys_write(AT91_PS_CR, AT91_PS_CR_CPU);
+#else
 	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+#endif
 #else
 	/*
 	 * Set the processor (CP15) into 'Wait for Interrupt' mode.

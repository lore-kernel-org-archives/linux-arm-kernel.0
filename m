From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 12 Oct 2014 17:28:49 +0200
Subject: [PATCH v2 2/4] arm: pxa: move init functions into generic.h
In-Reply-To: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
References: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1413127731-1187-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to have a unique .c file for all pxa variants device-tree
definitions, all the initialization functions for MACHINE_START and
DT_MACHINE_START have been put together into generic.h.

The alternative would have been one pxaXXX-dt.c file per variant.

The move is necessary because each include/mach/pxaXXX.h includes the
variant register descriptions which intersects and conflicts one with
each other.

The change is a preparation for pxa-dt.c to support multiple pxa,
ie. pxa3xx and pxa27x.

The machine files including mach/pxaXXX.h all include generic.h, which
guarantees no regression should be introduced.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

---
Since v1: Arnd's review:
            - removed some ifdefs for function prototypes
	    - moved ifdefs for get_freq_XXX() to the end for future
	      removal
---
 arch/arm/mach-pxa/generic.h             | 65 +++++++++++++++++++++------------
 arch/arm/mach-pxa/include/mach/pxa25x.h |  8 ----
 arch/arm/mach-pxa/include/mach/pxa27x.h |  4 --
 arch/arm/mach-pxa/include/mach/pxa3xx.h |  5 ---
 4 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 8963984..7a9fa1a 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -13,11 +13,11 @@
 
 struct irq_data;
 
-extern void pxa_timer_init(void);
-
-extern void __init pxa_map_io(void);
-
 extern unsigned int get_clk_frequency_khz(int info);
+extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *,
+					     unsigned int));
+extern void __init pxa_map_io(void);
+extern void pxa_timer_init(void);
 
 #define SET_BANK(__nr,__start,__size) \
 	mi->bank[__nr].start = (__start), \
@@ -25,6 +25,43 @@ extern unsigned int get_clk_frequency_khz(int info);
 
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
+#define pxa25x_handle_irq icip_handle_irq
+extern void __init pxa25x_init_irq(void);
+extern void __init pxa25x_map_io(void);
+extern void __init pxa26x_init_irq(void);
+
+#define pxa27x_handle_irq ichp_handle_irq
+extern void __init pxa27x_dt_init_irq(void);
+extern unsigned	pxa27x_get_clk_frequency_khz(int);
+extern void __init pxa27x_init_irq(void);
+extern void __init pxa27x_map_io(void);
+
+#define pxa3xx_handle_irq ichp_handle_irq
+extern void __init pxa3xx_dt_init_irq(void);
+extern void __init pxa3xx_init_irq(void);
+extern void __init pxa3xx_map_io(void);
+
+extern struct syscore_ops pxa_irq_syscore_ops;
+extern struct syscore_ops pxa2xx_mfp_syscore_ops;
+extern struct syscore_ops pxa3xx_mfp_syscore_ops;
+
+void __init pxa_set_ffuart_info(void *info);
+void __init pxa_set_btuart_info(void *info);
+void __init pxa_set_stuart_info(void *info);
+void __init pxa_set_hwuart_info(void *info);
+
+void pxa_restart(enum reboot_mode, const char *);
+
+#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
+extern void pxa2xx_clear_reset_status(unsigned int);
+#else
+static inline void pxa2xx_clear_reset_status(unsigned int mask) {}
+#endif
+
+/*
+ * Once fully converted to the clock framework, all these functions should be
+ * removed, and replaced with a clk_get(NULL, "core").
+ */
 #ifdef CONFIG_PXA25x
 extern unsigned pxa25x_get_clk_frequency_khz(int);
 #else
@@ -32,30 +69,12 @@ extern unsigned pxa25x_get_clk_frequency_khz(int);
 #endif
 
 #ifdef CONFIG_PXA27x
-extern unsigned pxa27x_get_clk_frequency_khz(int);
 #else
 #define pxa27x_get_clk_frequency_khz(x)		(0)
 #endif
 
-#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
-extern void pxa2xx_clear_reset_status(unsigned int);
-#else
-static inline void pxa2xx_clear_reset_status(unsigned int mask) {}
-#endif
-
 #ifdef CONFIG_PXA3xx
-extern unsigned pxa3xx_get_clk_frequency_khz(int);
+extern unsigned	pxa3xx_get_clk_frequency_khz(int);
 #else
 #define pxa3xx_get_clk_frequency_khz(x)		(0)
 #endif
-
-extern struct syscore_ops pxa_irq_syscore_ops;
-extern struct syscore_ops pxa2xx_mfp_syscore_ops;
-extern struct syscore_ops pxa3xx_mfp_syscore_ops;
-
-void __init pxa_set_ffuart_info(void *info);
-void __init pxa_set_btuart_info(void *info);
-void __init pxa_set_stuart_info(void *info);
-void __init pxa_set_hwuart_info(void *info);
-
-void pxa_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-pxa/include/mach/pxa25x.h b/arch/arm/mach-pxa/include/mach/pxa25x.h
index 3ac0baa..5a34175 100644
--- a/arch/arm/mach-pxa/include/mach/pxa25x.h
+++ b/arch/arm/mach-pxa/include/mach/pxa25x.h
@@ -6,12 +6,4 @@
 #include <mach/mfp-pxa25x.h>
 #include <mach/irqs.h>
 
-extern void __init pxa25x_map_io(void);
-extern void __init pxa25x_init_irq(void);
-#ifdef CONFIG_CPU_PXA26x
-extern void __init pxa26x_init_irq(void);
-#endif
-
-#define pxa25x_handle_irq	icip_handle_irq
-
 #endif /* __MACH_PXA25x_H */
diff --git a/arch/arm/mach-pxa/include/mach/pxa27x.h b/arch/arm/mach-pxa/include/mach/pxa27x.h
index 7cff640..599b925 100644
--- a/arch/arm/mach-pxa/include/mach/pxa27x.h
+++ b/arch/arm/mach-pxa/include/mach/pxa27x.h
@@ -19,11 +19,7 @@
 #define ARB_CORE_PARK		(1<<24)	   /* Be parked with core when idle */
 #define ARB_LOCK_FLAG		(1<<23)	   /* Only Locking masters gain access to the bus */
 
-extern void __init pxa27x_map_io(void);
-extern void __init pxa27x_init_irq(void);
 extern int __init pxa27x_set_pwrmode(unsigned int mode);
 extern void pxa27x_cpu_pm_enter(suspend_state_t state);
 
-#define pxa27x_handle_irq	ichp_handle_irq
-
 #endif /* __MACH_PXA27x_H */
diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx.h b/arch/arm/mach-pxa/include/mach/pxa3xx.h
index 6dd7fa1..b4143fb 100644
--- a/arch/arm/mach-pxa/include/mach/pxa3xx.h
+++ b/arch/arm/mach-pxa/include/mach/pxa3xx.h
@@ -5,9 +5,4 @@
 #include <mach/pxa3xx-regs.h>
 #include <mach/irqs.h>
 
-extern void __init pxa3xx_map_io(void);
-extern void __init pxa3xx_init_irq(void);
-
-#define pxa3xx_handle_irq	ichp_handle_irq
-
 #endif /* __MACH_PXA3XX_H */
-- 
2.1.0

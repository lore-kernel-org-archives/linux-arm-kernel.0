From: khilman@ti.com (Kevin Hilman)
Date: Wed, 15 Jun 2011 16:23:29 -0700
Subject: [PATCH 2/2] KJH: use CPU PM for UART
Message-ID: <mailman.123.1315504676.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-omap2/pm24xx.c             |    8 -------
 arch/arm/mach-omap2/pm34xx.c             |    8 -------
 arch/arm/mach-omap2/serial.c             |   33 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/serial.h |    2 -
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 9f7e551..e66c412 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -139,10 +139,6 @@ static void omap2_enter_full_retention(void)
 		if (!console_trylock())
 			goto no_sleep;
 
-	omap_uart_prepare_idle(0);
-	omap_uart_prepare_idle(1);
-	omap_uart_prepare_idle(2);
-
 	cpu_pm_enter();
 
 	/* Jump to SRAM suspend code */
@@ -152,10 +148,6 @@ static void omap2_enter_full_retention(void)
 
 	cpu_pm_exit();
 
-	omap_uart_resume_idle(2);
-	omap_uart_resume_idle(1);
-	omap_uart_resume_idle(0);
-
 	if (!is_suspending())
 		console_unlock();
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b167c7f..04f7075 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -392,8 +392,6 @@ void omap_sram_idle(void)
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
-		omap_uart_prepare_idle(2);
-		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_going_off);
 		if (per_next_state == PWRDM_POWER_OFF)
 				omap3_per_save_context();
@@ -401,8 +399,6 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(0);
-		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
@@ -449,8 +445,6 @@ void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		omap_uart_resume_idle(0);
-		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
 			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
@@ -464,8 +458,6 @@ void omap_sram_idle(void)
 		omap2_gpio_resume_after_idle();
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
-		omap_uart_resume_idle(2);
-		omap_uart_resume_idle(3);
 	}
 
 	cpu_pm_exit();
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 466fc722..1961484 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -28,6 +28,7 @@
 #include <linux/serial_8250.h>
 #include <linux/pm_runtime.h>
 #include <linux/console.h>
+#include <linux/cpu_pm.h>
 
 #ifdef CONFIG_SERIAL_OMAP
 #include <plat/omap-serial.h>
@@ -102,6 +103,8 @@ struct omap_uart_state {
 	u16 wer;
 	u16 mcr;
 #endif
+
+	struct notifier_block nb;
 };
 
 static LIST_HEAD(uart_list);
@@ -389,7 +392,7 @@ static void omap_uart_idle_timer(unsigned long data)
 	omap_uart_allow_sleep(uart);
 }
 
-void omap_uart_prepare_idle(int num)
+static void omap_uart_prepare_idle(int num)
 {
 	struct omap_uart_state *uart;
 
@@ -401,7 +404,7 @@ void omap_uart_prepare_idle(int num)
 	}
 }
 
-void omap_uart_resume_idle(int num)
+static void omap_uart_resume_idle(int num)
 {
 	struct omap_uart_state *uart;
 
@@ -855,6 +858,30 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
 }
 
+    
+static int uart_notifier_call(struct notifier_block *nb, 
+			      unsigned long val, void *p)
+{
+	struct omap_uart_state *uart = 
+		container_of(nb, struct omap_uart_state, nb);
+
+	switch (val) {
+	case CPU_PM_ENTER:
+	case CPU_CLUSTER_PM_ENTER:
+		omap_uart_prepare_idle(uart->num);
+		break;
+	case CPU_PM_EXIT:
+	case CPU_CLUSTER_PM_EXIT:
+		omap_uart_resume_idle(uart->num);
+		break;
+	default:
+		WARN(1,"%s: un-handled notifier value: 0x%lx\n", __func__, val);
+		break;
+	}
+
+	return 0;
+}
+
 /**
  * omap_serial_init() - initialize all supported serial ports
  *
@@ -874,5 +901,7 @@ void __init omap_serial_init(void)
 		bdata.pads_cnt = 0;
 		omap_serial_init_port(&bdata);
 
+		uart->nb.notifier_call = uart_notifier_call;
+		cpu_pm_register_notifier(&uart->nb);
 	}
 }
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index de3b10c..0e78f6d 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -112,8 +112,6 @@ extern void omap_serial_init_port(struct omap_board_data *bdata);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
-extern void omap_uart_prepare_idle(int num);
-extern void omap_uart_resume_idle(int num);
 extern void omap_uart_enable_irqs(int enable);
 #endif
 
-- 
1.7.6



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.125.1315579615.20020.linux-arm-kernel@lists.infradead.org>

- Move the SMP ops out of the descriptor, which makes the structure
  init a bit cleaner (thanks to Arnd).
- Mark all structures __initdata and keep a copy of the used ones.
- Keep a global pointer for the SMP ops.

Marc Zyngier (3):
  ARM: SoC: Introduce per SoC descriptor
  ARM: SoC: Add per SoC SMP and CPU hotplug operations
  ARM: SoC: convert VExpress/RealView to SoC descriptor

 arch/arm/include/asm/mach/arch.h               |    2 +
 arch/arm/include/asm/soc.h                     |   39 ++++++++++++++++++++
 arch/arm/kernel/setup.c                        |   20 ++++++++++
 arch/arm/kernel/smp.c                          |   47 ++++++++++++++++++++++++
 arch/arm/mach-realview/core.c                  |    8 ++++
 arch/arm/mach-realview/core.h                  |    8 ++++
 arch/arm/mach-realview/hotplug.c               |    6 ++--
 arch/arm/mach-realview/platsmp.c               |   21 +++++++++--
 arch/arm/mach-realview/realview_eb.c           |    1 +
 arch/arm/mach-realview/realview_pb1176.c       |    1 +
 arch/arm/mach-realview/realview_pb11mp.c       |    1 +
 arch/arm/mach-realview/realview_pba8.c         |    1 +
 arch/arm/mach-realview/realview_pbx.c          |    1 +
 arch/arm/mach-vexpress/core.h                  |    8 ++++
 arch/arm/mach-vexpress/hotplug.c               |    6 ++--
 arch/arm/mach-vexpress/platsmp.c               |   21 +++++++++--
 arch/arm/mach-vexpress/v2m.c                   |   10 +++++
 arch/arm/plat-versatile/include/plat/platsmp.h |   14 +++++++
 arch/arm/plat-versatile/platsmp.c              |    4 +-
 19 files changed, 203 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/include/asm/soc.h
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.128.1315824990.20020.linux-arm-kernel@lists.infradead.org>

- Split the SMP ops between init and runtime operations in order to
  have separate lifetimes for the different structures. This is not
  perfect though, as it still allows an __init function to make it to
  a runtime structure (all smp_*_ops structures are __initdata in
  order to be able to discard them). Thanks to Nico for pointing this
  out.
- Use macros to hide the #ifdef-ery in the SoC descriptor init,
  courtesy of Arnd.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.129.1315824991.20020.linux-arm-kernel@lists.infradead.org>

- Move the SMP ops out of the descriptor, which makes the structure
  init a bit cleaner (thanks to Arnd).
- Mark all structures __initdata and keep a copy of the used ones.
- Keep a global pointer for the SMP ops.

Marc Zyngier (3):
  ARM: SoC: Introduce per SoC descriptor
  ARM: SoC: Add per SoC SMP and CPU hotplug operations
  ARM: SoC: convert VExpress/RealView to SoC descriptor

 arch/arm/include/asm/mach/arch.h               |    2 +
 arch/arm/include/asm/soc.h                     |   52 ++++++++++++++++++++++++
 arch/arm/kernel/setup.c                        |   30 ++++++++++++++
 arch/arm/kernel/smp.c                          |   47 +++++++++++++++++++++
 arch/arm/mach-realview/core.c                  |    7 +++
 arch/arm/mach-realview/core.h                  |    9 ++++
 arch/arm/mach-realview/hotplug.c               |    6 +-
 arch/arm/mach-realview/platsmp.c               |   24 +++++++++--
 arch/arm/mach-realview/realview_eb.c           |    1 +
 arch/arm/mach-realview/realview_pb1176.c       |    1 +
 arch/arm/mach-realview/realview_pb11mp.c       |    1 +
 arch/arm/mach-realview/realview_pba8.c         |    1 +
 arch/arm/mach-realview/realview_pbx.c          |    1 +
 arch/arm/mach-vexpress/core.h                  |   10 +++++
 arch/arm/mach-vexpress/hotplug.c               |    6 +-
 arch/arm/mach-vexpress/platsmp.c               |   24 +++++++++--
 arch/arm/mach-vexpress/v2m.c                   |    9 ++++
 arch/arm/plat-versatile/include/plat/platsmp.h |   14 ++++++
 arch/arm/plat-versatile/platsmp.c              |    4 +-
 19 files changed, 233 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/include/asm/soc.h
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.130.1315844567.20020.linux-arm-kernel@lists.infradead.org>

any guaranteed barrier behaviour at all, although it will have a
barrier effect on many implementations.  As we get into v7-land, this
kind of thing becomre more and more unsafe as new implementations push
the architectural envelope.

Haojian, can you comment on whether the proposed sequence will work in
this case of synchronising CPACR updates?  If we can use the same
sequence for all v6/v7/ARM/Thumb-2 kernels, that would be preferable
to #ifdefs.

Cheers
---Dave

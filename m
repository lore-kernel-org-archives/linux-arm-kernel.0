From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Sun, 22 Jun 2014 22:11:51 -0500
Subject: [PATCH v7 2/9] clocksource: arm_arch_timer: enable counter access for
 32-bit ARM
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1403493118-7597-3-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only difference between arm and arm64's implementations of
arch_counter_set_user_access is that 32-bit ARM does not enable user
access to the virtual counter.  We want to enable this access for the
32-bit ARM VDSO, so copy the arm64 version to the driver itself,
giving it a slightly different name (arch_counter_set_access) to avoid
redefinition.

The arch_timer_evtstrm_enable hooks are also substantially similar,
the only difference being a CONFIG_COMPAT-conditional section which is
relevant only for arm64.  Copy the arm64 version to the driver, again
slightly renaming (arch_timer_evtstrm_enable => arch_timer_enable_evtstrm).

With this change, the arch_counter_set_user_access and
arch_timer_evtstrm_enable hooks in both arm and arm64 become unused, to
be removed in followup patches.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 drivers/clocksource/arm_arch_timer.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c99afdf12e98..0188332ad24b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -23,6 +23,7 @@
 #include <linux/sched_clock.h>
 
 #include <asm/arch_timer.h>
+#include <asm/hwcap.h>
 #include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -299,6 +300,20 @@ static void __arch_timer_setup(unsigned type,
 	clockevents_config_and_register(clk, arch_timer_rate, 0xf, 0x7fffffff);
 }
 
+static void arch_timer_enable_evtstrm(int divider)
+{
+	u32 cntkctl = arch_timer_get_cntkctl();
+	cntkctl &= ~ARCH_TIMER_EVT_TRIGGER_MASK;
+	/* Set the divider and enable virtual event stream */
+	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
+			| ARCH_TIMER_VIRT_EVT_EN;
+	arch_timer_set_cntkctl(cntkctl);
+	elf_hwcap |= HWCAP_EVTSTRM;
+#ifdef CONFIG_COMPAT
+	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
+#endif
+}
+
 static void arch_timer_configure_evtstream(void)
 {
 	int evt_stream_div, pos;
@@ -309,7 +324,24 @@ static void arch_timer_configure_evtstream(void)
 	if (pos > 1 && !(evt_stream_div & (1 << (pos - 2))))
 		pos--;
 	/* enable event stream */
-	arch_timer_evtstrm_enable(min(pos, 15));
+	arch_timer_enable_evtstrm(min(pos, 15));
+}
+
+static void arch_counter_set_access(void)
+{
+	u32 cntkctl = arch_timer_get_cntkctl();
+
+	/* Disable user access to the timers and the physical counter */
+	/* Also disable virtual event stream */
+	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
+			| ARCH_TIMER_USR_VT_ACCESS_EN
+			| ARCH_TIMER_VIRT_EVT_EN
+			| ARCH_TIMER_USR_PCT_ACCESS_EN);
+
+	/* Enable user access to the virtual counter */
+	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
+
+	arch_timer_set_cntkctl(cntkctl);
 }
 
 static int arch_timer_setup(struct clock_event_device *clk)
@@ -324,7 +356,7 @@ static int arch_timer_setup(struct clock_event_device *clk)
 			enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], 0);
 	}
 
-	arch_counter_set_user_access();
+	arch_counter_set_access();
 	if (IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM))
 		arch_timer_configure_evtstream();
 
-- 
1.9.3

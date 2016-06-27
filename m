From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Jun 2016 17:30:13 +0100
Subject: [PATCH] clocksource: arm_arch_timer: control the evtstrm via the
 cmdline
Message-ID: <1467045013-27211-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disabling the eventstream can be useful for both remotely debugging a
deployed production system and development of code using WFE-based
polling loops. Whilst this can currently be controlled via a Kconfig
option (CONFIG_ARM_ARCH_TIMER_EVTSTREAM), it's often desirable to toggle
the feature on the command line, so this patch adds a new command-line
option ("clocksource.arm_arch_timer.evtstrm") to do just that. The
default behaviour is determined based on CONFIG_ARM_ARCH_TIMER_EVTSTREAM.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/kernel-parameters.txt  |  8 ++++++++
 drivers/clocksource/Kconfig          | 12 +++++++-----
 drivers/clocksource/arm_arch_timer.c | 10 +++++++++-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 82b42c958d1c..2c92f1df7c69 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -687,6 +687,14 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			[SPARC64] tick
 			[X86-64] hpet,tsc
 
+	clocksource.arm_arch_timer.evtstrm=
+			[ARM,ARM64]
+			Format: <bool>
+			Enable/disable the eventstream feature of the ARM
+			architected timer so that code using WFE-based polling
+			loops can be debugged more effectively on production
+			systems.
+
 	clearcpuid=BITNUM [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 47352d25c15e..a6b0361c2ada 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -208,14 +208,16 @@ config ARM_ARCH_TIMER
 	select CLKSRC_ACPI if ACPI
 
 config ARM_ARCH_TIMER_EVTSTREAM
-	bool "Support for ARM architected timer event stream generation"
+	bool "Enable ARM architected timer event stream generation by default"
 	default y if ARM_ARCH_TIMER
 	depends on ARM_ARCH_TIMER
 	help
-	  This option enables support for event stream generation based on
-	  the ARM architected timer. It is used for waking up CPUs executing
-	  the wfe instruction at a frequency represented as a power-of-2
-	  divisor of the clock rate.
+	  This option enables support by default for event stream generation
+	  based on the ARM architected timer. It is used for waking up CPUs
+	  executing the wfe instruction at a frequency represented as a
+	  power-of-2 divisor of the clock rate. The behaviour can also be
+	  overridden on the command line using the
+	  clocksource.arm_arch_timer.evtstream parameter.
 	  The main use of the event stream is wfe-based timeouts of userspace
 	  locking implementations. It might also be useful for imposing timeout
 	  on wfe to safeguard against any programming errors in case an expected
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4814446a0024..48cda6498797 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -79,6 +79,14 @@ static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 
+static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
+
+static int __init early_evtstrm_cfg(char *buf)
+{
+	return strtobool(buf, &evtstrm_enable);
+}
+early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
+
 /*
  * Architected system timer support.
  */
@@ -372,7 +380,7 @@ static int arch_timer_setup(struct clock_event_device *clk)
 		enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], 0);
 
 	arch_counter_set_user_access();
-	if (IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM))
+	if (evtstrm_enable)
 		arch_timer_configure_evtstream();
 
 	return 0;
-- 
2.1.4

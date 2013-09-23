From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 15:24:34 -0400 (EDT)
Subject: [PATCH] ARM: MCPM: don't explode if invoked without being initialized
 first
Message-ID: <alpine.LFD.2.03.1309231522470.312@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently mcpm_cpu_power_down() and mcpm_cpu_suspend() trigger BUG()
if mcpm_platform_register() is not called beforehand.  This may occur
for many reasons such as some incomplete device tree passed to the kernel
or the like.

Let's be nicer to users and avoid killing the kernel if that happens by
logging a warning and returning to the caller.  The mcpm_cpu_suspend()
user is already set to deal with this situation, and so is cpu_die()
invoking mcpm_cpu_die().

The problematic case would have been the B.L switcher's usage of
mcpm_cpu_power_down(), however it has to call mcpm_cpu_power_up() first
which is already set to catch an error resulting from a missing
mcpm_platform_register() call.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 370236dd1a..3fd43f1fd2 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -51,7 +51,8 @@ void mcpm_cpu_power_down(void)
 {
 	phys_reset_t phys_reset;
 
-	BUG_ON(!platform_ops);
+	if (WARN_ON_ONCE(!platform_ops))
+		return;
 	BUG_ON(!irqs_disabled());
 
 	/*
@@ -93,7 +94,8 @@ void mcpm_cpu_suspend(u64 expected_residency)
 {
 	phys_reset_t phys_reset;
 
-	BUG_ON(!platform_ops);
+	if (WARN_ON_ONCE(!platform_ops))
+		return;
 	BUG_ON(!irqs_disabled());
 
 	/* Very similar to mcpm_cpu_power_down() */
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 0f7b7620e9..fc82a88f5b 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -76,8 +76,11 @@ int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster);
  *
  * This must be called with interrupts disabled.
  *
- * This does not return.  Re-entry in the kernel is expected via
- * mcpm_entry_point.
+ * On success this does not return.  Re-entry in the kernel is expected
+ * via mcpm_entry_point.
+ *
+ * This will return if mcpm_platform_register() has not been called
+ * previously in which case the caller should take appropriate action.
  */
 void mcpm_cpu_power_down(void);
 
@@ -98,8 +101,11 @@ void mcpm_cpu_power_down(void);
  *
  * This must be called with interrupts disabled.
  *
- * This does not return.  Re-entry in the kernel is expected via
- * mcpm_entry_point.
+ * On success this does not return.  Re-entry in the kernel is expected
+ * via mcpm_entry_point.
+ *
+ * This will return if mcpm_platform_register() has not been called
+ * previously in which case the caller should take appropriate action.
  */
 void mcpm_cpu_suspend(u64 expected_residency);
 

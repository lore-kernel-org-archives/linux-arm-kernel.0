From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 21 Mar 2016 17:48:44 +0100
Subject: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160321164843.GD6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The below annotates the two most used idle functions on x86


--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -152,7 +152,7 @@ int acpi_processor_ffh_cstate_probe(unsi
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
 
-void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
+__cpuidle void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 {
 	unsigned int cpu = smp_processor_id();
 	struct cstate_entry *percpu_entry;
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -725,7 +725,7 @@ static struct cpuidle_state avn_cstates[
  *
  * Must be called under local_irq_disable().
  */
-static int intel_idle(struct cpuidle_device *dev,
+__cpuidle static int intel_idle(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
 	unsigned long ecx = 1; /* break on interrupt flag */

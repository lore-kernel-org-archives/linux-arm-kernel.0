From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 14:59:33 +0000
Subject: [PATCH v12 4/4] xen/arm: account for stolen ticks
In-Reply-To: <alpine.DEB.2.02.1511201434520.1107@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511201434520.1107@kaball.uk.xensource.com>
Message-ID: <1448031573-23497-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the runstate_memory_area with the hypervisor.
Use pv_time_ops.steal_clock to account for stolen ticks.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v12:
- ifdef CONFIG_PARAVIRT the code that depends on it
- remove useless #include's

Changes in v4:
- don't use paravirt_steal_rq_enabled: we do not support retrieving
stolen ticks for vcpus other than one we are running on.

Changes in v3:
- use BUG_ON and smp_processor_id.
---
 arch/arm/xen/enlighten.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index fc7ea52..408211f 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -79,6 +79,23 @@ int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(xen_unmap_domain_gfn_range);
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+
+static unsigned long long xen_stolen_accounting(int cpu)
+{
+	struct vcpu_runstate_info state;
+
+	BUG_ON(cpu != smp_processor_id());
+
+	xen_get_runstate_snapshot(&state);
+
+	WARN_ON(state.state != RUNSTATE_running);
+
+	return state.time[RUNSTATE_runnable] + state.time[RUNSTATE_offline];
+}
+#endif
+
 static void xen_percpu_init(void)
 {
 	struct vcpu_register_vcpu_info info;
@@ -104,6 +121,8 @@ static void xen_percpu_init(void)
 	BUG_ON(err);
 	per_cpu(xen_vcpu, cpu) = vcpup;
 
+	xen_setup_runstate_info(cpu);
+
 after_register_vcpu_info:
 	enable_percpu_irq(xen_events_irq, 0);
 	put_cpu();
@@ -271,6 +290,11 @@ static int __init xen_guest_init(void)
 
 	register_cpu_notifier(&xen_cpu_notifier);
 
+#ifdef CONFIG_PARAVIRT
+	pv_time_ops.steal_clock = xen_stolen_accounting;
+	static_key_slow_inc(&paravirt_steal_enabled);
+#endif
+
 	return 0;
 }
 early_initcall(xen_guest_init);
-- 
1.7.10.4

From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 24 Apr 2013 20:28:10 +0100
Subject: [PATCH v4 2/7] xen/arm: SMP support
In-Reply-To: <alpine.DEB.2.02.1304242012590.4180@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304242012590.4180@kaball.uk.xensource.com>
Message-ID: <1366831695-13214-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Map vcpu_info using VCPUOP_register_vcpu_info on secondary cpus.

Call enable_percpu_irq on every cpu.

Changed in v2:
- move the percpu variable argument fix to a separate patch;
- remove unused variable.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 99ce189..94bbf3b 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -2,6 +2,7 @@
 #include <xen/events.h>
 #include <xen/grant_table.h>
 #include <xen/hvm.h>
+#include <xen/interface/vcpu.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
 #include <xen/interface/hvm/params.h>
@@ -32,6 +33,7 @@ struct shared_info xen_dummy_shared_info;
 struct shared_info *HYPERVISOR_shared_info = (void *)&xen_dummy_shared_info;
 
 DEFINE_PER_CPU(struct vcpu_info *, xen_vcpu);
+DEFINE_PER_CPU(struct vcpu_info, xen_vcpu_info);
 
 /* These are unused until we support booting "pre-ballooned" */
 unsigned long xen_released_pages;
@@ -148,6 +150,32 @@ int xen_unmap_domain_mfn_range(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(xen_unmap_domain_mfn_range);
 
+static int __init xen_secondary_init(unsigned int cpu)
+{
+	struct vcpu_register_vcpu_info info;
+	struct vcpu_info *vcpup;
+	int err;
+
+	if (cpu == 0)
+		return 0;
+
+	pr_info("Xen: initializing cpu%d\n", cpu);
+	vcpup = &per_cpu(xen_vcpu_info, cpu);
+
+	info.mfn = __pa(vcpup) >> PAGE_SHIFT;
+	info.offset = offset_in_page(vcpup);
+
+	err = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_info, cpu, &info);
+	if (err) {
+		pr_debug("register_vcpu_info failed: err=%d\n", err);
+	} else {
+		/* This cpu is using the registered vcpu info, even if
+		   later ones fail to. */
+		per_cpu(xen_vcpu, cpu) = vcpup;
+	}
+	return 0;
+}
+
 /*
  * see Documentation/devicetree/bindings/arm/xen.txt for the
  * documentation of the Xen Device Tree format.
@@ -163,6 +191,7 @@ static int __init xen_guest_init(void)
 	const char *version = NULL;
 	const char *xen_prefix = "xen,xen-";
 	struct resource res;
+	int i;
 
 	node = of_find_compatible_node(NULL, NULL, "xen,xen");
 	if (!node) {
@@ -216,6 +245,8 @@ static int __init xen_guest_init(void)
 	 * is required to use VCPUOP_register_vcpu_info to place vcpu info
 	 * for secondary CPUs as they are brought up. */
 	per_cpu(xen_vcpu, 0) = &HYPERVISOR_shared_info->vcpu_info[0];
+	for_each_online_cpu(i)
+		xen_secondary_init(i);
 
 	gnttab_init();
 	if (!xen_initial_domain())
@@ -231,6 +262,11 @@ static irqreturn_t xen_arm_callback(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static __init void xen_percpu_enable_events(void *unused)
+{
+	enable_percpu_irq(xen_events_irq, 0);
+}
+
 static int __init xen_init_events(void)
 {
 	if (!xen_domain() || xen_events_irq < 0)
@@ -244,7 +280,7 @@ static int __init xen_init_events(void)
 		return -EINVAL;
 	}
 
-	enable_percpu_irq(xen_events_irq, 0);
+	on_each_cpu(xen_percpu_enable_events, NULL, 0);
 
 	return 0;
 }
-- 
1.7.2.5

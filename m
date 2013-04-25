From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 25 Apr 2013 17:57:51 +0100
Subject: [PATCH v5 3/7] xen/arm: SMP support
In-Reply-To: <alpine.DEB.2.02.1304251750160.4180@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304251750160.4180@kaball.uk.xensource.com>
Message-ID: <1366909075-28775-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Map vcpu_info using VCPUOP_register_vcpu_info on all the online vcpus,
make sure the allocated struct doesn't cross a page boundary.

Call enable_percpu_irq on every cpu.

Changes in v5:
- allocate xen_vcpu_info dynamically, aligning it to the size of the
struct;
- use VCPUOP_register_vcpu_info on cpu0 too.

Changed in v2:
- move the percpu variable argument fix to a separate patch;
- remove unused variable.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |   48 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 82d5e63..6c87d11 100644
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
+static struct vcpu_info __percpu *xen_vcpu_info;
 
 /* These are unused until we support booting "pre-ballooned" */
 unsigned long xen_released_pages;
@@ -148,6 +150,29 @@ int xen_unmap_domain_mfn_range(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(xen_unmap_domain_mfn_range);
 
+static int __init xen_secondary_init(unsigned int cpu)
+{
+	struct vcpu_register_vcpu_info info;
+	struct vcpu_info *vcpup;
+	int err;
+
+	pr_info("Xen: initializing cpu%d\n", cpu);
+	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
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
@@ -163,6 +188,7 @@ static int __init xen_guest_init(void)
 	const char *version = NULL;
 	const char *xen_prefix = "xen,xen-";
 	struct resource res;
+	int i;
 
 	node = of_find_compatible_node(NULL, NULL, "xen,xen");
 	if (!node) {
@@ -209,13 +235,18 @@ static int __init xen_guest_init(void)
 
 	/* xen_vcpu is a pointer to the vcpu_info struct in the shared_info
 	 * page, we use it in the event channel upcall and in some pvclock
-	 * related functions. We don't need the vcpu_info placement
-	 * optimizations because we don't use any pv_mmu or pv_irq op on
-	 * HVM.
+	 * related functions. 
 	 * The shared info contains exactly 1 CPU (the boot CPU). The guest
 	 * is required to use VCPUOP_register_vcpu_info to place vcpu info
-	 * for secondary CPUs as they are brought up. */
-	per_cpu(xen_vcpu, 0) = &HYPERVISOR_shared_info->vcpu_info[0];
+	 * for secondary CPUs as they are brought up.
+	 * For uniformity we use VCPUOP_register_vcpu_info even on cpu0.
+	 */
+	xen_vcpu_info = __alloc_percpu(sizeof(struct vcpu_info),
+			                       sizeof(struct vcpu_info));
+	if (xen_vcpu_info == NULL)
+		return -ENOMEM;
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

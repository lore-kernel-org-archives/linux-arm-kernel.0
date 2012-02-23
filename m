From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Feb 2012 17:48:30 +0000
Subject: [PATCH-WIP 09/13] xen/arm: shared_info and start_info
In-Reply-To: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
Message-ID: <1330019314-20865-9-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow xen_hvm_domain's to be xen_initial_domain.

Set xen_domain_type to XEN_HVM_DOMAIN.

Set xen_start_info to an empty struct, set flags to SIF_INITDOMAIN and
SIF_PRIVILEGED so that we identify as initial domain by default.

Map the real shared info page using XENMEM_add_to_physmap with
XENMAPSPACE_shared_info.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |   61 ++++++++++++++++++++++++++++++++++++++++------
 include/xen/xen.h        |    2 +-
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 39ef68c..d76f3b4e 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -1,24 +1,69 @@
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
+#include <xen/interface/memory.h>
 #include <asm/xen/hypervisor.h>
+#include <asm/xen/hypercall.h>
 #include <linux/module.h>
 
-struct start_info *xen_start_info;
+struct start_info _xen_start_info = { .flags = (SIF_INITDOMAIN|SIF_PRIVILEGED) };
+struct start_info *xen_start_info = &_xen_start_info;
 EXPORT_SYMBOL_GPL(xen_start_info);
 
-enum xen_domain_type xen_domain_type = XEN_NATIVE;
+enum xen_domain_type xen_domain_type = XEN_HVM_DOMAIN;
 EXPORT_SYMBOL_GPL(xen_domain_type);
 
+struct shared_info xen_dummy_shared_info;
+struct shared_info *HYPERVISOR_shared_info = (void *)&xen_dummy_shared_info;
 
-/* TODO: remove these functions below and use the real implementation
- * instead
- */
-void rebind_evtchn_irq(int evtchn, int irq)
+DEFINE_PER_CPU(struct vcpu_info *, xen_vcpu);
+
+/* XXX: to be removed */
+__read_mostly int xen_have_vector_callback;
+EXPORT_SYMBOL_GPL(xen_have_vector_callback);
+
+/* XXX: to be removed */
+int xen_platform_pci_unplug;
+EXPORT_SYMBOL_GPL(xen_platform_pci_unplug);
+
+void __ref xen_hvm_init_shared_info(void)
 {
+	int cpu;
+	struct xen_add_to_physmap xatp;
+	static struct shared_info *shared_info_page = 0;
+
+	if (!shared_info_page)
+		shared_info_page = (struct shared_info *)
+			get_zeroed_page(GFP_KERNEL);
+	if (!shared_info_page) {
+		printk(KERN_ERR "not enough memory");
+		return;
+	}
+	xatp.domid = DOMID_SELF;
+	xatp.idx = 0;
+	xatp.space = XENMAPSPACE_shared_info;
+	xatp.gpfn = __pa(shared_info_page) >> PAGE_SHIFT;
+	if (HYPERVISOR_memory_op(XENMEM_add_to_physmap, &xatp))
+		BUG();
+
+	HYPERVISOR_shared_info = (struct shared_info *)shared_info_page;
+
+	/* xen_vcpu is a pointer to the vcpu_info struct in the shared_info
+	 * page, we use it in the event channel upcall and in some pvclock
+	 * related functions. We don't need the vcpu_info placement
+	 * optimizations because we don't use any pv_mmu or pv_irq op on
+	 * HVM.
+	 * When xen_hvm_init_shared_info is run at boot time only vcpu 0 is
+	 * online but xen_hvm_init_shared_info is run at resume time too and
+	 * in that case multiple vcpus might be online. */
+	for_each_online_cpu(cpu) {
+		per_cpu(xen_vcpu, cpu) = &HYPERVISOR_shared_info->vcpu_info[cpu];
+	}
 }
 
-int bind_evtchn_to_irq(unsigned int evtchn)
+static int __init xen_hvm_guest_init(void)
 {
+	xen_hvm_init_shared_info();
 	return 0;
 }
-EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
+
+core_initcall(xen_hvm_guest_init);
diff --git a/include/xen/xen.h b/include/xen/xen.h
index a164024..2c0d3a5 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -23,7 +23,7 @@ extern enum xen_domain_type xen_domain_type;
 #include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 
-#define xen_initial_domain()	(xen_pv_domain() && \
+#define xen_initial_domain()	(xen_domain() && \
 				 xen_start_info->flags & SIF_INITDOMAIN)
 #else  /* !CONFIG_XEN_DOM0 */
 #define xen_initial_domain()	(0)
-- 
1.7.2.5

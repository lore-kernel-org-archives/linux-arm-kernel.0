From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 6 Aug 2012 15:27:17 +0100
Subject: [PATCH v2 14/23] xen/arm: initialize grant_table on ARM
In-Reply-To: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
Message-ID: <1344263246-28036-14-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the grant table mapping at the address specified at index 0
in the DT under the /xen node.
After the grant table is initialized, call xenbus_probe (if not dom0).

Changes in v2:

- introduce GRANT_TABLE_PHYSADDR;
- remove unneeded initialization of boot_max_nr_grant_frames.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index ac3a2d6..e5e92d5 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -1,8 +1,12 @@
 #include <xen/xen.h>
+#include <xen/grant_table.h>
+#include <xen/hvm.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
+#include <xen/interface/hvm/params.h>
 #include <xen/features.h>
 #include <xen/platform_pci.h>
+#include <xen/xenbus.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 #include <linux/module.h>
@@ -45,17 +49,23 @@ EXPORT_SYMBOL_GPL(xen_remap_domain_mfn_range);
  * - one interrupt for Xen event notifications;
  * - one memory region to map the grant_table.
  */
+
+#define GRANT_TABLE_PHYSADDR 0
 static int __init xen_guest_init(void)
 {
 	struct xen_add_to_physmap xatp;
 	static struct shared_info *shared_info_page = 0;
 	struct device_node *node;
+	struct resource res;
 
 	node = of_find_compatible_node(NULL, NULL, "arm,xen");
 	if (!node) {
 		pr_debug("No Xen support\n");
 		return 0;
 	}
+	if (of_address_to_resource(node, GRANT_TABLE_PHYSADDR, &res))
+		return 0;
+	xen_hvm_resume_frames = res.start >> PAGE_SHIFT;
 	xen_domain_type = XEN_HVM_DOMAIN;
 
 	xen_setup_features();
@@ -89,6 +99,11 @@ static int __init xen_guest_init(void)
 	 * is required to use VCPUOP_register_vcpu_info to place vcpu info
 	 * for secondary CPUs as they are brought up. */
 	per_cpu(xen_vcpu, 0) = &HYPERVISOR_shared_info->vcpu_info[0];
+
+	gnttab_init();
+	if (!xen_initial_domain())
+		xenbus_probe(NULL);
+
 	return 0;
 }
 core_initcall(xen_guest_init);
-- 
1.7.2.5

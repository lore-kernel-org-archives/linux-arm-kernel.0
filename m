From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 14 Sep 2012 12:13:15 +0100
Subject: [PATCH v4 13/24] xen/arm: get privilege status
In-Reply-To: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
Message-ID: <1347621207-11294-13-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use Xen features to figure out if we are privileged.

XENFEAT_dom0 was introduced by 23735 in xen-unstable.hg.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/arm/xen/enlighten.c         |    7 +++++++
 include/xen/interface/features.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 6a0217d..c2a47a7 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -1,6 +1,7 @@
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
+#include <xen/features.h>
 #include <xen/platform_pci.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
@@ -66,6 +67,12 @@ static int __init xen_guest_init(void)
 	}
 	xen_domain_type = XEN_HVM_DOMAIN;
 
+	xen_setup_features();
+	if (xen_feature(XENFEAT_dom0))
+		xen_start_info->flags |= SIF_INITDOMAIN|SIF_PRIVILEGED;
+	else
+		xen_start_info->flags &= ~(SIF_INITDOMAIN|SIF_PRIVILEGED);
+
 	if (!shared_info_page)
 		shared_info_page = (struct shared_info *)
 			get_zeroed_page(GFP_KERNEL);
diff --git a/include/xen/interface/features.h b/include/xen/interface/features.h
index b6ca39a..131a6cc 100644
--- a/include/xen/interface/features.h
+++ b/include/xen/interface/features.h
@@ -50,6 +50,9 @@
 /* x86: pirq can be used by HVM guests */
 #define XENFEAT_hvm_pirqs           10
 
+/* operation as Dom0 is supported */
+#define XENFEAT_dom0                      11
+
 #define XENFEAT_NR_SUBMAPS 1
 
 #endif /* __XEN_PUBLIC_FEATURES_H__ */
-- 
1.7.2.5

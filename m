From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 8 Jul 2014 16:42:10 +0100
Subject: [PATCH v2 1/3] xen/arm: introduce XENFEAT_grant_map_11
In-Reply-To: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
Message-ID: <1404834132-15847-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flag tells us that the hypervisor maps a grant page to guest
physical address == machine address of the page in addition to the
normal grant mapping address. It is needed to properly issue cache
maintenance operation at the completion of a DMA operation involving a
foreign grant.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c         |    6 ++++++
 include/xen/interface/features.h |    3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index b96723e..ee3135a 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -262,6 +262,12 @@ static int __init xen_guest_init(void)
 	xen_domain_type = XEN_HVM_DOMAIN;
 
 	xen_setup_features();
+
+	if (!xen_feature(XENFEAT_grant_map_11)) {
+		pr_warn("Please upgrade your Xen.\n"
+				"If your platform has any non-coherent DMA devices, they won't work properly.\n");
+	}
+
 	if (xen_feature(XENFEAT_dom0))
 		xen_start_info->flags |= SIF_INITDOMAIN|SIF_PRIVILEGED;
 	else
diff --git a/include/xen/interface/features.h b/include/xen/interface/features.h
index 131a6cc..6517dd5 100644
--- a/include/xen/interface/features.h
+++ b/include/xen/interface/features.h
@@ -53,6 +53,9 @@
 /* operation as Dom0 is supported */
 #define XENFEAT_dom0                      11
 
+/* Xen also maps grant references at pfn = mfn */
+#define XENFEAT_grant_map_11              12
+
 #define XENFEAT_NR_SUBMAPS 1
 
 #endif /* __XEN_PUBLIC_FEATURES_H__ */
-- 
1.7.10.4

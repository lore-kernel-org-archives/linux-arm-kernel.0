From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 16 Oct 2015 17:35:01 +0100
Subject: [PATCH v2 3/3] xen/arm: don't try to re-register vcpu_info on
 cpu_hotplug.
In-Reply-To: <alpine.DEB.2.02.1510161731510.27957@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1510161731510.27957@kaball.uk.xensource.com>
Message-ID: <1445013301-12624-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 6c09cc4..b193811 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -93,6 +93,16 @@ static void xen_percpu_init(void)
 	int err;
 	int cpu = get_cpu();
 
+	/* 
+	 * VCPUOP_register_vcpu_info cannot be called twice for the same
+	 * vcpu, so if vcpu_info is already registered, just get out. This
+	 * can happen with cpu-hotplug.
+	 */
+	if (per_cpu(xen_vcpu, cpu) != NULL) {
+		put_cpu();
+		return;
+	}
+
 	pr_info("Xen: initializing cpu%d\n", cpu);
 	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
 
-- 
1.7.9.5

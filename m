From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 14 Oct 2015 18:49:57 +0100
Subject: [PATCH 3/3] xen/arm: don't try to re-register vcpu_info on
 cpu_hotplug.
In-Reply-To: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
Message-ID: <1444844997-27314-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 6c09cc4..59f5421 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -93,6 +93,12 @@ static void xen_percpu_init(void)
 	int err;
 	int cpu = get_cpu();
 
+	/* vcpu_info already registered, can happen with cpu-hotplug */
+	if (per_cpu(xen_vcpu, cpu) != NULL) {
+		put_cpu();
+		return;
+	}
+
 	pr_info("Xen: initializing cpu%d\n", cpu);
 	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
 
-- 
1.7.9.5

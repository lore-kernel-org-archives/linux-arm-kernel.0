From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 8 May 2013 13:11:19 +0100
Subject: [PATCH 2/3] xen/arm: do not handle VCPUOP_register_vcpu_info failures
In-Reply-To: <alpine.DEB.2.02.1305081303310.18865@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305081303310.18865@kaball.uk.xensource.com>
Message-ID: <1368015080-5182-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We expect VCPUOP_register_vcpu_info to succeed, do not try to handle
failures.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 83d13b0..519acf9 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -165,13 +165,10 @@ static int __init xen_secondary_init(unsigned int cpu)
 	info.offset = offset_in_page(vcpup);
 
 	err = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_info, cpu, &info);
-	if (err) {
-		pr_debug("register_vcpu_info failed: err=%d\n", err);
-	} else {
-		/* This cpu is using the registered vcpu info, even if
-		   later ones fail to. */
-		per_cpu(xen_vcpu, cpu) = vcpup;
-	}
+	if (err)
+		BUG();
+	per_cpu(xen_vcpu, cpu) = vcpup;
+
 	return 0;
 }
 
-- 
1.7.2.5

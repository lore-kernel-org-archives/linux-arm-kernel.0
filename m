From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  3 Jul 2015 12:26:35 +0100
Subject: [PATCH v5 07/10] limit number of VCPUs on demand
In-Reply-To: <1435922798-14375-1-git-send-email-andre.przywara@arm.com>
References: <1435922798-14375-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1435922798-14375-8-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the ARM GIC checks the number of VCPUs against a fixed
limit, which is GICv2 specific. Don't pretend we know better than the
kernel and let's get rid of that explicit check.
We now fail if the number of requested VCPUs could not be
instantiated instead of limiting the number of VCPUs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index 99f0d2b..05f85a2 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -84,12 +84,6 @@ int gic__create(struct kvm *kvm)
 {
 	int err;
 
-	if (kvm->nrcpus > GIC_MAX_CPUS) {
-		pr_warning("%d CPUS greater than maximum of %d -- truncating\n",
-				kvm->nrcpus, GIC_MAX_CPUS);
-		kvm->nrcpus = GIC_MAX_CPUS;
-	}
-
 	/* Try the new way first, and fallback on legacy method otherwise */
 	err = gic__create_device(kvm);
 	if (err)
-- 
2.3.5

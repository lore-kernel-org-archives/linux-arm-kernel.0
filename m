From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Sep 2016 15:13:52 +0100
Subject: [PATCH 1/2] ARM: vexpress: Do not enable MCPM if booted from HYP
In-Reply-To: <1474380833-30121-1-git-send-email-marc.zyngier@arm.com>
References: <1474380833-30121-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1474380833-30121-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using MCPM implies being able to tweak the CCI at runtime, which
is impossible to do when running non-secure. Since HYP implies
running non-secure, let's not enable MCPM in that case.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-vexpress/platsmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 8b8d072..09819f1 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -17,6 +17,7 @@
 
 #include <asm/mcpm.h>
 #include <asm/smp_scu.h>
+#include <asm/virt.h>
 #include <asm/mach/map.h>
 
 #include <plat/platsmp.h>
@@ -29,11 +30,14 @@ bool __init vexpress_smp_init_ops(void)
 	/*
 	 * The best way to detect a multi-cluster configuration at the moment
 	 * is to look for the presence of a CCI in the system.
-	 * Override the default vexpress_smp_ops if so.
+	 * Override the default vexpress_smp_ops if so, but only if
+	 * the kernel is not booted from HYP mode (which indicates
+	 * that we're running in non-secure mode, where the CCI is not
+	 * accessible).
 	 */
 	struct device_node *node;
 	node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
-	if (node && of_device_is_available(node)) {
+	if (node && of_device_is_available(node) && !is_hyp_mode_available()) {
 		mcpm_smp_set_ops();
 		return true;
 	}
-- 
2.1.4

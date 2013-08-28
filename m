From: robherring2@gmail.com (Rob Herring)
Date: Wed, 28 Aug 2013 13:20:03 -0500
Subject: [PATCH v2] ARM: xen: only set pm function ptrs for Xen guests
Message-ID: <1377714003-22096-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

xen_pm_init was unconditionally setting pm_power_off and arm_pm_restart
function pointers. This breaks multi-platform kernels. Make this
conditional on running as a Xen guest and make it a late_initcall to
ensure it is setup after platform code for Dom0.

Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/xen/enlighten.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 8a6295c..13a7d1f 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -273,12 +273,15 @@ core_initcall(xen_guest_init);
 
 static int __init xen_pm_init(void)
 {
+	if (!of_find_compatible_node(NULL, NULL, "xen,xen"))
+		return -ENODEV;
+
 	pm_power_off = xen_power_off;
 	arm_pm_restart = xen_restart;
 
 	return 0;
 }
-subsys_initcall(xen_pm_init);
+late_initcall(xen_pm_init);
 
 static irqreturn_t xen_arm_callback(int irq, void *arg)
 {
-- 
1.8.1.2

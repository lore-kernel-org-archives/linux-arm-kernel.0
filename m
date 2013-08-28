From: robherring2@gmail.com (Rob Herring)
Date: Wed, 28 Aug 2013 11:19:54 -0500
Subject: [PATCH] ARM: xen: only set pm function ptrs for Xen guests
Message-ID: <1377706794-8481-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

xen_pm_init was unconditionally setting pm_power_off and arm_pm_restart
function pointers. This breaks multi-platform kernels. Move this
initialization into xen_guest_init, so it is conditional on running as a
Xen guest.

Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
This breaks reset and poweroff for Midway when Xen is enabled. This 
should go into 3.11 or stable.

Rob

 arch/arm/xen/enlighten.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 8a6295c..fa86452 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -263,6 +263,9 @@ static int __init xen_guest_init(void)
 	if (xen_vcpu_info == NULL)
 		return -ENOMEM;
 
+	pm_power_off = xen_power_off;
+	arm_pm_restart = xen_restart;
+
 	gnttab_init();
 	if (!xen_initial_domain())
 		xenbus_probe(NULL);
@@ -271,15 +274,6 @@ static int __init xen_guest_init(void)
 }
 core_initcall(xen_guest_init);
 
-static int __init xen_pm_init(void)
-{
-	pm_power_off = xen_power_off;
-	arm_pm_restart = xen_restart;
-
-	return 0;
-}
-subsys_initcall(xen_pm_init);
-
 static irqreturn_t xen_arm_callback(int irq, void *arg)
 {
 	xen_hvm_evtchn_do_upcall();
-- 
1.8.1.2

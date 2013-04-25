From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 25 Apr 2013 17:57:55 +0100
Subject: [PATCH v5 7/7] xen/arm: use sched_op hypercalls for machine reboot
 and power off
In-Reply-To: <alpine.DEB.2.02.1304251750160.4180@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304251750160.4180@kaball.uk.xensource.com>
Message-ID: <1366909075-28775-7-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v5:
- set pm_power_off and arm_pm_restart from the Xen specific
intialization code.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 6c87d11..9a0a917 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -10,9 +10,12 @@
 #include <xen/platform_pci.h>
 #include <xen/xenbus.h>
 #include <xen/page.h>
+#include <xen/xen.h>
+#include <xen/interface/sched.h>
 #include <xen/xen-ops.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
+#include <asm/system_misc.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
 #include <linux/module.h>
@@ -173,6 +176,24 @@ static int __init xen_secondary_init(unsigned int cpu)
 	return 0;
 }
 
+static void xen_restart(char str, const char *cmd)
+{
+	struct sched_shutdown r = { .reason = SHUTDOWN_reboot };
+	int rc;
+	rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
+	if (rc)
+		BUG();
+}
+
+static void xen_power_off(void)
+{
+	struct sched_shutdown r = { .reason = SHUTDOWN_poweroff };
+	int rc;
+	rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
+	if (rc)
+		BUG();
+}
+
 /*
  * see Documentation/devicetree/bindings/arm/xen.txt for the
  * documentation of the Xen Device Tree format.
@@ -252,6 +273,9 @@ static int __init xen_guest_init(void)
 	if (!xen_initial_domain())
 		xenbus_probe(NULL);
 
+	pm_power_off = xen_power_off;
+	arm_pm_restart = xen_restart;
+
 	return 0;
 }
 core_initcall(xen_guest_init);
-- 
1.7.2.5

From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 1 May 2013 20:27:40 +0100
Subject: [PATCH 3/3] xen/arm: account for stolen ticks
In-Reply-To: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
Message-ID: <1367436460-10183-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the runstate_memory_area with the hypervisor.
Use arch_timer_stolen_ticks and xen_stolen_accounting to account for
stolen ticks.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index d30042e..8f040a0 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -14,6 +14,7 @@
 #include <xen/xen-ops.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
+#include <asm/arch_timer.h>
 #include <asm/system_misc.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
@@ -172,6 +173,8 @@ static int __init xen_secondary_init(unsigned int cpu)
 		   later ones fail to. */
 		per_cpu(xen_vcpu, cpu) = vcpup;
 	}
+
+	xen_setup_runstate_info(cpu);
 	return 0;
 }
 
@@ -272,6 +275,7 @@ static int __init xen_guest_init(void)
 	if (!xen_initial_domain())
 		xenbus_probe(NULL);
 
+	arch_timer_stolen_ticks = xen_stolen_accounting;
 	pm_power_off = xen_power_off;
 	arm_pm_restart = xen_restart;
 
-- 
1.7.2.5

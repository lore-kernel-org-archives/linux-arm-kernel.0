From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 29 Mar 2013 16:42:50 +0000
Subject: [PATCH v4 2/2] arm: prefer PSCI for SMP bringup
Message-ID: <1364575371-8926-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If PSCI initializes correctly and PSCI SMP operations are available, use them.
This is required for SMP support in Dom0 on Xen.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: will.deacon at arm.com
CC: arnd at arndb.de
CC: marc.zyngier at arm.com
CC: linux at arm.linux.org.uk
CC: nico at linaro.org
---
 arch/arm/kernel/setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 341efaa..c7e50dd 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -770,10 +770,10 @@ void __init setup_arch(char **cmdline_p)
 	psci_init();
 #ifdef CONFIG_SMP
 	if (is_smp()) {
-		if (mdesc->smp)
-			smp_set_ops(mdesc->smp);
-		else if (psci_smp_available())
+		if (psci_smp_available())
 			smp_set_ops(&psci_smp_ops);
+		else
+			smp_set_ops(mdesc->smp);
 		smp_init_cpus();
 	}
 #endif
-- 
1.7.2.5

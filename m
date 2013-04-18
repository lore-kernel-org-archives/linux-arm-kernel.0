From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 18 Apr 2013 16:05:29 +0100
Subject: [PATCH v7 2/3] arm: prefer psci_smp_ops over mdesc->smp
In-Reply-To: <alpine.DEB.2.02.1304181556210.7254@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304181556210.7254@kaball.uk.xensource.com>
Message-ID: <1366297530-12497-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If PSCI is available on the platform, prefer psci_smp_ops over the
platform smp_ops.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 341efaa..dad3048 100644
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
+		else if (mdesc->smp)
+			smp_set_ops(mdesc->smp);
 		smp_init_cpus();
 	}
 #endif
-- 
1.7.2.5

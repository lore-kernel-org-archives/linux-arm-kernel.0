From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 26 May 2015 18:43:36 +0200
Subject: [PATCH] ARM: imx6: allow booting with old DT
Message-ID: <1432658616-13733-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPC rewrite to IRQ domains has been on the premise that it may break
suspend/resume for new kernels on old DT, but otherwise keep things working
from a user perspective. This was an accepted compromise to be able to move
the GIC cleanup forward.

What actually happened was that booting a new kernel on an old DT crashes
before even the console is up, so the user does not even see the warning
that the DT is too old. The warning message suggests that this has been
known before, which is clearly unacceptable.

Fix the early crash by mapping the GPC memory space if the IRQ controller
doesn't claim it. This keeps at least CPUidle and the needed CPU wakeup
workarounds working. With this fixed the system is able to boot up
properly minus the expected suspend/resume breakage.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
Shawn, this is a critical fix for 4.1, to keep the combination of old
DT + new kernel at least somewhat working, to allow users to resolve
the situation on their systems. Please make sure this gets forwarded
ASAP.
---
 arch/arm/mach-imx/gpc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 4d60005e9277..bbf015056221 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -280,9 +280,15 @@ void __init imx_gpc_check_dt(void)
 	struct device_node *np;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
-	if (WARN_ON(!np ||
-		    !of_find_property(np, "interrupt-controller", NULL)))
-		pr_warn("Outdated DT detected, system is about to crash!!!\n");
+	if (WARN_ON(!np))
+		return;
+
+	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL))) {
+		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
+
+		/* map GPC, so that at least CPUidle and WARs keep working */
+		gpc_base = of_iomap(np, 0);
+	}
 }
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
2.1.4

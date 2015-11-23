From: nyushchenko@dev.rtsoft.ru (nyushchenko at dev.rtsoft.ru)
Date: Mon, 23 Nov 2015 14:59:06 +0300
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
Message-ID: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>

While running an imx6s boasrd, I got following message in boot log:

[    0.032414] CPU1: failed to boot: -38

This looked strange: imx6s is singe-core and kernel perfectly knows
that. However, for some reason it tries to initialize CPU 1?

I found this to be caused by
- CONFIG_SMP_ON_UP successfully detects that system is single core,
- this causes is_smp() to return false,
- this causes setup_arch() to skip smp_init_cpus() call,
- this skips board-specific code that sets cpu_possible mask.

By looking at the code, I don't understand why several initialization
routines are called only in is_smp() case - while other kernel
CONFIG_SMP code does not check is_smp() every time and uses what should
have been initialized by skipped routines.

Thus I propose making these init calls regardless of is_smp() check.
Calls are already conditional on CONFIG_SMP. This will make init and
usage sides consistent.

Signed-off-by: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
---
 arch/arm/kernel/setup.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 20edd34..8a14fce 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -980,16 +980,14 @@ void __init setup_arch(char **cmdline_p)
 	psci_dt_init();
 	xen_early_init();
 #ifdef CONFIG_SMP
-	if (is_smp()) {
-		if (!mdesc->smp_init || !mdesc->smp_init()) {
-			if (psci_smp_available())
-				smp_set_ops(&psci_smp_ops);
-			else if (mdesc->smp)
-				smp_set_ops(mdesc->smp);
-		}
-		smp_init_cpus();
-		smp_build_mpidr_hash();
+	if (!mdesc->smp_init || !mdesc->smp_init()) {
+		if (psci_smp_available())
+			smp_set_ops(&psci_smp_ops);
+		else if (mdesc->smp)
+			smp_set_ops(mdesc->smp);
 	}
+	smp_init_cpus();
+	smp_build_mpidr_hash();
 #endif
 
 	if (!is_smp())
-- 
2.1.4

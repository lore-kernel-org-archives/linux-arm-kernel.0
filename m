From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:22 +0900
Subject: [PATCH 30/43] ARM: shmobile: Use sh73a0-specific cpu disable code
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-31-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert the sh73a0 CPU Hotplug code to use a local
implementation of ->cpu_disable(). With this change
in place the sh73a0 SMP code does no longer depend
on hotplug.c.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-sh73a0.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 593f8de..5ae502b 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -124,6 +124,11 @@ static void sh73a0_cpu_die(unsigned int cpu)
 	/* Enter shutdown mode */
 	cpu_do_idle();
 }
+
+static int sh73a0_cpu_disable(unsigned int cpu)
+{
+	return 0; /* CPU0 and CPU1 supported */
+}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 struct smp_operations sh73a0_smp_ops __initdata = {
@@ -134,6 +139,6 @@ struct smp_operations sh73a0_smp_ops __initdata = {
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= sh73a0_cpu_kill,
 	.cpu_die		= sh73a0_cpu_die,
-	.cpu_disable		= shmobile_cpu_disable_any,
+	.cpu_disable		= sh73a0_cpu_disable,
 #endif
 };
-- 
1.7.10.4

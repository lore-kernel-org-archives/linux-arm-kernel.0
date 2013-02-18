From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 18 Feb 2013 22:47:44 +0900
Subject: [PATCH 06/08] ARM: shmobile: Use sh73a0-specific cpu disable code
In-Reply-To: <20130218134648.17303.97576.sendpatchset@w520>
References: <20130218134648.17303.97576.sendpatchset@w520>
Message-ID: <20130218134744.17303.64308.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert the sh73a0 CPU Hotplug code to use a local
implementation of ->cpu_disable(). With this change
in place the sh73a0 SMP code does no longer depend
on hotplug.c.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-sh73a0.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- 0003/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2013-02-18 16:32:37.000000000 +0900
@@ -124,6 +124,11 @@ static void sh73a0_cpu_die(unsigned int
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
@@ -134,6 +139,6 @@ struct smp_operations sh73a0_smp_ops __i
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= sh73a0_cpu_kill,
 	.cpu_die		= sh73a0_cpu_die,
-	.cpu_disable		= shmobile_cpu_disable_any,
+	.cpu_disable		= sh73a0_cpu_disable,
 #endif
 };

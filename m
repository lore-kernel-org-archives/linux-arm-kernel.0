From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 5 Apr 2013 14:11:34 +0100
Subject: [PATCH v6 3/4] ARM: Enable selection of SMP operations at boot time
In-Reply-To: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
Message-ID: <1365167495-18508-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@linaro.org>

Add a new 'smp_init' hook to machine_desc so platforms can specify a
function to be used to setup smp ops instead of having a statically
defined value.

If smp_init is set, use it instead of psci_smp_ops or mdesc->smp.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/mach/arch.h |    3 +++
 arch/arm/kernel/setup.c          |    4 +++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 308ad7d..c01bf53 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -16,8 +16,10 @@ struct pt_regs;
 struct smp_operations;
 #ifdef CONFIG_SMP
 #define smp_ops(ops) (&(ops))
+#define smp_init_ops(ops) (&(ops))
 #else
 #define smp_ops(ops) (struct smp_operations *)NULL
+#define smp_init_ops(ops) (void (*)(void))NULL
 #endif
 
 struct machine_desc {
@@ -41,6 +43,7 @@ struct machine_desc {
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
 	char			restart_mode;	/* default restart mode	*/
 	struct smp_operations	*smp;		/* SMP operations	*/
+	void			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **,
 					 struct meminfo *);
 	void			(*reserve)(void);/* reserve mem blocks	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index dad3048..2f738cb 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -770,7 +770,9 @@ void __init setup_arch(char **cmdline_p)
 	psci_init();
 #ifdef CONFIG_SMP
 	if (is_smp()) {
-		if (psci_smp_available())
+		if (mdesc->smp_init)
+			(*mdesc->smp_init)();
+		else if (psci_smp_available())
 			smp_set_ops(&psci_smp_ops);
 		else if (mdesc->smp)
 			smp_set_ops(mdesc->smp);
-- 
1.7.2.5

From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Sun, 28 Apr 2013 15:50:50 +0100
Subject: [PATCH v9 2/2] ARM: Enable selection of SMP operations at boot time
In-Reply-To: <alpine.DEB.2.02.1304281544240.5398@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304281544240.5398@kaball.uk.xensource.com>
Message-ID: <1367160650-4888-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@linaro.org>

Add a new 'smp_init' hook to machine_desc so platforms can specify a
function to be used to setup smp ops instead of having a statically
defined value.  The hook must return true when smp_ops are initialized.
If false the static mdesc->smp_ops will be used by default.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/mach/arch.h |    3 +++
 arch/arm/kernel/setup.c          |   10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 308ad7d..af8c54c 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -16,8 +16,10 @@ struct pt_regs;
 struct smp_operations;
 #ifdef CONFIG_SMP
 #define smp_ops(ops) (&(ops))
+#define smp_init_ops(ops) (&(ops))
 #else
 #define smp_ops(ops) (struct smp_operations *)NULL
+#define smp_init_ops(ops) (bool (*)(void))NULL
 #endif
 
 struct machine_desc {
@@ -41,6 +43,7 @@ struct machine_desc {
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
 	char			restart_mode;	/* default restart mode	*/
 	struct smp_operations	*smp;		/* SMP operations	*/
+	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **,
 					 struct meminfo *);
 	void			(*reserve)(void);/* reserve mem blocks	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index dad3048..22cc863 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -770,10 +770,12 @@ void __init setup_arch(char **cmdline_p)
 	psci_init();
 #ifdef CONFIG_SMP
 	if (is_smp()) {
-		if (psci_smp_available())
-			smp_set_ops(&psci_smp_ops);
-		else if (mdesc->smp)
-			smp_set_ops(mdesc->smp);
+		if (!mdesc->smp_init || !mdesc->smp_init()) {
+			if (psci_smp_available())
+				smp_set_ops(&psci_smp_ops);
+			else if (mdesc->smp)
+				smp_set_ops(mdesc->smp);
+		}
 		smp_init_cpus();
 	}
 #endif
-- 
1.7.2.5

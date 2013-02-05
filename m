From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Feb 2013 00:22:11 -0500
Subject: [PATCH v4 14/15] ARM: Enable selection of SMP operations at boot time
In-Reply-To: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1360041732-17936-15-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@linaro.org>

Add a new 'smp_init' hook to machine_desc so platforms can specify a
function to be used to setup smp ops instead of having a statically
defined value.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/mach/arch.h | 3 +++
 arch/arm/kernel/setup.c          | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 917d4fcfd9..3d01c6d6c3 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -17,8 +17,10 @@ struct pt_regs;
 struct smp_operations;
 #ifdef CONFIG_SMP
 #define smp_ops(ops) (&(ops))
+#define smp_init_ops(ops) (&(ops))
 #else
 #define smp_ops(ops) (struct smp_operations *)NULL
+#define smp_init_ops(ops) (void (*)(void))NULL
 #endif
 
 struct machine_desc {
@@ -42,6 +44,7 @@ struct machine_desc {
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
 	char			restart_mode;	/* default restart mode	*/
 	struct smp_operations	*smp;		/* SMP operations	*/
+	void			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **,
 					 struct meminfo *);
 	void			(*reserve)(void);/* reserve mem blocks	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3f6cbb2e3e..41edca8582 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -768,7 +768,10 @@ void __init setup_arch(char **cmdline_p)
 	arm_dt_init_cpu_maps();
 #ifdef CONFIG_SMP
 	if (is_smp()) {
-		smp_set_ops(mdesc->smp);
+		if(mdesc->smp_init)
+			(*mdesc->smp_init)();
+		else
+			smp_set_ops(mdesc->smp);
 		smp_init_cpus();
 	}
 #endif
-- 
1.8.1.2

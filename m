From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 15:43:21 +0100
Subject: [PATCH] [RFC] ARM: keystone: possibly fix big-endian kernels
Message-ID: <1456238609-962461-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While discussing a regressing in the netcp driver, I wondered
whether Keystone can work with a big-endian kernel, and noticed
that we don't switch endianess when we enter the kernel on the
secondary CPU, or when we call into smc.

I don't know whether this works on the machine, but on others
it does not, so this adds the explicit switch to big-endian
in keystone_secondary_startup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-keystone/keystone.h | 2 +-
 arch/arm/mach-keystone/platsmp.c  | 2 +-
 arch/arm/mach-keystone/smc.S      | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-keystone/keystone.h b/arch/arm/mach-keystone/keystone.h
index 33eaa037af5a..016ae7644e73 100644
--- a/arch/arm/mach-keystone/keystone.h
+++ b/arch/arm/mach-keystone/keystone.h
@@ -16,7 +16,7 @@
 #ifndef __ASSEMBLER__
 
 extern const struct smp_operations keystone_smp_ops;
-extern void secondary_startup(void);
+extern void keystone_secondary_startup(void);
 extern u32 keystone_cpu_smc(u32 command, u32 cpu, u32 addr);
 extern int keystone_pm_runtime_init(void);
 
diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
index 5665276972ec..c427787f78d1 100644
--- a/arch/arm/mach-keystone/platsmp.c
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -26,7 +26,7 @@
 static int keystone_smp_boot_secondary(unsigned int cpu,
 						struct task_struct *idle)
 {
-	unsigned long start = virt_to_idmap(&secondary_startup);
+	unsigned long start = virt_to_idmap(&keystone_secondary_startup);
 	int error;
 
 	pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
diff --git a/arch/arm/mach-keystone/smc.S b/arch/arm/mach-keystone/smc.S
index d15de8179fab..81604c0d4e1b 100644
--- a/arch/arm/mach-keystone/smc.S
+++ b/arch/arm/mach-keystone/smc.S
@@ -10,6 +10,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 
 /**
  * u32 keystone_cpu_smc(u32 command, u32 cpu, u32 addr)
@@ -26,3 +27,10 @@ ENTRY(keystone_cpu_smc)
 	smc	#0
 	ldmfd   sp!, {r4-r11, pc}
 ENDPROC(keystone_cpu_smc)
+
+#ifdef CONFIG_SMP
+ENTRY(keystone_secondary_startup)
+ARM_BE8(setend	be)			@ go BE8 if entered LE
+	b	secondary_startup
+ENDPROC(keystone_secondary_startup)
+#endif
-- 
2.7.0

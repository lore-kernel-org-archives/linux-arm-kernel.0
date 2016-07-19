From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jul 2016 12:57:03 +0100
Subject: [PATCH] Fix shmobile build with CONFIG_SMP=n
Message-ID: <20160719115703.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shmobile currently fails to build when CONFIG_SMP is disabled:

arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_init_fallback_ops':
pm-rcar-gen2.c:(.init.text+0x744): undefined reference to `platform_can_secondary_boot'
make[1]: *** [vmlinux] Error 1

Fix this by providing a stub for this function.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Untested, please test.

 arch/arm/mach-shmobile/common.h  | 7 +++++++
 arch/arm/mach-shmobile/platsmp.c | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 1a8f7b3ab449..6badb3e41cfa 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -10,7 +10,14 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
+#ifdef CONFIG_SMP
 extern bool shmobile_smp_init_fallback_ops(void);
+#else
+static inline bool shmobile_smp_init_fallback_ops(void)
+{
+	return false;
+}
+#endif
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
 					  unsigned int max_cpus);
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index f3dba6f356e2..44d91f5624a3 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -37,8 +37,10 @@ bool shmobile_smp_cpu_can_disable(unsigned int cpu)
 }
 #endif
 
+#ifdef CONFIG_SMP
 bool __init shmobile_smp_init_fallback_ops(void)
 {
 	/* fallback on PSCI/smp_ops if no other DT based method is detected */
 	return platform_can_secondary_boot() ? true : false;
 }
+#endif

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

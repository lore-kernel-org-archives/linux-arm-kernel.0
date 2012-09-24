From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:21:54 +1000
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
Message-ID: <20120924192154.2aab0ae61dea89722bbcb974@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/include/mach/common.h between commit 35f2b0bd5911
("ARM: shmobile: Move definition of shmobile_init_late() to header") from
the pm tree and commit a62580e58065 ("ARM: SoC: convert shmobile SMP to
SMP operations") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/include/mach/common.h
index eb89293,f80f9c5..0000000
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@@ -81,13 -73,10 +75,8 @@@ extern void r8a7779_pinmux_init(void)
  extern void r8a7779_pm_init(void);
  extern void r8a7740_meram_workaround(void);
  
- extern unsigned int r8a7779_get_core_count(void);
- extern int r8a7779_platform_cpu_kill(unsigned int cpu);
- extern void r8a7779_secondary_init(unsigned int cpu);
- extern int r8a7779_boot_secondary(unsigned int cpu);
- extern void r8a7779_smp_prepare_cpus(void);
  extern void r8a7779_register_twd(void);
  
 -extern void shmobile_init_late(void);
 -
  #ifdef CONFIG_SUSPEND
  int shmobile_suspend_init(void);
  #else
@@@ -100,10 -89,15 +89,21 @@@ int shmobile_cpuidle_init(void)
  static inline int shmobile_cpuidle_init(void) { return 0; }
  #endif
  
 +static inline void shmobile_init_late(void)
 +{
 +	shmobile_suspend_init();
 +	shmobile_cpuidle_init();
 +}
 +
+ extern void shmobile_cpu_die(unsigned int cpu);
+ extern int shmobile_cpu_disable(unsigned int cpu);
+ 
+ #ifdef CONFIG_HOTPLUG_CPU
+ extern int shmobile_cpu_is_dead(unsigned int cpu);
+ #else
+ static inline int shmobile_cpu_is_dead(unsigned int cpu) { return 1; }
+ #endif
+ 
+ extern void shmobile_smp_init_cpus(unsigned int ncores);
+ 
  #endif /* __ARCH_MACH_COMMON_H */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/efad3cc4/attachment.sig>

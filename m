From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 30 May 2014 22:18:16 +0200
Subject: [PATCH 3/5] ARM: mvebu: export PMSU idle enter/exit functions
In-Reply-To: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1401481098-23326-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMSU idle enter/exit functions will be needed for the CPU hotplug
implementation on Armada XP, so this commit removes their static
qualifier, and adds the appropriate prototypes in armada-370-xp.h.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.h | 3 +++
 arch/arm/mach-mvebu/pmsu.c          | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index c3465f5..52c1603a 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -24,4 +24,7 @@ void armada_xp_secondary_startup(void);
 extern struct smp_operations armada_xp_smp_ops;
 #endif
 
+int armada_370_xp_pmsu_idle_enter(unsigned long deepidle);
+void armada_370_xp_pmsu_idle_exit(void);
+
 #endif /* __MACH_ARMADA_370_XP_H */
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 73e6629..27d98e7 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -148,7 +148,7 @@ static void armada_370_xp_cpu_resume(void)
 }
 
 /* No locking is needed because we only access per-CPU registers */
-static int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
+int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
@@ -219,7 +219,7 @@ static int armada_370_xp_cpu_suspend(unsigned long deepidle)
 }
 
 /* No locking is needed because we only access per-CPU registers */
-static void armada_370_xp_pmsu_idle_exit(void)
+void armada_370_xp_pmsu_idle_exit(void)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
-- 
1.9.3

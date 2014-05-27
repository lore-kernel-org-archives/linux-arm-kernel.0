From: cengelma@gmx.at (Christian Engelmayer)
Date: Tue, 27 May 2014 23:20:47 +0200
Subject: [PATCH] ARM: psci: fix warning on psci_init if ARM_PSCI is undefined
Message-ID: <1401225647-8299-1-git-send-email-cengelma@gmx.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e71246a (PSCI: Add initial support for PSCIv0.2 functions) changed the
return type of function psci_init() from void to int, but left the static
inline stub used if CONFIG_ARM_PSCI is not defined otherwise untouched. This
results in minor compile warning "warning: no return statement in function
returning non-void [-Wreturn-type]". The return value is currently not
evaluated by the only caller anyway.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
Compile tested only. Applies against branch next in tree
git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
---
 arch/arm/include/asm/psci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index b93e34a..c25ef3e 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -41,7 +41,7 @@ extern struct smp_operations psci_smp_ops;
 int psci_init(void);
 bool psci_smp_available(void);
 #else
-static inline int psci_init(void) { }
+static inline int psci_init(void) { return 0; }
 static inline bool psci_smp_available(void) { return false; }
 #endif
 
-- 
1.9.1

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Apr 2017 15:59:17 +0200
Subject: [PATCH, 3.18-stable regression] ARM: psci: fix header file
Message-ID: <20170421135923.2735181-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit be95485a0b828 was incorrectly backported to 3.18 and
now causes a different build error when CONFIG_SMP is disabled:

 arch/arm/kernel/psci.c:287:12: error: redefinition of 'psci_init'

This version is how it should be on 3.18, with the main psci
code built for both SMP and UP, but the psci_smp_available()
function only being available for SMP builds.

Fixes: dbcfee724255 ("ARM: 8457/1: psci-smp is built only for SMP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/psci.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index e3789fb02c9c..8ca5308a05d7 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -37,11 +37,15 @@ struct psci_operations {
 extern struct psci_operations psci_ops;
 extern struct smp_operations psci_smp_ops;
 
-#if defined(CONFIG_SMP) && defined(CONFIG_ARM_PSCI)
+#ifdef CONFIG_ARM_PSCI
 int psci_init(void);
-bool psci_smp_available(void);
 #else
 static inline int psci_init(void) { return 0; }
+#endif
+
+#if defined(CONFIG_SMP) && defined(CONFIG_ARM_PSCI)
+bool psci_smp_available(void);
+#else
 static inline bool psci_smp_available(void) { return false; }
 #endif
 
-- 
2.9.0

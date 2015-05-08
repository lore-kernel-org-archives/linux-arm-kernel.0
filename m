From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri,  8 May 2015 07:55:26 +0200
Subject: [PATCH 1/2] ARM: Availability of psci_smp_available depends on
 CONFIG_SMP
In-Reply-To: <cover.1431064527.git.jan.kiszka@siemens.com>
References: <cover.1431064527.git.jan.kiszka@siemens.com>
Message-ID: <0f0a77ddee48027efa35f36d6c809d2d3ff91ce1.1431064527.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that we can use psci_smp_available without checking for
CONFIG_SMP first.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/asm/psci.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index c25ef3e..eef6a0a 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -39,9 +39,13 @@ extern struct smp_operations psci_smp_ops;
 
 #ifdef CONFIG_ARM_PSCI
 int psci_init(void);
-bool psci_smp_available(void);
 #else
 static inline int psci_init(void) { return 0; }
+#endif
+
+#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_SMP)
+bool psci_smp_available(void);
+#else
 static inline bool psci_smp_available(void) { return false; }
 #endif
 
-- 
2.1.4

From: nkela@cisco.com (Nikunj Kela)
Date: Mon,  2 Jul 2018 14:04:50 -0700
Subject: [PATCH 1/2] arm64: add kconfig symbol to configure section size
Message-ID: <20180702210451.16057-1-nkela@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, section size is fixed to 1024MB. This change
adds a config that would allow it to be customized.
This could be useful in reducing kernel memory usage.

Cc: xe-kernel at external.cisco.com
Cc: Nikunj Kela <nkela@cisco.com>
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 arch/arm64/Kconfig                 | 15 +++++++++++++++
 arch/arm64/include/asm/sparsemem.h |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..edf327f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -687,6 +687,21 @@ config ARM64_PA_BITS
 	default 48 if ARM64_PA_BITS_48
 	default 52 if ARM64_PA_BITS_52
 
+choice
+	prompt "Section size"
+	default ARM64_SEC_BITS_30
+	help
+	  Choose the maximum amount of memory in a section.
+
+config ARM64_SEC_BITS_30
+	bool "30-bit"
+
+endchoice
+
+config ARM64_SEC_BITS
+	int
+	default 30 if ARM64_SEC_BITS_30
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index b299929..dc8fb4b 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -18,7 +18,7 @@
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
-#define SECTION_SIZE_BITS	30
+#define SECTION_SIZE_BITS	CONFIG_ARM64_SEC_BITS
 #endif
 
 #endif
-- 
2.5.0

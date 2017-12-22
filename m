From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Dec 2017 15:23:00 +0000
Subject: [PATCH v2 1/8] arm64: add kconfig symbol to configure physical
 address size
In-Reply-To: <20171222152307.11252-1-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
Message-ID: <20171222152307.11252-2-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kristina Martsenko <kristina.martsenko@arm.com>

ARMv8.2 introduces support for 52-bit physical addresses. To prepare for
supporting this, add a new kconfig symbol to configure the physical
address space size. The symbols will be used in subsequent patches.
Currently the only choice is 48, a later patch will add the option of 52
once the required code is in place.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
[catalin.marinas at arm.com: folded minor patches into this one]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                     | 16 ++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  2 +-
 arch/arm64/include/asm/sparsemem.h     |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a93339f5178f..8dc937823eeb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -646,6 +646,22 @@ config ARM64_VA_BITS
 	default 47 if ARM64_VA_BITS_47
 	default 48 if ARM64_VA_BITS_48
 
+choice
+	prompt "Physical address space size"
+	default ARM64_PA_BITS_48
+	help
+	  Choose the maximum physical address range that the kernel will
+	  support.
+
+config ARM64_PA_BITS_48
+	bool "48-bit"
+
+endchoice
+
+config ARM64_PA_BITS
+	int
+	default 48 if ARM64_PA_BITS_48
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eb0c2bd90de9..c1de9f67980b 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -196,7 +196,7 @@
 /*
  * Highest possible physical address supported.
  */
-#define PHYS_MASK_SHIFT		(48)
+#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
 #define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
 
 /*
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 74a9d301819f..b299929fe56c 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -17,7 +17,7 @@
 #define __ASM_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
-#define MAX_PHYSMEM_BITS	48
+#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
 #define SECTION_SIZE_BITS	30
 #endif
 

From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 18:46:03 +0100
Subject: [PATCH 1/2] arm64: mm: only perform memstart_addr sanity check if
 DEBUG_VM
Message-ID: <1456163164-23251-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking whether memstart_addr has been assigned every time it is
referenced adds a branch instruction that may hurt performance if
the reference in question occurs on a hot path. So only perform the
check if CONFIG_DEBUG_VM=y.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 68e7d96b9ed3..771d0b506e4b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -134,7 +134,11 @@
 
 extern phys_addr_t		memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
+#ifndef CONFIG_DEBUG_VM
+#define PHYS_OFFSET		({ memstart_addr; })
+#else
 #define PHYS_OFFSET		({ BUG_ON(memstart_addr & 1); memstart_addr; })
+#endif
 
 /* the virtual base of the kernel image (minus TEXT_OFFSET) */
 extern u64			kimage_vaddr;
-- 
2.5.0

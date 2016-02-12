From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Feb 2016 15:57:26 +0100
Subject: [PATCH v3 4/4] arm64: prevent __va() translations before
 memstart_addr is assigned
In-Reply-To: <1455289046-21321-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455289046-21321-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455289046-21321-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since memstart_addr is assigned relatively late in the boot code,
after generic code like DT parsing and memblock manipulation has
already occurred, we need to ensure that no __va() translation occur
until memstart_addr has been set to a meaningful value.

So initialize memstart_addr to a value that cannot represent a valid
physical address, and BUG() if memstart_addr is referenced while it
still holds this value. Note that the > comparison against LLONG_MAX
(not ULLONG_MAX) resolves to a single tbnz instruction that performs
a conditional jump to a brk instruction that is emitted out of line.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 4 +++-
 arch/arm64/mm/init.c            | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index c900883a3119..ae398919fb5f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/const.h>
 #include <linux/types.h>
+#include <asm/bug.h>
 #include <asm/sizes.h>
 
 /*
@@ -133,7 +134,8 @@
 
 extern phys_addr_t		memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
-#define PHYS_OFFSET		({ memstart_addr; })
+#define PHYS_OFFSET		\
+	({ BUG_ON(memstart_addr > LLONG_MAX); memstart_addr; })
 
 /* the virtual base of the kernel image (minus TEXT_OFFSET) */
 extern u64			kimage_vaddr;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ed85778b32e5..023c41f22b5b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -48,7 +48,13 @@
 
 #include "mm.h"
 
-phys_addr_t memstart_addr __read_mostly = 0;
+/*
+ * We need to be able to catch inadvertent references to memstart_addr
+ * that occur (potentially in generic code) before arm64_memblock_init()
+ * executes, which assigns it its actual value. So use a default value
+ * that cannot be mistaken for a real physical address.
+ */
+phys_addr_t memstart_addr __read_mostly = ULLONG_MAX;
 phys_addr_t arm64_dma_phys_limit __read_mostly;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-- 
2.5.0

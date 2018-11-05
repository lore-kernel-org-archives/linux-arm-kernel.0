From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:41 +0000
Subject: [PATCH 02/10] arm64: move memstart_addr export inline
In-Reply-To: <20181105130649.29429-1-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
Message-ID: <20181105130649.29429-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we define memstart_addr in a C file, we can have the export
immediately after the definition of the symbol, as we do elsewhere.

As a step towards removing arm64ksyms.c, move the export of
memstart_addr to init.c, where the symbol is defined.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c | 3 ---
 arch/arm64/mm/init.c           | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index c4003c18a18b..73237dc8a994 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -40,9 +40,6 @@ EXPORT_SYMBOL(__arch_copy_to_user);
 EXPORT_SYMBOL(__arch_clear_user);
 EXPORT_SYMBOL(__arch_copy_in_user);
 
-	/* physical memory */
-EXPORT_SYMBOL(memstart_addr);
-
 	/* string / mem functions */
 #ifndef CONFIG_KASAN
 EXPORT_SYMBOL(strchr);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9d9582cac6c4..65288aa9b3b4 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -59,6 +59,8 @@
  * that cannot be mistaken for a real physical address.
  */
 s64 memstart_addr __ro_after_init = -1;
+EXPORT_SYMBOL(memstart_addr);
+
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-- 
2.11.0

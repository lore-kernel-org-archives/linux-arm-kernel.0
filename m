From: bp@suse.de (Borislav Petkov)
Date: Mon, 8 Oct 2018 23:30:18 +0200
Subject: next-20181008 build: 2 failures 22 warnings (next-20181008)
In-Reply-To: <20181008211109.GA4440@sirena.org.uk>
References: <E1g9cV0-0008Sg-4U@optimist> <20181008211109.GA4440@sirena.org.uk>
Message-ID: <20181008213018.GL6490@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 10:11:09PM +0100, Mark Brown wrote:
> caused by 3a387c6d96e69 (x86/kaslr, ACPI/NUMA: Fix KASLR build error)
> which adds the inclusion unconditionally.

This should fix it:

---
 arch/x86/include/asm/kaslr.h | 2 --
 drivers/acpi/numa.c          | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kaslr.h b/arch/x86/include/asm/kaslr.h
index 95ef3fc01d12..db7ba2feb947 100644
--- a/arch/x86/include/asm/kaslr.h
+++ b/arch/x86/include/asm/kaslr.h
@@ -6,10 +6,8 @@ unsigned long kaslr_get_random_long(const char *purpose);
 
 #ifdef CONFIG_RANDOMIZE_MEMORY
 void kernel_randomize_memory(void);
-void kaslr_check_padding(void);
 #else
 static inline void kernel_randomize_memory(void) { }
-static inline void kaslr_check_padding(void) { }
 #endif /* CONFIG_RANDOMIZE_MEMORY */
 
 #endif
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 4408e37600ef..ba62004f4d86 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -32,7 +32,6 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
-#include <asm/kaslr.h>
 
 static nodemask_t nodes_found_map = NODE_MASK_NONE;
 
@@ -433,6 +432,9 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 					    handler, max_entries);
 }
 
+/* To be overridden by architectures */
+void __init __weak kaslr_check_padding(void) { }
+
 int __init acpi_numa_init(void)
 {
 	int cnt = 0;
-- 
2.19.0.271.gfe8321ec057f


-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)

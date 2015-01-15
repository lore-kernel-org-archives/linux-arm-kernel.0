From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Jan 2015 16:42:14 +0000
Subject: [PATCH RESEND] arm64: respect mem= for EFI
Message-ID: <1421340134-3206-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I posted this back in December [1], but due to some dependence on Ard's EFI
series it wasn't picked up. Now that's in the arm64 for-next/core branch, it
would be nice if this could be picked up along with Ard's failed remap handling
patch [2].

I've given this a run on Juno with mem=128m, which seems to work:

nanook at localhost:~$ head /proc/meminfo 
MemTotal:         106624 kB
MemFree:           59572 kB
MemAvailable:      73228 kB
Buffers:               0 kB
Cached:            15796 kB
SwapCached:            0 kB
Active:            19624 kB
Inactive:           7796 kB
Active(anon):      11648 kB
Inactive(anon):       88 kB

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308633.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/316540.html

---->8----
When booting with EFI, we acquire the EFI memory map after parsing the
early params. This unfortuantely renders the option useless as we call
memblock_enforce_memory_limit (which uses memblock_remove_range behind
the scenes) before we've added any memblocks. We end up removing
nothing, then adding all of memory later when efi_init calls
reserve_regions.

Instead, we can log the limit and apply this later when we do the rest
of the memblock work in memblock_init, which should work regardless of
the presence of EFI. At the same time we may as well move the early
parameter into arm64's mm/init.c, close to arm64_memblock_init.

Any memory which must be mapped (e.g. for use by EFI runtime services)
must be mapped explicitly reather than relying on the linear mapping,
which may be truncated as a result of a mem= option passed on the kernel
command line.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/setup.c | 19 -------------------
 arch/arm64/mm/init.c      | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 199d1b7..207413f 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -322,25 +322,6 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
 }
 
-/*
- * Limit the memory size that was specified via FDT.
- */
-static int __init early_mem(char *p)
-{
-	phys_addr_t limit;
-
-	if (!p)
-		return 1;
-
-	limit = memparse(p, &p) & PAGE_MASK;
-	pr_notice("Memory limited to %lldMB\n", limit >> 20);
-
-	memblock_enforce_memory_limit(limit);
-
-	return 0;
-}
-early_param("mem", early_mem);
-
 static void __init request_standard_resources(void)
 {
 	struct memblock_region *region;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bac492c..11c7b70 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -136,10 +136,29 @@ static void arm64_memory_present(void)
 }
 #endif
 
+static phys_addr_t memory_limit = (phys_addr_t)ULLONG_MAX;
+
+/*
+ * Limit the memory size that was specified via FDT.
+ */
+static int __init early_mem(char *p)
+{
+	if (!p)
+		return 1;
+
+	memory_limit = memparse(p, &p) & PAGE_MASK;
+	pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
+
+	return 0;
+}
+early_param("mem", early_mem);
+
 void __init arm64_memblock_init(void)
 {
 	phys_addr_t dma_phys_limit = 0;
 
+	memblock_enforce_memory_limit(memory_limit);
+
 	/*
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
-- 
1.9.1

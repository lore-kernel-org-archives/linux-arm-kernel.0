From: dennis.chen@arm.com (Dennis Chen)
Date: Thu, 23 Jun 2016 19:30:15 +0800
Subject: [PATCH 2/2] arm64:acpi Fix the acpi alignment exeception when 'mem='
 specified
In-Reply-To: <1466681415-8058-1-git-send-email-dennis.chen@arm.com>
References: <1466681415-8058-1-git-send-email-dennis.chen@arm.com>
Message-ID: <1466681415-8058-2-git-send-email-dennis.chen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a rework patch based on [1]. According to the proposal from
Mark Rutland, when applying the system memory limit through 'mem=x'
kernel command line, don't remove the rest memory regions above the
limit from the memblock, instead marking them as MEMBLOCK_NOMAP region,
which will preserve the ability to identify regions as normal memory
while not using them for allocation and the linear map.

Without this patch, the ACPI core will map those acpi data regions(if
they are above the limit) as device type memory, which will result in
the alignment exception when ACPI core parses the AML data stream 
since the parsing will produce some non-alignment accesses.

[1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438443.html

Signed-off-by: Dennis Chen <dennis.chen@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: linux-mm at kvack.org
Cc: linux-acpi at vger.kernel.org
Cc: linux-efi at vger.kernel.org
---
 arch/arm64/mm/init.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d45f862..e509e24 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -222,12 +222,14 @@ void __init arm64_memblock_init(void)
 
 	/*
 	 * Apply the memory limit if it was set. Since the kernel may be loaded
-	 * high up in memory, add back the kernel region that must be accessible
-	 * via the linear mapping.
+	 * in the memory regions above the limit, so we need to clear the
+	 * MEMBLOCK_NOMAP flag of this region to make it can be accessible via
+	 * the linear mapping.
 	 */
 	if (memory_limit != (phys_addr_t)ULLONG_MAX) {
-		memblock_enforce_memory_limit(memory_limit);
-		memblock_add(__pa(_text), (u64)(_end - _text));
+		memblock_mem_limit_mark_nomap(memory_limit);
+		if (!memblock_is_map_memory(__pa(_text)))
+			memblock_clear_nomap(__pa(_text), (u64)(_end - _text));
 	}
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
-- 
1.8.3.1

From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Fri, 26 Feb 2016 11:01:57 +0000
Subject: [PATCH][RFC] arm64: kaslr: add pseudo-RNG in kernel
Message-ID: <56D030A4.5050205@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the bootloader doesn't provide randomness
(through device tree or by uefi protocol) generate
a pseudo-random seed based on the timer counter.
People might find this "week rng" approach convenient
as it gets rid of the bootloader dependency.

The patch tries to mimic the x86's rdtsc
based implementation authored by Kees Cook.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
---
based on http://git.linaro.org/people/ard.biesheuvel/linux-arm.git,
branch arm64-kaslr-v6

 arch/arm64/kernel/kaslr.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 5829839..41e9cbd 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 
+#include <asm/arch_timer.h>
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
@@ -20,9 +21,30 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 
+#include <generated/compile.h>
+#include <generated/utsrelease.h>
+
+/* Simplified build-specific string for starting entropy. */
+static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
+		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
+
 u64 __read_mostly module_alloc_base;
 u16 __initdata memstart_offset_seed;
 
+static u64 rotate_xor(u64 hash, const void *area, size_t size)
+{
+	size_t i;
+	unsigned long *ptr = (unsigned long *)area;
+
+	for (i = 0; i < size / sizeof(hash); i++) {
+		/* Rotate by odd number of bits and XOR. */
+		hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
+		hash ^= ptr[i];
+	}
+
+	return hash;
+}
+
 static __init u64 get_kaslr_seed(void *fdt)
 {
 	int node, len;
@@ -101,8 +123,26 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 * Retrieve (and wipe) the seed from the FDT
 	 */
 	seed = get_kaslr_seed(fdt);
-	if (!seed)
-		return 0;
+	if (!seed) {
+		u64 raw;
+		const u64 mix_const = 0x5d6008cbf3848dd3UL;
+
+		/*
+		 * Attempt to create a simple but unpredictable starting
+		 * entropy.
+		 */
+		seed = rotate_xor(seed, build_str, sizeof(build_str));
+		seed = rotate_xor(seed, fdt, size);
+
+		raw = arch_counter_get_cntvct();
+		seed ^= raw;
+
+		/* Circular multiply for better bit diffusion */
+		asm("mul %1, %2, %3; umulh %0, %2, %3"
+		    : "=&r" (raw), "=&r" (seed)
+		    : "r" (seed), "r" (mix_const));
+		seed += raw;
+	}
 
 	/*
 	 * Check if 'nokaslr' appears on the command line, and
-- 
1.8.3.1

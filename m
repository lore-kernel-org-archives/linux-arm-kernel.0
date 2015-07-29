From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Jul 2015 12:42:58 +0100
Subject: bug in identity map for 4KB pages?
In-Reply-To: <CAKv+Gu_PMvbeKRnx8t3P+44q1pt-NiUcCMTq6vK-8yUMRjQPdA@mail.gmail.com>
References: <CY1PR0301MB0748B85327B6501BE7987B03878C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu_PMvbeKRnx8t3P+44q1pt-NiUcCMTq6vK-8yUMRjQPdA@mail.gmail.com>
Message-ID: <20150729114258.GK15213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 08:47:10AM +0100, Ard Biesheuvel wrote:
> On 29 July 2015 at 04:37, Stuart Yoder <stuart.yoder@freescale.com> wrote:
> > Our system has RAM at a high address, and previously required using 48-bit VA
> > in order to have an idmap that covered all of RAM.
> >
> > In testing on 4.2-rc4, which now contains support for the increased VA range
> > of the idmap without using 48-bit VA, I'm finding that things work for
> > 64KB pages, but do not for 4KB pages.
> >
> > Is there any known limitation here with 4KB pages?  Any ideas?
> >
> 
> You probably have memory at 0x8000_0000 and at 0x80_8000_0000, right?
> So the physical arrangement still requires more than the 39 bits of
> virtual address space you get with 3 levels, even if the ID map can
> cope now. That is why you get the 0x40_0000_0000 virtual address:
> __phys_to_virt() just wraps to a positive number.

Ah, I see. So it's the linear mapping rather than the idmap which is the
problem.

We cut memory which would fall below the start of the linear map in
early_init_dt_add_memory_arch, by cutting memory below phys_offset.

It looks like we already have the logic for cutting memory beyond the
end of the linear map, so we should just need to override the limit.

Stuart, does the below patch prevent the panic you see?

Thanks,
Mark.

---->8----
>From 1bdea78e4427ae6af20050967f03ca7efb1d58fa Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 29 Jul 2015 12:35:35 +0100
Subject: [PATCH] arm64/fdt: cut out memory which cannot be mapped

Currently early_init_dt_add_memory_arch only cuts out memory above
((phys_addr_t)~0), while the end of memory an architecture can map may
be lower than this, and will likely be some fixed offset from
phys_offset.

This patch adds a new (optional) ARCH_VA_RANGE that architectures can
override to define such a limit, and plumbs it in for arch/arm64.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/page.h |  2 ++
 drivers/of/fdt.c              | 14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 7d9c7e4..91eb057 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -67,6 +67,8 @@ extern int pfn_valid(unsigned long);
 
 #include <asm/memory.h>
 
+#define ARCH_VA_RANGE (1UL << VA_BITS)
+
 #endif /* !__ASSEMBLY__ */
 
 #define VM_DATA_DEFAULT_FLAGS \
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 07496560..643e37c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -967,11 +967,15 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK
-#define MAX_PHYS_ADDR	((phys_addr_t)~0)
 
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	const u64 phys_offset = __pa(PAGE_OFFSET);
+#ifdef ARCH_VA_RANGE
+	const u64 phys_end = phys_offset + ARCH_VA_RANGE - 1;
+#else
+	const u64 phys_end = ((phys_addr_t)~0);
+#endif
 
 	if (!PAGE_ALIGNED(base)) {
 		if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
@@ -984,16 +988,16 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 	}
 	size &= PAGE_MASK;
 
-	if (base > MAX_PHYS_ADDR) {
+	if (base > phys_end) {
 		pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
 				base, base + size);
 		return;
 	}
 
-	if (base + size - 1 > MAX_PHYS_ADDR) {
+	if (base + size - 1 > phys_end) {
 		pr_warning("Ignoring memory range 0x%llx - 0x%llx\n",
-				((u64)MAX_PHYS_ADDR) + 1, base + size);
-		size = MAX_PHYS_ADDR - base + 1;
+				((u64)phys_end) + 1, base + size);
+		size = phys_end - base + 1;
 	}
 
 	if (base + size < phys_offset) {
-- 
1.9.1

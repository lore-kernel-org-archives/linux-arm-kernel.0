From: robherring2@gmail.com (Rob Herring)
Date: Thu, 18 Oct 2012 08:47:56 -0500
Subject: [PATCH V2 3/3] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <507F1F31.2060503@wwwdotorg.org>
References: <1350328024-30485-1-git-send-email-swarren@wwwdotorg.org>
 <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
 <507EC303.1080000@gmail.com> <507EDB37.1060102@wwwdotorg.org>
 <507F1F31.2060503@wwwdotorg.org>
Message-ID: <5080088C.9090607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2012 04:12 PM, Stephen Warren wrote:
> On 10/17/2012 10:22 AM, Stephen Warren wrote:

snip

> That implies we really do need to keep the two pieces of code completely
> in sync, so a shared header is the right way to go. It also implies that
> having duplicate mappings of the same physical address doesn't cause any
> immediate obvious catastrophic problems.
> 
> Ways we might avoid files in arch/arm/include/debug having to use
> relative include paths to pick up that header are:
> 
> a) Move mach-${mach}/include/mach/iomap.h to iomap-${mach}.h in some
> standard include path.
> 

Your goal should be to get rid of iomap.h though...

> b) Rework debug-macro.S so that it isn't an include file, but rather a
> regular top-level file. In other words, rather than compiling
> arch/arm/kernel/debug.S, and having that #include DEBUG_LL_INCLUDE,
> instead compile DEBUG_LL_SOURCE (i.e. arch/arm/mach-${mach}/debug.S by
> default), and have that #include any common parts (e.g. implementation
> of printhex8). This has benefits of:
> 
> b1) arch/arm/mach-${mach}/debug.S is in the mach directory that owns it,
> rather than having them all dumped into a common location.
> 
> b2) Can use #include "iomap.h", a non-relative include, to pick up the
> shared header
> 
> b3) Perhaps we can simplify the current debug.S e.g. have a common
> debug-semihosting.S that contains the semihosting stuff, and only
> include that from mach-*/debug.S if that machine uses semihosting, or
> similar?
> 
> (b) seems like a lot of work. I don't see any advantage of (a) over just
> using the relative include.

Agreed.

Here is what I mentioned previously. This removes the static mapping from 
the platforms. This is untested and probably breaks on different DEBUG_LL 
options. For now, platforms call debug_ll_io_init, but once all platforms 
are converted, this can be called from devicemaps_init.

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 195ac2f..2ece92c 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -40,6 +40,9 @@ extern void iotable_init(struct map_desc *, int);
 extern void vm_reserve_area_early(unsigned long addr, unsigned long size,
 				  void *caller);
 
+extern void debug_ll_addr(unsigned long *paddr, unsigned long *vaddr);
+extern void debug_ll_io_init(void);
+
 struct mem_type;
 extern const struct mem_type *get_mem_type(unsigned int type);
 /*
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index 66f711b..93883ed 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -100,6 +100,13 @@ ENTRY(printch)
 		b	1b
 ENDPROC(printch)
 
+ENTRY(debug_ll_addr)
+		addruart r2, r3, ip
+		str	r2, [r0]
+		str	r3, [r1]
+		mov	pc, lr
+ENDPROC(debug_ll_addr)
+
 #else
 
 ENTRY(printascii)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 941dfb9..1c8c7be 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -876,6 +876,20 @@ static void __init pci_reserve_io(void)
 #define pci_reserve_io() do { } while (0)
 #endif
 
+void __init debug_ll_io_init(void)
+{
+	struct map_desc map;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_LL))
+		return;
+
+	debug_ll_addr(&map.pfn, &map.virtual);
+	map.pfn = __phys_to_pfn(map.pfn);
+	map.length = PAGE_SIZE;
+	map.type = MT_DEVICE;
+	create_mapping(&map);
+}
+
 static void * __initdata vmalloc_min =
 	(void *)(VMALLOC_END - (240 << 20) - VMALLOC_OFFSET);
 

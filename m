From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Thu, 15 Apr 2010 15:40:39 +0300
Subject: [RFC 09/10] arm: implement reserve memory early parameter
In-Reply-To: <20100412210521.GW3048@n2100.arm.linux.org.uk>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<9c79bfd3046abe3165a79b6ef10c1938c455fa71.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<20100412210521.GW3048@n2100.arm.linux.org.uk>
Message-ID: <20100415124039.GD21896@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 12, 2010 at 11:05:21PM +0200, ext Russell King - ARM Linux wrote:
> On Mon, Mar 29, 2010 at 12:26:35PM +0300, Mika Westerberg wrote:
> > Implemented mem=size$start early parameter which makes it possible to reserve
> > some memory from the kernel. This can be used for dump capture kernels to
> > preserve any memory used by the primary kernel.
> 
> Please note that if we move ARM over to LMB, these patches will have to
> be redone.
> 
> However, I'm not sure why this is required - it appears that x86 doesn't
> require this kind of feature.  Can you explain in more detail how this
> new parameter format would be used?

Hi,

I investigated this further and it seems that this is, like you commented, not
required. It should be enough to pass correct mem=size at start parameter to the
dump capture kernel.

I have following changes to get kernel linked into different address (in this
case 0xc2008000):
	arch/arm/Makefile: 			textofs-y := 0x02008000
	arch/arm/mach-omap2/Makefile.boot:	zreladdr-y := 0x82008000

Physical memory in this platform starts at 0x80000000.

When I start the kernel with 'mem=32M at 0x82000000' boot fails in very early stage:

[    0.000000] BUG: Bad page state in process swapper  pfn:82000
[    0.000000] page:c2ac2000 count:0 mapcount:0 mapping:(null) index:0xffffffff
[    0.000000] page flags: 0x92092(error|dirty|slab|writeback|swapcache|buddy)

Is mem= parameter supposed to work so that I can pass also start address? Now it
seems to still use hard-coded PHYS_OFFSET etc. Or maybe I'm doing something
wrong here.

I managed to get this working with following patch but it is probably not
correct. Any ideas how to get it working properly?

Thanks,
MW

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4312ee5..7036a2f 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -171,7 +171,8 @@
  * direct-mapped view.  We assume this is the first page
  * of RAM in the mem_map as well.
  */
-#define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
+extern unsigned long phys_pfn_offset;
+#define PHYS_PFN_OFFSET	phys_pfn_offset
 
 /*
  * These are *only* valid on the kernel direct mapped RAM memory.
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 25a1664..e61e57d 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -90,6 +90,8 @@ EXPORT_SYMBOL(system_serial_high);
 unsigned int elf_hwcap;
 EXPORT_SYMBOL(elf_hwcap);
 
+unsigned long phys_pfn_offset = PHYS_OFFSET >> PAGE_SHIFT;
+EXPORT_SYMBOL(phys_pfn_offset);
 
 #ifdef MULTI_CPU
 struct processor processor;
@@ -439,8 +441,10 @@ static int __init early_mem(char *p)
 
 	start = PHYS_OFFSET;
 	size  = memparse(p, &endp);
-	if (*endp == '@')
+	if (*endp == '@') {
 		start = memparse(endp + 1, NULL);
+		phys_pfn_offset = start >> PAGE_SHIFT;
+	}
 
 	arm_add_memory(start, size);
 

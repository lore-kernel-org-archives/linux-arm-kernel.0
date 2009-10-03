From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sat, 03 Oct 2009 20:19:48 +0100
Subject: Sparsemem  on EP93XX
Message-ID: <4AC7A3D4.3080408@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm trying to get a TS72XX board working with sparsemem, but got 
unlucky so far. I've read all related threads in the archive and 
especially this one:
http://marc.info/?l=linux-arm&m=122754446724900&w=2

Here is the patch I've applied:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..0f1d52f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -288,6 +288,7 @@ config ARCH_EP93XX
         select CPU_ARM920T
         select ARM_AMBA
         select ARM_VIC
+       select ARCH_SPARSEMEM_ENABLE
         select GENERIC_GPIO
         select HAVE_CLK
         select COMMON_CLKDEV
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index cefedf0..6be9d9b 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -125,8 +125,10 @@
   * private definitions which should NOT be used outside memory.h
   * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
   */
+#ifndef __phys_to_virt
  #define __virt_to_phys(x)      ((x) - PAGE_OFFSET + PHYS_OFFSET)
  #define __phys_to_virt(x)      ((x) - PHYS_OFFSET + PAGE_OFFSET)
+#endif

  /*
   * Convert a physical address to a Page Frame Number and back
diff --git a/arch/arm/mach-ep93xx/include/mach/memory.h 
b/arch/arm/mach-ep93xx/include/mach/memory.h
index 554064e..4cb3329 100644
--- a/arch/arm/mach-ep93xx/include/mach/memory.h
+++ b/arch/arm/mach-ep93xx/include/mach/memory.h
@@ -19,4 +19,34 @@
  #error "Kconfig bug: No EP93xx PHYS_OFFSET set"
  #endif

+#ifdef CONFIG_MACH_TS72XX
+/*
+ * Non-linear mapping like so:
+ * phys       => virt
+ * 0x00000000 => 0xc0000000
+ * 0x01000000 => 0xc1000000
+ * 0x04000000 => 0xc4000000
+ * 0x05000000 => 0xc5000000
+ * 0xe0000000 => 0xc8000000
+ * 0xe1000000 => 0xc9000000
+ * 0xe4000000 => 0xcc000000
+ * 0xe5000000 => 0xcd000000
+ *
+ * As suggested here: http://marc.info/?l=linux-arm&m=122754446724900&w=2
+ *
+ * Note that static inline functions won't work here because
+ * arch/arm/include/asm/memory.h uses "#ifndef __virt_to_phys" to 
check whether to
+ * use generic functions or not.
+ */
+#define __phys_to_virt(p)   \
+            (((p) & 0x07ffffff) | (((p) & 0xe0000000) ? 0x08000000 : 
0) | PAGE_OFFSET)
+
+#define __virt_to_phys(v)   \
+            (((v) & 0x07ffffff) | (((v) & 0x08000000) ? 0xe0000000 : 0 ))
+
+#define SECTION_SIZE_BITS 24
+#define MAX_PHYSMEM_BITS 32
+
+#endif /* CONFIG_ARCH_TS72XX */
+
  #endif

I have forced some early debugging and dump the meminfo passed by the 
bootloader in bootmem_init() (just to be sure of the mem config) and 
here is the output i got:

Using base address 0x00218000 and length 0x000ab888
Uncompressing Linux............................................... 
done, booting the kernel.
<5>Linux version 2.6.32-rc2-twm0.0 (cgagneraud at archeopterix) (gcc 
version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #23 Sat Oct 3 20:01:39 
IST 2
009
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=40007177
CPU: VIVT data cache, VIVT instruction cache
Machine: Technologic Systems TS-72xx SBC
Memory policy: ECC disabled, Data cache writeback
meminfo has 8 banks:
00: start = 0x00000000
     size  = 0x00800000
     node  = 0x00000000
     hm    = 0x00000000
01: start = 0x01000000
     size  = 0x00800000
     node  = 0x00000000
     hm    = 0x00000000
02: start = 0x04000000
     size  = 0x00800000
     node  = 0x00000000
     hm    = 0x00000000
03: start = 0x05000000
     size  = 0x00800000
     node  = 0x00000000
     hm    = 0x00000000
04: start = 0xE0000000
     size  = 0x00800000
     node  = 0x00000000
     hm    = 0x00000000
05: start = 0xE1000000
     size  = 0x00800000
     node  = 0x00000000
     hm    = 0x00000000
06: start = 0xE4000000
     size  = 0x00800000
     node  = 0x00000000
     hm    = 0x00000000
07: start = 0xE5000000
     size  = 0x00800000
     node  = 0x00000000
     hm    = 0x00000000
<6>bootmem::init_bootmem_core nid=0 start=0 map=18a end=e5800 
mapsize=1cb00
<6>bootmem::mark_bootmem_node nid=0 start=0 end=800 reserve=0 flags=0
<6>bootmem::__free nid=0 start=0 end=800
<6>bootmem::mark_bootmem_node nid=0 start=1000 end=1800 reserve=0 flags=0
<6>bootmem::__free nid=0 start=1000 end=1800
<6>bootmem::mark_bootmem_node nid=0 start=4000 end=4800 reserve=0 flags=0
<6>bootmem::__free nid=0 start=4000 end=4800
<6>bootmem::mark_bootmem_node nid=0 start=5000 end=5800 reserve=0 flags=0
<6>bootmem::__free nid=0 start=5000 end=5800
<6>bootmem::mark_bootmem_node nid=0 start=e0000 end=e0800 reserve=0 
flags=0
<6>bootmem::__free nid=0 start=e0000 end=e0800
<6>bootmem::mark_bootmem_node nid=0 start=e1000 end=e1800 reserve=0 
flags=0
<6>bootmem::__free nid=0 start=e1000 end=e1800
<6>bootmem::mark_bootmem_node nid=0 start=e4000 end=e4800 reserve=0 
flags=0
<6>bootmem::__free nid=0 start=e4000 end=e4800
<6>bootmem::mark_bootmem_node nid=0 start=e5000 end=e5800 reserve=0 
flags=0
<6>bootmem::__free nid=0 start=e5000 end=e5800
<6>bootmem::mark_bootmem_node nid=0 start=18a end=1a7 reserve=1 flags=0
<6>bootmem::__reserve nid=0 start=18a end=1a7 flags=0
<6>bootmem::mark_bootmem_node nid=0 start=8 end=18a reserve=1 flags=0
<6>bootmem::__reserve nid=0 start=8 end=18a flags=0
<6>bootmem::mark_bootmem_node nid=0 start=4 end=8 reserve=1 flags=0
<6>bootmem::__reserve nid=0 start=4 end=8 flags=0
<7>On node 0 totalpages: 16384
<6>bootmem::alloc_bootmem_core nid=0 size=1cb0000 [7344 pages] 
align=20 goal=e7ffffff limit=0
<6>bootmem::alloc_bootmem_core nid=0 size=1cb0000 [7344 pages] 
align=20 goal=0 limit=0
<1>bootmem alloc of 30081024 bytes failed!
<0>Kernel panic - not syncing: Out of memory
Backtrace:
[<c001c750>] (dump_backtrace+0x0/0x10c) from [<c0120c0c>] 
(dump_stack+0x18/0x1c)
  r7:00000020 r6:c01618d0 r5:00000000 r4:01cb0000
[<c0120bf4>] (dump_stack+0x0/0x1c) from [<c0120c5c>] (panic+0x4c/0x12c)
[<c0120c10>] (panic+0x0/0x12c) from [<c000f298>] 
(___alloc_bootmem+0x30/0x38)
  r3:ffffffff r2:c0156140 r1:600000d3 r0:c0144420
[<c000f268>] (___alloc_bootmem+0x0/0x38) from [<c000f310>] 
(___alloc_bootmem_node+0x70/0x74)
  r5:00000000 r4:c0017280
[<c000f2a0>] (___alloc_bootmem_node+0x0/0x74) from [<c000f3ec>] 
(__alloc_bootmem_node+0x44/0x90)
  r8:c0160de4 r7:01cb0000 r6:e7ffffff r5:00000020 r4:c0160de4
[<c000f3a8>] (__alloc_bootmem_node+0x0/0x90) from [<c0120a90>] 
(alloc_node_mem_map+0x74/0x90)
  r7:000e5800 r6:c0151ef0 r5:c0160de4 r4:00000000
[<c0120a1c>] (alloc_node_mem_map+0x0/0x90) from [<c000fb40>] 
(free_area_init_node+0x74/0x3d0)
  r5:000e5800 r4:00000000
[<c000facc>] (free_area_init_node+0x0/0x3d0) from [<c000aaa8>] 
(bootmem_init+0x22c/0x484)
[<c000a87c>] (bootmem_init+0x0/0x484) from [<c000ba70>] 
(paging_init+0x55c/0x758)
[<c000b514>] (paging_init+0x0/0x758) from [<c0009e8c>] 
(setup_arch+0x2e4/0x720)
[<c0009ba8>] (setup_arch+0x0/0x720) from [<c000898c>] 
(start_kernel+0x5c/0x264)
[<c0008930>] (start_kernel+0x0/0x264) from [<00008038>] (0x8038)
  r5:c0161728 r4:40007175

Then I tried digging into the code by following the backtrace, but 
couldn't spot anything!

If I force the machine to see only 32MB then it boots fine, I've done 
this by passing the mem=stuff on the command line.
I've even tried to force using 2 nodes by over-writing bank->node, 
first node for the low part, and second node for the upper part 
(0xeX000000) and it boots fine as well, the difference is that the 
kernel says that it sees 8 banks of 8MB each, but report only 32MB of 
free memory (only node 0 is used I guess).

Obviously, I've missed something, any helps are welcome.

Thanks,
Chris

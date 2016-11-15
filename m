From: william.helsby@stfc.ac.uk (william.helsby at stfc.ac.uk)
Date: Tue, 15 Nov 2016 15:45:55 +0000
Subject: [PATCH] Replacement for Arm initrd memblock reserve and free
 inconsistency.
In-Reply-To: <20161110174645.GB1041@n2100.armlinux.org.uk>
References: <592F4D3D062D79449F140027567F70E8FE080A79@exchmbx03>
 <20161110174645.GB1041@n2100.armlinux.org.uk>
Message-ID: <592F4D3D062D79449F140027567F70E8FE0810D3@exchmbx03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The option of moving the initrd code later (after 	early_init_fdt_reserve_self(); 	early_init_fdt_scan_reserved_mem() ) 
was tested.
This resulted in the initrd being disabled because early_init_fdt_scan_reserved_mem
Has already reserved the initrd area.
With memblock=debug
Machine model: Xspress3 Mini in PicoZed Developement Board
bootconsole [earlycon0] enabled
memblock_add: [0x00000000000000-0x0000000fffffff] flags 0x0 arm_add_
memory+0x14c/0x174
memblock_reserve: [0x00000000100000-0x00000000b71de7] flags 0x0 arm_
memblock_init+0x1c/0x284
memblock_reserve: [0x00000000004000-0x00000000007fff] flags 0x0 arm_
memblock_init+0x20/0x284
memblock_reserve: [0x00000000000000-0x00000000003fff] flags 0x0 arm_
memblock_init+0x30/0x284
memblock_reserve: [0x0000000fa5f000-0x0000000fa6207f] flags 0x0 arm_
memblock_init+0x38/0x284
memblock_reserve: [0x0000000fa5f000-0x0000000fa61fff] flags 0x0 early_
init_fdt_scan_reserved_mem+0x54/0x78
memblock_reserve: [0x0000000fa65000-0x0000000ffff46a] flags 0x0 early_
init_fdt_scan_reserved_mem+0x54/0x78
memblock_reserve: [0x0000000e800000-0x0000000f7fffff] flags 0x0 membl
ock_alloc_range_nid+0x3c/0x50
cma: Reserved 16 MiB at 0x0e800000
INITRD: 0x0fa65000+0x0059a46b overlaps in-use memory region - disabling initrd
MEMBLOCK configuration:

With the initrd code back to its normal place
memblock_add: [0x00000000000000-0x0000000fffffff] flags 0x0 arm_add_
memory+0x14c/0x174
memblock_reserve: [0x00000000100000-0x00000000b71de7] flags 0x0 arm_m
emblock_init+0x24/0x284
memblock_reserve: [0x0000000fa65000-0x0000000fffffff] flags 0x0 arm_me
mblock_init+0x1e4/0x284
memblock_reserve: [0x00000000004000-0x00000000007fff] flags 0x0 arm_me
mblock_init+0x210/0x284
memblock_reserve: [0x00000000000000-0x00000000003fff] flags 0x0 arm_me
mblock_init+0x220/0x284
memblock_reserve: [0x0000000fa5f000-0x0000000fa6207f] flags 0x0 arm_me
mblock_init+0x224/0x284
memblock_reserve: [0x0000000fa5f000-0x0000000fa61fff] flags 0x0 early_ini
t_fdt_scan_reserved_mem+0x54/0x78
memblock_reserve: [0x0000000fa65000-0x0000000ffff46a] flags 0x0 early_in
it_fdt_scan_reserved_mem+0x54/0x78
memblock_reserve: [0x0000000e800000-0x0000000f7fffff] flags 0x0 memblo
ck_alloc_range_nid+0x3c/0x50
cma: Reserved 16 MiB at 0x0e800000
MEMBLOCK configuration:
 memory size = 0x10000000 reserved size = 0x2017e68
 memory.cnt  = 0x1
 memory[0x0]    [0x00000000000000-0x0000000fffffff], 0x10000000 bytes f
lags: 0x0
 reserved.cnt  = 0x5
 reserved[0x0]  [0x00000000000000-0x00000000007fff], 0x8000 bytes fl
ags: 0x0
 reserved[0x1]  [0x00000000100000-0x00000000b71de7], 0xa71de8 bytes fl
ags: 0x0
 reserved[0x2]  [0x0000000e800000-0x0000000f7fffff], 0x1000000 bytes flags: 0x0
 reserved[0x3]  [0x0000000fa5f000-0x0000000fa6207f], 0x3080 bytes flag
s: 0x0
 reserved[0x4]  [0x0000000fa65000-0x0000000fffffff], 0x59b000 bytes fl
ags: 0x0
Memory policy: Data cache writealloc

So poison the memory all the way from the start to end I would now suggest:
--- ../linux-xlnx-4.6.0-orig/arch/arm/mm/init.c 2016-11-15 15:10:44.476001509 +0000
+++ arch/arm/mm/init.c  2016-11-15 14:05:19.640969244 +0000
@@ -49,6 +49,8 @@

 static phys_addr_t phys_initrd_start __initdata = 0;
 static unsigned long phys_initrd_size __initdata = 0;
+static unsigned long initrd_reservation_start __initdata = 0;
+static unsigned long initrd_reservation_end __initdata = 0;

 static int __init early_initrd(char *p)
 {
@@ -255,11 +257,38 @@
                phys_initrd_start = phys_initrd_size = 0;
        }
        if (phys_initrd_size) {
-               memblock_reserve(phys_initrd_start, phys_initrd_size);
+           /* try to round the initrd start and end down and up to page boundaries,
+              so when freed, whole pages can be released.
+              However the initrd image may be adjacent to something else, so check that this rounding is OK
+           */
+         /* First try rounding the start down and end up */
+           phys_addr_t phys_initrd_reservation_start = phys_initrd_start & PAGE_MASK;
+            unsigned long size_to_reserve = PAGE_ALIGN(phys_initrd_start+phys_initrd_size) - phys_initrd_reservation_start;
+           if (!memblock_is_region_memory(phys_initrd_reservation_start, size_to_reserve) ||
+                 memblock_is_region_reserved(phys_initrd_reservation_start, size_to_reserve)) {
+             /* This either does fit or overlaps something else, so try just rounding end up */
+             phys_initrd_reservation_start = phys_initrd_start;
+             size_to_reserve = PAGE_ALIGN(phys_initrd_start+phys_initrd_size) - phys_initrd_reservation_start;
+             if (!memblock_is_region_memory(phys_initrd_reservation_start, size_to_reserve) ||
+                 memblock_is_region_reserved(phys_initrd_reservation_start, size_to_reserve)) {
+               /* This either does not fit or overlaps something else, so try just rounding start down */
+               phys_initrd_reservation_start = phys_initrd_start & PAGE_MASK;
+               size_to_reserve = (phys_initrd_start+phys_initrd_size) - phys_initrd_reservation_start;
+               if (!memblock_is_region_memory(phys_initrd_reservation_start, size_to_reserve) ||
+                   memblock_is_region_reserved(phys_initrd_reservation_start, size_to_reserve)) {
+                 /* This either does not fit or overlaps something else, so do not round at all */
+                 phys_initrd_reservation_start = phys_initrd_start;
+                 size_to_reserve = (phys_initrd_start+phys_initrd_size) - phys_initrd_reservation_start;
+               }
+             }
+           }
+               memblock_reserve(phys_initrd_reservation_start, size_to_reserve);

                /* Now convert initrd to virtual addresses */
                initrd_start = __phys_to_virt(phys_initrd_start);
                initrd_end = initrd_start + phys_initrd_size;
+               initrd_reservation_start = __phys_to_virt(phys_initrd_reservation_start);
+               initrd_reservation_end = initrd_reservation_start + size_to_reserve;
        }
 #endif

@@ -325,7 +354,12 @@
  */
 static inline void poison_init_mem(void *s, size_t count)
 {
-       u32 *p = (u32 *)s;
+       u32 *p;
+       unsigned long start = (unsigned long)s, start_align;
+       start_align = (start+3) & ~3L;   // Round up to 32 bit word boundary.
+       count -= (start_align-start);
+       p = (u32 *)start_align;
+       count &= ~3L;
        for (; count != 0; count -= 4)
                *p++ = 0xe7fddef0;
 }
@@ -771,11 +805,11 @@
 {
        if (!keep_initrd) {
                if (start == initrd_start)
-                       start = round_down(start, PAGE_SIZE);
+                 start = initrd_reservation_start;
                if (end == initrd_end)
-                       end = round_up(end, PAGE_SIZE);
+                 end = initrd_reservation_end;

-               poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
+               poison_init_mem((void *)start, end-start);
                free_reserved_area((void *)start, (void *)end, -1, "initrd");
        }
 }

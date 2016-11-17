From: william.helsby@stfc.ac.uk (william.helsby at stfc.ac.uk)
Date: Thu, 17 Nov 2016 10:41:19 +0000
Subject: [PATCH] Replacement for Arm initrd memblock reserve and free
 inconsistency.
In-Reply-To: <20161116234741.GE1041@n2100.armlinux.org.uk>
References: <592F4D3D062D79449F140027567F70E8FE080A79@exchmbx03>
 <20161110174645.GB1041@n2100.armlinux.org.uk>
 <592F4D3D062D79449F140027567F70E8FE0810D3@exchmbx03>
 <20161116234741.GE1041@n2100.armlinux.org.uk>
Message-ID: <592F4D3D062D79449F140027567F70E8FE081234@exchmbx03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My understanding of your proposed patch is that it rounds the area to be reserved for the initrd image to page
boundaries. It then checks that this rounding does not grow the initrd to overlap other areas.

If it does not overlap, all is well. The kernel will not kmalloc anything within the partial pages 
at the beginning and end of the initrd image. When the initrd image is freed, complete pages are 
released and there is no wasted memory.
However, if it does overlap other regions, it disables the initrd image and the kernel panics with no root file system.

My patch rounds the area to be reserved for the initrd image to page boundaries. 
It then checks that this rounding does not grow the initrd to overlap other areas.
If it does not overlap the system initialised the ramdisk from the initrd image and then frees the initrd area
with no wasted memory. All is good.
If it does overlap, my code tried to determine the cause of the overlap and fell back to, in the worst case,
just reserving the space actually occupied by the initrd image. In this case the kernel would start, 
initialise the ramdisk and try to free the initrd image. At worst 2 partial pages at the beginning and end of 
the initrd image would not be freed, wasting up to 8kBytes. 
To me this is a more acceptable fallback than deleting the root file system.

Also not that in the current code free_initrd_mem checks:
if (end == initrd_end)
                        end = round_up(end, PAGE_SIZE);
So only rounds up the end if the whole initrd image is being freed. 
If free_initrd_mem is called with end != initrd_end (because the crash kernel area overlaps), 
then the end is not rounded up. 
However:
poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
will still page align the end address and could potentially overwrite the crash kernel area.
I don't know anything about if and when the crash kernel area is used, but in principle this may be a bad thing.

William.

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk] 
Sent: 16 November 2016 23:48
To: Helsby, William (STFC,DL,TECH)
Cc: linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] Replacement for Arm initrd memblock reserve and free inconsistency.

On Tue, Nov 15, 2016 at 03:45:55PM +0000, william.helsby at stfc.ac.uk wrote:
> The option of moving the initrd code later (after
> 	early_init_fdt_reserve_self();
> 	early_init_fdt_scan_reserved_mem() ) was tested.

Moving stuff around tends to break...

I'd prefer to do it this way, as it's much more readable (and we prize readability... see Documentation/CodingStyle.)

 arch/arm/mm/init.c | 71 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c index 370581aeb871..ffae20b25929 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -227,6 +227,48 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 	return phys;
 }
 
+static void __init arm_initrd_init(void) { #ifdef CONFIG_BLK_DEV_INITRD
+	unsigned long size;
+	phys_addr_t start;
+
+	/* FDT scan will populate initrd_start */
+	if (initrd_start && !phys_initrd_size) {
+		phys_initrd_start = __virt_to_phys(initrd_start);
+		phys_initrd_size = initrd_end - initrd_start;
+	}
+
+	initrd_start = initrd_end = 0;
+
+	if (!phys_initrd_size)
+		return;
+
+	start = phys_initrd_start & PAGE_MASK;
+	size = PAGE_ALIGN(phys_initrd_size + phys_initrd_start - start);
+
+	if (!memblock_is_region_memory(start, size)) {
+		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
+		       (u64)start, size);
+		phys_initrd_start = phys_initrd_size = 0;
+		return;
+	}
+
+	if (memblock_is_region_reserved(start, size)) {
+		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region - disabling initrd\n",
+		       (u64)start, size);
+		phys_initrd_start = phys_initrd_size = 0;
+		return;
+	}
+
+	memblock_reserve(start, size);
+
+	/* Now convert initrd to virtual addresses */
+	initrd_start = __phys_to_virt(phys_initrd_start);
+	initrd_end = initrd_start + phys_initrd_size; #endif }
+
 void __init arm_memblock_init(const struct machine_desc *mdesc)  {
 	/* Register the kernel text, kernel data and initrd with memblock. */ @@ -235,34 +277,7 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)  #else
 	memblock_reserve(__pa(_stext), _end - _stext);  #endif -#ifdef CONFIG_BLK_DEV_INITRD
-	/* FDT scan will populate initrd_start */
-	if (initrd_start && !phys_initrd_size) {
-		phys_initrd_start = __virt_to_phys(initrd_start);
-		phys_initrd_size = initrd_end - initrd_start;
-	}
-	initrd_start = initrd_end = 0;
-	if (phys_initrd_size &&
-	    !memblock_is_region_memory(phys_initrd_start, phys_initrd_size)) {
-		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
-		       (u64)phys_initrd_start, phys_initrd_size);
-		phys_initrd_start = phys_initrd_size = 0;
-	}
-	if (phys_initrd_size &&
-	    memblock_is_region_reserved(phys_initrd_start, phys_initrd_size)) {
-		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region - disabling initrd\n",
-		       (u64)phys_initrd_start, phys_initrd_size);
-		phys_initrd_start = phys_initrd_size = 0;
-	}
-	if (phys_initrd_size) {
-		memblock_reserve(phys_initrd_start, phys_initrd_size);
-
-		/* Now convert initrd to virtual addresses */
-		initrd_start = __phys_to_virt(phys_initrd_start);
-		initrd_end = initrd_start + phys_initrd_size;
-	}
-#endif
-
+	arm_initrd_init();
 	arm_mm_memblock_reserve();
 
 	/* reserve any platform specific memblock areas */

--
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up according to speedtest.net.

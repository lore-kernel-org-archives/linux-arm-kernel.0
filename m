From: william.helsby@stfc.ac.uk (william.helsby at stfc.ac.uk)
Date: Fri, 11 Nov 2016 15:46:39 +0000
Subject: [PATCH] Replacement for Arm initrd memblock reserve and free
 inconsistency.
In-Reply-To: <20161110174645.GB1041@n2100.armlinux.org.uk>
References: <592F4D3D062D79449F140027567F70E8FE080A79@exchmbx03>
 <20161110174645.GB1041@n2100.armlinux.org.uk>
Message-ID: <592F4D3D062D79449F140027567F70E8FE080C9F@exchmbx03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 45272bc4d3f27f2c316f5b607441d1337a5501ec Mon Sep 17 00:00:00 2001
From: William Helsby <william.helsby@stfc.ac.uk>
Date: Fri, 11 Nov 2016 15:04:04 +0000
Subject: [PATCH] arm: zynq::Fixing inconsistent reserve and free for initrd
 image
My first attempt at fixing this was very similar to your proposed patch,
though due me not understanding the need to switch outlook to plain text
it never got posted.
In the current case, with the initrd image starting page aligned, with space
above it, the patch worked.
However, on reflection it struck me that the placement of the ramdisk image
is done by the bootloader, so may not always be like this. 
This patch tries to round down the start and up the end, but checks that this 
does not cause an overlap. If it does overlap, it tries aligning just the end 
or start and if neither is possible falls back to not expanding the area 
reserved. 
The code then remembers the start and end of reserved area, with 
any successful expansions to page boundaries. 
If when ./init/initramfs.c calls free_initrd_mem(), the start or end match,
The respective extended values are used so complete pages are released.
Note that according to comments in ./init/initramfs.c, the crashkernel
region can overlap the initrd region, though I don't know anything about
this. 
The POISON_FREE_INITMEM value is used to cause free_reserved_area to
poison only the pages which are released.
Despite this code being careful not to overlap the kernel, there still may be 
an issue with it extending the RAMDISK image reserved are to overlap 
the device tree or something else I am unaware of.
Perhaps the call to early_init_fdt_reserve_self() should be moved 
to before the initrd code?
For the sake of freeing at most 2 partial 4k pages, I am not sure whether 
complexity and technical risk of this solution is justified - unless these 
pages are going to be in the middle of a DMA contiguous area.
Note that the arm64 code reverted to not extending the released area,
but enable clearing of the released areas at 
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/arch/arm64/mm/init.c?id=6b00f7efb5303418c231994c91fb8239f5ada260

Now
void free_initrd_mem(unsigned long start, unsigned long end)
{
	if (!keep_initrd)
		free_reserved_area((void *)start, (void *)end, 0, "initrd");
} 

Signed-off-by: William Helsby <william.helsby@stfc.ac.uk>
---
 arch/arm/mm/init.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 370581a..00a489d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -49,6 +49,8 @@ unsigned long __init __clear_cr(unsigned long mask)

 static phys_addr_t phys_initrd_start __initdata = 0;
 static unsigned long phys_initrd_size __initdata = 0;
+static unsigned long initrd_reservation_start __initdata = 0;
+static unsigned long initrd_reservation_end __initdata = 0;

 static int __init early_initrd(char *p)
 {
@@ -255,11 +257,38 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
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

@@ -771,12 +800,11 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 {
        if (!keep_initrd) {
                if (start == initrd_start)
-                       start = round_down(start, PAGE_SIZE);
+                 start = initrd_reservation_start;
                if (end == initrd_end)
-                       end = round_up(end, PAGE_SIZE);
+                 end = initrd_reservation_end;

-               poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
-               free_reserved_area((void *)start, (void *)end, -1, "initrd");
+               free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM, "initrd");
        }
 }

--
1.8.3.1

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk] 
> Sent: 10 November 2016 17:47
>To: Helsby, William (STFC,DL,TECH)
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] Replacement for Arm initrd memblock reserve and free inconsistency.

>On Wed, Nov 09, 2016 at 04:35:37PM +0000, william.helsby at stfc.ac.uk wrote:
>> A boot time system crash was noticed with a segmentation fault just after the initrd image had been used to initialise the ramdisk.
>> This occurred when the U-Boot loaded the ramdisk image from a FAT partition, but not when loaded by TFTPBOOT. This is not understood?
>> However the problem was caused by free_initrd_mem freeing and 
>> "poisoning" memory that had been allocted to init/main.c to store the saved_command_line.
>> This patch reverses "ARM: 8167/1: extend the reserved memory for initrd to be page aligned" 
>> because it is safer to leave a partial head or tail page reserved (wasted) than to free a page which is partially still in use.
>> If this is not acceptable (particularly if wanting large contiguous physical areas for DMA) then a better solution is required.
>> This would extend the region reserved to page boundaries, if possible without overlapping other regions. 
>>My previous attempt to fix this coded this scheme, to grow the are reserved. 
>> However, this? again is not safe if in growing the area it then overlaps a region that is in use.
>> Note this patch is against the 4.6 kernel, but as far as I can tell applies equally to 4.8.
>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c index 
> 370581a..ff3e9c3 100644
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -770,12 +770,6 @@ static int keep_initrd; void 
>> free_initrd_mem(unsigned long start, unsigned long end) {
>> ??????? if (!keep_initrd) {
>> -?????????????? if (start == initrd_start)
>> -?????????????????????? start = round_down(start, PAGE_SIZE);
>> -?????????????? if (end == initrd_end)
>> -?????????????????????? end = round_up(end, PAGE_SIZE);
>> -
>> -???? ??????????poison_init_mem((void *)start, PAGE_ALIGN(end) - 
>> start);

> We're definitely not getting rid of the poisoning of the pages - the poisoning there is to detect accesses to this memory which should not be made.

> The point of rounding up and down is to ensure that the partly-used pages (which would have been previously reserved) are freed.

> Probably a better fix is to round the start up/end down of the initrd when reserving the memory region:

>  arch/arm/mm/init.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c index 370581aeb871..ee8509e4329d 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -255,7 +255,11 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
>  		phys_initrd_start = phys_initrd_size = 0;
>  	}
>  	if (phys_initrd_size) {
> -		memblock_reserve(phys_initrd_start, phys_initrd_size);
> +		phys_addr_t start, size;
> +
> +		start = round_down(phys_initrd_start, PAGE_SIZE);
> +		end = round_up(phys_initrd_start + phys_initrd_size, PAGE_SIZE);
> +		memblock_reserve(start, end - start);
>  
>  		/* Now convert initrd to virtual addresses */
>  		initrd_start = __phys_to_virt(phys_initrd_start); 
>
> and this should ensure that memblock_alloc() doesn't try to allocate memory overlapping the pages containing the initrd.

> Intentionally using pages overlapping the initrd is a recipe for problems...

> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up according to speedtest.net.

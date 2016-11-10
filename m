From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Nov 2016 17:46:45 +0000
Subject: [PATCH] Replacement for Arm initrd memblock reserve and free
 inconsistency.
In-Reply-To: <592F4D3D062D79449F140027567F70E8FE080A79@exchmbx03>
References: <592F4D3D062D79449F140027567F70E8FE080A79@exchmbx03>
Message-ID: <20161110174645.GB1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 04:35:37PM +0000, william.helsby at stfc.ac.uk wrote:
> A boot time system crash was noticed with a segmentation fault just after the initrd image had been used to initialise the ramdisk.
> This occurred when the U-Boot loaded the ramdisk image from a FAT partition, but not when loaded by TFTPBOOT. This is not understood?
> However the problem was caused by free_initrd_mem freeing and "poisoning" memory that had been allocted to init/main.c to store the saved_command_line
> This patch reverses "ARM: 8167/1: extend the reserved memory for initrd to be page aligned" because it is safer to leave a partial head or tail page reserved (wasted) than to free a page which is partially still in use.
> If this is not acceptable (particularly if wanting large contiguous physical areas for DMA) then a better solution is required.
> This would extend the region reserved to page boundaries, if possible without overlapping other regions. My previous attempt to fix this coded this scheme, to grow the are reserved. 
> However, this? again is not safe if in growing the area it then overlaps a region that is in use.
> Note this path is against the 4.6 kernel, but as far as I can tell applies equally to 4.8.

Please wrap commit messages at or before column 72, the exception is
for lines with a URL.

> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 370581a..ff3e9c3 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -770,12 +770,6 @@ static int keep_initrd;
> void free_initrd_mem(unsigned long start, unsigned long end)
> {
> ??????? if (!keep_initrd) {
> -?????????????? if (start == initrd_start)
> -?????????????????????? start = round_down(start, PAGE_SIZE);
> -?????????????? if (end == initrd_end)
> -?????????????????????? end = round_up(end, PAGE_SIZE);
> -
> -???? ??????????poison_init_mem((void *)start, PAGE_ALIGN(end) - start);

We're definitely not getting rid of the poisoning of the pages - the
poisoning there is to detect accesses to this memory which should not
be made.

The point of rounding up and down is to ensure that the partly-used
pages (which would have been previously reserved) are freed.

Probably a better fix is to round the start up/end down of the initrd
when reserving the memory region:

 arch/arm/mm/init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 370581aeb871..ee8509e4329d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -255,7 +255,11 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 		phys_initrd_start = phys_initrd_size = 0;
 	}
 	if (phys_initrd_size) {
-		memblock_reserve(phys_initrd_start, phys_initrd_size);
+		phys_addr_t start, size;
+
+		start = round_down(phys_initrd_start, PAGE_SIZE);
+		end = round_up(phys_initrd_start + phys_initrd_size, PAGE_SIZE);
+		memblock_reserve(start, end - start);
 
 		/* Now convert initrd to virtual addresses */
 		initrd_start = __phys_to_virt(phys_initrd_start);

and this should ensure that memblock_alloc() doesn't try to allocate
memory overlapping the pages containing the initrd.

Intentionally using pages overlapping the initrd is a recipe for
problems...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

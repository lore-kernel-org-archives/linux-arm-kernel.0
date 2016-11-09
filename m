From: william.helsby@stfc.ac.uk (william.helsby at stfc.ac.uk)
Date: Wed, 9 Nov 2016 16:35:37 +0000
Subject: [PATCH] Replacement for Arm initrd memblock reserve and free
 inconsistency.
Message-ID: <592F4D3D062D79449F140027567F70E8FE080A79@exchmbx03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


A boot time system crash was noticed with a segmentation fault just after the initrd image had been used to initialise the ramdisk.
This occurred when the U-Boot loaded the ramdisk image from a FAT partition, but not when loaded by TFTPBOOT. This is not understood?
However the problem was caused by free_initrd_mem freeing and "poisoning" memory that had been allocted to init/main.c to store the saved_command_line
This patch reverses "ARM: 8167/1: extend the reserved memory for initrd to be page aligned" because it is safer to leave a partial head or tail page reserved (wasted) than to free a page which is partially still in use.
If this is not acceptable (particularly if wanting large contiguous physical areas for DMA) then a better solution is required.
This would extend the region reserved to page boundaries, if possible without overlapping other regions. My previous attempt to fix this coded this scheme, to grow the are reserved. 
However, this? again is not safe if in growing the area it then overlaps a region that is in use.
Note this path is against the 4.6 kernel, but as far as I can tell applies equally to 4.8.

Signed-off-by: William Helsby <wih73@xilinxsrv1.dl.ac.uk>
---
arch/arm/mm/init.c | 6 ------
1 file changed, 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 370581a..ff3e9c3 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -770,12 +770,6 @@ static int keep_initrd;
void free_initrd_mem(unsigned long start, unsigned long end)
{
??????? if (!keep_initrd) {
-?????????????? if (start == initrd_start)
-?????????????????????? start = round_down(start, PAGE_SIZE);
-?????????????? if (end == initrd_end)
-?????????????????????? end = round_up(end, PAGE_SIZE);
-
-???? ??????????poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
??????????????? free_reserved_area((void *)start, (void *)end, -1, "initrd");
??????? }
}
--
1.8.3.1

Science and Technology Facilities Council
SciTech Daresbury
Keckwick Lane
Daresbury
Warrington WA4 4AD

Tel +44(0)1925 603250

From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 20 Jan 2010 15:34:11 +0000
Subject: too much memory for node
Message-ID: <20100120153411.GG26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been looking at support for a new machine type where the
current system is using DISCONTIGMEM as the 1G memory map has
4x256M RAM ranges which may not all be filled.

After removing a hack in the machine support file which fills in
its own memory table thus obliteratign the bootloader supplied ATAG_MEM
I found a problem. The board has the full complement of memory and is
being passed a single ATAG_MEM from the bootloader for all 1G.

This causes arm_add_memory to add a membank that has more memory
than the bank.node it is describing and thus the memory setup code
is then failing.

My current hack to get this working is to do a check for the end
of memory being in the same node as the start, as so:

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..a5f7b21 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -410,6 +410,21 @@ static int __init arm_add_memory(unsigned long start, unsigned long size)
 		return -EINVAL;
 
 	meminfo.nr_banks++;
+
+	if (PHYS_TO_NID(start + size) != bank->node) {
+		/* more memory than a single node can handle */
+
+		unsigned long next = (1024*1024);
+
+		while (PHYS_TO_NID(start + next) == bank->node) 
+			next += (1024*1024); 
+
+		bank->size = next;
+		printk(KERN_INFO "adding new bank 0x%08x size 0x%08x\n",
+				start + next, size - next);
+		arm_add_memory(start + next, size - next);
+	}
+
 	return 0;
 }
 
Note, this code uses a search as I couldn't find a good way of calculating
how mucch space was left in a node given a starting address.

Another option is to do similar to sanity_check_meminfo() in the mmu
setup code (we would still need some form of nodemask or similar from
the memory.h). Is NODE_MEM_SIZE_MASK usable if !CONIFG_DISCONTIGMEM
to allow us to avoid the search and still have compilable code?

A third option is to add some code to the specific cpu type to sanitise
the memory info in the machine fixups, but this is getting into hack
teritory.

There is the option of changing the bootloader, but this would required
updating a number of extant boards and would also require the kernel to
at least warn if the problems happens instead of stopping before the
console is started.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2012 16:17:12 +0000
Subject: Kirkwood, kernel 3.2, vmalloc region overlap, not starting up
In-Reply-To: <4F313832.1070600@kernelconcepts.de>
References: <4F313832.1070600@kernelconcepts.de>
Message-ID: <20120213161711.GB25655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 03:41:54PM +0100, Nils Faerber wrote:
> Hello!
> I am in the process of upgrading board support for my TK71 board from
> 2.6.38 to 3.2 and am now halted by this strange issue...
> 
> The board support for the TK71 is almost identical to the 3.2 included
> board files for e.g. the Sheevaplug or the rd88f6281 reference design.
> After applying my board patch and re-inserting my machine ID again the
> kernel freezes very early.
> 
> After enabling earlyprintk I get the following:
> 
> Uncompressing Linux... done, booting the kernel.
> 
> [    0.000000] Linux version 3.2.0-00012-g980d683-dirty (nils at moi) (gcc
> version 4.4.2 (GCC) ) #30 Tue Feb 7 15:18:57 CET 2012
> [    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE),
> cr=00053977
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> 
> [    0.000000] Machine: TK71 Kirkwood based Q7 formfactor board
> 
> [    0.000000] bootconsole [earlycon0] enabled
> 
> [    0.000000] Ignoring RAM at 00000000-0fffffff (vmalloc region
> overlap).

I think the problem may be due to something screwing up the v:p code
fixups.  So, let's try to find out what the values the code decided on
were, and how some of the __va() macros are behaving.  Could you try
booting with this patch applied?

If this is cache related, this _may_ change the behaviour and make the
bug go away...

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 10303b3..98213f0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -916,6 +916,9 @@ void __init setup_arch(char **cmdline_p)
 {
 	struct machine_desc *mdesc;
 
+	pr_info("PHYS_OFFSET: 0x%08lx PAGE_OFFSET: 0x%08lx __pa(PAGE_OFFSET): 0x%08lx\n",
+		PHYS_OFFSET, PAGE_OFFSET, __virt_to_phys(PAGE_OFFSET));
+
 	setup_processor();
 	mdesc = setup_machine_fdt(__atags_pointer);
 	if (!mdesc)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f77f1db..143430f 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -821,7 +821,7 @@ void __init sanity_check_meminfo(void)
 	for (i = 0, j = 0; i < meminfo.nr_banks; i++) {
 		struct membank *bank = &meminfo.bank[j];
 		*bank = meminfo.bank[i];
-
+pr_info("block %u: pa0x%08lx va%p +0x%08lx\n", bank->start, __va(bank->start), bank->size);
 		if (bank->start > ULONG_MAX)
 			highmem = 1;
 

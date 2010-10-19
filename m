From: ccross@google.com (Colin Cross)
Date: Tue, 19 Oct 2010 01:13:36 -0700
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101011152516.GF27153@n2100.arm.linux.org.uk>
References: <20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<AANLkTinhwORqdWU43yr1AXJGZm2zPKGG+Q9twruNs2aH@mail.gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimQJLmDZPHtVJLCv9ZQgx_Yjh9=MOwOxMSAz4QX@mail.gmail.com>
	<20101011152516.GF27153@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikZAt-KWFF_MXxXGruia-=AieStQgird2XWgr6y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 8:25 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Oct 10, 2010 at 04:52:36AM +0300, Felipe Contreras wrote:
> Here's a different approach which will work. ?This pushes ARM further
> towards using memblock for everything relating to memory init (although
> we still have the old membank stuff around.)
>
> The advantage with this is that memblock is now used as the basis for
> determining where memory is, setting up the maps, freeing memory into
> the pools, etc.
>
> What this also means is that this code in the ->reserve callback:
>
> ? ? ? ?size = min(size, SZ_2M);
> ? ? ? ?base = memblock_alloc(size, min(align, SZ_2M));
> ? ? ? ?memblock_free(base, size);
> ? ? ? ?memblock_remove(base, size);
>
> will result in [base+size] being removed from the available memory,
> using highmem if available, if not from lowmem and removing it from
> the lowmem memory map - which is exactly the behaviour we want.
>
> ?arch/arm/mm/init.c | ?160 +++++++++++++++++++++++++++++++++++-----------------
> ?arch/arm/mm/mmu.c ?| ? 43 ++++++++------
> ?mm/memblock.c ? ? ?| ? ?4 +
> ?3 files changed, 138 insertions(+), 69 deletions(-)

If memblock_remove is used on the end of memory with this patch,
mem_init accesses off the end of the array of page structures because
of the discrepancy between memblock.memory and membank on the number
of the last pfn.   memblock.memory is used to determine the memory
zones in arm_bootmem_free, which eventually  is used to create the
array of page structures, but mem_init iterates over membank and calls
pfn_to_page on pfns up to bank_pfn_end.

Converting show_mem and mem_init to use memblock.memory fixes it:

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 52192f4..6c2b8a0 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -81,18 +81,16 @@ void show_mem(void)
 {
        int free = 0, total = 0, reserved = 0;
        int shared = 0, cached = 0, slab = 0, i;
-       struct meminfo * mi = &meminfo;

        printk("Mem-info:\n");
        show_free_areas();

-       for_each_bank (i, mi) {
-               struct membank *bank = &mi->bank[i];
+       for (i = 0; i < memblock.memory.cnt; i++) {
                unsigned int pfn1, pfn2;
                struct page *page, *end;

-               pfn1 = bank_pfn_start(bank);
-               pfn2 = bank_pfn_end(bank);
+               pfn1 = memblock_start_pfn(&memblock.memory, i);
+               pfn2 = memblock_end_pfn(&memblock.memory, i);

                page = pfn_to_page(pfn1);
                end  = pfn_to_page(pfn2 - 1) + 1;
@@ -520,13 +518,12 @@ void __init mem_init(void)

        reserved_pages = free_pages = 0;

-       for_each_bank(i, &meminfo) {
-               struct membank *bank = &meminfo.bank[i];
+       for (i = 0; i < memblock.memory.cnt; i++) {
                unsigned int pfn1, pfn2;
                struct page *page, *end;

-               pfn1 = bank_pfn_start(bank);
-               pfn2 = bank_pfn_end(bank);
+               pfn1 = memblock_start_pfn(&memblock.memory, i);
+               pfn2 = memblock_end_pfn(&memblock.memory, i);

                page = pfn_to_page(pfn1);
                end  = pfn_to_page(pfn2 - 1) + 1;

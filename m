From: omycle@gmail.com (Li Haifeng)
Date: Sat, 25 Aug 2012 11:12:09 +0800
Subject: For physical memory management, why take holes page as free pages?
Message-ID: <CAFNq8R6FL3bVnht2b16zsCm82N+WyrobH3kXzXv3Z-YERfeudw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, everybody.

Sorry to disturb you. When I study memory management of boot_mem, I
have question about 505~506 lines below code for initialization of
physical memory management. The function of these two lines is to make
the holes between adjacent bank free in node_bootmem_map of
corresponding node, which is a bitmap.

IMO, the holes between two bank should be marked reserved in page
bitmap, because it couldn't be used for allocating memory in buddy
system.

start_kernel->mm_init->mem_init-> free_unused_memmap:
-------------------------------->
arch/arm/mm/init.c:

472 static void __init free_unused_memmap(struct meminfo *mi)
473 {
474         unsigned long bank_start, prev_bank_end = 0;
475         unsigned int i;
476
477         /*
478          * This relies on each bank being in address order.
479          * The banks are sorted previously in bootmem_init().
480          */
481         for_each_bank(i, mi) {
482                 struct membank *bank = &mi->bank[i];
483
484                 bank_start = bank_pfn_start(bank);
485
486 #ifdef CONFIG_SPARSEMEM
487                 /*
488                  * Take care not to free memmap entries that don't exist
489                  * due to SPARSEMEM sections which aren't present.
490                  */
491                 bank_start = min(bank_start,
492                                  ALIGN(prev_bank_end, PAGES_PER_SECTION));
493 #else
494                 /*
495                  * Align down here since the VM subsystem insists that the
496                  * memmap entries are valid from the bank start aligned to
497                  * MAX_ORDER_NR_PAGES.
498                  */
499                 bank_start = round_down(bank_start, MAX_ORDER_NR_PAGES);
500 #endif
501                 /*
502                  * If we had a previous bank, and there is a space
503                  * between the current bank and the previous, free it.
504                  */
505                 if (prev_bank_end && prev_bank_end < bank_start)
506                         free_memmap(prev_bank_end, bank_start);
507
508                 /*
509                  * Align up here since the VM subsystem insists that the
510                  * memmap entries are valid from the bank end aligned to
511                  * MAX_ORDER_NR_PAGES.
512                  */
513                 prev_bank_end = ALIGN(bank_pfn_end(bank),
MAX_ORDER_NR_PAGES);
514         }


Thanks.

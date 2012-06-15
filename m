From: omycle@gmail.com (Li Haifeng)
Date: Fri, 15 Jun 2012 18:04:54 +0800
Subject: why do_translation_fault does not fill Page table entry?
Message-ID: <CAFNq8R7Lk6V8dRnrhufApF+XcyU-ubkp0n4qEFghi3DE2KBa7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When page fault happens on VMALLOC_START~VMALLOC_END, why
do_translation_fault does not fill Page table entry ?

Does the least size of vmalloc is more than 1 MB?

413 #ifdef CONFIG_MMU
414 static int __kprobes
415 do_translation_fault(unsigned long addr, unsigned int fsr,
416                      struct pt_regs *regs)
417 {
418         unsigned int index;
419         pgd_t *pgd, *pgd_k;
420         pud_t *pud, *pud_k;
421         pmd_t *pmd, *pmd_k;
422
423         if (addr < TASK_SIZE)
424                 return do_page_fault(addr, fsr, regs);
425
426         if (user_mode(regs))
427                 goto bad_area;
428
429         index = pgd_index(addr);
430
431         /*
432          * FIXME: CP15 C1 is write only on ARMv3 architectures.
433          */
434         pgd = cpu_get_pgd() + index;
435         pgd_k = init_mm.pgd + index;
436
437         if (pgd_none(*pgd_k))
438                 goto bad_area;
439         if (!pgd_present(*pgd))
440                 set_pgd(pgd, *pgd_k);
441
442         pud = pud_offset(pgd, addr);
443         pud_k = pud_offset(pgd_k, addr);
444
445         if (pud_none(*pud_k))
446                 goto bad_area;
447         if (!pud_present(*pud))
448                 set_pud(pud, *pud_k);
449
450         pmd = pmd_offset(pud, addr);
451         pmd_k = pmd_offset(pud_k, addr);
452
453 #ifdef CONFIG_ARM_LPAE
454         /*
455          * Only one hardware entry per PMD with LPAE.
456          */
457         index = 0;
458 #else
459         /*
460          * On ARM one Linux PGD entry contains two hardware entries
(see page
461          * tables layout in pgtable.h). We normally guarantee that we
always
462          * fill both L1 entries. But create_mapping() doesn't follow
the rule.
463          * It can create inidividual L1 entries, so here we have to call
464          * pmd_none() check for the entry really corresponded to
address, not
465          * for the first of pair.
466          */
467         index = (addr >> SECTION_SHIFT) & 1;
468 #endif
469         if (pmd_none(pmd_k[index]))
470                 goto bad_area;
471
472         copy_pmd(pmd, pmd_k);
473         return 0;
474
475 bad_area:
476         do_bad_area(addr, fsr, regs);
477         return 0;
478 }
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120615/85ba17af/attachment-0001.html>

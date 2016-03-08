From: labbott@redhat.com (Laura Abbott)
Date: Mon, 7 Mar 2016 17:27:46 -0800
Subject: mmotm broken on arm with ebc495cfcea9 (mm: cleanup *pte_alloc*
 interfaces)
Message-ID: <56DE2A92.5010806@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I just tried the master of mmotm and ran into compilation issues on arm:

   CC      arch/arm/mm/mmu.o
arch/arm/mm/mmu.c:737:37: error: macro "pte_alloc" passed 4 arguments, but takes just 3
      void *(*alloc)(unsigned long sz))
                                      ^
arch/arm/mm/mmu.c:738:1: error: expected ?=?, ?,?, ?;?, ?asm? or ?__attribute__? before ?{? token
  {
  ^
arch/arm/mm/mmu.c: In function ?early_pte_alloc?:
arch/arm/mm/mmu.c:750:47: error: macro "pte_alloc" passed 4 arguments, but takes just 3
   return pte_alloc(pmd, addr, prot, early_alloc);
                                                ^
arch/arm/mm/mmu.c:750:9: error: ?pte_alloc? undeclared (first use in this function)
   return pte_alloc(pmd, addr, prot, early_alloc);
          ^
arch/arm/mm/mmu.c:750:9: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/mm/mmu.c: In function ?alloc_init_pte?:
arch/arm/mm/mmu.c:759:56: error: macro "pte_alloc" passed 4 arguments, but takes just 3
   pte_t *pte = pte_alloc(pmd, addr, type->prot_l1, alloc);
                                                         ^
arch/arm/mm/mmu.c:759:15: error: ?pte_alloc? undeclared (first use in this function)
   pte_t *pte = pte_alloc(pmd, addr, type->prot_l1, alloc);
                ^
arch/arm/mm/mmu.c: In function ?early_pte_alloc?:
arch/arm/mm/mmu.c:751:1: warning: control reaches end of non-void function [-Wreturn-type]
  }
  ^


It looks like this is caused by ebc495cfcea9 (mm: cleanup *pte_alloc* interfaces)
which added

#define pte_alloc(mm, pmd, address)                     \
         (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd, address))


and conflicts with arch/arm/mm/mmu.c which is using pte_alloc as a function name.

Is this a known issue? If not, Russell would you take a patch to rename the pte_alloc
functions in arm?

Thanks,
Laura

From: msalter@redhat.com (Mark Salter)
Date: Fri, 25 Jul 2014 15:00:37 -0400
Subject: memory leak in arm kvm
Message-ID: <1406314837.27055.25.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been looking into a memory leak in the arm kvm code which has been
seen on arm64 platforms. It seems there is a small (2-4MB depending on
pagesize) leak when a guest is started and stopped. The leak is
happening in arch/arm/kvm/mmu.c when kvm_free_stage2_pgd() tries to
unmap everything and free the pgd allocation. The problem I see is that
unmap_range() does not remove all the page references to the pgd so when
free_pages() is called, the pages are not actually freed because of
page->count > 1. Looking further, the call to unmap_range() only ever
calls put_page() once for the pgd and then it bails out of the while
loop. This happens because of the arm64 kvm_p?d_addr_end() macros. They
are defined to the normal p?d_addr_end macros. On arm64 with 3-level
page tables, pud_addr_end() simply advances to the end. With 2-level
page tables, pud_addr_end() and pmd_addr_end() both advance to end. So
when the bottom of the while loop in unmap_range() uses those to advance
to next pmd or pud, the loop ends up exiting. I can get around this by
open coding the  kvm_p?d_addr_end macros thusly:

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 7d29847..d7f77ff 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -122,8 +122,16 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
 }
 
 #define kvm_pgd_addr_end(addr, end)	pgd_addr_end(addr, end)
-#define kvm_pud_addr_end(addr, end)	pud_addr_end(addr, end)
-#define kvm_pmd_addr_end(addr, end)	pmd_addr_end(addr, end)
+
+#define kvm_pud_addr_end(addr, end)					\
+({	unsigned long __boundary = ((addr) + PUD_SIZE) & PUD_MASK;	\
+	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
+})
+
+#define kvm_pmd_addr_end(addr, end)					\
+({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
+	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
+})
 
 struct kvm;
 
I'm not@all sure this is a correct/complete fix and I'm not really
familiar with the design of the arm kvm code, so I'll leave it to
others to decide that.

From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 16:46:04 +0200
Subject: [PATCH v2 9/9] mm: replace open coded page to virt conversion with
 page_to_virt()
In-Reply-To: <1459349164-27175-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459349164-27175-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459349164-27175-10-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The open coded conversion from struct page address to virtual address in
lowmem_page_address() involves an intermediate conversion step to pfn
number/physical address. Since the placement of the struct page array
relative to the linear mapping may be completely independent from the
placement of physical RAM (as is that case for arm64 after commit
dfd55ad85e 'arm64: vmemmap: use virtual projection of linear region'),
the conversion to physical address and back again should factor out of
the equation, but unfortunately, the shifting and pointer arithmetic
involved prevent this from happening, and the resulting calculation
essentially subtracts the address of the start of physical memory and
adds it back again, in a way that prevents the compiler from optimizing
it away.

Since the start of physical memory is not a build time constant on arm64,
the resulting conversion involves an unnecessary memory access, which
we would like to get rid of. So replace the open coded conversion with
a call to page_to_virt(), and use the open coded conversion as its
default definition, to be overriden by the architecture, if desired.
The existing arch specific definitions of page_to_virt are all equivalent
to this default definition, so by itself this patch is a no-op.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/mm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ed6407d1b7b5..474c4625756e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -72,6 +72,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
 
+#ifndef page_to_virt
+#define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
+#endif
+
 /*
  * To prevent common memory management code establishing
  * a zero page mapping on a read fault.
@@ -948,7 +952,7 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 
 static __always_inline void *lowmem_page_address(const struct page *page)
 {
-	return __va(PFN_PHYS(page_to_pfn(page)));
+	return page_to_virt(page);
 }
 
 #if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
-- 
2.5.0

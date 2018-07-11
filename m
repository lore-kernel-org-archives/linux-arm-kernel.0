From: ben@decadent.org.uk (Ben Hutchings)
Date: Thu, 12 Jul 2018 00:18:22 +0100
Subject: [RFC PATCH] arm64: mm: Export __sync_icache_dcache() for xen-privcmd
Message-ID: <20180711231822.GG14131@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xen-privcmd driver, which can be modular, calls set_pte_at()
which in turn may call __sync_icache_dcache().

The call to __sync_icache_dcache() may be optimised out because it is
conditional on !pte_special(), and xen-privcmd calls pte_mkspecial().
But it seems unwise to rely on this optimisation.

Fixes: 3ad0876554ca ("xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This is an RFC since I haven't found an actual build failure.  Using
Debian's gcc 7.3 with either CC_OPTIMIZE_FOR_PERFORMANCE or
CC_OPTIMIZE_FOR_SIZE, the call *is* optimised away.

Ben.

 arch/arm64/mm/flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 1059884f9a6f..a76f0b983294 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -66,6 +66,7 @@ void __sync_icache_dcache(pte_t pte)
 		sync_icache_aliases(page_address(page),
 				    PAGE_SIZE << compound_order(page));
 }
+EXPORT_SYMBOL_GPL(__sync_icache_dcache);
 
 /*
  * This function is called when a page has been modified by the kernel. Mark

From: ben@decadent.org.uk (Ben Hutchings)
Date: Wed, 11 Jul 2018 23:50:13 +0100
Subject: [PATCH] ARM: mm: Export __sync_icache_dcache() for xen-privcmd
Message-ID: <20180711225013.GF14131@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xen-privcmd driver, which can be modular, calls set_pte_at()
which in turn may call __sync_icache_dcache().

The call to __sync_icache_dcache() may be optimised out because it is
conditional on !pte_special(), and xen-privcmd calls pte_mkspecial().
However, in a non-LPAE configuration there is no "special" bit and the
call is really unconditional.

Fixes: 3ad0876554ca ("xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This is a 4.18 regression so ideally should be fixed before 4.18 is
released.

Ben.

 arch/arm/mm/flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 58469623b015..5345f86c56d2 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -295,6 +295,7 @@ void __sync_icache_dcache(pte_t pteval)
 	if (pte_exec(pteval))
 		__flush_icache_all();
 }
+EXPORT_SYMBOL_GPL(__sync_icache_dcache);
 #endif
 
 /*
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/c196a30b/attachment.sig>

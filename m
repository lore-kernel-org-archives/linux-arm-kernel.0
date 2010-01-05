From: jsun@junsun.net (Jun Sun)
Date: Tue, 5 Jan 2010 10:51:08 -0800
Subject: [patch v3] Valid relocation symbol for FLAT format on ARM
Message-ID: <20100105185108.GA19420@Pogoplug>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Strange - this did not seem to go through. Another try.

Cheers.

Jun
-------------- next part --------------

Apparently newer GCC would generate ANCHOR symbols beyond the end of
data/bss segment on ARM CPUs. As a result, the exiting validity checking
for relocation symbols in FLAT format will fail.

Signed-off-by: Jun Sun <jsun@junsun.net>
---

diff -Nru linux-2.6.32.2/arch/arm/include/asm/flat.h.orig linux-2.6.32.2/arch/arm/include/asm/flat.h
--- linux-2.6.32.2/arch/arm/include/asm/flat.h.orig	2009-12-18 14:27:07.000000000 -0800
+++ linux-2.6.32.2/arch/arm/include/asm/flat.h	2010-01-02 09:15:03.000000000 -0800
@@ -7,7 +7,12 @@
 
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		(flags)
-#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
+/* New gcc 4.x generates ANCHOR symbols in order to reduce the size
+ * of GOT table for PIC code. It is possible the ANCHOR is placed beyond
+ * the end of data/bss segment up to 4K bytes(12 bits), because ARM allows
+ * negative 12-bit offset. Thus we allow 0x1000 extra in reloc address range.
+ */
+#define	flat_reloc_valid(reloc, size)		((reloc) <= (size) + 0x1000)
 #define	flat_get_addr_from_rp(rp, relval, flags, persistent) get_unaligned(rp)
 #define	flat_put_addr_at_rp(rp, val, relval)	put_unaligned(val,rp)
 #define	flat_get_relocate_addr(rel)		(rel)

From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 26 Sep 2011 16:24:49 +0100
Subject: [PATCHv3 4/4] picoxcell: remove custom ioremap implementation
In-Reply-To: <1317050689-16417-1-git-send-email-jamie@jamieiles.com>
References: <1317050689-16417-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1317050689-16417-5-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre's generic ioremap() patch set means that we don't need
this any more.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/include/mach/io.h      |    7 -------
 arch/arm/mach-picoxcell/include/mach/vmalloc.h |   18 ------------------
 arch/arm/mach-picoxcell/io.c                   |   24 ------------------------
 3 files changed, 0 insertions(+), 49 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h

diff --git a/arch/arm/mach-picoxcell/include/mach/io.h b/arch/arm/mach-picoxcell/include/mach/io.h
index a863b0f..7573ec7 100644
--- a/arch/arm/mach-picoxcell/include/mach/io.h
+++ b/arch/arm/mach-picoxcell/include/mach/io.h
@@ -19,11 +19,4 @@
 /* No PCI possible on picoxcell. */
 #define __mem_pci(a)		(a)
 
-#define __arch_ioremap	picoxcell_ioremap
-#define __arch_iounmap	picoxcell_iounmap
-
-extern void __iomem *picoxcell_ioremap(unsigned long phys, size_t size,
-				       unsigned int type);
-extern void picoxcell_iounmap(volatile void __iomem *addr);
-
 #endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/vmalloc.h b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
deleted file mode 100644
index 62559e3..0000000
--- a/arch/arm/mach-picoxcell/include/mach/vmalloc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#define VMALLOC_END		0xFE000000UL
diff --git a/arch/arm/mach-picoxcell/io.c b/arch/arm/mach-picoxcell/io.c
index 935a2fa..39e9b9e 100644
--- a/arch/arm/mach-picoxcell/io.c
+++ b/arch/arm/mach-picoxcell/io.c
@@ -30,27 +30,3 @@ void __init picoxcell_map_io(void)
 
 	iotable_init(&io_map, 1);
 }
-
-void __iomem *picoxcell_ioremap(unsigned long p, size_t size,
-				unsigned int type)
-{
-	if (unlikely(size == 0))
-		return NULL;
-
-	if (p >= PICOXCELL_PERIPH_BASE &&
-	    p < PICOXCELL_PERIPH_BASE + PICOXCELL_PERIPH_LENGTH)
-		return IO_ADDRESS(p);
-
-	return __arm_ioremap_caller(p, size, type,
-				    __builtin_return_address(0));
-}
-EXPORT_SYMBOL_GPL(picoxcell_ioremap);
-
-void picoxcell_iounmap(volatile void __iomem *addr)
-{
-	unsigned long virt = (unsigned long)addr;
-
-	if (virt >= VMALLOC_START && virt < VMALLOC_END)
-		__iounmap(addr);
-}
-EXPORT_SYMBOL_GPL(picoxcell_iounmap);
-- 
1.7.4.1

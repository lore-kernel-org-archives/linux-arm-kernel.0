From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Apr 2013 14:57:14 +0530
Subject: [PATCH 3/4] ARM: davinci: sram.c: fix incorrect type in assignment
In-Reply-To: <1365586035-26583-1-git-send-email-nsekhar@ti.com>
References: <1365586035-26583-1-git-send-email-nsekhar@ti.com>
Message-ID: <1365586035-26583-4-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix missing __iomem attribute. This fixes the sparse warning:

  CHECK   arch/arm/mach-davinci/sram.c
arch/arm/mach-davinci/sram.c:75:8: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-davinci/sram.c:75:8:    expected void *addr
arch/arm/mach-davinci/sram.c:75:8:    got void [noderef] <asn:2>*
arch/arm/mach-davinci/sram.c:81:12: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-davinci/sram.c:81:12:    expected void volatile [noderef] <asn:2>*addr
arch/arm/mach-davinci/sram.c:81:12:    got void *addr

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/sram.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index c5f7ee5..f18928b 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -62,7 +62,7 @@ static int __init sram_init(void)
 	phys_addr_t phys = davinci_soc_info.sram_dma;
 	unsigned len = davinci_soc_info.sram_len;
 	int status = 0;
-	void *addr;
+	void __iomem *addr;
 
 	if (len) {
 		len = min_t(unsigned, len, SRAM_SIZE);
@@ -75,7 +75,7 @@ static int __init sram_init(void)
 		addr = ioremap(phys, len);
 		if (!addr)
 			return -ENOMEM;
-		status = gen_pool_add_virt(sram_pool, (unsigned)addr,
+		status = gen_pool_add_virt(sram_pool, (unsigned long) addr,
 					   phys, len, -1);
 		if (status < 0)
 			iounmap(addr);
-- 
1.7.10.1

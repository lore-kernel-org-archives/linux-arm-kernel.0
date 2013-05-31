From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 22:47:04 +0200
Subject: [PATCH] ARM: ux500: avoid warning in ux500_read_asicid
Message-ID: <2475820.dXNmmAuTaP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

phys_addr_t may be 64 bit, which causes this harmless warning
in ux500_read_asicid:

arch/arm/mach-ux500/id.c: In function 'ux500_read_asicid':
arch/arm/include/asm/io.h:159:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
 #define IOMEM(x) ((void __force __iomem *)(x))
                   ^
arch/arm/mach-ux500/id.c:40:9: note: in expansion of macro 'readl'
  return readl(IOMEM(UX500_VIRT_ROM + (addr & 0xfff)));

We can solve this in a nicer way by making UX500_VIRT_ROM have a proper
type to start with and calculating the address using pointer arithmetic.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>

diff --git a/arch/arm/mach-ux500/db8500-regs.h b/arch/arm/mach-ux500/db8500-regs.h
index b2d7a0b..bb4cc41 100644
--- a/arch/arm/mach-ux500/db8500-regs.h
+++ b/arch/arm/mach-ux500/db8500-regs.h
@@ -184,7 +184,7 @@
 #define U8500_IO_VIRTUAL	0xf0000000
 #define U8500_IO_PHYSICAL	0xa0000000
 /* This is where we map in the ROM to check ASIC IDs */
-#define UX500_VIRT_ROM		0xf0000000
+#define UX500_VIRT_ROM		IOMEM(0xf0000000)
 
 /* This macro is used in assembly, so no cast */
 #define IO_ADDRESS(x)           \
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index 0d33d1a..392f2fd 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -21,11 +21,11 @@
 
 struct dbx500_asic_id dbx500_id;
 
-static unsigned int ux500_read_asicid(phys_addr_t addr)
+static unsigned int __init ux500_read_asicid(phys_addr_t addr)
 {
 	phys_addr_t base = addr & ~0xfff;
 	struct map_desc desc = {
-		.virtual	= UX500_VIRT_ROM,
+		.virtual	= (unsigned long)UX500_VIRT_ROM,
 		.pfn		= __phys_to_pfn(base),
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
@@ -37,7 +37,7 @@ static unsigned int ux500_read_asicid(phys_addr_t addr)
 	local_flush_tlb_all();
 	flush_cache_all();
 
-	return readl(IOMEM(UX500_VIRT_ROM + (addr & 0xfff)));
+	return readl(UX500_VIRT_ROM + (addr & 0xfff));
 }
 
 static void ux500_print_soc_info(unsigned int asicid)

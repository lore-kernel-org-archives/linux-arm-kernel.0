From: alan@signal11.us (Alan Ott)
Date: Sat, 10 Mar 2012 13:44:55 -0500
Subject: [PATCH 2/2] ARM: at91: Use proper __iomem annotations
In-Reply-To: <1331405049-3186-1-git-send-email-alan@signal11.us>
References: <1331405049-3186-1-git-send-email-alan@signal11.us>
Message-ID: <1331405095-3299-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

MMIO addresses should be of type 'void __iomem *', not integer,
in order to make the build-time type system of the kernel work.

This changes some of the locations in the at91 platform that
I noticed, but there may be more, since I have not yet built
every configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alan Ott <alan@signal11.us>
---
 arch/arm/mach-at91/at91rm9200.c            |    2 +-
 arch/arm/mach-at91/include/mach/hardware.h |    4 ++++
 arch/arm/mach-at91/setup.c                 |    4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 99c3174..239b657 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -27,7 +27,7 @@
 
 static struct map_desc at91rm9200_io_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_EMAC,
+		.virtual	= (unsigned long)AT91_VA_BASE_EMAC,
 		.pfn		= __phys_to_pfn(AT91RM9200_BASE_EMAC),
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 2d0e4e9..91375e2 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -75,8 +75,12 @@
  * to 0xFEF78000 .. 0xFF000000.  (544Kb)
  */
 #define AT91_IO_PHYS_BASE	0xFFF78000
+#ifdef __ASSEMBLER__
 #define AT91_IO_VIRT_BASE	(0xFF000000 - AT91_IO_SIZE)
 #else
+#define AT91_IO_VIRT_BASE	(void __iomem *)(0xFF000000 - AT91_IO_SIZE)
+#endif
+#else
 /*
  * Identity mapping for the non MMU case.
  */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 69d3fc4..809da35 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -57,7 +57,7 @@ void __init at91_init_sram(int bank, unsigned long base, unsigned int length)
 {
 	struct map_desc *desc = &sram_desc[bank];
 
-	desc->virtual = AT91_IO_VIRT_BASE - length;
+	desc->virtual = (unsigned long)AT91_IO_VIRT_BASE - length;
 	if (bank > 0)
 		desc->virtual -= sram_desc[bank - 1].length;
 
@@ -72,7 +72,7 @@ void __init at91_init_sram(int bank, unsigned long base, unsigned int length)
 }
 
 static struct map_desc at91_io_desc __initdata = {
-	.virtual	= AT91_VA_BASE_SYS,
+	.virtual	= (unsigned long)AT91_VA_BASE_SYS,
 	.pfn		= __phys_to_pfn(AT91_BASE_SYS),
 	.length		= SZ_16K,
 	.type		= MT_DEVICE,
-- 
1.7.0.4

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Jan 2015 22:23:44 +0100
Subject: [PATCH 5/6] ARM: at91: remove unused at91_init_sram
In-Reply-To: <1421097825-396-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421097825-396-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421097825-396-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SRAM initialization is now done through the mmio-sram driver and
at91_init_sram() is not called anymore, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/generic.h |  2 --
 arch/arm/mach-at91/setup.c   | 20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 54f3837a0a4d..18d5547f11d5 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -17,8 +17,6 @@
  /* Map io */
 extern void __init at91_map_io(void);
 extern void __init at91_alt_map_io(void);
-extern void __init at91_init_sram(int bank, unsigned long base,
-				  unsigned int length);
 
  /* Processors */
 extern void __init at91_dt_initialize(void);
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index e3c21b458bb8..4c184285d38f 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -34,26 +34,6 @@ EXPORT_SYMBOL(at91_soc_initdata);
 void __iomem *at91_ramc_base[2];
 EXPORT_SYMBOL_GPL(at91_ramc_base);
 
-static struct map_desc sram_desc[2] __initdata;
-
-void __init at91_init_sram(int bank, unsigned long base, unsigned int length)
-{
-	struct map_desc *desc = &sram_desc[bank];
-
-	desc->virtual = (unsigned long)AT91_IO_VIRT_BASE - length;
-	if (bank > 0)
-		desc->virtual -= sram_desc[bank - 1].length;
-
-	desc->pfn = __phys_to_pfn(base);
-	desc->length = length;
-	desc->type = MT_MEMORY_RWX_NONCACHED;
-
-	pr_info("sram at 0x%lx of 0x%x mapped at 0x%lx\n",
-		base, length, desc->virtual);
-
-	iotable_init(desc, 1);
-}
-
 static struct map_desc at91_io_desc __initdata __maybe_unused = {
 	.virtual	= (unsigned long)AT91_VA_BASE_SYS,
 	.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-- 
2.1.0

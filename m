From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jul 2016 14:45:08 +0200
Subject: [PATCH 09/11] ARM: ux500: call ux500_setup_id later
In-Reply-To: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1467722710-1577-9-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

ux500_setup_id is currently called from u8500_map_io(), which is
really early, but nothing relies on the ID any more, other than
a printk message that is not really all that important to
have early during boot.

If we move the call to ux500_setup_id() into ux500_soc_device_init(),
that file becomes usuable almost entirely standalone, and we can kill
off the u8500_map_io() callback as it just does the default
debug_ll_io_init() now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |  8 --------
 arch/arm/mach-ux500/id.c         | 23 ++++++++++-------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index e7eba473d3bd..881cafbc4d97 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -27,13 +27,6 @@
 
 #include "board-mop500.h"
 #include "db8500-regs.h"
-#include "id.h"
-
-static void __init u8500_map_io(void)
-{
-	debug_ll_io_init();
-	ux500_setup_id();
-}
 
 /*
  * The PMU IRQ lines of two cores are wired together into a single interrupt.
@@ -117,7 +110,6 @@ static const char * stericsson_dt_platform_compat[] = {
 DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
 	.l2c_aux_val    = 0,
 	.l2c_aux_mask	= ~0,
-	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	.init_machine	= u8500_init_machine,
 	.dt_compat      = stericsson_dt_platform_compat,
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index 17f80ef44c58..983004d0fef2 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -37,21 +37,16 @@ static struct dbx500_asic_id dbx500_id;
 
 static unsigned int __init ux500_read_asicid(phys_addr_t addr)
 {
-	phys_addr_t base = addr & ~0xfff;
-	struct map_desc desc = {
-		.virtual	= (unsigned long)UX500_VIRT_ROM,
-		.pfn		= __phys_to_pfn(base),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	};
+	void __iomem *virt = ioremap(addr, 4);
+	unsigned int asicid;
 
-	iotable_init(&desc, 1);
+	if (!virt)
+		return 0;
 
-	/* As in devicemaps_init() */
-	local_flush_tlb_all();
-	flush_cache_all();
+	asicid = readl(virt);
+	iounmap(virt);
 
-	return readl(UX500_VIRT_ROM + (addr & 0xfff));
+	return asicid;
 }
 
 static void ux500_print_soc_info(unsigned int asicid)
@@ -86,7 +81,7 @@ static unsigned int partnumber(unsigned int asicid)
  * DB9540	0x413fc090	0xFFFFDBF4		0x009540xx
  */
 
-void __init ux500_setup_id(void)
+static void __init ux500_setup_id(void)
 {
 	unsigned int cpuid = read_cpuid_id();
 	unsigned int asicid = 0;
@@ -197,6 +192,8 @@ struct device * __init ux500_soc_device_init(void)
 	struct soc_device *soc_dev;
 	struct soc_device_attribute *soc_dev_attr;
 
+	ux500_setup_id();
+
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return ERR_PTR(-ENOMEM);
-- 
2.4.11

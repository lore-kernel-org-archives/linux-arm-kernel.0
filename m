From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Jul 2010 17:55:09 +0100
Subject: [PATCH] ARM: Versatile Express: Add default memory layout
Message-ID: <20100721165509.26047.70564.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since this platform is known to have 1GB of RAM at 0x60000000, add a
.fixup function to set the defaults in case no "mem=" option is passed
on the kernel command line.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 arch/arm/mach-vexpress/ct-ca9x4.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6353459..3556284 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -16,6 +16,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
+#include <asm/setup.h>
 
 #include <mach/clkdev.h>
 #include <mach/ct-ca9x4.h>
@@ -32,6 +33,17 @@
 
 #define V2M_PA_CS7	0x10000000
 
+void ct_ca9x4_fixup(struct machine_desc *mdesc, struct tag *tags, char **from,
+		    struct meminfo *meminfo)
+{
+	/*
+	 * 1GB at 0x60000000.
+	 */
+	meminfo->bank[0].start = 0x60000000;
+	meminfo->bank[0].size = SZ_1G;
+	meminfo->nr_banks = 1;
+}
+
 static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 	{
 		.virtual	= __MMIO_P2V(CT_CA9X4_MPIC),
@@ -240,6 +252,7 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
 	.phys_io	= V2M_UART0 & SECTION_MASK,
 	.io_pg_offst	= (__MMIO_P2V(V2M_UART0) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.fixup		= ct_ca9x4_fixup,
 	.map_io		= ct_ca9x4_map_io,
 	.init_irq	= ct_ca9x4_init_irq,
 #if 0

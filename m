From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:16:00 +0900
Subject: [PATCH 20/29] ARM: shmobile: r8a7790: Declare SCIF register base and
 IRQ as resources
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
Message-ID: <c0a384f5ed28031315e5f61220982d31d517e672.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index b6deb19..8bfdc36 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -103,11 +103,14 @@ void __init r8a7790_pinmux_init(void)
 #define __R8A7790_SCIF(scif_type, _scscr, algo, index, baseaddr, irq)	\
 static struct plat_sci_port scif##index##_platform_data = {		\
 	.type		= scif_type,					\
-	.mapbase	= baseaddr,					\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
 	.scbrr_algo_id	= algo,						\
 	.scscr		= _scscr,					\
-	.irqs		= SCIx_IRQ_MUXED(irq),				\
+};									\
+									\
+static struct resource scif##index##_resources[] = {			\
+	DEFINE_RES_MEM(baseaddr, 0x100),				\
+	DEFINE_RES_IRQ(irq),						\
 }
 
 #define R8A7790_SCIF(index, baseaddr, irq)				\
@@ -138,9 +141,11 @@ R8A7790_HSCIF(8, 0xe62c0000, gic_spi(154)); /* HSCIF0 */
 R8A7790_HSCIF(9, 0xe62c8000, gic_spi(155)); /* HSCIF1 */
 
 #define r8a7790_register_scif(index)					       \
-	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
-				      &scif##index##_platform_data,	       \
-				      sizeof(scif##index##_platform_data))
+	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+					  scif##index##_resources,	       \
+					  ARRAY_SIZE(scif##index##_resources), \
+					  &scif##index##_platform_data,	       \
+					  sizeof(scif##index##_platform_data))
 
 static const struct renesas_irqc_config irqc0_data __initconst = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
-- 
1.8.4

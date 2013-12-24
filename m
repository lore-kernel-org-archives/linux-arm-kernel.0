From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:16:06 +0900
Subject: [PATCH 26/29] ARM: shmobile: r8a7790: Don't set plat_sci_port
 scbrr_algo_id field
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
Message-ID: <6319ea5089a267b3a1cbd1d745ecc7cdae9a0a7e.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 8bfdc36..66476d2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -100,11 +100,10 @@ void __init r8a7790_pinmux_init(void)
 	r8a7790_register_i2c(3);
 }
 
-#define __R8A7790_SCIF(scif_type, _scscr, algo, index, baseaddr, irq)	\
+#define __R8A7790_SCIF(scif_type, _scscr, index, baseaddr, irq)		\
 static struct plat_sci_port scif##index##_platform_data = {		\
 	.type		= scif_type,					\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
-	.scbrr_algo_id	= algo,						\
 	.scscr		= _scscr,					\
 };									\
 									\
@@ -115,19 +114,19 @@ static struct resource scif##index##_resources[] = {			\
 
 #define R8A7790_SCIF(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_SCIF, SCSCR_RE | SCSCR_TE,			\
-		       SCBRR_ALGO_2, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 #define R8A7790_SCIFA(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_SCIFA, SCSCR_RE | SCSCR_TE | SCSCR_CKE0,	\
-		       SCBRR_ALGO_4, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 #define R8A7790_SCIFB(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_SCIFB, SCSCR_RE | SCSCR_TE,			\
-		       SCBRR_ALGO_4, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 #define R8A7790_HSCIF(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_HSCIF, SCSCR_RE | SCSCR_TE,			\
-		       SCBRR_ALGO_6, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 R8A7790_SCIFA(0, 0xe6c40000, gic_spi(144)); /* SCIFA0 */
 R8A7790_SCIFA(1, 0xe6c50000, gic_spi(145)); /* SCIFA1 */
-- 
1.8.4

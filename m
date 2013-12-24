From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:16:08 +0900
Subject: [PATCH 28/29] ARM: shmobile: r8a7791: Don't set plat_sci_port
 scbrr_algo_id field
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
Message-ID: <f72ed4beb198eb25c8532e76addc0034ae2aa8c7.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7791.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index f15b537..e28404e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -84,11 +84,10 @@ void __init r8a7791_pinmux_init(void)
 	r8a7791_register_gpio(7);
 }
 
-#define __R8A7791_SCIF(scif_type, algo, index, baseaddr, irq)		\
+#define __R8A7791_SCIF(scif_type, index, baseaddr, irq)			\
 static struct plat_sci_port scif##index##_platform_data = {		\
 	.type		= scif_type,					\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
-	.scbrr_algo_id	= algo,						\
 	.scscr		= SCSCR_RE | SCSCR_TE,				\
 };									\
 									\
@@ -98,13 +97,13 @@ static struct resource scif##index##_resources[] = {			\
 }
 
 #define R8A7791_SCIF(index, baseaddr, irq)				\
-	__R8A7791_SCIF(PORT_SCIF, SCBRR_ALGO_2, index, baseaddr, irq)
+	__R8A7791_SCIF(PORT_SCIF, index, baseaddr, irq)
 
 #define R8A7791_SCIFA(index, baseaddr, irq)				\
-	__R8A7791_SCIF(PORT_SCIFA, SCBRR_ALGO_4, index, baseaddr, irq)
+	__R8A7791_SCIF(PORT_SCIFA, index, baseaddr, irq)
 
 #define R8A7791_SCIFB(index, baseaddr, irq)				\
-	__R8A7791_SCIF(PORT_SCIFB, SCBRR_ALGO_4, index, baseaddr, irq)
+	__R8A7791_SCIF(PORT_SCIFB, index, baseaddr, irq)
 
 R8A7791_SCIFA(0,  0xe6c40000, gic_spi(144)); /* SCIFA0 */
 R8A7791_SCIFA(1,  0xe6c50000, gic_spi(145)); /* SCIFA1 */
-- 
1.8.4

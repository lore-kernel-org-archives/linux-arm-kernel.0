From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:12 +0900
Subject: [PATCH 07/26] ARM: shmobile: bockw: add pin pull-up setting for SDHI
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <79990c164dcc7514398ca824a609c74cb5f563da.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SDHI CD/WP pin needs pull-up

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw-reference.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index c7b217d..6586f5c 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -38,9 +38,13 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 #define FPGA	0x18200000
 #define IRQ0MR	0x30
 #define COMCTLR	0x101c
+
+#define PFC	0xfffc0000
+#define PUPR4	0x110
 static void __init bockw_init(void)
 {
 	void __iomem *fpga;
+	void __iomem *pfc;
 
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin_dt(1);
@@ -66,6 +70,17 @@ static void __init bockw_init(void)
 		iounmap(fpga);
 	}
 
+	pfc = ioremap_nocache(PFC, 0x200);
+	if (pfc) {
+		/*
+		 * FIXME
+		 *
+		 * SDHI CD/WP pin needs pull-up
+		 */
+		iowrite32(ioread32(pfc + PUPR4) | (3 << 26), pfc + PUPR4);
+		iounmap(pfc);
+	}
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.4

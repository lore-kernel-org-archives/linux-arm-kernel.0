From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:51:05 +0900
Subject: [PATCH 13/14] ARM: shmobile: bockw: add SMSC support on reference
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
Message-ID: <90357fcbf2fcb9e50899fd3b2a91a6dc3cfe5ea5.1381299817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables INTC IRQ, and SMSC IRQ.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw-reference.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 1a7c893..ae88fda 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -36,15 +36,35 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 				  "scif0_ctrl", "scif0"),
 };
 
+#define FPGA	0x18200000
+#define IRQ0MR	0x30
+#define COMCTLR	0x101c
 static void __init bockw_init(void)
 {
+	static void __iomem *fpga;
+
 	r8a7778_clock_init();
+	r8a7778_init_irq_extpin_dt(1);
 
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
 	r8a7778_add_dt_devices();
 
+	fpga = ioremap_nocache(FPGA, SZ_1M);
+	if (fpga) {
+		/*
+		 * CAUTION
+		 *
+		 * IRQ0/1 is cascaded interrupt from FPGA.
+		 * it should be cared in the future
+		 * Now, it is assuming IRQ0 was used only from SMSC.
+		 */
+		u16 val = ioread16(fpga + IRQ0MR);
+		val &= ~(1 << 4); /* enable SMSC911x */
+		iowrite16(val, fpga + IRQ0MR);
+	}
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.4

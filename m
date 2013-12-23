From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:11 +0900
Subject: [PATCH 06/26] ARM: shmobile: bockw: fixup FPGA ioremap area
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <b6d3eba338b4a24e49947fc45542fca7b76dda9a.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Don't keep FPGA ioremap area.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw-reference.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 1687df9..c7b217d 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -40,7 +40,7 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 #define COMCTLR	0x101c
 static void __init bockw_init(void)
 {
-	static void __iomem *fpga;
+	void __iomem *fpga;
 
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin_dt(1);
@@ -62,6 +62,8 @@ static void __init bockw_init(void)
 		u16 val = ioread16(fpga + IRQ0MR);
 		val &= ~(1 << 4); /* enable SMSC911x */
 		iowrite16(val, fpga + IRQ0MR);
+
+		iounmap(fpga);
 	}
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.8.4

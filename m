From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:37:05 +0900
Subject: [PATCH 05/12] ARM: shmobile: bockw: enable global use of FPGA
In-Reply-To: <cover.1380530519.git.horms+renesas@verge.net.au>
References: <cover.1380530519.git.horms+renesas@verge.net.au>
Message-ID: <71d7472f63385f4f6fb7c8548450b2e4665dc542.1380530519.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables global use of FPGA,
since it will be used from many devices.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 6b9faf3..b998c6b 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -38,6 +38,10 @@
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
 
+#define FPGA	0x18200000
+#define IRQ0MR	0x30
+static void __iomem *fpga;
+
 /*
  *	CN9(Upper side) SCIF/RCAN selection
  *
@@ -224,8 +228,6 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 				  "vin1_data8", "vin1"),
 };
 
-#define FPGA	0x18200000
-#define IRQ0MR	0x30
 #define PFC	0xfffc0000
 #define PUPR4	0x110
 static void __init bockw_init(void)
@@ -269,8 +271,8 @@ static void __init bockw_init(void)
 
 
 	/* for SMSC */
-	base = ioremap_nocache(FPGA, SZ_1M);
-	if (base) {
+	fpga = ioremap_nocache(FPGA, SZ_1M);
+	if (fpga) {
 		/*
 		 * CAUTION
 		 *
@@ -278,10 +280,9 @@ static void __init bockw_init(void)
 		 * it should be cared in the future
 		 * Now, it is assuming IRQ0 was used only from SMSC.
 		 */
-		u16 val = ioread16(base + IRQ0MR);
+		u16 val = ioread16(fpga + IRQ0MR);
 		val &= ~(1 << 4); /* enable SMSC911x */
-		iowrite16(val, base + IRQ0MR);
-		iounmap(base);
+		iowrite16(val, fpga + IRQ0MR);
 
 		regulator_register_fixed(0, dummy_supplies,
 					 ARRAY_SIZE(dummy_supplies));
-- 
1.8.4

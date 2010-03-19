From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Mar 2010 11:28:45 +0100
Subject: [PATCH 5/5] i.MX51: remove NFC AXI static mapping
In-Reply-To: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
References: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1268994525-32495-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This area contains the Nand Flash controller registers. There
is no need to map them statically as the Nand driver uses ioremap().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/mm.c                |    5 -----
 arch/arm/plat-mxc/include/mach/mx51.h |    9 ++-------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 9fe7beb..b7677ef 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -49,11 +49,6 @@ static struct map_desc mxc_io_desc[] __initdata = {
 		.pfn = __phys_to_pfn(MX51_AIPS2_BASE_ADDR),
 		.length = MX51_AIPS2_SIZE,
 		.type = MT_DEVICE
-	}, {
-		.virtual = MX51_NFC_AXI_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_NFC_AXI_BASE_ADDR),
-		.length = MX51_NFC_AXI_SIZE,
-		.type = MT_DEVICE
 	},
 };
 
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index fd255a9..5aad344 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -23,7 +23,7 @@
  *         	C8000000	64M	CS3 Flash
  *         	CC000000	32M	CS4 SRAM
  *         	CE000000	32M	CS5 SRAM
- * F9000000	CFFF0000	64K	NFC (NAND Flash AXI)
+ *		CFFF0000	64K	NFC (NAND Flash AXI)
  *
  */
 
@@ -46,7 +46,6 @@
  * NFC
  */
 #define MX51_NFC_AXI_BASE_ADDR		0xCFFF0000	/* NAND flash AXI */
-#define MX51_NFC_AXI_BASE_ADDR_VIRT	0xF9000000
 #define MX51_NFC_AXI_SIZE		SZ_64K
 
 /*
@@ -240,8 +239,7 @@
 	MX51_IS_MODULE(x, DEBUG) ? MX51_DEBUG_IO_ADDRESS(x) :	\
 	MX51_IS_MODULE(x, SPBA0) ? MX51_SPBA0_IO_ADDRESS(x) :	\
 	MX51_IS_MODULE(x, AIPS1) ? MX51_AIPS1_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, AIPS2) ? MX51_AIPS2_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, NFC_AXI) ? MX51_NFC_AXI_IO_ADDRESS(x) : \
+	MX51_IS_MODULE(x, AIPS2) ? MX51_AIPS2_IO_ADDRESS(x) : \
 	0xDEADBEEF)
 
 /*
@@ -262,9 +260,6 @@
 #define MX51_AIPS2_IO_ADDRESS(x)  \
 	(((x) - MX51_AIPS2_BASE_ADDR) + MX51_AIPS2_BASE_ADDR_VIRT)
 
-#define MX51_NFC_AXI_IO_ADDRESS(x) \
-	(((x) - MX51_NFC_AXI_BASE_ADDR) + MX51_NFC_AXI_BASE_ADDR_VIRT)
-
 #define MX51_IS_MEM_DEVICE_NONSHARED(x)		0
 
 /*
-- 
1.7.0

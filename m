From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  6 Aug 2017 11:44:02 +0900
Subject: [PATCH 2/2] reset: uniphier: do not use per-SoC macro for system
 reset block
In-Reply-To: <1501987442-2583-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501987442-2583-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1501987442-2583-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This macro turned out not so useful as I had expected.

Hardware engineers said they would change reset bit assignments for
every SoC going forward.  This means we can not share the macros
among SoCs.  Just use primitive macros.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/reset-uniphier.c | 48 +++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 3947fc2ef52c..954b2c4e6ca7 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -50,24 +50,6 @@ struct uniphier_reset_data {
 	}
 
 /* System reset data */
-#define UNIPHIER_LD11_SYS_RESET_NAND(id)		\
-	UNIPHIER_RESETX((id), 0x200c, 0)
-
-#define UNIPHIER_LD11_SYS_RESET_EMMC(id)		\
-	UNIPHIER_RESETX((id), 0x200c, 2)
-
-#define UNIPHIER_LD11_SYS_RESET_STDMAC(id)		\
-	UNIPHIER_RESETX((id), 0x200c, 8)
-
-#define UNIPHIER_PRO4_SYS_RESET_GIO(id)			\
-	UNIPHIER_RESETX((id), 0x2000, 6)
-
-#define UNIPHIER_LD20_SYS_RESET_GIO(id)			\
-	UNIPHIER_RESETX((id), 0x200c, 5)
-
-#define UNIPHIER_PRO4_SYS_RESET_USB3(id, ch)		\
-	UNIPHIER_RESETX((id), 0x2000 + 0x4 * (ch), 17)
-
 static const struct uniphier_reset_data uniphier_ld4_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
 	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (Ether, HSC, MIO) */
@@ -77,26 +59,26 @@ static const struct uniphier_reset_data uniphier_ld4_sys_reset_data[] = {
 static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
 	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (HSC, MIO, RLE) */
-	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* Ether, SATA, USB3 */
-	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
-	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
+	UNIPHIER_RESETX(12, 0x2000, 6),		/* GIO (Ether, SATA, USB3) */
+	UNIPHIER_RESETX(14, 0x2000, 17),	/* USB30 */
+	UNIPHIER_RESETX(15, 0x2004, 17),	/* USB31 */
 	UNIPHIER_RESET_END,
 };
 
 static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
 	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (HSC) */
-	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* PCIe, USB3 */
-	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
-	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
+	UNIPHIER_RESETX(12, 0x2000, 6),		/* GIO (PCIe, USB3) */
+	UNIPHIER_RESETX(14, 0x2000, 17),	/* USB30 */
+	UNIPHIER_RESETX(15, 0x2004, 17),	/* USB31 */
 	UNIPHIER_RESET_END,
 };
 
 static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
 	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (HSC, RLE) */
-	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
-	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
+	UNIPHIER_RESETX(14, 0x2000, 17),	/* USB30 */
+	UNIPHIER_RESETX(15, 0x2004, 17),	/* USB31 */
 	UNIPHIER_RESETX(16, 0x2014, 4),		/* USB30-PHY0 */
 	UNIPHIER_RESETX(17, 0x2014, 0),		/* USB30-PHY1 */
 	UNIPHIER_RESETX(18, 0x2014, 2),		/* USB30-PHY2 */
@@ -108,17 +90,17 @@ static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
 };
 
 static const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
-	UNIPHIER_LD11_SYS_RESET_NAND(2),
-	UNIPHIER_LD11_SYS_RESET_EMMC(4),
-	UNIPHIER_LD11_SYS_RESET_STDMAC(8),	/* HSC, MIO */
+	UNIPHIER_RESETX(2, 0x200c, 0),		/* NAND */
+	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
+	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC, MIO) */
 	UNIPHIER_RESET_END,
 };
 
 static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
-	UNIPHIER_LD11_SYS_RESET_NAND(2),
-	UNIPHIER_LD11_SYS_RESET_EMMC(4),
-	UNIPHIER_LD11_SYS_RESET_STDMAC(8),	/* HSC */
-	UNIPHIER_LD20_SYS_RESET_GIO(12),	/* PCIe, USB3 */
+	UNIPHIER_RESETX(2, 0x200c, 0),		/* NAND */
+	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
+	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC) */
+	UNIPHIER_RESETX(12, 0x200c, 5),		/* GIO (PCIe, USB3) */
 	UNIPHIER_RESETX(16, 0x200c, 12),	/* USB30-PHY0 */
 	UNIPHIER_RESETX(17, 0x200c, 13),	/* USB30-PHY1 */
 	UNIPHIER_RESETX(18, 0x200c, 14),	/* USB30-PHY2 */
-- 
2.7.4

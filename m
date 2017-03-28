From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 28 Mar 2017 17:40:08 +0900
Subject: [PATCH] reset: uniphier: add NAND and eMMC reset control
Message-ID: <1490690408-2616-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset lines for the Denali NAND controller on all UniPhier SoCs,
for the Cadence eMMC controller on LD11/LD20 SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Philipp,

Sorry for sending this in the last minute.
If it is not too late, please apply this for 4.12-rc1.
Thanks!


 drivers/reset/reset-uniphier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 7af60bc..c4ba898 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -50,6 +50,15 @@ struct uniphier_reset_data {
 	}
 
 /* System reset data */
+#define UNIPHIER_SLD3_SYS_RESET_NAND(id)		\
+	UNIPHIER_RESETX((id), 0x2004, 2)
+
+#define UNIPHIER_LD11_SYS_RESET_NAND(id)		\
+	UNIPHIER_RESETX((id), 0x200c, 0)
+
+#define UNIPHIER_LD11_SYS_RESET_EMMC(id)		\
+	UNIPHIER_RESETX((id), 0x200c, 2)
+
 #define UNIPHIER_SLD3_SYS_RESET_STDMAC(id)		\
 	UNIPHIER_RESETX((id), 0x2000, 10)
 
@@ -66,11 +75,13 @@ struct uniphier_reset_data {
 	UNIPHIER_RESETX((id), 0x2000 + 0x4 * (ch), 17)
 
 static const struct uniphier_reset_data uniphier_sld3_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_NAND(2),
 	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* Ether, HSC, MIO */
 	UNIPHIER_RESET_END,
 };
 
 static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_NAND(2),
 	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC, MIO, RLE */
 	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
@@ -79,6 +90,7 @@ static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
 };
 
 static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_NAND(2),
 	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC */
 	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* PCIe, USB3 */
 	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
@@ -87,6 +99,7 @@ static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
 };
 
 static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_NAND(2),
 	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC, RLE */
 	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
@@ -101,11 +114,15 @@ static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
 };
 
 static const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
+	UNIPHIER_LD11_SYS_RESET_NAND(2),
+	UNIPHIER_LD11_SYS_RESET_EMMC(4),
 	UNIPHIER_LD11_SYS_RESET_STDMAC(8),	/* HSC, MIO */
 	UNIPHIER_RESET_END,
 };
 
 static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
+	UNIPHIER_LD11_SYS_RESET_NAND(2),
+	UNIPHIER_LD11_SYS_RESET_EMMC(4),
 	UNIPHIER_LD11_SYS_RESET_STDMAC(8),	/* HSC */
 	UNIPHIER_LD20_SYS_RESET_GIO(12),	/* PCIe, USB3 */
 	UNIPHIER_RESETX(16, 0x200c, 12),	/* USB30-PHY0 */
-- 
2.7.4

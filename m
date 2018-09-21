From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 21 Sep 2018 12:07:35 +0800
Subject: [PATCH 1/4] pinctrl: mediatek: fix static checker warning caused by
 EINT_NA
Message-ID: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

EINT_NA is an u16 number, so it should be U16_MAX instead of -1
to fix up drivers/pinctrl/mediatek/pinctrl-paris.c:732 mtk_gpio_to_irq()
warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))

Also happens in
drivers/pinctrl/mediatek/pinctrl-paris.c:749 mtk_gpio_set_config()
warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))

drivers/pinctrl/mediatek/pinctrl-moore.c:479 mtk_gpio_to_irq()
warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))

drivers/pinctrl/mediatek/pinctrl-moore.c:496 mtk_gpio_set_config()
warn: impossible condition '(desc->eint.eint_n == -1) => (0-u16max == (-1))

Fixes: 6561859b067f ("pinctrl: mediatek: add eint support to MT8183 pinctrl driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 10d33ec..b618042 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -18,7 +18,7 @@
 #define MTK_PULLDOWN   0
 #define MTK_PULLUP     1
 
-#define EINT_NA	-1
+#define EINT_NA	U16_MAX
 
 #define PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs,      \
 		       _s_bit, _x_bits, _sz_reg, _fixed) {		\
-- 
2.7.4

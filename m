From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jun 2016 17:18:34 +0200
Subject: [PATCH 1/2] pinctrl: fix incorrect inline keyword in multiple drivers
Message-ID: <1465831250-2689101-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with 'make W=1', we get harmless warnings about
five drivers in drivers/pinctrl, which all contain a copy of
the same line:

drivers/pinctrl/freescale/pinctrl-imx1-core.c:160:1: error: 'inline' is not at beginning of declaration [-Werror=old-style-declaration]

This replaces the somewhat nonstandard 'static const inline'
with 'static inline const', which has the same meaning but
does not cause this warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/freescale/pinctrl-imx.c       | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx1-core.c | 2 +-
 drivers/pinctrl/pinctrl-at91.c                | 2 +-
 drivers/pinctrl/pinctrl-rockchip.c            | 2 +-
 drivers/pinctrl/pinctrl-st.c                  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 309d31d61390..491d2d244f56 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -46,7 +46,7 @@ struct imx_pinctrl {
 	const struct imx_pinctrl_soc_info *info;
 };
 
-static const inline struct imx_pin_group *imx_pinctrl_find_group_by_name(
+static inline const struct imx_pin_group *imx_pinctrl_find_group_by_name(
 				const struct imx_pinctrl_soc_info *info,
 				const char *name)
 {
diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
index b4400cb19b61..38d39388d7a4 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -157,7 +157,7 @@ static int imx1_read_bit(struct imx1_pinctrl *ipctl, unsigned int pin_id,
 	return !!(readl(reg) & BIT(offset));
 }
 
-static const inline struct imx1_pin_group *imx1_pinctrl_find_group_by_name(
+static inline const struct imx1_pin_group *imx1_pinctrl_find_group_by_name(
 				const struct imx1_pinctrl_soc_info *info,
 				const char *name)
 {
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index b7c0d6f7c046..2ce429cf41e6 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -189,7 +189,7 @@ struct at91_pinctrl {
 	struct at91_pinctrl_mux_ops *ops;
 };
 
-static const inline struct at91_pin_group *at91_pinctrl_find_group_by_name(
+static inline const struct at91_pin_group *at91_pinctrl_find_group_by_name(
 				const struct at91_pinctrl *info,
 				const char *name)
 {
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index a91026e8cd7c..a2337b7dfc41 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -360,7 +360,7 @@ static struct regmap_config rockchip_regmap_config = {
 	.reg_stride = 4,
 };
 
-static const inline struct rockchip_pin_group *pinctrl_name_to_group(
+static inline const struct rockchip_pin_group *pinctrl_name_to_group(
 					const struct rockchip_pinctrl *info,
 					const char *name)
 {
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index d0ba968af5bb..0de1c67dfb94 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -844,7 +844,7 @@ static int st_pctl_get_group_pins(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static const inline struct st_pctl_group *st_pctl_find_group_by_name(
+static inline const struct st_pctl_group *st_pctl_find_group_by_name(
 	const struct st_pinctrl *info, const char *name)
 {
 	int i;
-- 
2.7.0

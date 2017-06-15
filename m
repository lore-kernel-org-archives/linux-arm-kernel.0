From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 15 Jun 2017 18:33:15 +0200
Subject: [PATCH 1/2] pinctrl: samsung: Use unsigned int for number of
 controller IO mem resources
Message-ID: <20170615163316.6444-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Number of IO memory resources cannot be negative obviously and the
driver depends silently on this (by iterating from 0 to
nr_ext_resources+1).  Make this requirement explicit.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 86c98c1dec3a..c7ac2b944f57 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -960,7 +960,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 	struct samsung_pin_bank *bank;
 	struct resource *res;
 	void __iomem *virt_base[SAMSUNG_PINCTRL_NUM_RESOURCES];
-	int i;
+	unsigned int i;
 
 	id = of_alias_get_id(node, "pinctrl");
 	if (id < 0) {
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 15b26c786b1e..49a05f4fc37d 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -231,7 +231,7 @@ struct samsung_retention_data {
 struct samsung_pin_ctrl {
 	const struct samsung_pin_bank_data *pin_banks;
 	u32		nr_banks;
-	int		nr_ext_resources;
+	unsigned int	nr_ext_resources;
 	const struct samsung_retention_data *retention_data;
 
 	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
-- 
2.9.3

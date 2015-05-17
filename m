From: carlo@caione.org (Carlo Caione)
Date: Sun, 17 May 2015 17:57:38 +0200
Subject: [PATCH] pinctrl: Fix gpio/pin mapping for Meson8b
Message-ID: <1431878258-10229-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

The num_pins field in the struct meson_domain_data must include also the
missing pins in the Meson8b SoC, otherwise the GPIO <-> pin mapping is
broken on this platform. Avoid also the dinamic allocation for GPIOs.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c   | 2 +-
 drivers/pinctrl/meson/pinctrl-meson8b.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index edcd140..a70a5fe 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -569,7 +569,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 		domain->chip.direction_output = meson_gpio_direction_output;
 		domain->chip.get = meson_gpio_get;
 		domain->chip.set = meson_gpio_set;
-		domain->chip.base = -1;
+		domain->chip.base = domain->data->pin_base;
 		domain->chip.ngpio = domain->data->num_pins;
 		domain->chip.can_sleep = false;
 		domain->chip.of_node = domain->of_node;
diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 2f7ea62..9677807 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -876,13 +876,13 @@ static struct meson_domain_data meson8b_domain_data[] = {
 		.banks		= meson8b_banks,
 		.num_banks	= ARRAY_SIZE(meson8b_banks),
 		.pin_base	= 0,
-		.num_pins	= 83,
+		.num_pins	= 130,
 	},
 	{
 		.name		= "ao-bank",
 		.banks		= meson8b_ao_banks,
 		.num_banks	= ARRAY_SIZE(meson8b_ao_banks),
-		.pin_base	= 83,
+		.pin_base	= 130,
 		.num_pins	= 16,
 	},
 };
-- 
1.9.1

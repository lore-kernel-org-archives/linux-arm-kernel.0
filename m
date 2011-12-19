From: holger.brunck@keymile.com (Holger Brunck)
Date: Mon, 19 Dec 2011 17:49:48 +0100
Subject: [PATCH] arm/plat-orion: make gpiochip label unique
Message-ID: <1324313388-16703-1-git-send-email-holger.brunck@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The former implementation adds a fix gpiochip label string
to the framework. This is confusing because orion_gpio_init
is called more than once and this ends up in different gpiochips
with the same label.

This patch adds the already present orion_gpio_chip_count to the
label string to make it unique in the system.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/plat-orion/gpio.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 41ab97e..10d1608 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -384,12 +384,16 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
 	struct orion_gpio_chip *ochip;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	char gc_label[16];
 
 	if (orion_gpio_chip_count == ARRAY_SIZE(orion_gpio_chips))
 		return;
 
+	snprintf(gc_label, sizeof(gc_label), "orion_gpio%d",
+		orion_gpio_chip_count);
+
 	ochip = orion_gpio_chips + orion_gpio_chip_count;
-	ochip->chip.label = "orion_gpio";
+	ochip->chip.label = kstrdup(gc_label, GFP_KERNEL);
 	ochip->chip.request = orion_gpio_request;
 	ochip->chip.direction_input = orion_gpio_direction_input;
 	ochip->chip.get = orion_gpio_get;
-- 
1.7.1

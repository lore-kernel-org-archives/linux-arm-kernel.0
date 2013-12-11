From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 04:26:22 +0100
Subject: [PATCH 02/10] sh-pfc: Terminate gpios array by -1
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1386732390-31724-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0 is a valid GPIO value, use -1 to terminate the gpios array in IRQ
lists.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/gpio.c   | 4 ++--
 drivers/pinctrl/sh-pfc/sh_pfc.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 3d30e6e..c24be81 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -207,9 +207,9 @@ static int gpio_pin_to_irq(struct gpio_chip *gc, unsigned offset)
 	unsigned int i, k;
 
 	for (i = 0; i < pfc->info->gpio_irq_size; i++) {
-		unsigned short *gpios = pfc->info->gpio_irq[i].gpios;
+		short *gpios = pfc->info->gpio_irq[i].gpios;
 
-		for (k = 0; gpios[k]; k++) {
+		for (k = 0; gpios[k] >= 0; k++) {
 			if (gpios[k] == offset)
 				return pfc->info->gpio_irq[i].irq;
 		}
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 11bd0d9..cd040e0 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -94,11 +94,11 @@ struct pinmux_data_reg {
 
 struct pinmux_irq {
 	int irq;
-	unsigned short *gpios;
+	short *gpios;
 };
 
 #define PINMUX_IRQ(irq_nr, ids...)			   \
-	{ .irq = irq_nr, .gpios = (unsigned short []) { ids, 0 } }	\
+	{ .irq = irq_nr, .gpios = (short []) { ids, -1 } }
 
 struct pinmux_range {
 	u16 begin;
-- 
1.8.3.2

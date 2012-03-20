From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Tue, 20 Mar 2012 16:23:14 +0530
Subject: [PATCH v4 RESEND 2/7] gpio/omap: fix trigger type to unsigned
In-Reply-To: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1332240799-6748-3-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO trigger parameter is of type unsigned.
enum {
        IRQ_TYPE_NONE           = 0x00000000,
        IRQ_TYPE_EDGE_RISING    = 0x00000001,
        IRQ_TYPE_EDGE_FALLING   = 0x00000002,
        IRQ_TYPE_EDGE_BOTH      = (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING),
        IRQ_TYPE_LEVEL_HIGH     = 0x00000004,
        IRQ_TYPE_LEVEL_LOW      = 0x00000008,
        IRQ_TYPE_LEVEL_MASK     = (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH),
        IRQ_TYPE_SENSE_MASK     = 0x0000000f,

        IRQ_TYPE_PROBE          = 0x00000010,
...
};
Even though gpio_irq_type(struct irq_data *d, unsigned type) has the right type
of parameter, the subsequent called functions set_gpio_triggering() and
set_gpio_trigger() wrongly makes it signed integer. Fix this.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1a144ac..2042857 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -245,7 +245,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
-						int trigger)
+						unsigned trigger)
 {
 	void __iomem *base = bank->base;
 	u32 gpio_bit = 1 << gpio;
@@ -327,7 +327,8 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio) {}
 #endif
 
-static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
+static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
+							unsigned trigger)
 {
 	void __iomem *reg = bank->base;
 	void __iomem *base = bank->base;
-- 
1.7.0.4

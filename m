From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 04:26:25 +0100
Subject: [PATCH 05/10] sh-pfc: Rename sh_pfc window field to windows
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1386732390-31724-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's more than one window, name the field windows.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c        | 19 ++++++++++---------
 drivers/pinctrl/sh-pfc/core.h        |  2 +-
 drivers/pinctrl/sh-pfc/gpio.c        |  4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  8 ++++----
 7 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 06e648b..7831f07 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -34,20 +34,21 @@ static int sh_pfc_ioremap(struct sh_pfc *pfc, struct platform_device *pdev)
 	if (pdev->num_resources == 0)
 		return -EINVAL;
 
-	pfc->window = devm_kzalloc(pfc->dev, pdev->num_resources *
-				   sizeof(*pfc->window), GFP_NOWAIT);
-	if (!pfc->window)
+	pfc->windows = devm_kzalloc(pfc->dev, pdev->num_resources *
+				    sizeof(*pfc->windows), GFP_NOWAIT);
+	if (!pfc->windows)
 		return -ENOMEM;
 
 	pfc->num_windows = pdev->num_resources;
 
 	for (k = 0, res = pdev->resource; k < pdev->num_resources; k++, res++) {
 		WARN_ON(resource_type(res) != IORESOURCE_MEM);
-		pfc->window[k].phys = res->start;
-		pfc->window[k].size = resource_size(res);
-		pfc->window[k].virt = devm_ioremap_nocache(pfc->dev, res->start,
-							   resource_size(res));
-		if (!pfc->window[k].virt)
+		pfc->windows[k].phys = res->start;
+		pfc->windows[k].size = resource_size(res);
+		pfc->windows[k].virt =
+			devm_ioremap_nocache(pfc->dev, res->start,
+					     resource_size(res));
+		if (!pfc->windows[k].virt)
 			return -ENOMEM;
 	}
 
@@ -62,7 +63,7 @@ static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
 
 	/* scan through physical windows and convert address */
 	for (i = 0; i < pfc->num_windows; i++) {
-		window = pfc->window + i;
+		window = pfc->windows + i;
 
 		if (address < window->phys)
 			continue;
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 11ea872..a83b747 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -37,7 +37,7 @@ struct sh_pfc {
 	spinlock_t lock;
 
 	unsigned int num_windows;
-	struct sh_pfc_window *window;
+	struct sh_pfc_window *windows;
 
 	struct sh_pfc_pin_range *ranges;
 	unsigned int nr_ranges;
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index c24be81..6a21349 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -347,7 +347,7 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	 * GPIOs.
 	 */
 	for (i = 0; i < pfc->num_windows; ++i) {
-		struct sh_pfc_window *window = &pfc->window[i];
+		struct sh_pfc_window *window = &pfc->windows[i];
 
 		if (pfc->info->data_regs[0].reg >= window->phys &&
 		    pfc->info->data_regs[0].reg < window->phys + window->size)
@@ -358,7 +358,7 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 		return 0;
 
 	/* Register the real GPIOs chip. */
-	chip = sh_pfc_add_gpiochip(pfc, gpio_pin_setup, &pfc->window[i]);
+	chip = sh_pfc_add_gpiochip(pfc, gpio_pin_setup, &pfc->windows[i]);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index d25fd4e..5401cd7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -2691,7 +2691,7 @@ static unsigned int r8a73a4_pinmux_get_bias(struct sh_pfc *pfc,
 {
 	void __iomem *addr;
 
-	addr = pfc->window->virt + r8a73a4_portcr_offsets[pin >> 5] + pin;
+	addr = pfc->windows->virt + r8a73a4_portcr_offsets[pin >> 5] + pin;
 
 	switch (ioread8(addr) & PORTCR_PULMD_MASK) {
 	case PORTCR_PULMD_UP:
@@ -2710,7 +2710,7 @@ static void r8a73a4_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 	void __iomem *addr;
 	u32 value;
 
-	addr = pfc->window->virt + r8a73a4_portcr_offsets[pin >> 5] + pin;
+	addr = pfc->windows->virt + r8a73a4_portcr_offsets[pin >> 5] + pin;
 	value = ioread8(addr) & ~PORTCR_PULMD_MASK;
 
 	switch (bias) {
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 009174d..36e1b76 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3721,7 +3721,7 @@ static void __iomem *r8a7740_pinmux_portcr(struct sh_pfc *pfc, unsigned int pin)
 			&r8a7740_portcr_offsets[i];
 
 		if (i <= group->end_pin)
-			return pfc->window->virt + group->offset + pin;
+			return pfc->windows->virt + group->offset + pin;
 	}
 
 	return NULL;
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 70b522d..d97bb0c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -2585,7 +2585,7 @@ static void __iomem *sh7372_pinmux_portcr(struct sh_pfc *pfc, unsigned int pin)
 			&sh7372_portcr_offsets[i];
 
 		if (i <= group->end_pin)
-			return pfc->window->virt + group->offset + pin;
+			return pfc->windows->virt + group->offset + pin;
 	}
 
 	return NULL;
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index d6c57dd..995bb69 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3702,7 +3702,7 @@ static const struct pinmux_irq pinmux_irqs[] = {
 static void sh73a0_vccq_mc0_endisable(struct regulator_dev *reg, bool enable)
 {
 	struct sh_pfc *pfc = reg->reg_data;
-	void __iomem *addr = pfc->window[1].virt + 4;
+	void __iomem *addr = pfc->windows[1].virt + 4;
 	unsigned long flags;
 	u32 value;
 
@@ -3735,7 +3735,7 @@ static int sh73a0_vccq_mc0_disable(struct regulator_dev *reg)
 static int sh73a0_vccq_mc0_is_enabled(struct regulator_dev *reg)
 {
 	struct sh_pfc *pfc = reg->reg_data;
-	void __iomem *addr = pfc->window[1].virt + 4;
+	void __iomem *addr = pfc->windows[1].virt + 4;
 	unsigned long flags;
 	u32 value;
 
@@ -3794,7 +3794,7 @@ static const unsigned int sh73a0_portcr_offsets[] = {
 
 static unsigned int sh73a0_pinmux_get_bias(struct sh_pfc *pfc, unsigned int pin)
 {
-	void __iomem *addr = pfc->window->virt
+	void __iomem *addr = pfc->windows->virt
 			   + sh73a0_portcr_offsets[pin >> 5] + pin;
 	u32 value = ioread8(addr) & PORTnCR_PULMD_MASK;
 
@@ -3812,7 +3812,7 @@ static unsigned int sh73a0_pinmux_get_bias(struct sh_pfc *pfc, unsigned int pin)
 static void sh73a0_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 				   unsigned int bias)
 {
-	void __iomem *addr = pfc->window->virt
+	void __iomem *addr = pfc->windows->virt
 			   + sh73a0_portcr_offsets[pin >> 5] + pin;
 	u32 value = ioread8(addr) & ~PORTnCR_PULMD_MASK;
 
-- 
1.8.3.2

From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:10 +0100
Subject: [PATCH 38/54] ARM: PXA SoCs: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134110.GM15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-pxa/balloon3.c          |   23 +++++++++++-------
 arch/arm/mach-pxa/cm-x2xx-pci.c       |    2 +-
 arch/arm/mach-pxa/generic.h           |    4 ++-
 arch/arm/mach-pxa/irq.c               |   42 ++++++++++++++++----------------
 arch/arm/mach-pxa/lpd270.c            |   17 +++++++------
 arch/arm/mach-pxa/lubbock.c           |   17 +++++++------
 arch/arm/mach-pxa/mainstone.c         |   17 +++++++------
 arch/arm/mach-pxa/pcm990-baseboard.c  |   15 ++++++-----
 arch/arm/mach-pxa/pxa25x.c            |    7 +++--
 arch/arm/mach-pxa/pxa27x.c            |    9 ++++---
 arch/arm/mach-pxa/pxa3xx.c            |   36 ++++++++++++++--------------
 arch/arm/mach-pxa/viper.c             |   22 ++++++++--------
 arch/arm/mach-pxa/zeus.c              |   22 ++++++++--------
 arch/arm/plat-pxa/gpio.c              |   28 +++++++++++-----------
 arch/arm/plat-pxa/include/plat/gpio.h |    4 ++-
 15 files changed, 140 insertions(+), 125 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 21e1889..e9352b9 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -477,25 +477,25 @@ static inline void balloon3_leds_init(void) {}
 /******************************************************************************
  * FPGA IRQ
  ******************************************************************************/
-static void balloon3_mask_irq(unsigned int irq)
+static void balloon3_mask_irq(struct irq_data *d)
 {
-	int balloon3_irq = (irq - BALLOON3_IRQ(0));
+	int balloon3_irq = (d->irq - BALLOON3_IRQ(0));
 	balloon3_irq_enabled &= ~(1 << balloon3_irq);
 	__raw_writel(~balloon3_irq_enabled, BALLOON3_INT_CONTROL_REG);
 }
 
-static void balloon3_unmask_irq(unsigned int irq)
+static void balloon3_unmask_irq(struct irq_data *d)
 {
-	int balloon3_irq = (irq - BALLOON3_IRQ(0));
+	int balloon3_irq = (d->irq - BALLOON3_IRQ(0));
 	balloon3_irq_enabled |= (1 << balloon3_irq);
 	__raw_writel(~balloon3_irq_enabled, BALLOON3_INT_CONTROL_REG);
 }
 
 static struct irq_chip balloon3_irq_chip = {
 	.name		= "FPGA",
-	.ack		= balloon3_mask_irq,
-	.mask		= balloon3_mask_irq,
-	.unmask		= balloon3_unmask_irq,
+	.irq_ack	= balloon3_mask_irq,
+	.irq_mask	= balloon3_mask_irq,
+	.irq_unmask	= balloon3_unmask_irq,
 };
 
 static void balloon3_irq_handler(unsigned int irq, struct irq_desc *desc)
@@ -504,8 +504,13 @@ static void balloon3_irq_handler(unsigned int irq, struct irq_desc *desc)
 					balloon3_irq_enabled;
 	do {
 		/* clear useless edge notification */
-		if (desc->chip->ack)
-			desc->chip->ack(BALLOON3_AUX_NIRQ);
+		if (desc->irq_data.chip->irq_ack) {
+			struct irq_data *d;
+
+			d = irq_get_irq_data(BALLOON3_AUX_NIRQ);
+			desc->irq_data.chip->irq_ack(d);
+		}
+
 		while (pending) {
 			irq = BALLOON3_IRQ(0) + __ffs(pending);
 			generic_handle_irq(irq);
diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
index 0f31305..a2380cd 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -59,7 +59,7 @@ void __init cmx2xx_pci_adjust_zones(unsigned long *zone_size,
 static void cmx2xx_it8152_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
 	/* clear our parent irq */
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	it8152_irq_demux(irq, desc);
 }
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 4b1ad27..3842608 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -9,11 +9,13 @@
  * published by the Free Software Foundation.
  */
 
+struct irq_data;
 struct sys_timer;
 
 extern struct sys_timer pxa_timer;
 extern void __init pxa_init_irq(int irq_nr,
-				int (*set_wake)(unsigned int, unsigned int));
+				int (*set_wake)(struct irq_data *,
+						unsigned int));
 extern void __init pxa25x_init_irq(void);
 #ifdef CONFIG_CPU_PXA26x
 extern void __init pxa26x_init_irq(void);
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 1beb40f..fd59b64 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -37,29 +37,29 @@
 
 static int pxa_internal_irq_nr;
 
-static void pxa_mask_irq(unsigned int irq)
+static void pxa_mask_irq(struct irq_data *d)
 {
-	_ICMR(irq) &= ~(1 << IRQ_BIT(irq));
+	_ICMR(d->irq) &= ~(1 << IRQ_BIT(d->irq));
 }
 
-static void pxa_unmask_irq(unsigned int irq)
+static void pxa_unmask_irq(struct irq_data *d)
 {
-	_ICMR(irq) |= 1 << IRQ_BIT(irq);
+	_ICMR(d->irq) |= 1 << IRQ_BIT(d->irq);
 }
 
 static struct irq_chip pxa_internal_irq_chip = {
 	.name		= "SC",
-	.ack		= pxa_mask_irq,
-	.mask		= pxa_mask_irq,
-	.unmask		= pxa_unmask_irq,
+	.irq_ack	= pxa_mask_irq,
+	.irq_mask	= pxa_mask_irq,
+	.irq_unmask	= pxa_unmask_irq,
 };
 
 /*
  * GPIO IRQs for GPIO 0 and 1
  */
-static int pxa_set_low_gpio_type(unsigned int irq, unsigned int type)
+static int pxa_set_low_gpio_type(struct irq_data *d, unsigned int type)
 {
-	int gpio = irq - IRQ_GPIO0;
+	int gpio = d->irq - IRQ_GPIO0;
 
 	if (__gpio_is_occupied(gpio)) {
 		pr_err("%s failed: GPIO is configured\n", __func__);
@@ -79,27 +79,27 @@ static int pxa_set_low_gpio_type(unsigned int irq, unsigned int type)
 	return 0;
 }
 
-static void pxa_ack_low_gpio(unsigned int irq)
+static void pxa_ack_low_gpio(struct irq_data *d)
 {
-	GEDR0 = (1 << (irq - IRQ_GPIO0));
+	GEDR0 = (1 << (d->irq - IRQ_GPIO0));
 }
 
-static void pxa_mask_low_gpio(unsigned int irq)
+static void pxa_mask_low_gpio(struct irq_data *d)
 {
-	ICMR &= ~(1 << (irq - PXA_IRQ(0)));
+	ICMR &= ~(1 << (d->irq - PXA_IRQ(0)));
 }
 
-static void pxa_unmask_low_gpio(unsigned int irq)
+static void pxa_unmask_low_gpio(struct irq_data *d)
 {
-	ICMR |= 1 << (irq - PXA_IRQ(0));
+	ICMR |= 1 << (d->irq - PXA_IRQ(0));
 }
 
 static struct irq_chip pxa_low_gpio_chip = {
 	.name		= "GPIO-l",
-	.ack		= pxa_ack_low_gpio,
-	.mask		= pxa_mask_low_gpio,
-	.unmask		= pxa_unmask_low_gpio,
-	.set_type	= pxa_set_low_gpio_type,
+	.irq_ack	= pxa_ack_low_gpio,
+	.irq_mask	= pxa_mask_low_gpio,
+	.irq_unmask	= pxa_unmask_low_gpio,
+	.irq_set_type	= pxa_set_low_gpio_type,
 };
 
 static void __init pxa_init_low_gpio_irq(set_wake_t fn)
@@ -117,7 +117,7 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)
 		set_irq_flags(irq, IRQF_VALID);
 	}
 
-	pxa_low_gpio_chip.set_wake = fn;
+	pxa_low_gpio_chip.irq_set_wake = fn;
 }
 
 void __init pxa_init_irq(int irq_nr, set_wake_t fn)
@@ -148,7 +148,7 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
 		set_irq_flags(irq, IRQF_VALID);
 	}
 
-	pxa_internal_irq_chip.set_wake = fn;
+	pxa_internal_irq_chip.irq_set_wake = fn;
 	pxa_init_low_gpio_irq(fn);
 }
 
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 623af02..cdc402f 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -94,9 +94,9 @@ static unsigned long lpd270_pin_config[] __initdata = {
 
 static unsigned int lpd270_irq_enabled;
 
-static void lpd270_mask_irq(unsigned int irq)
+static void lpd270_mask_irq(struct irq_data *d)
 {
-	int lpd270_irq = irq - LPD270_IRQ(0);
+	int lpd270_irq = d->irq - LPD270_IRQ(0);
 
 	__raw_writew(~(1 << lpd270_irq), LPD270_INT_STATUS);
 
@@ -104,9 +104,9 @@ static void lpd270_mask_irq(unsigned int irq)
 	__raw_writew(lpd270_irq_enabled, LPD270_INT_MASK);
 }
 
-static void lpd270_unmask_irq(unsigned int irq)
+static void lpd270_unmask_irq(struct irq_data *d)
 {
-	int lpd270_irq = irq - LPD270_IRQ(0);
+	int lpd270_irq = d->irq - LPD270_IRQ(0);
 
 	lpd270_irq_enabled |= 1 << lpd270_irq;
 	__raw_writew(lpd270_irq_enabled, LPD270_INT_MASK);
@@ -114,9 +114,9 @@ static void lpd270_unmask_irq(unsigned int irq)
 
 static struct irq_chip lpd270_irq_chip = {
 	.name		= "CPLD",
-	.ack		= lpd270_mask_irq,
-	.mask		= lpd270_mask_irq,
-	.unmask		= lpd270_unmask_irq,
+	.irq_ack	= lpd270_mask_irq,
+	.irq_mask	= lpd270_mask_irq,
+	.irq_unmask	= lpd270_unmask_irq,
 };
 
 static void lpd270_irq_handler(unsigned int irq, struct irq_desc *desc)
@@ -125,7 +125,8 @@ static void lpd270_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 	pending = __raw_readw(LPD270_INT_STATUS) & lpd270_irq_enabled;
 	do {
-		desc->chip->ack(irq);	/* clear useless edge notification */
+		/* clear useless edge notification */
+		desc->irq_data.chip->irq_ack(&desc->irq_data);
 		if (likely(pending)) {
 			irq = LPD270_IRQ(0) + __ffs(pending);
 			generic_handle_irq(irq);
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 1499493..3ee1b39 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -121,15 +121,15 @@ EXPORT_SYMBOL(lubbock_set_misc_wr);
 
 static unsigned long lubbock_irq_enabled;
 
-static void lubbock_mask_irq(unsigned int irq)
+static void lubbock_mask_irq(struct irq_data *d)
 {
-	int lubbock_irq = (irq - LUBBOCK_IRQ(0));
+	int lubbock_irq = (d->irq - LUBBOCK_IRQ(0));
 	LUB_IRQ_MASK_EN = (lubbock_irq_enabled &= ~(1 << lubbock_irq));
 }
 
-static void lubbock_unmask_irq(unsigned int irq)
+static void lubbock_unmask_irq(struct irq_data *d)
 {
-	int lubbock_irq = (irq - LUBBOCK_IRQ(0));
+	int lubbock_irq = (d->irq - LUBBOCK_IRQ(0));
 	/* the irq can be acknowledged only if deasserted, so it's done here */
 	LUB_IRQ_SET_CLR &= ~(1 << lubbock_irq);
 	LUB_IRQ_MASK_EN = (lubbock_irq_enabled |= (1 << lubbock_irq));
@@ -137,16 +137,17 @@ static void lubbock_unmask_irq(unsigned int irq)
 
 static struct irq_chip lubbock_irq_chip = {
 	.name		= "FPGA",
-	.ack		= lubbock_mask_irq,
-	.mask		= lubbock_mask_irq,
-	.unmask		= lubbock_unmask_irq,
+	.irq_ack	= lubbock_mask_irq,
+	.irq_mask	= lubbock_mask_irq,
+	.irq_unmask	= lubbock_unmask_irq,
 };
 
 static void lubbock_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned long pending = LUB_IRQ_SET_CLR & lubbock_irq_enabled;
 	do {
-		desc->chip->ack(irq);	/* clear our parent irq */
+		/* clear our parent irq */
+		desc->irq_data.chip->irq_ack(&desc->irq_data);
 		if (likely(pending)) {
 			irq = LUBBOCK_IRQ(0) + __ffs(pending);
 			generic_handle_irq(irq);
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index a980a5c..0591239 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -122,15 +122,15 @@ static unsigned long mainstone_pin_config[] = {
 
 static unsigned long mainstone_irq_enabled;
 
-static void mainstone_mask_irq(unsigned int irq)
+static void mainstone_mask_irq(struct irq_data *d)
 {
-	int mainstone_irq = (irq - MAINSTONE_IRQ(0));
+	int mainstone_irq = (d->irq - MAINSTONE_IRQ(0));
 	MST_INTMSKENA = (mainstone_irq_enabled &= ~(1 << mainstone_irq));
 }
 
-static void mainstone_unmask_irq(unsigned int irq)
+static void mainstone_unmask_irq(struct irq_data *d)
 {
-	int mainstone_irq = (irq - MAINSTONE_IRQ(0));
+	int mainstone_irq = (d->irq - MAINSTONE_IRQ(0));
 	/* the irq can be acknowledged only if deasserted, so it's done here */
 	MST_INTSETCLR &= ~(1 << mainstone_irq);
 	MST_INTMSKENA = (mainstone_irq_enabled |= (1 << mainstone_irq));
@@ -138,16 +138,17 @@ static void mainstone_unmask_irq(unsigned int irq)
 
 static struct irq_chip mainstone_irq_chip = {
 	.name		= "FPGA",
-	.ack		= mainstone_mask_irq,
-	.mask		= mainstone_mask_irq,
-	.unmask		= mainstone_unmask_irq,
+	.irq_ack	= mainstone_mask_irq,
+	.irq_mask	= mainstone_mask_irq,
+	.irq_unmask	= mainstone_unmask_irq,
 };
 
 static void mainstone_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned long pending = MST_INTSETCLR & mainstone_irq_enabled;
 	do {
-		desc->chip->ack(irq);	/* clear useless edge notification */
+		/* clear useless edge notification */
+		desc->irq_data.chip->irq_ack(&desc->irq_data);
 		if (likely(pending)) {
 			irq = MAINSTONE_IRQ(0) + __ffs(pending);
 			generic_handle_irq(irq);
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index f33647a..90820fa 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -241,23 +241,23 @@ static struct platform_device pcm990_backlight_device = {
 
 static unsigned long pcm990_irq_enabled;
 
-static void pcm990_mask_ack_irq(unsigned int irq)
+static void pcm990_mask_ack_irq(struct irq_data *d)
 {
-	int pcm990_irq = (irq - PCM027_IRQ(0));
+	int pcm990_irq = (d->irq - PCM027_IRQ(0));
 	PCM990_INTMSKENA = (pcm990_irq_enabled &= ~(1 << pcm990_irq));
 }
 
-static void pcm990_unmask_irq(unsigned int irq)
+static void pcm990_unmask_irq(struct irq_data *d)
 {
-	int pcm990_irq = (irq - PCM027_IRQ(0));
+	int pcm990_irq = (d->irq - PCM027_IRQ(0));
 	/* the irq can be acknowledged only if deasserted, so it's done here */
 	PCM990_INTSETCLR |= 1 << pcm990_irq;
 	PCM990_INTMSKENA  = (pcm990_irq_enabled |= (1 << pcm990_irq));
 }
 
 static struct irq_chip pcm990_irq_chip = {
-	.mask_ack	= pcm990_mask_ack_irq,
-	.unmask		= pcm990_unmask_irq,
+	.irq_mask_ack	= pcm990_mask_ack_irq,
+	.irq_unmask	= pcm990_unmask_irq,
 };
 
 static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
@@ -265,7 +265,8 @@ static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
 	unsigned long pending = (~PCM990_INTSETCLR) & pcm990_irq_enabled;
 
 	do {
-		desc->chip->ack(irq);	/* clear our parent IRQ */
+		/* clear our parent IRQ */
+		desc->irq_data.chip->irq_ack(&desc->irq_data);
 		if (likely(pending)) {
 			irq = PCM027_IRQ(0) + __ffs(pending);
 			generic_handle_irq(irq);
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index de53f2e..34c0a23 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
 #include <linux/sysdev.h>
+#include <linux/irq.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -282,15 +283,15 @@ static inline void pxa25x_init_pm(void) {}
 /* PXA25x: supports wakeup from GPIO0..GPIO15 and RTC alarm
  */
 
-static int pxa25x_set_wake(unsigned int irq, unsigned int on)
+static int pxa25x_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = IRQ_TO_GPIO(irq);
+	int gpio = IRQ_TO_GPIO(d->irq);
 	uint32_t mask = 0;
 
 	if (gpio >= 0 && gpio < 85)
 		return gpio_set_wake(gpio, on);
 
-	if (irq == IRQ_RTCAlrm) {
+	if (d->irq == IRQ_RTCAlrm) {
 		mask = PWER_RTC;
 		goto set_pwer;
 	}
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index d1fbf29..52771eb 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/platform_device.h>
 #include <linux/sysdev.h>
+#include <linux/irq.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -334,18 +335,18 @@ static inline void pxa27x_init_pm(void) {}
 /* PXA27x:  Various gpios can issue wakeup events.  This logic only
  * handles the simple cases, not the WEMUX2 and WEMUX3 options
  */
-static int pxa27x_set_wake(unsigned int irq, unsigned int on)
+static int pxa27x_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = IRQ_TO_GPIO(irq);
+	int gpio = IRQ_TO_GPIO(d->irq);
 	uint32_t mask;
 
 	if (gpio >= 0 && gpio < 128)
 		return gpio_set_wake(gpio, on);
 
-	if (irq == IRQ_KEYPAD)
+	if (d->irq == IRQ_KEYPAD)
 		return keypad_set_wake(on);
 
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_RTCAlrm:
 		mask = PWER_RTC;
 		break;
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index d1c747c..98b6c3d 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -425,11 +425,11 @@ static void __init pxa3xx_init_pm(void)
 	pxa_cpu_pm_fns = &pxa3xx_cpu_pm_fns;
 }
 
-static int pxa3xx_set_wake(unsigned int irq, unsigned int on)
+static int pxa3xx_set_wake(struct irq_data *d, unsigned int on)
 {
 	unsigned long flags, mask = 0;
 
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_SSP3:
 		mask = ADXER_MFP_WSSP3;
 		break;
@@ -518,40 +518,40 @@ static inline void pxa3xx_init_pm(void) {}
 #define pxa3xx_set_wake	NULL
 #endif
 
-static void pxa_ack_ext_wakeup(unsigned int irq)
+static void pxa_ack_ext_wakeup(struct irq_data *d)
 {
-	PECR |= PECR_IS(irq - IRQ_WAKEUP0);
+	PECR |= PECR_IS(d->irq - IRQ_WAKEUP0);
 }
 
-static void pxa_mask_ext_wakeup(unsigned int irq)
+static void pxa_mask_ext_wakeup(struct irq_data *d)
 {
-	ICMR2 &= ~(1 << ((irq - PXA_IRQ(0)) & 0x1f));
-	PECR &= ~PECR_IE(irq - IRQ_WAKEUP0);
+	ICMR2 &= ~(1 << ((d->irq - PXA_IRQ(0)) & 0x1f));
+	PECR &= ~PECR_IE(d->irq - IRQ_WAKEUP0);
 }
 
-static void pxa_unmask_ext_wakeup(unsigned int irq)
+static void pxa_unmask_ext_wakeup(struct irq_data *d)
 {
-	ICMR2 |= 1 << ((irq - PXA_IRQ(0)) & 0x1f);
-	PECR |= PECR_IE(irq - IRQ_WAKEUP0);
+	ICMR2 |= 1 << ((d->irq - PXA_IRQ(0)) & 0x1f);
+	PECR |= PECR_IE(d->irq - IRQ_WAKEUP0);
 }
 
-static int pxa_set_ext_wakeup_type(unsigned int irq, unsigned int flow_type)
+static int pxa_set_ext_wakeup_type(struct irq_data *d, unsigned int flow_type)
 {
 	if (flow_type & IRQ_TYPE_EDGE_RISING)
-		PWER |= 1 << (irq - IRQ_WAKEUP0);
+		PWER |= 1 << (d->irq - IRQ_WAKEUP0);
 
 	if (flow_type & IRQ_TYPE_EDGE_FALLING)
-		PWER |= 1 << (irq - IRQ_WAKEUP0 + 2);
+		PWER |= 1 << (d->irq - IRQ_WAKEUP0 + 2);
 
 	return 0;
 }
 
 static struct irq_chip pxa_ext_wakeup_chip = {
 	.name		= "WAKEUP",
-	.ack		= pxa_ack_ext_wakeup,
-	.mask		= pxa_mask_ext_wakeup,
-	.unmask		= pxa_unmask_ext_wakeup,
-	.set_type	= pxa_set_ext_wakeup_type,
+	.irq_ack	= pxa_ack_ext_wakeup,
+	.irq_mask	= pxa_mask_ext_wakeup,
+	.irq_unmask	= pxa_unmask_ext_wakeup,
+	.irq_set_type	= pxa_set_ext_wakeup_type,
 };
 
 static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
@@ -564,7 +564,7 @@ static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
 		set_irq_flags(irq, IRQF_VALID);
 	}
 
-	pxa_ext_wakeup_chip.set_wake = fn;
+	pxa_ext_wakeup_chip.irq_set_wake = fn;
 }
 
 void __init pxa3xx_init_irq(void)
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 438fc9a..59cc35f 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -249,9 +249,9 @@ static inline int viper_bit_to_irq(int bit)
 	return viper_isa_irqs[bit] + PXA_ISA_IRQ(0);
 }
 
-static void viper_ack_irq(unsigned int irq)
+static void viper_ack_irq(struct irq_data *d)
 {
-	int viper_irq = viper_irq_to_bitmask(irq);
+	int viper_irq = viper_irq_to_bitmask(d->irq);
 
 	if (viper_irq & 0xff)
 		VIPER_LO_IRQ_STATUS = viper_irq;
@@ -259,14 +259,14 @@ static void viper_ack_irq(unsigned int irq)
 		VIPER_HI_IRQ_STATUS = (viper_irq >> 8);
 }
 
-static void viper_mask_irq(unsigned int irq)
+static void viper_mask_irq(struct irq_data *d)
 {
-	viper_irq_enabled_mask &= ~(viper_irq_to_bitmask(irq));
+	viper_irq_enabled_mask &= ~(viper_irq_to_bitmask(d->irq));
 }
 
-static void viper_unmask_irq(unsigned int irq)
+static void viper_unmask_irq(struct irq_data *d)
 {
-	viper_irq_enabled_mask |= viper_irq_to_bitmask(irq);
+	viper_irq_enabled_mask |= viper_irq_to_bitmask(d->irq);
 }
 
 static inline unsigned long viper_irq_pending(void)
@@ -283,7 +283,7 @@ static void viper_irq_handler(unsigned int irq, struct irq_desc *desc)
 	do {
 		/* we're in a chained irq handler,
 		 * so ack the interrupt by hand */
-		desc->chip->ack(irq);
+		desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 		if (likely(pending)) {
 			irq = viper_bit_to_irq(__ffs(pending));
@@ -294,10 +294,10 @@ static void viper_irq_handler(unsigned int irq, struct irq_desc *desc)
 }
 
 static struct irq_chip viper_irq_chip = {
-	.name	= "ISA",
-	.ack	= viper_ack_irq,
-	.mask	= viper_mask_irq,
-	.unmask	= viper_unmask_irq
+	.name		= "ISA",
+	.irq_ack	= viper_ack_irq,
+	.irq_mask	= viper_mask_irq,
+	.irq_unmask	= viper_unmask_irq
 };
 
 static void __init viper_init_irq(void)
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index dea46a2..054f42b 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -82,19 +82,19 @@ static inline int zeus_bit_to_irq(int bit)
 	return zeus_isa_irqs[bit] + PXA_ISA_IRQ(0);
 }
 
-static void zeus_ack_irq(unsigned int irq)
+static void zeus_ack_irq(struct irq_data *d)
 {
-	__raw_writew(zeus_irq_to_bitmask(irq), ZEUS_CPLD_ISA_IRQ);
+	__raw_writew(zeus_irq_to_bitmask(d->irq), ZEUS_CPLD_ISA_IRQ);
 }
 
-static void zeus_mask_irq(unsigned int irq)
+static void zeus_mask_irq(struct irq_data *d)
 {
-	zeus_irq_enabled_mask &= ~(zeus_irq_to_bitmask(irq));
+	zeus_irq_enabled_mask &= ~(zeus_irq_to_bitmask(d->irq));
 }
 
-static void zeus_unmask_irq(unsigned int irq)
+static void zeus_unmask_irq(struct irq_data *d)
 {
-	zeus_irq_enabled_mask |= zeus_irq_to_bitmask(irq);
+	zeus_irq_enabled_mask |= zeus_irq_to_bitmask(d->irq);
 }
 
 static inline unsigned long zeus_irq_pending(void)
@@ -110,7 +110,7 @@ static void zeus_irq_handler(unsigned int irq, struct irq_desc *desc)
 	do {
 		/* we're in a chained irq handler,
 		 * so ack the interrupt by hand */
-		desc->chip->ack(gpio_to_irq(ZEUS_ISA_GPIO));
+		desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 		if (likely(pending)) {
 			irq = zeus_bit_to_irq(__ffs(pending));
@@ -121,10 +121,10 @@ static void zeus_irq_handler(unsigned int irq, struct irq_desc *desc)
 }
 
 static struct irq_chip zeus_irq_chip = {
-	.name	= "ISA",
-	.ack	= zeus_ack_irq,
-	.mask	= zeus_mask_irq,
-	.unmask	= zeus_unmask_irq,
+	.name		= "ISA",
+	.irq_ack	= zeus_ack_irq,
+	.irq_mask	= zeus_mask_irq,
+	.irq_unmask	= zeus_unmask_irq,
 };
 
 static void __init zeus_init_irq(void)
diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index 98548c6..e7de6ae 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -155,10 +155,10 @@ static inline void update_edge_detect(struct pxa_gpio_chip *c)
 	__raw_writel(gfer, c->regbase + GFER_OFFSET);
 }
 
-static int pxa_gpio_irq_type(unsigned int irq, unsigned int type)
+static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct pxa_gpio_chip *c;
-	int gpio = irq_to_gpio(irq);
+	int gpio = irq_to_gpio(d->irq);
 	unsigned long gpdr, mask = GPIO_bit(gpio);
 
 	c = gpio_to_chip(gpio);
@@ -195,7 +195,7 @@ static int pxa_gpio_irq_type(unsigned int irq, unsigned int type)
 
 	update_edge_detect(c);
 
-	pr_debug("%s: IRQ%d (GPIO%d) - edge%s%s\n", __func__, irq, gpio,
+	pr_debug("%s: IRQ%d (GPIO%d) - edge%s%s\n", __func__, d->irq, gpio,
 		((type & IRQ_TYPE_EDGE_RISING)  ? " rising"  : ""),
 		((type & IRQ_TYPE_EDGE_FALLING) ? " falling" : ""));
 	return 0;
@@ -227,17 +227,17 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 	} while (loop);
 }
 
-static void pxa_ack_muxed_gpio(unsigned int irq)
+static void pxa_ack_muxed_gpio(struct irq_data *d)
 {
-	int gpio = irq_to_gpio(irq);
+	int gpio = irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_chip(gpio);
 
 	__raw_writel(GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
 }
 
-static void pxa_mask_muxed_gpio(unsigned int irq)
+static void pxa_mask_muxed_gpio(struct irq_data *d)
 {
-	int gpio = irq_to_gpio(irq);
+	int gpio = irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_chip(gpio);
 	uint32_t grer, gfer;
 
@@ -249,9 +249,9 @@ static void pxa_mask_muxed_gpio(unsigned int irq)
 	__raw_writel(gfer, c->regbase + GFER_OFFSET);
 }
 
-static void pxa_unmask_muxed_gpio(unsigned int irq)
+static void pxa_unmask_muxed_gpio(struct irq_data *d)
 {
-	int gpio = irq_to_gpio(irq);
+	int gpio = irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_chip(gpio);
 
 	c->irq_mask |= GPIO_bit(gpio);
@@ -260,10 +260,10 @@ static void pxa_unmask_muxed_gpio(unsigned int irq)
 
 static struct irq_chip pxa_muxed_gpio_chip = {
 	.name		= "GPIO",
-	.ack		= pxa_ack_muxed_gpio,
-	.mask		= pxa_mask_muxed_gpio,
-	.unmask		= pxa_unmask_muxed_gpio,
-	.set_type	= pxa_gpio_irq_type,
+	.irq_ack	= pxa_ack_muxed_gpio,
+	.irq_mask	= pxa_mask_muxed_gpio,
+	.irq_unmask	= pxa_unmask_muxed_gpio,
+	.irq_set_type	= pxa_gpio_irq_type,
 };
 
 void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
@@ -291,7 +291,7 @@ void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
 
 	/* Install handler for GPIO>=2 edge detect interrupts */
 	set_irq_chained_handler(mux_irq, pxa_gpio_demux_handler);
-	pxa_muxed_gpio_chip.set_wake = fn;
+	pxa_muxed_gpio_chip.irq_set_wake = fn;
 }
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/plat-pxa/include/plat/gpio.h b/arch/arm/plat-pxa/include/plat/gpio.h
index 44248cb..1ddd2b9 100644
--- a/arch/arm/plat-pxa/include/plat/gpio.h
+++ b/arch/arm/plat-pxa/include/plat/gpio.h
@@ -1,6 +1,8 @@
 #ifndef __PLAT_GPIO_H
 #define __PLAT_GPIO_H
 
+struct irq_data;
+
 /*
  * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
  * one set of registers. The register offsets are organized below:
@@ -56,7 +58,7 @@ static inline void gpio_set_value(unsigned gpio, int value)
  */
 extern int pxa_last_gpio;
 
-typedef int (*set_wake_t)(unsigned int irq, unsigned int on);
+typedef int (*set_wake_t)(struct irq_data *d, unsigned int on);
 
 extern void pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn);
 #endif /* __PLAT_GPIO_H */
-- 
1.7.1

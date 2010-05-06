From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:23:52 -0700
Subject: [PATCH 01/34] davinci: misc cleanups from sparse
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-2-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Convert data/functions to static
- include headers for missing declarations
- pointer cleanups:  struct foo *__iomem f --> struct foo __iomem *f;

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c  |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c      |    2 +-
 arch/arm/mach-davinci/cdce949.c           |    1 +
 arch/arm/mach-davinci/clock.c             |    1 +
 arch/arm/mach-davinci/devices.c           |    2 ++
 arch/arm/mach-davinci/dm355.c             |    2 +-
 arch/arm/mach-davinci/dm365.c             |    2 +-
 arch/arm/mach-davinci/dm644x.c            |    4 ++--
 arch/arm/mach-davinci/dm646x.c            |    6 +++---
 arch/arm/mach-davinci/gpio.c              |   24 ++++++++++++------------
 arch/arm/mach-davinci/include/mach/gpio.h |    8 ++++----
 arch/arm/mach-davinci/mux.c               |    1 +
 13 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 976e11b..95cef1f 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -111,7 +111,7 @@ static struct platform_device davinci_evm_norflash_device = {
  * It may used instead of the (default) NOR chip to boot, using TI's
  * tools to install the secondary boot loader (UBL) and U-Boot.
  */
-struct mtd_partition davinci_evm_nandflash_partition[] = {
+static struct mtd_partition davinci_evm_nandflash_partition[] = {
 	/* Bootloader layout depends on whose u-boot is installed, but we
 	 * can hide all the details.
 	 *  - block 0 for u-boot environment ... in mainline u-boot
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index bd9ca07..1fadc68 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -60,7 +60,7 @@
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
-struct mtd_partition davinci_ntosd2_nandflash_partition[] = {
+static struct mtd_partition davinci_ntosd2_nandflash_partition[] = {
 	{
 		/* UBL (a few copies) plus U-Boot */
 		.name		= "bootloader",
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 08d373b..a7cf810 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -48,7 +48,7 @@
 #define DAVINCI_ASYNC_EMIF_CONTROL_BASE   0x01e00000
 #define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE  0x02000000
 
-struct mtd_partition davinci_sffsdr_nandflash_partition[] = {
+static struct mtd_partition davinci_sffsdr_nandflash_partition[] = {
 	/* U-Boot Environment: Block 0
 	 * UBL:                Block 1
 	 * U-Boot:             Blocks 6-7 (256 kb)
diff --git a/arch/arm/mach-davinci/cdce949.c b/arch/arm/mach-davinci/cdce949.c
index aec3756..ba8b12b 100644
--- a/arch/arm/mach-davinci/cdce949.c
+++ b/arch/arm/mach-davinci/cdce949.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 
 #include <mach/clock.h>
+#include <mach/cdce949.h>
 
 #include "clock.h"
 
diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index bf6218e..058c77f 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -22,6 +22,7 @@
 
 #include <mach/hardware.h>
 
+#include <mach/clock.h>
 #include <mach/psc.h>
 #include <mach/cputype.h>
 #include "clock.h"
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 1479496..ef28080 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -23,6 +23,8 @@
 #include <mach/mmc.h>
 #include <mach/time.h>
 
+#include "clock.h"
+
 #define DAVINCI_I2C_BASE	     0x01C21000
 #define DAVINCI_MMCSD0_BASE	     0x01E10000
 #define DM355_MMCSD0_BASE	     0x01E11000
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 3dc0a88..5efce70 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -798,7 +798,7 @@ static void __iomem *dm355_psc_bases[] = {
  * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
  * T1_TOP: Timer 1, top   :  <unused>
  */
-struct davinci_timer_info dm355_timer_info = {
+static struct davinci_timer_info dm355_timer_info = {
 	.timers		= davinci_timer_instance,
 	.clockevent_id	= T0_BOT,
 	.clocksource_id	= T0_TOP,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 0d6ee58..871be5a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1010,7 +1010,7 @@ static void __iomem *dm365_psc_bases[] = {
 	IO_ADDRESS(DAVINCI_PWR_SLEEP_CNTRL_BASE),
 };
 
-struct davinci_timer_info dm365_timer_info = {
+static struct davinci_timer_info dm365_timer_info = {
 	.timers		= davinci_timer_instance,
 	.clockevent_id	= T0_BOT,
 	.clocksource_id	= T0_TOP,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 2f2ae8b..23cbe9d 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -277,7 +277,7 @@ static struct clk timer2_clk = {
 	.usecount = 1,              /* REVISIT: why cant' this be disabled? */
 };
 
-struct clk_lookup dm644x_clks[] = {
+static struct clk_lookup dm644x_clks[] = {
 	CLK(NULL, "ref", &ref_clk),
 	CLK(NULL, "pll1", &pll1_clk),
 	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
@@ -687,7 +687,7 @@ static void __iomem *dm644x_psc_bases[] = {
  * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
  * T1_TOP: Timer 1, top   :  <unused>
  */
-struct davinci_timer_info dm644x_timer_info = {
+static struct davinci_timer_info dm644x_timer_info = {
 	.timers		= davinci_timer_instance,
 	.clockevent_id	= T0_BOT,
 	.clocksource_id	= T0_TOP,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 893baf4..b67b997 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -311,7 +311,7 @@ static struct clk vpif1_clk = {
 	.flags = ALWAYS_ENABLED,
 };
 
-struct clk_lookup dm646x_clks[] = {
+static struct clk_lookup dm646x_clks[] = {
 	CLK(NULL, "ref", &ref_clk),
 	CLK(NULL, "aux", &aux_clkin),
 	CLK(NULL, "pll1", &pll1_clk),
@@ -797,7 +797,7 @@ static void __iomem *dm646x_psc_bases[] = {
  * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
  * T1_TOP: Timer 1, top   :  <unused>
  */
-struct davinci_timer_info dm646x_timer_info = {
+static struct davinci_timer_info dm646x_timer_info = {
 	.timers		= davinci_timer_instance,
 	.clockevent_id	= T0_BOT,
 	.clocksource_id	= T0_TOP,
@@ -867,7 +867,7 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.sram_len		= SZ_32K,
 };
 
-void __init dm646x_init_ide()
+void __init dm646x_init_ide(void)
 {
 	davinci_cfg_reg(DM646X_ATAEN);
 	platform_device_register(&ide_dev);
diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index 744755b..3f77062 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -24,14 +24,14 @@ static DEFINE_SPINLOCK(gpio_lock);
 
 struct davinci_gpio {
 	struct gpio_chip	chip;
-	struct gpio_controller	*__iomem regs;
+	struct gpio_controller	__iomem *regs;
 	int			irq_base;
 };
 
 static struct davinci_gpio chips[DIV_ROUND_UP(DAVINCI_N_GPIO, 32)];
 
 /* create a non-inlined version */
-static struct gpio_controller __iomem * __init gpio2controller(unsigned gpio)
+static struct gpio_controller __iomem __init *gpio2controller(unsigned gpio)
 {
 	return __gpio_to_controller(gpio);
 }
@@ -48,7 +48,7 @@ static int __init davinci_gpio_irq_setup(void);
 static int davinci_direction_in(struct gpio_chip *chip, unsigned offset)
 {
 	struct davinci_gpio *d = container_of(chip, struct davinci_gpio, chip);
-	struct gpio_controller *__iomem g = d->regs;
+	struct gpio_controller __iomem *g = d->regs;
 	u32 temp;
 
 	spin_lock(&gpio_lock);
@@ -70,7 +70,7 @@ static int davinci_direction_in(struct gpio_chip *chip, unsigned offset)
 static int davinci_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct davinci_gpio *d = container_of(chip, struct davinci_gpio, chip);
-	struct gpio_controller *__iomem g = d->regs;
+	struct gpio_controller __iomem *g = d->regs;
 
 	return (1 << offset) & __raw_readl(&g->in_data);
 }
@@ -79,7 +79,7 @@ static int
 davinci_direction_out(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct davinci_gpio *d = container_of(chip, struct davinci_gpio, chip);
-	struct gpio_controller *__iomem g = d->regs;
+	struct gpio_controller __iomem *g = d->regs;
 	u32 temp;
 	u32 mask = 1 << offset;
 
@@ -99,7 +99,7 @@ static void
 davinci_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct davinci_gpio *d = container_of(chip, struct davinci_gpio, chip);
-	struct gpio_controller *__iomem g = d->regs;
+	struct gpio_controller __iomem *g = d->regs;
 
 	__raw_writel((1 << offset), value ? &g->set_data : &g->clr_data);
 }
@@ -161,7 +161,7 @@ pure_initcall(davinci_gpio_setup);
 
 static void gpio_irq_disable(unsigned irq)
 {
-	struct gpio_controller *__iomem g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
 	u32 mask = (u32) get_irq_data(irq);
 
 	__raw_writel(mask, &g->clr_falling);
@@ -170,7 +170,7 @@ static void gpio_irq_disable(unsigned irq)
 
 static void gpio_irq_enable(unsigned irq)
 {
-	struct gpio_controller *__iomem g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
 	u32 mask = (u32) get_irq_data(irq);
 	unsigned status = irq_desc[irq].status;
 
@@ -186,7 +186,7 @@ static void gpio_irq_enable(unsigned irq)
 
 static int gpio_irq_type(unsigned irq, unsigned trigger)
 {
-	struct gpio_controller *__iomem g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
 	u32 mask = (u32) get_irq_data(irq);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
@@ -215,7 +215,7 @@ static struct irq_chip gpio_irqchip = {
 static void
 gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct gpio_controller *__iomem g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
 	u32 mask = 0xffff;
 
 	/* we only care about one bank */
@@ -276,7 +276,7 @@ static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
 
 static int gpio_irq_type_unbanked(unsigned irq, unsigned trigger)
 {
-	struct gpio_controller *__iomem g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
 	u32 mask = (u32) get_irq_data(irq);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
@@ -305,7 +305,7 @@ static int __init davinci_gpio_irq_setup(void)
 	u32		binten = 0;
 	unsigned	ngpio, bank_irq;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	struct gpio_controller	*__iomem g;
+	struct gpio_controller	__iomem *g;
 
 	ngpio = soc_info->gpio_num;
 
diff --git a/arch/arm/mach-davinci/include/mach/gpio.h b/arch/arm/mach-davinci/include/mach/gpio.h
index f3b8ef8..0099e6e 100644
--- a/arch/arm/mach-davinci/include/mach/gpio.h
+++ b/arch/arm/mach-davinci/include/mach/gpio.h
@@ -67,10 +67,10 @@ struct gpio_controller {
  *
  * These are NOT part of the cross-platform GPIO interface
  */
-static inline struct gpio_controller *__iomem
+static inline struct gpio_controller __iomem *
 __gpio_to_controller(unsigned gpio)
 {
-	void *__iomem ptr;
+	void __iomem *ptr;
 	void __iomem *base = davinci_soc_info.gpio_base;
 
 	if (gpio < 32 * 1)
@@ -102,7 +102,7 @@ static inline u32 __gpio_mask(unsigned gpio)
 static inline void gpio_set_value(unsigned gpio, int value)
 {
 	if (__builtin_constant_p(value) && gpio < DAVINCI_N_GPIO) {
-		struct gpio_controller	*__iomem g;
+		struct gpio_controller	__iomem *g;
 		u32			mask;
 
 		g = __gpio_to_controller(gpio);
@@ -128,7 +128,7 @@ static inline void gpio_set_value(unsigned gpio, int value)
  */
 static inline int gpio_get_value(unsigned gpio)
 {
-	struct gpio_controller	*__iomem g;
+	struct gpio_controller	__iomem *g;
 
 	if (!__builtin_constant_p(gpio) || gpio >= DAVINCI_N_GPIO)
 		return __gpio_get_value(gpio);
diff --git a/arch/arm/mach-davinci/mux.c b/arch/arm/mach-davinci/mux.c
index f757e83..c942c89 100644
--- a/arch/arm/mach-davinci/mux.c
+++ b/arch/arm/mach-davinci/mux.c
@@ -21,6 +21,7 @@
 
 #include <mach/mux.h>
 #include <mach/common.h>
+#include <mach/da8xx.h>
 
 /*
  * Sets the DAVINCI MUX register based on the table
-- 
1.7.0.2

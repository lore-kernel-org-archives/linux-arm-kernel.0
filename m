From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:30 +0530
Subject: [PATCH 67/74] ST SPEAr3xx: Updating plgpio and emi source to make it
	compliant with single image strategy
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <b2d84a16d43538fc6adf668636f70bb844a62e6d.1283161024.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/emi.c               |   20 +++++++++++-
 arch/arm/mach-spear3xx/include/mach/emi.h  |   19 ++++++-----
 arch/arm/mach-spear3xx/include/mach/gpio.h |   27 ++++++++--------
 arch/arm/plat-spear/plgpio.c               |   46 ++++++++++++++++++++-------
 4 files changed, 76 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-spear3xx/emi.c b/arch/arm/mach-spear3xx/emi.c
index dd5cb8e..f0de4e0 100644
--- a/arch/arm/mach-spear3xx/emi.c
+++ b/arch/arm/mach-spear3xx/emi.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <asm/mach-types.h>
 #include <mach/emi.h>
 
 int __init emi_init(struct platform_device *pdev, unsigned long base,
@@ -23,8 +24,23 @@ int __init emi_init(struct platform_device *pdev, unsigned long base,
 	void __iomem *emi_reg_base;
 	struct clk *clk;
 	int ret;
+	u32 ack_reg, max_banks;
+	/* u32 timeout_reg, irq_reg; */
 
-	if (bank > (EMI_MAX_BANKS - 1))
+	/* fixing machine dependent values */
+	if (machine_is_spear310()) {
+		ack_reg = SPEAR310_ACK_REG;
+		max_banks = SPEAR310_EMI_MAX_BANKS;
+		/* timeout_reg = SPEAR310_TIMEOUT_REG; */
+		/* irq_reg = SPEAR310_IRQ_REG; */
+	} else {
+		ack_reg = SPEAR320_ACK_REG;
+		max_banks = SPEAR320_EMI_MAX_BANKS;
+		/* timeout_reg = SPEAR320_TIMEOUT_REG; */
+		/* irq_reg = SPEAR320_IRQ_REG; */
+	}
+
+	if (bank > (max_banks - 1))
 		return -EINVAL;
 
 	emi_reg_base = ioremap(base, EMI_REG_SIZE);
@@ -71,7 +87,7 @@ int __init emi_init(struct platform_device *pdev, unsigned long base,
 		emi_reg_base + (EMI_BANK_REG_SIZE * bank) + CTRL_REG);
 
 	/* disable all the acks */
-	writel(0x3f << bank, emi_reg_base + ACK_REG);
+	writel(0x3f << bank, emi_reg_base + ack_reg);
 
 	iounmap(emi_reg_base);
 
diff --git a/arch/arm/mach-spear3xx/include/mach/emi.h b/arch/arm/mach-spear3xx/include/mach/emi.h
index f3cbfbc..53b8cf8 100644
--- a/arch/arm/mach-spear3xx/include/mach/emi.h
+++ b/arch/arm/mach-spear3xx/include/mach/emi.h
@@ -33,18 +33,19 @@
 #define CTRL_REG		(0x14)
 
 #if defined(CONFIG_MACH_SPEAR310)
-#define TIMEOUT_REG		(0x90)
-#define ACK_REG			(0x94)
-#define IRQ_REG			(0x98)
+#define SPEAR310_TIMEOUT_REG	(0x90)
+#define SPEAR310_ACK_REG	(0x94)
+#define SPEAR310_IRQ_REG	(0x98)
 
-#define EMI_MAX_BANKS		6
+#define SPEAR310_EMI_MAX_BANKS	6
+#endif
 
-#elif defined(CONFIG_MACH_SPEAR320)
-#define TIMEOUT_REG		(0x60)
-#define ACK_REG			(0x64)
-#define IRQ_REG			(0x68)
+#if defined(CONFIG_MACH_SPEAR320)
+#define SPEAR320_TIMEOUT_REG	(0x60)
+#define SPEAR320_ACK_REG	(0x64)
+#define SPEAR320_IRQ_REG	(0x68)
 
-#define EMI_MAX_BANKS		4
+#define SPEAR320_EMI_MAX_BANKS	4
 
 #endif
 
diff --git a/arch/arm/mach-spear3xx/include/mach/gpio.h b/arch/arm/mach-spear3xx/include/mach/gpio.h
index f15248c..0c13d8c 100644
--- a/arch/arm/mach-spear3xx/include/mach/gpio.h
+++ b/arch/arm/mach-spear3xx/include/mach/gpio.h
@@ -17,20 +17,21 @@
 #include <plat/gpio.h>
 
 #ifdef CONFIG_MACH_SPEAR310
-#define PLGPIO_ENB		0x0010
-#define PLGPIO_WDATA		0x0020
-#define PLGPIO_DIR		0x0030
-#define PLGPIO_IE		0x0040
-#define PLGPIO_RDATA		0x0050
-#define PLGPIO_MIS		0x0060
+#define SPEAR310_PLGPIO_ENB		0x0010
+#define SPEAR310_PLGPIO_WDATA		0x0020
+#define SPEAR310_PLGPIO_DIR		0x0030
+#define SPEAR310_PLGPIO_IE		0x0040
+#define SPEAR310_PLGPIO_RDATA		0x0050
+#define SPEAR310_PLGPIO_MIS		0x0060
+#endif
 
-#elif defined(CONFIG_MACH_SPEAR320)
-#define PLGPIO_ENB		0x0024
-#define PLGPIO_WDATA		0x0034
-#define PLGPIO_DIR		0x0044
-#define PLGPIO_RDATA		0x0054
-#define PLGPIO_IE		0x0064
-#define PLGPIO_MIS		0x0074
+#if defined(CONFIG_MACH_SPEAR320)
+#define SPEAR320_PLGPIO_ENB		0x0024
+#define SPEAR320_PLGPIO_WDATA		0x0034
+#define SPEAR320_PLGPIO_DIR		0x0044
+#define SPEAR320_PLGPIO_RDATA		0x0054
+#define SPEAR320_PLGPIO_IE		0x0064
+#define SPEAR320_PLGPIO_MIS		0x0074
 #endif
 
 #define BASIC_GPIO_0		0
diff --git a/arch/arm/plat-spear/plgpio.c b/arch/arm/plat-spear/plgpio.c
index 847ff9c..d5631a8 100644
--- a/arch/arm/plat-spear/plgpio.c
+++ b/arch/arm/plat-spear/plgpio.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <asm/mach-types.h>
 #include <mach/gpio.h>
 
 #define MAX_GPIO_PER_REG		32
@@ -29,6 +30,9 @@
 #define REG_OFFSET(base, reg, pin)	(base + reg + (pin / MAX_GPIO_PER_REG)\
 		* sizeof(int *))
 
+static u32 plgpio_enb, plgpio_wdata, plgpio_dir, plgpio_rdata, plgpio_ie,
+	   plgpio_mis;
+
 /*
  * struct plgpio: plgpio driver specific structure
  *
@@ -97,7 +101,7 @@ static int plgpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_set(plgpio->base, offset, PLGPIO_DIR);
+	plgpio_reg_set(plgpio->base, offset, plgpio_dir);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 
 	return 0;
@@ -126,11 +130,11 @@ static int plgpio_direction_output(struct gpio_chip *chip, unsigned offset,
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_reset(plgpio->base, dir_offset, PLGPIO_DIR);
+	plgpio_reg_reset(plgpio->base, dir_offset, plgpio_dir);
 	if (value)
-		plgpio_reg_set(plgpio->base, wdata_offset, PLGPIO_WDATA);
+		plgpio_reg_set(plgpio->base, wdata_offset, plgpio_wdata);
 	else
-		plgpio_reg_reset(plgpio->base, wdata_offset, PLGPIO_WDATA);
+		plgpio_reg_reset(plgpio->base, wdata_offset, plgpio_wdata);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 
 	return 0;
@@ -150,7 +154,7 @@ static int plgpio_get_value(struct gpio_chip *chip, unsigned offset)
 			return -EINVAL;
 	}
 
-	return is_plgpio_set(plgpio->base, offset, PLGPIO_RDATA);
+	return is_plgpio_set(plgpio->base, offset, plgpio_rdata);
 }
 
 static void plgpio_set_value(struct gpio_chip *chip, unsigned offset, int value)
@@ -168,9 +172,9 @@ static void plgpio_set_value(struct gpio_chip *chip, unsigned offset, int value)
 	}
 
 	if (value)
-		plgpio_reg_set(plgpio->base, offset, PLGPIO_WDATA);
+		plgpio_reg_set(plgpio->base, offset, plgpio_wdata);
 	else
-		plgpio_reg_reset(plgpio->base, offset, PLGPIO_WDATA);
+		plgpio_reg_reset(plgpio->base, offset, plgpio_wdata);
 }
 
 static int plgpio_request(struct gpio_chip *chip, unsigned offset)
@@ -197,7 +201,7 @@ static int plgpio_request(struct gpio_chip *chip, unsigned offset)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_set(plgpio->base, offset, PLGPIO_ENB);
+	plgpio_reg_set(plgpio->base, offset, plgpio_enb);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 
 	return 0;
@@ -219,7 +223,7 @@ static void plgpio_free(struct gpio_chip *chip, unsigned offset)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_reset(plgpio->base, offset, PLGPIO_ENB);
+	plgpio_reg_reset(plgpio->base, offset, plgpio_enb);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 }
 
@@ -248,7 +252,7 @@ static void plgpio_irq_mask(unsigned irq)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_set(plgpio->base, offset, PLGPIO_IE);
+	plgpio_reg_set(plgpio->base, offset, plgpio_ie);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 }
 
@@ -266,7 +270,7 @@ static void plgpio_irq_unmask(unsigned irq)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_reset(plgpio->base, offset, PLGPIO_IE);
+	plgpio_reg_reset(plgpio->base, offset, plgpio_ie);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 }
 
@@ -299,7 +303,7 @@ static void plgpio_irq_handler(unsigned irq, struct irq_desc *desc)
 
 	/* check all plgpio MIS registers for a possible interrupt */
 	for (; i < regs_count; i++) {
-		pending = readl(plgpio->base + PLGPIO_MIS + i * sizeof(int *));
+		pending = readl(plgpio->base + plgpio_mis + i * sizeof(int *));
 		if (!pending)
 			continue;
 
@@ -444,6 +448,24 @@ static struct platform_driver plgpio_driver = {
 
 static int __init plgpio_init(void)
 {
+	if (machine_is_spear310()) {
+		plgpio_enb = SPEAR310_PLGPIO_ENB;
+		plgpio_wdata = SPEAR310_PLGPIO_WDATA;
+		plgpio_dir = SPEAR310_PLGPIO_DIR;
+		plgpio_rdata = SPEAR310_PLGPIO_IE;
+		plgpio_ie = SPEAR310_PLGPIO_RDATA;
+		plgpio_mis = SPEAR310_PLGPIO_MIS;
+	} else if (machine_is_spear320()) {
+		plgpio_enb = SPEAR320_PLGPIO_ENB;
+		plgpio_wdata = SPEAR320_PLGPIO_WDATA;
+		plgpio_dir = SPEAR320_PLGPIO_DIR;
+		plgpio_rdata = SPEAR320_PLGPIO_IE;
+		plgpio_ie = SPEAR320_PLGPIO_RDATA;
+		plgpio_mis = SPEAR320_PLGPIO_MIS;
+	} else {
+		return 0;
+	}
+
 	return platform_driver_register(&plgpio_driver);
 }
 subsys_initcall(plgpio_init);
-- 
1.7.2.2

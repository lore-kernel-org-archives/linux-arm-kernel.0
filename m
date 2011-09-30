From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 30 Sep 2011 18:19:17 +0800
Subject: [PATCH v2 2/5] ARM: pxa: remove set_wake_t
In-Reply-To: <1317377960-11063-1-git-send-email-haojian.zhuang@marvell.com>
References: <1317377960-11063-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1317377960-11063-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since set_wake_t is used for irq chip, it shouldn't be defined in
gpio.h. Just remove it from gpio.h.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/irq.c               |    5 +++--
 arch/arm/mach-pxa/pxa3xx.c            |    3 ++-
 arch/arm/plat-pxa/gpio.c              |    3 ++-
 arch/arm/plat-pxa/include/plat/gpio.h |    5 ++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index b569e70..a8e1aa1 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -159,7 +159,8 @@ asmlinkage void __exception_irq_entry ichp_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-static void __init pxa_init_low_gpio_irq(set_wake_t fn)
+static void __init pxa_init_low_gpio_irq(int (*fn)(struct irq_data *,
+					 unsigned int))
 {
 	int irq;
 
@@ -178,7 +179,7 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)
 	pxa_low_gpio_chip.irq_set_wake = fn;
 }
 
-void __init pxa_init_irq(int irq_nr, set_wake_t fn)
+void __init pxa_init_irq(int irq_nr, int (*fn)(struct irq_data *, unsigned int))
 {
 	int irq, i, n;
 
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 3ab9e84..f18a6eb 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -365,7 +365,8 @@ static struct irq_chip pxa_ext_wakeup_chip = {
 	.irq_set_type	= pxa_set_ext_wakeup_type,
 };
 
-static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
+static void __init pxa_init_ext_wakeup_irq(int (*fn)(struct irq_data *,
+					   unsigned int))
 {
 	int irq;
 
diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index 5d6a86b..cd6d210 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -264,7 +264,8 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_set_type	= pxa_gpio_irq_type,
 };
 
-void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
+void __init pxa_init_gpio(int mux_irq, int start, int end,
+			  int (*fn)(struct irq_data *, unsigned int))
 {
 	struct pxa_gpio_chip *c;
 	int gpio, irq;
diff --git a/arch/arm/plat-pxa/include/plat/gpio.h b/arch/arm/plat-pxa/include/plat/gpio.h
index 6fc41db..d31c2a5 100644
--- a/arch/arm/plat-pxa/include/plat/gpio.h
+++ b/arch/arm/plat-pxa/include/plat/gpio.h
@@ -60,7 +60,6 @@ static inline void gpio_set_value(unsigned gpio, int value)
  */
 extern int pxa_last_gpio;
 
-typedef int (*set_wake_t)(struct irq_data *d, unsigned int on);
-
-extern void pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn);
+extern void pxa_init_gpio(int mux_irq, int start, int end,
+			  int (*fn)(struct irq_data *, unsigned int));
 #endif /* __PLAT_GPIO_H */
-- 
1.7.2.5

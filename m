From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu,  1 Dec 2011 16:19:09 +0800
Subject: [PATCH 2/2] arm/imx: fix irq_base for gpio
In-Reply-To: <1322727549-10852-1-git-send-email-shawn.guo@linaro.org>
References: <1322727549-10852-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1322727549-10852-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When gpio core dynamically allocate gpio number for a port, it starts
from the end of the total range, 0 ~ ARCH_NR_GPIOS.  That said, the
earlier a port gets probed, the bigger gpio number it gets assigned.
To match this, the irq_base for gpio should be assigned from
'MXC_GPIO_IRQ_START + ARCH_NR_GPIOS' decreasingly.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c |    5 ++---
 arch/arm/mach-mx5/imx51-dt.c   |    5 ++---
 arch/arm/mach-mx5/imx53-dt.c   |    5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index eb7531b..22aa54a 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -39,11 +39,10 @@ static void __init imx6q_map_io(void)
 static int __init imx6q_gpio_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
-	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
-				   32 * 7; /* imx6q gets 7 gpio ports */
+	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
 
+	gpio_irq_base -= 32;
 	irq_domain_add_simple(np, gpio_irq_base);
-	gpio_irq_base += 32;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
index 3451a46..596edd9 100644
--- a/arch/arm/mach-mx5/imx51-dt.c
+++ b/arch/arm/mach-mx5/imx51-dt.c
@@ -54,11 +54,10 @@ static int __init imx51_tzic_add_irq_domain(struct device_node *np,
 static int __init imx51_gpio_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
-	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
-				   32 * 4; /* imx51 gets 4 gpio ports */
+	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
 
+	gpio_irq_base -= 32;
 	irq_domain_add_simple(np, gpio_irq_base);
-	gpio_irq_base += 32;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
index 022bc03..85bfd5f 100644
--- a/arch/arm/mach-mx5/imx53-dt.c
+++ b/arch/arm/mach-mx5/imx53-dt.c
@@ -58,11 +58,10 @@ static int __init imx53_tzic_add_irq_domain(struct device_node *np,
 static int __init imx53_gpio_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
-	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
-				   32 * 7; /* imx53 gets 7 gpio ports */
+	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
 
+	gpio_irq_base -= 32;
 	irq_domain_add_simple(np, gpio_irq_base);
-	gpio_irq_base += 32;
 
 	return 0;
 }
-- 
1.7.4.1

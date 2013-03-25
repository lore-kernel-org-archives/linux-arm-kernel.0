From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:22:49 +0800
Subject: [PATCH 1/3] ARM: mxs: get icoll base address from device tree
In-Reply-To: <1364224971-28431-1-git-send-email-shawn.guo@linaro.org>
References: <1364224971-28431-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364224971-28431-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than using the static definition, it gets icoll base address
with mapping from device tree.

As the result, <mach/mxs.h> inclusion can be removed from the driver
now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/icoll.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/icoll.c b/arch/arm/mach-mxs/icoll.c
index e26eeba..1cf32af 100644
--- a/arch/arm/mach-mxs/icoll.c
+++ b/arch/arm/mach-mxs/icoll.c
@@ -22,9 +22,9 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <asm/exception.h>
-#include <mach/mxs.h>
 #include <mach/common.h>
 
 #define HW_ICOLL_VECTOR				0x0000
@@ -38,7 +38,7 @@
 
 #define ICOLL_NUM_IRQS		128
 
-static void __iomem *icoll_base = MXS_IO_ADDRESS(MXS_ICOLL_BASE_ADDR);
+static void __iomem *icoll_base;
 static struct irq_domain *icoll_domain;
 
 static void icoll_ack_irq(struct irq_data *d)
@@ -103,6 +103,9 @@ static struct irq_domain_ops icoll_irq_domain_ops = {
 static void __init icoll_of_init(struct device_node *np,
 			  struct device_node *interrupt_parent)
 {
+	icoll_base = of_iomap(np, 0);
+	WARN_ON(!icoll_base);
+
 	/*
 	 * Interrupt Collector reset, which initializes the priority
 	 * for each irq to level 0.
-- 
1.7.9.5

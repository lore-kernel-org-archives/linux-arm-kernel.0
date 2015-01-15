From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 15 Jan 2015 13:09:30 +0300
Subject: [PATCH 1/5] ARM: sa1100: add platform functions to handle PWER
 settings
Message-ID: <1421316574-10022-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWER settings logically belongs neither to GPIO nor to system IRQ code.
Add special functions to handle PWER (for GPIO and for system IRQs)
from platform code.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/generic.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 40e0d86..022e451 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -416,3 +416,24 @@ void sa1110_mb_enable(void)
 	local_irq_restore(flags);
 }
 
+int sa11x0_gpio_set_wake(unsigned int gpio, unsigned int on)
+{
+	if (on)
+		PWER |= BIT(gpio);
+	else
+		PWER &= ~BIT(gpio);
+
+	return 0;
+}
+
+int sa11x0_sc_set_wake(unsigned int irq, unsigned int on)
+{
+	if (BIT(irq) != IC_RTCAlrm)
+		return -EINVAL;
+
+	if (on)
+		PWER |= PWER_RTC;
+	else
+		PWER &= ~PWER_RTC;
+	return 0;
+}
-- 
2.1.4

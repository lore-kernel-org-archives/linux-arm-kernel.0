From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 18 May 2015 17:44:03 +0300
Subject: [RESEND][PATCH 1/5] ARM: sa1100: add platform functions to handle
 PWER settings
Message-ID: <1431960247-32646-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWER settings logically belongs neither to GPIO nor to system IRQ code.
Add special functions to handle PWER (for GPIO and for system IRQs)
from platform code.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/generic.c | 24 ++++++++++++++++++++++++
 include/soc/sa1100/pwer.h      | 15 +++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/soc/sa1100/pwer.h

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 40e0d86..c651f6e 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -23,6 +23,8 @@
 
 #include <video/sa1100fb.h>
 
+#include <soc/sa1100/pwer.h>
+
 #include <asm/div64.h>
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
@@ -416,3 +418,25 @@ void sa1110_mb_enable(void)
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
+
+	return 0;
+}
diff --git a/include/soc/sa1100/pwer.h b/include/soc/sa1100/pwer.h
new file mode 100644
index 0000000..15a545b
--- /dev/null
+++ b/include/soc/sa1100/pwer.h
@@ -0,0 +1,15 @@
+#ifndef SOC_SA1100_PWER_H
+#define SOC_SA1100_PWER_H
+
+/*
+ * Copyright (C) 2015, Dmitry Eremin-Solenikov
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+int sa11x0_gpio_set_wake(unsigned int gpio, unsigned int on);
+int sa11x0_sc_set_wake(unsigned int irq, unsigned int on);
+
+#endif
-- 
2.1.4

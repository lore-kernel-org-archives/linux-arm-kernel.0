From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 15 Nov 2013 12:47:56 +0400
Subject: [PATCH 5/9] ARM: sa1100: add platform functions to handle PWER
 settings
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384505280-25389-6-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWER settings logically belongs neither to GPIO nor to system IRQ code.
Add special functions to handle PWER (for GPIO and for system IRQs)
from platform code.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/generic.c | 21 +++++++++++++++++++++
 arch/arm/mach-sa1100/generic.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index c2718f0..702f18c 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -421,3 +421,24 @@ void sa1110_mb_enable(void)
 	local_irq_restore(flags);
 }
 
+int sa11x0_gpio_set_wake(unsigned int gpio, unsigned int on)
+{
+	if (on)
+		PWER |= 1 << gpio;
+	else
+		PWER &= ~(1 << gpio);
+
+	return 0;
+}
+
+int sa11x0_sc_set_wake(unsigned int irq, unsigned int on)
+{
+	if (irq != IRQ_RTCAlrm)
+		return -EINVAL;
+
+	if (on)
+		PWER |= PWER_RTC;
+	else
+		PWER &= ~PWER_RTC;
+	return 0;
+}
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 0b68b95..39753c4 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -11,6 +11,8 @@ extern void __init sa1100_map_io(void);
 extern void __init sa1100_init_irq(void);
 extern void sa11x0_restart(enum reboot_mode, const char *);
 extern void sa11x0_init_late(void);
+extern int sa11x0_gpio_set_wake(unsigned int gpio, unsigned int on);
+extern int sa11x0_sc_set_wake(unsigned int irq, unsigned int on);
 
 #define SET_BANK(__nr,__start,__size) \
 	mi->bank[__nr].start = (__start), \
-- 
1.8.4.2

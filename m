From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  1 Jun 2011 10:44:51 +0100
Subject: [PATCH 3/5] ARM: S3C64XX: Ensure VIC based IRQs can be resumed from
In-Reply-To: <1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1306921493-30911-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Any interrupts based off either of the onboard VICs cannot be resumed
from any more as it seems set_irq_wake() is now checking the error code
returned from the low level handlers and not setting the wake-state on
the interrupt if this fails.

Ensure that we make the interrupts we can resume from available on the
VIC and then do a pre-sleep mask of all the VIC interrupts as the wakeup
is handled by a seperate block.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/include/mach/pm-core.h |    2 +-
 arch/arm/mach-s3c64xx/irq.c                  |   12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
index e4f1ce0..38659be 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
@@ -53,7 +53,7 @@ static inline void s3c_pm_arch_show_resume_irqs(void)
  * the IRQ wake controls depending on the CPU we are running on */
 
 #define s3c_irqwake_eintallow	((1 << 28) - 1)
-#define s3c_irqwake_intallow	(0)
+#define s3c_irqwake_intallow	(~0)
 
 static inline void s3c_pm_arch_update_uart(void __iomem *regs,
 					   struct pm_uart_save *save)
diff --git a/arch/arm/mach-s3c64xx/irq.c b/arch/arm/mach-s3c64xx/irq.c
index 97660c8..75d9a0e 100644
--- a/arch/arm/mach-s3c64xx/irq.c
+++ b/arch/arm/mach-s3c64xx/irq.c
@@ -48,14 +48,22 @@ static struct s3c_uart_irq uart_irqs[] = {
 	},
 };
 
+/* setup the sources the vic should advertise resume for, even though it
+ * is not doing the wake (set_irq_wake needs to be valid) */
+#define IRQ_VIC0_RESUME (1 << (IRQ_RTC_TIC - IRQ_VIC0_BASE))
+#define IRQ_VIC1_RESUME (1 << (IRQ_RTC_ALARM - IRQ_VIC1_BASE) |	\
+			 1 << (IRQ_PENDN - IRQ_VIC1_BASE) |	\
+			 1 << (IRQ_HSMMC0 - IRQ_VIC1_BASE) |	\
+			 1 << (IRQ_HSMMC1 - IRQ_VIC1_BASE) |	\
+			 1 << (IRQ_HSMMC2 - IRQ_VIC1_BASE))
 
 void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 {
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
 
 	/* initialise the pair of VICs */
-	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, 0);
-	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, 0);
+	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, IRQ_VIC0_RESUME);
+	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, IRQ_VIC1_RESUME);
 
 	/* add the timer sub-irqs */
 	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
-- 
1.7.5.3

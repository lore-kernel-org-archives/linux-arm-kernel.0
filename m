From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 19 Jul 2011 22:21:41 +0200
Subject: [PATCH 1/5] ARM: s3c64xx: PM: Mask and acknowledge all UART
 interrupts during core resume.
Message-ID: <mailman.43.1311955510.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some boards (in my case Tiny6410 from FriendlyARM), after waking up from
sleep mode, UART controllers are left in an unclean state with interrupt
status bits set. After reenabling interrupts the system starts to get
hammered by infinite UART interrupts, which cannot be acknowledged, because
of disabled UART bus clock. You can imagine the outcome.

This patch deals with the issue by reenabling the bus clock in PCLK mask
temporarily, acknowledging and masking all the UART interrupts and then
restoring the original PCLK mask value, before interrupts get enabled.

Alternatively, the issue could be avoided by moving all the UART interrupt
handling to the S3C UART driver and disabling the IRQ on port suspend.
Could anyone explain me what is the benefit of having the UART IRQ managed
by the generic IRQ infrastructure, while it is used only by a single driver?

---
 arch/arm/mach-s3c64xx/pm.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index bc1c470..799a212 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -16,12 +16,14 @@
 #include <linux/suspend.h>
 #include <linux/serial_core.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
 
 #include <plat/pm.h>
 #include <plat/wakeup-mask.h>
+#include <plat/regs-serial.h>
 
 #include <mach/regs-sys.h>
 #include <mach/regs-gpio.h>
@@ -93,12 +95,36 @@ void s3c_pm_configure_extint(void)
 
 void s3c_pm_restore_core(void)
 {
+	u32 pclkgate, tmp;
+	int i;
+
 	__raw_writel(0, S3C64XX_EINT_MASK);
 
 	s3c_pm_debug_smdkled(1 << 2, 0);
 
 	s3c_pm_do_restore_core(core_save, ARRAY_SIZE(core_save));
 	s3c_pm_do_restore(misc_save, ARRAY_SIZE(misc_save));
+
+	tmp = pclkgate = __raw_readl(S3C_PCLK_GATE);
+
+	/* re-start uart clocks */
+	tmp |= S3C_CLKCON_PCLK_UART0;
+	tmp |= S3C_CLKCON_PCLK_UART1;
+	tmp |= S3C_CLKCON_PCLK_UART2;
+	tmp |= S3C_CLKCON_PCLK_UART3;
+
+	__raw_writel(tmp, S3C_PCLK_GATE);
+
+	udelay(10);
+
+	for (i = 0; i < 4; ++i) {
+		__raw_writel(15, S3C_VA_UARTx(i) + S3C64XX_UINTM);
+		__raw_writel(15, S3C_VA_UARTx(i) + S3C64XX_UINTP);
+	}
+
+	udelay(10);
+
+	__raw_writel(pclkgate, S3C_PCLK_GATE);
 }
 
 void s3c_pm_save_core(void)
-- 
1.7.6

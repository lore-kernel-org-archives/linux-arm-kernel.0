From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 20 Jul 2011 19:12:15 +0200
Subject: S3C6410 UART resume problem
In-Reply-To: <1534460.6WAISbrX4v@flatron>
References: <1534460.6WAISbrX4v@flatron>
Message-ID: <8865715.7kkxAXkp10@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have managed to implement a workaround that works for me, but I am not sure 
whether it could not be done in a better way. I have attached a patch based on 
Linux 2.6.38.

P.S. Please excuse me sending my last message incorrectly, using To instead of 
CC fields, as my mail client automatically sets all address text fields as To 
and I have forgotten to switch them to CC.

---
 arch/arm/mach-s3c64xx/pm.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 79412f7..7818bdd 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -22,6 +22,7 @@
 
 #include <plat/pm.h>
 #include <plat/wakeup-mask.h>
+#include <plat/regs-serial.h>
 
 #include <mach/regs-sys.h>
 #include <mach/regs-gpio.h>
@@ -29,6 +30,8 @@
 #include <mach/regs-syscon-power.h>
 #include <mach/regs-gpio-memport.h>
 
+#include <asm/delay.h>
+
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
 #include <mach/gpio-bank-n.h>
 
@@ -101,12 +104,36 @@ void s3c_pm_configure_extint(void)
 
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

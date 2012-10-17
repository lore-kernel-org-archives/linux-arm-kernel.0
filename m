From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 17 Oct 2012 06:13:25 +0000
Subject: discrepancy while save and restore of debounce registers
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAA9A7C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I came across a peculiar issue while updating GPIO debounce registers on
OMAP platform.

According to mainline commit ae547354a8ed59f19b57f7e1de9c7816edfc3537

gpio/omap: save and restore debounce registers

GPIO debounce registers need to be saved and restored for proper functioning
of driver.

...
@@ -1363,6 +1369,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
        __raw_writel(bank->context.fallingdetect,
                                bank->base + bank->regs->fallingdetect);
        __raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
+       if (bank->dbck_enable_mask) {
+               __raw_writel(bank->context.debounce, bank->base +
+                                       bank->regs->debounce);
+               __raw_writel(bank->context.debounce_en,
+                                       bank->base + bank->regs->debounce_en);
+       }
 }


Due to copy/paste of this commit into my local tree, I missed the check for 
bank->dbck_enable_mask, and directly restored the saved value from context.

After this, I saw random crashes when accessing different registers (sometimes
its OE register and sometime its DATAOUT register). 

These crashes were seen across 2nd and subsequent suspend/resume.

My doubt/questions are
1. Why should debounce registers be updated only when it's accessed previously?

2. What is the relation between updating debounce registers and crash seen on
others registers? 

Thanks in advance for the support.

Regards
Gururaja

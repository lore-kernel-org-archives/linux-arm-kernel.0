From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 13:26:56 +0800
Subject: [PATCH 15/16] ARM: fiq: save FIQ_START by passing absolute fiq
 number
In-Reply-To: <20120618164402.GA18630@n2100.arm.linux.org.uk>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-16-git-send-email-shawn.guo@linaro.org>
 <20120618143128.GF19249@S2101-09.ap.freescale.net>
 <20120618164402.GA18630@n2100.arm.linux.org.uk>
Message-ID: <20120619052654.GC21951@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 05:44:02PM +0100, Russell King - ARM Linux wrote:
> FIQs should be an entirely separate number space from IRQs, as we
> may want to totally decouple them from the IRQ stuff (we probably
> should have already done this when genirq came along.)
> 
> About the only stuff FIQs use is the enable/disable_irq as a short
> cut to dealing with the mask registers.

I do not quite understand what you are asking for, but I'm guessing it
with the patch below.  Please elaborate it a little bit more if that's
not what you are asking for.

Regards,
Shawn

--8<---

diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index c32f845..dce12fb 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -39,6 +39,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/seq_file.h>

 #include <asm/cacheflush.h>
@@ -124,12 +125,20 @@ void release_fiq(struct fiq_handler *f)

 void enable_fiq(int fiq)
 {
-       enable_irq(fiq + FIQ_START);
+       struct irq_data *d = irq_get_irq_data(fiq);
+       struct irq_chip *chip = irq_data_get_irq_chip(d);
+
+       if (chip->irq_unmask)
+               chip->irq_unmask(d);
 }

 void disable_fiq(int fiq)
 {
-       disable_irq(fiq + FIQ_START);
+       struct irq_data *d = irq_get_irq_data(fiq);
+       struct irq_chip *chip = irq_data_get_irq_chip(d);
+
+       if (chip->irq_mask)
+               chip->irq_mask(d);
 }

 EXPORT_SYMBOL(set_fiq_handler);

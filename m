From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 10 Jan 2013 00:41:45 +0100
Subject: [RFC PATCH 3/7] ARM: s3c64xx: Add support for OF-based VIC
 initialization
In-Reply-To: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
References: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1357774909-29938-4-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies IRQ initialization code of S3C64xx to support
Device Tree-based initialization of VICs.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/common.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index aef303b..798c5d4 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/of_irq.h>
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -181,13 +182,26 @@ core_initcall(s3c64xx_dev_init);
 			 1 << (IRQ_HSMMC1 - IRQ_VIC1_BASE) |	\
 			 1 << (IRQ_HSMMC2 - IRQ_VIC1_BASE))
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c64xx_dt_irq_match[] = {
+	{ .compatible = "arm,pl192-vic", .data = vic_of_init, },
+	{},
+};
+#endif
+
 void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 {
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
 
-	/* initialise the pair of VICs */
-	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, IRQ_VIC0_RESUME);
-	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, IRQ_VIC1_RESUME);
+	if (!of_have_populated_dt()) {
+		/* initialise the pair of VICs */
+		vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, IRQ_VIC0_RESUME);
+		vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, IRQ_VIC1_RESUME);
+	}
+#ifdef CONFIG_OF
+	else
+		of_irq_init(s3c64xx_dt_irq_match);
+#endif
 
 	/* add the timer sub-irqs */
 	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
-- 
1.8.1

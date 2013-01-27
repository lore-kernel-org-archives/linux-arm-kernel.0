From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 27 Jan 2013 21:38:00 +0100
Subject: [PATCH v4 3/9] ARM: S3C24XX: Modify s3c_irq_wake to use the hwirq
 property
In-Reply-To: <201301272124.18530.heiko@sntech.de>
References: <201301272124.18530.heiko@sntech.de>
Message-ID: <201301272138.00842.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of the use of static irq mappings there.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/irq-pm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq-pm.c b/arch/arm/mach-s3c24xx/irq-pm.c
index d48126d..640ec91 100644
--- a/arch/arm/mach-s3c24xx/irq-pm.c
+++ b/arch/arm/mach-s3c24xx/irq-pm.c
@@ -30,18 +30,18 @@
  * set bit to 1 in allow bitfield to enable the wakeup settings on it
 */
 
-unsigned long s3c_irqwake_intallow	= 1L << (IRQ_RTC - IRQ_EINT0) | 0xfL;
+unsigned long s3c_irqwake_intallow	= 1L << 30 | 0xfL;
 unsigned long s3c_irqwake_eintallow	= 0x0000fff0L;
 
 int s3c_irq_wake(struct irq_data *data, unsigned int state)
 {
-	unsigned long irqbit = 1 << (data->irq - IRQ_EINT0);
+	unsigned long irqbit = 1 << data->hwirq;
 
 	if (!(s3c_irqwake_intallow & irqbit))
 		return -ENOENT;
 
-	printk(KERN_INFO "wake %s for irq %d\n",
-	       state ? "enabled" : "disabled", data->irq);
+	pr_info("wake %s for hwirq %lu\n",
+		state ? "enabled" : "disabled", data->hwirq);
 
 	if (!state)
 		s3c_irqwake_intmask |= irqbit;
-- 
1.7.10.4

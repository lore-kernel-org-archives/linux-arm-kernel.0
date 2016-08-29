From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:24:46 +0100
Subject: [PATCH 08/33] ARM: sa1100/neponset: add GPIO drivers for control and
 modem registers
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJkE-0000mU-Cn@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NCR, MDM_CTL* and AUD registers manipulate the state of external
signals (eg, the RTS, DTR signals and the ethernet oscillator enable
signal) or indicate the state of external signals (eg, CTS, DSR).

Where these registers can be written, the current value can be read
back, which relieves us from having to maintain a software copy of
the current state.

Model these registers as fixed-direction GPIO registers.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c | 153 ++++++++++++++++++++++++----------------
 1 file changed, 93 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 8411985af9ff..75d758ca6799 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -2,6 +2,8 @@
  * linux/arch/arm/mach-sa1100/neponset.c
  */
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio-reg.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
@@ -44,10 +46,13 @@
 #define IRR_USAR	(1 << 1)
 #define IRR_SA1111	(1 << 2)
 
+#define NCR_NGPIO	7
+
 #define MDM_CTL0_RTS1	(1 << 0)
 #define MDM_CTL0_DTR1	(1 << 1)
 #define MDM_CTL0_RTS2	(1 << 2)
 #define MDM_CTL0_DTR2	(1 << 3)
+#define MDM_CTL0_NGPIO	4
 
 #define MDM_CTL1_CTS1	(1 << 0)
 #define MDM_CTL1_DSR1	(1 << 1)
@@ -55,80 +60,87 @@
 #define MDM_CTL1_CTS2	(1 << 3)
 #define MDM_CTL1_DSR2	(1 << 4)
 #define MDM_CTL1_DCD2	(1 << 5)
+#define MDM_CTL1_NGPIO	6
 
 #define AUD_SEL_1341	(1 << 0)
 #define AUD_MUTE_1341	(1 << 1)
+#define AUD_NGPIO	2
 
 extern void sa1110_mb_disable(void);
 
+#define to_neponset_gpio_chip(x) container_of(x, struct neponset_gpio_chip, gc)
+
+static const char *neponset_ncr_names[] = {
+	"gp01_off", "tp_power", "ms_power", "enet_osc",
+	"spi_kb_wk_up", "a0vpp", "a1vpp"
+};
+
+static const char *neponset_mdmctl0_names[] = {
+	"rts3", "dtr3", "rts1", "dtr1",
+};
+
+static const char *neponset_mdmctl1_names[] = {
+	"cts3", "dsr3", "dcd3", "cts1", "dsr1", "dcd1"
+};
+
+static const char *neponset_aud_names[] = {
+	"sel_1341", "mute_1341",
+};
+
 struct neponset_drvdata {
 	void __iomem *base;
 	struct platform_device *sa1111;
 	struct platform_device *smc91x;
 	unsigned irq_base;
-#ifdef CONFIG_PM_SLEEP
-	u32 ncr0;
-	u32 mdm_ctl_0;
-#endif
+	struct gpio_chip *gpio[4];
 };
 
-static void __iomem *nep_base;
+static struct neponset_drvdata *nep;
 
 void neponset_ncr_frob(unsigned int mask, unsigned int val)
 {
-	void __iomem *base = nep_base;
-
-	if (base) {
-		unsigned long flags;
-		unsigned v;
-
-		local_irq_save(flags);
-		v = readb_relaxed(base + NCR_0);
-		writeb_relaxed((v & ~mask) | val, base + NCR_0);
-		local_irq_restore(flags);
-	} else {
-		WARN(1, "nep_base unset\n");
-	}
+	struct neponset_drvdata *n = nep;
+	unsigned long m = mask, v = val;
+
+	if (nep)
+		n->gpio[0]->set_multiple(n->gpio[0], &m, &v);
+	else
+		WARN(1, "nep unset\n");
 }
 EXPORT_SYMBOL(neponset_ncr_frob);
 
 static void neponset_set_mctrl(struct uart_port *port, u_int mctrl)
 {
-	void __iomem *base = nep_base;
-	u_int mdm_ctl0;
+	struct neponset_drvdata *n = nep;
+	unsigned long mask, val = 0;
 
-	if (!base)
+	if (!n)
 		return;
 
-	mdm_ctl0 = readb_relaxed(base + MDM_CTL_0);
 	if (port->mapbase == _Ser1UTCR0) {
-		if (mctrl & TIOCM_RTS)
-			mdm_ctl0 &= ~MDM_CTL0_RTS2;
-		else
-			mdm_ctl0 |= MDM_CTL0_RTS2;
-
-		if (mctrl & TIOCM_DTR)
-			mdm_ctl0 &= ~MDM_CTL0_DTR2;
-		else
-			mdm_ctl0 |= MDM_CTL0_DTR2;
+		mask = MDM_CTL0_RTS2 | MDM_CTL0_DTR2;
+
+		if (!(mctrl & TIOCM_RTS))
+			val |= MDM_CTL0_RTS2;
+
+		if (!(mctrl & TIOCM_DTR))
+			val |= MDM_CTL0_DTR2;
 	} else if (port->mapbase == _Ser3UTCR0) {
-		if (mctrl & TIOCM_RTS)
-			mdm_ctl0 &= ~MDM_CTL0_RTS1;
-		else
-			mdm_ctl0 |= MDM_CTL0_RTS1;
-
-		if (mctrl & TIOCM_DTR)
-			mdm_ctl0 &= ~MDM_CTL0_DTR1;
-		else
-			mdm_ctl0 |= MDM_CTL0_DTR1;
+		mask = MDM_CTL0_RTS1 | MDM_CTL0_DTR1;
+
+		if (!(mctrl & TIOCM_RTS))
+			val |= MDM_CTL0_RTS1;
+
+		if (!(mctrl & TIOCM_DTR))
+			val |= MDM_CTL0_DTR1;
 	}
 
-	writeb_relaxed(mdm_ctl0, base + MDM_CTL_0);
+	n->gpio[1]->set_multiple(n->gpio[1], &mask, &val);
 }
 
 static u_int neponset_get_mctrl(struct uart_port *port)
 {
-	void __iomem *base = nep_base;
+	void __iomem *base = nep->base;
 	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
 	u_int mdm_ctl1;
 
@@ -230,6 +242,22 @@ static struct irq_chip nochip = {
 	.irq_unmask = nochip_noop,
 };
 
+static int neponset_init_gpio(struct gpio_chip **gcp,
+	struct device *dev, const char *label, void __iomem *reg,
+	unsigned num, bool in, const char *const * names)
+{
+	struct gpio_chip *gc;
+
+	gc = gpio_reg_init(dev, reg, -1, num, label, in ? 0xffffffff : 0,
+			   readl_relaxed(reg), names);
+	if (IS_ERR(gc))
+		return PTR_ERR(gc);
+
+	*gcp = gc;
+
+	return 0;
+}
+
 static struct sa1111_platform_data sa1111_info = {
 	.disable_devs	= SA1111_DEVID_PS2_MSE,
 };
@@ -273,7 +301,7 @@ static int neponset_probe(struct platform_device *dev)
 	};
 	int ret, irq;
 
-	if (nep_base)
+	if (nep)
 		return -EBUSY;
 
 	irq = ret = platform_get_irq(dev, 0);
@@ -329,6 +357,19 @@ static int neponset_probe(struct platform_device *dev)
 	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
 	irq_set_chained_handler_and_data(irq, neponset_irq_handler, d);
 
+	neponset_init_gpio(&d->gpio[0], &dev->dev, "neponset-ncr",
+			   d->base + NCR_0, NCR_NGPIO, false,
+			   neponset_ncr_names);
+	neponset_init_gpio(&d->gpio[1], &dev->dev, "neponset-mdm-ctl0",
+			   d->base + MDM_CTL_0, MDM_CTL0_NGPIO, false,
+			   neponset_mdmctl0_names);
+	neponset_init_gpio(&d->gpio[2], &dev->dev, "neponset-mdm-ctl1",
+			   d->base + MDM_CTL_1, MDM_CTL1_NGPIO, true,
+			   neponset_mdmctl1_names);
+	neponset_init_gpio(&d->gpio[3], &dev->dev, "neponset-aud-ctl",
+			   d->base + AUD_CTL, AUD_NGPIO, false,
+			   neponset_aud_names);
+
 	/*
 	 * We would set IRQ_GPIO25 to be a wake-up IRQ, but unfortunately
 	 * something on the Neponset activates this IRQ on sleep (eth?)
@@ -339,7 +380,7 @@ static int neponset_probe(struct platform_device *dev)
 
 	dev_info(&dev->dev, "Neponset daughter board, providing IRQ%u-%u\n",
 		 d->irq_base, d->irq_base + NEP_IRQ_NR - 1);
-	nep_base = d->base;
+	nep = d;
 
 	sa1100_register_uart_fns(&neponset_port_fns);
 
@@ -384,7 +425,7 @@ static int neponset_remove(struct platform_device *dev)
 		platform_device_unregister(d->smc91x);
 	irq_set_chained_handler(irq, NULL);
 	irq_free_descs(d->irq_base, NEP_IRQ_NR);
-	nep_base = NULL;
+	nep = NULL;
 	iounmap(d->base);
 	kfree(d);
 
@@ -392,30 +433,22 @@ static int neponset_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int neponset_suspend(struct device *dev)
-{
-	struct neponset_drvdata *d = dev_get_drvdata(dev);
-
-	d->ncr0 = readb_relaxed(d->base + NCR_0);
-	d->mdm_ctl_0 = readb_relaxed(d->base + MDM_CTL_0);
-
-	return 0;
-}
-
 static int neponset_resume(struct device *dev)
 {
 	struct neponset_drvdata *d = dev_get_drvdata(dev);
+	int i, ret = 0;
 
-	writeb_relaxed(d->ncr0, d->base + NCR_0);
-	writeb_relaxed(d->mdm_ctl_0, d->base + MDM_CTL_0);
+	for (i = 0; i < ARRAY_SIZE(d->gpio); i++) {
+		ret = gpio_reg_resume(d->gpio[i]);
+		if (ret)
+			break;
+	}
 
-	return 0;
+	return ret;
 }
 
 static const struct dev_pm_ops neponset_pm_ops = {
-	.suspend_noirq = neponset_suspend,
 	.resume_noirq = neponset_resume,
-	.freeze_noirq = neponset_suspend,
 	.restore_noirq = neponset_resume,
 };
 #define PM_OPS &neponset_pm_ops
-- 
2.1.0

From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:07 +0200
Subject: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <1318178172-7965-5-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-spmp8000/adc.c                      |  465 +++++++++++++++++++++
 arch/arm/mach-spmp8000/include/mach/spmp8000adc.h |   29 ++
 2 files changed, 494 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spmp8000/adc.c
 create mode 100644 arch/arm/mach-spmp8000/include/mach/spmp8000adc.h

diff --git a/arch/arm/mach-spmp8000/adc.c b/arch/arm/mach-spmp8000/adc.c
new file mode 100644
index 0000000..c517116
--- /dev/null
+++ b/arch/arm/mach-spmp8000/adc.c
@@ -0,0 +1,465 @@
+/*
+ * SPMP8000 ADC support
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <mach/spmp8000adc.h>
+#include <mach/scu.h>
+
+#define SARCTRL			0x00
+#define SARCTRL_BUSY		BIT(21)
+#define SARCTRL_REF		BIT(17)
+#define SARCTRL_TOG_EN		BIT(16)
+#define SARCTRL_DIVNUM_OFF	8
+#define SARCTRL_DIVNUM_MASK	0xFF00
+#define SARCTRL_BACK2INT	BIT(7)
+#define SARCTRL_TPS_OFF		5
+#define SARCTRL_TPS_MASK	(3 << 5)
+#define SARCTRL_TPS_NOP		0
+#define SARCTRL_TPS_TEST	1
+#define SARCTRL_TPS_TP		2
+#define SARCTRL_TPS_INT		3
+#define SARCTRL_SARS_OFF	2
+#define SARCTRL_SARS_MASK	(7 << 2)
+#define SARCTRL_SARS_TPXP	0
+#define SARCTRL_SARS_TPXN	1
+#define SARCTRL_SARS_TPYP	2
+#define SARCTRL_SARS_TPYN	3
+#define SARCTRL_SARS_SARIN4	4
+#define SARCTRL_SARS_SARIN5	5
+#define SARCTRL_SARS_SARIN6	6
+#define SARCTRL_SARS_SARIN7	7
+#define SARCTRL_MANCON		BIT(1)
+#define SARCTRL_AUTOCON		BIT(0)
+
+#define SARCONDLY		0x04
+#define SARAUTODLY		0x08
+#define SARDEBTIME		0x0C
+#define SARDEBTIME_DEBDLY_OFF	0
+#define SARDEBTIME_DEBDLY_MASK	0xFFFF
+#define SARDEBTIME_CHKDLY_OFF	16
+#define SARDEBTIME_CHKDLY_MASK	0xFFFF0000UL
+#define SARPNL			0x10
+#define SARAUX			0x14
+#define SARINTEN		0x18
+#define SARINTF			0x1C
+#define SARINT_NAUX		BIT(3)
+#define SARINT_NPNL		BIT(2)
+#define SARINT_PENUP		BIT(1)
+#define SARINT_PENDOWN		BIT(0)
+
+#define SAR_CLKRATE		400000UL
+#define ADC_CHANNELS		8
+
+struct spmp8000_adc {
+	void __iomem		*reg_base;
+	struct device		*dev;
+	struct clk		*clk_apbdma;
+	struct clk		*clk_saacc;
+	spinlock_t		lock;
+	/* These are callbacks that get served with the measurement data
+	 *@their according channel interrupt. */
+	struct spmp8000adc_client_chan	*chan[ADC_CHANNELS];
+	/* Same for the touch-panel data */
+	struct spmp8000adc_client_tp	*tp;
+};
+
+static struct spmp8000_adc	*adc_dev;
+
+static int spmp8000adc_should_run(struct spmp8000_adc *adc)
+{
+	int i = ADC_CHANNELS - 1;
+
+	while (i-- >= 0) {
+		if (adc->chan[i])
+			return 1;
+	}
+
+	return 0;
+}
+
+/* Starts or stops the ADC controller */
+static void spmp8000adc_ctrl(struct spmp8000_adc *adc, int start, int chan)
+{
+	u32			ctrl_reg;
+
+	ctrl_reg = readl(adc->reg_base + SARCTRL);
+
+	if (start) {
+		ctrl_reg &= ~SARCTRL_SARS_MASK;
+		ctrl_reg |= (chan << SARCTRL_SARS_OFF);
+		ctrl_reg |= (SARCTRL_TPS_TEST << SARCTRL_TPS_OFF) |
+				SARCTRL_MANCON;
+	} else
+		ctrl_reg &= ~SARCTRL_MANCON;
+
+	writel(ctrl_reg, adc->reg_base + SARCTRL);
+}
+
+/* Request an ADC channel to be measured. Measurement starts automatically
+ * when at least one channel is requested. IRQ code loops around all channels
+ * to be measured.
+ */
+int spmp8000adc_request_channel(unsigned int chan,
+				struct spmp8000adc_client_chan *c)
+{
+	struct spmp8000_adc	*adc = adc_dev;
+	unsigned long		flags;
+
+	if (chan > ADC_CHANNELS - 1)
+		return -EINVAL;
+
+	if (!c)
+		return -EINVAL;
+
+	spin_lock_irqsave(&adc->lock, flags);
+
+	if (adc->chan[chan]) {
+		spin_unlock_irqrestore(&adc->lock, flags);
+		return -EBUSY;
+	}
+
+	adc->chan[chan] = c;
+
+	if (spmp8000adc_should_run(adc))
+		spmp8000adc_ctrl(adc, 1, chan);
+
+	spin_unlock_irqrestore(&adc->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(spmp8000adc_request_channel);
+
+/* Release an ADC channel. If no more channels are to be measured,
+ * the controller is shut down
+ */
+int spmp8000adc_release_channel(unsigned int chan)
+{
+	struct spmp8000_adc	*adc = adc_dev;
+	unsigned long		flags;
+
+	if (chan > ADC_CHANNELS - 1)
+		return -EINVAL;
+
+	spin_lock_irqsave(&adc->lock, flags);
+
+	if (!spmp8000adc_should_run(adc))
+		spmp8000adc_ctrl(adc, 0, 0);
+
+	adc->chan[chan] = NULL;
+
+	spin_unlock_irqrestore(&adc->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(spmp8000adc_release_channel);
+
+/* Request touch panel measurement */
+int spmp8000adc_request_tp(struct spmp8000adc_client_tp *tp)
+{
+	struct spmp8000_adc	*adc = adc_dev;
+	unsigned long		flags;
+	u32 ctrl_reg;
+
+	spin_lock_irqsave(&adc->lock, flags);
+
+	if (adc->tp) {
+		spin_unlock_irqrestore(&adc->lock, flags);
+		return -EBUSY;
+	}
+
+	adc->tp = tp;
+
+	ctrl_reg = readl(adc->reg_base + SARCTRL);
+	ctrl_reg |= SARCTRL_AUTOCON;
+	writel(ctrl_reg, adc->reg_base + SARCTRL);
+	spin_unlock_irqrestore(&adc->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(spmp8000adc_request_tp);
+
+/* Relase touch panel measurement */
+void spmp8000adc_release_tp(void)
+{
+	struct spmp8000_adc	*adc = adc_dev;
+	unsigned long		flags;
+	u32 ctrl_reg;
+
+	spin_lock_irqsave(&adc->lock, flags);
+
+	ctrl_reg = readl(adc->reg_base + SARCTRL);
+	ctrl_reg &= ~SARCTRL_AUTOCON;
+	writel(ctrl_reg, adc->reg_base + SARCTRL);
+	adc->tp = NULL;
+
+	spin_unlock_irqrestore(&adc->lock, flags);
+}
+EXPORT_SYMBOL(spmp8000adc_release_tp);
+
+static irqreturn_t spmp8000adc_irq(int irq, void *dev)
+{
+	struct spmp8000_adc		*adc = dev;
+	void __iomem			*regs = adc->reg_base;
+	u32				ints, ctrl;
+	s32				val_tp;
+	s16				val_chan;
+	int curchan;
+
+	ints = readl(regs + SARINTF);
+
+	dev_vdbg(adc->dev, "irq: %08X\n", ints);
+
+	if (unlikely(!ints))
+		return IRQ_NONE;
+
+	if (unlikely(ints & SARINT_PENDOWN))
+		dev_dbg(adc->dev, "IRQ: Pen down\n");
+
+	if (unlikely(ints & SARINT_PENUP))
+		dev_dbg(adc->dev, "IRQ: Pen up\n");
+
+	/* Channel measurement end in manual mode */
+	if (ints & SARINT_NAUX) {
+		spin_lock(&adc->lock);
+
+		ctrl = readl(regs + SARCTRL);
+		curchan = (ctrl & SARCTRL_SARS_MASK) >> SARCTRL_SARS_OFF;
+		dev_vdbg(adc->dev, "irq aux chan: %d\n", curchan);
+
+		/* The read also clears the interrupt */
+		val_chan = readl(regs + SARAUX);
+		if (adc->chan[curchan])
+			adc->chan[curchan]->cb(val_chan,
+						adc->chan[curchan]->priv);
+
+		if (!spmp8000adc_should_run(adc)) {
+			spin_unlock(&adc->lock);
+			return IRQ_HANDLED;
+		}
+
+		/* Select next channel */
+		curchan++;
+		if (curchan == ADC_CHANNELS - 1)
+			curchan = 0;
+
+		/* Set up next measurement */
+		spmp8000adc_ctrl(adc, 1, curchan);
+
+		spin_unlock(&adc->lock);
+	}
+
+	/* Touch panel measurement end in automatic mode */
+	if (ints & SARINT_NPNL) {
+		/* The read also clears the interrupt */
+		val_tp = readl(regs + SARPNL);
+		if (adc->tp)
+			adc->tp->cb(val_tp, adc->tp->priv);
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+static int __devinit spmp8000adc_probe(struct platform_device *pdev)
+{
+	struct spmp8000_adc		*adc;
+	struct clk			*clk_apbdma, *clk_saacc;
+	unsigned long			clkrate;
+	struct resource			*r;
+	int ret, irq;
+
+	if (adc_dev) {
+		dev_err(&pdev->dev, "ADC driver already initialized\n");
+		return -EINVAL;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	r = request_mem_region(r->start, resource_size(r), pdev->name);
+	if (!r) {
+		dev_err(&pdev->dev, "Failed to request base memory region\n");
+		return -EBUSY;
+	}
+
+	adc = kzalloc(sizeof(struct spmp8000_adc), GFP_KERNEL);
+	if (!adc) {
+		ret = -ENOMEM;
+		goto out_release_mem;
+	}
+
+	adc->reg_base = ioremap(r->start, resource_size(r));
+	if (!adc->reg_base) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	clk_apbdma = clk_get(&pdev->dev, "apbdma_a");
+	if (IS_ERR_OR_NULL(clk_apbdma)) {
+		dev_err(&pdev->dev, "Can't get data path clock\n");
+		ret = -ENODEV;
+		goto out_iounmap;
+	}
+
+	clk_saacc = clk_get(&pdev->dev, "saacc");
+	if (IS_ERR_OR_NULL(clk_saacc)) {
+		dev_err(&pdev->dev, "Can't get controller clock\n");
+		ret = -ENODEV;
+		goto out_put_clk_apbdma;
+	}
+
+	clk_enable(clk_apbdma);
+	clk_enable(clk_saacc);
+
+	clkrate = clk_get_rate(clk_saacc);
+
+	clkrate = DIV_ROUND_UP(clkrate, SAR_CLKRATE);	/* Target clkrate */
+	clkrate = DIV_ROUND_UP(clkrate, 2) - 1;		/* Divisor */
+
+	dev_dbg(&pdev->dev, "clock rate: %ld\n", clk_get_rate(clk_saacc) /
+		((clkrate + 1) * 2));
+
+	if (clkrate > 255) {
+		dev_err(&pdev->dev, "Input clockrate too high\n");
+		ret = -EINVAL;
+		goto out_clk_disable;
+	}
+
+	spin_lock_init(&adc->lock);
+	adc->dev = &pdev->dev;
+	adc->clk_apbdma = clk_apbdma;
+	adc->clk_saacc = clk_saacc;
+
+	ret = request_irq(irq, spmp8000adc_irq, 0, dev_name(&pdev->dev), adc);
+	if (ret)
+		goto out_clk_disable;
+
+	adc_dev = adc;
+	platform_set_drvdata(pdev, adc);
+
+	/* Set internal clock divider */
+	writel(clkrate << SARCTRL_DIVNUM_OFF, adc->reg_base + SARCTRL);
+
+	/* Set conversion time defaults */
+	writel(0x10010, adc->reg_base + SARAUTODLY);
+	writel(0x1000, adc->reg_base + SARDEBTIME);
+	writel(0xFF, adc->reg_base + SARCONDLY);
+
+	/* Clear pending interrupts */
+	writel(0xF, adc->reg_base + SARINTF);
+
+	/* Enable interrupts */
+	writel(0xF, adc->reg_base + SARINTEN);
+
+	dev_info(&pdev->dev, "registered\n");
+
+	return 0;
+
+out_clk_disable:
+	clk_disable(clk_saacc);
+	clk_disable(clk_apbdma);
+	clk_put(clk_saacc);
+out_put_clk_apbdma:
+	clk_put(clk_apbdma);
+out_iounmap:
+	iounmap(adc->reg_base);
+out_free:
+	kfree(adc);
+out_release_mem:
+	release_mem_region(r->start, resource_size(r));
+
+	return ret;
+}
+
+static int __devexit spmp8000adc_remove(struct platform_device *pdev)
+{
+	struct spmp8000_adc		*adc;
+	struct resource			*r;
+	int irq;
+
+	adc = platform_get_drvdata(pdev);
+
+	/* Disable and clear remaining interrupts */
+	writel(0, adc->reg_base + SARCTRL);
+	writel(0xF, adc->reg_base + SARINTEN);
+	writel(0xF, adc->reg_base + SARINTF);
+
+	clk_disable(adc->clk_saacc);
+	clk_disable(adc->clk_apbdma);
+	clk_put(adc->clk_saacc);
+	clk_put(adc->clk_apbdma);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	free_irq(irq, adc);
+
+	iounmap(adc->reg_base);
+
+	kfree(adc);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	release_mem_region(r->start, resource_size(r));
+
+	platform_set_drvdata(pdev, NULL);
+
+	dev_info(&pdev->dev, "registered\n");
+
+	return 0;
+}
+
+static const struct of_device_id spmp8000_adc_match[] __devinitdata = {
+	{ .compatible = "sunplus,spmp8000-adc" },
+	{},
+};
+
+static struct platform_driver spmp8000adc_driver = {
+	.driver		= {
+		.name	= "spmp8000-adc",
+		.owner	= THIS_MODULE,
+		.of_match_table = spmp8000_adc_match,
+	},
+	.probe		= spmp8000adc_probe,
+	.remove		= __devexit_p(spmp8000adc_remove),
+};
+
+
+static int __init spmp8000adc_init(void)
+{
+	return platform_driver_register(&spmp8000adc_driver);
+}
+module_init(spmp8000adc_init);
+
+static void __exit spmp8000adc_exit(void)
+{
+	platform_driver_unregister(&spmp8000adc_driver);
+}
+module_exit(spmp8000adc_exit);
+
+MODULE_AUTHOR("Zoltan Devai <zoss@devai.org>");
+MODULE_DESCRIPTION("ADC driver for Sunplus SPMP8000 SoC");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-spmp8000/include/mach/spmp8000adc.h b/arch/arm/mach-spmp8000/include/mach/spmp8000adc.h
new file mode 100644
index 0000000..df5dfad
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/spmp8000adc.h
@@ -0,0 +1,29 @@
+/*
+ * SPMP8000 ADC support
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef __MACH_SPMP8000_ADC_H__
+#define __MACH_SPMP8000_ADC_H__
+
+struct spmp8000adc_client_chan {
+	void	(*cb)(s16, void*); /* Callback for every measurement value */
+	void	*priv;		/* Private data for client passed to cb */
+};
+
+struct spmp8000adc_client_tp {
+	void	(*cb)(s32, void*); /* Callback for every measurement value */
+	void	*priv;		/* Private data for client passed to cb */
+};
+
+extern int spmp8000adc_request_channel(unsigned int chan,
+				struct spmp8000adc_client_chan *c);
+extern int spmp8000adc_release_channel(unsigned int chan);
+extern int spmp8000adc_request_tp(struct spmp8000adc_client_tp *tp);
+extern void spmp8000adc_release_tp(void);
+
+#endif /* __MACH_SPMP8000_ADC_H__ */
-- 
1.7.4.1

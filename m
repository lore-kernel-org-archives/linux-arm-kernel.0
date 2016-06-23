From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Jun 2016 17:46:34 +0200
Subject: [RFC PATCH v2 1/9] mailbox: Add Amlogic Meson
 Message-Handling-Unit
In-Reply-To: <CABb+yY3r3_B9wbW6D-do8h8xMKCANQWfz1gFGyre1oWadd7A8Q@mail.gmail.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
 <1466503374-28841-2-git-send-email-narmstrong@baylibre.com>
 <CABb+yY3r3_B9wbW6D-do8h8xMKCANQWfz1gFGyre1oWadd7A8Q@mail.gmail.com>
Message-ID: <576C045A.3070701@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2016 06:31 AM, Jassi Brar wrote:
> On Tue, Jun 21, 2016 at 3:32 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> Add Amlogic Meson SoCs Message-Handling-Unit as mailbox controller
>> with 2 independent channels/links to communicate with a remote processor.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> .....
> 
>> +++ b/drivers/mailbox/meson_mhu.c
>> @@ -0,0 +1,199 @@
>> +/*
>> + * Copyright (C) 2016 BayLibre SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + * Heavily based on meson_mhu.c from :
>> + * Copyright (C) 2013-2015 Fujitsu Semiconductor Ltd.
>> + * Copyright (C) 2015 Linaro Ltd.
>> + * Author: Jassi Brar <jaswinder.singh@linaro.org>
> 
> .........
>> +
>> +#define INTR_SET_OFS   0x0
>> +#define INTR_STAT_OFS  0x4
>> +#define INTR_CLR_OFS   0x8
>> +
>> +#define MHU_LP_OFFSET  0x10
>> +#define MHU_HP_OFFSET  0x1c
>> +
>> +#define TX_REG_OFFSET  0x24
>> +
> It seems only some register offsets have changed from arm_mhu. So
> maybe just adapt the arm_mhu driver to look for IP variant and assign
> corresponding offsets to set,stat,clr registers.
> 
> Cheers.
> 

Hi Jassi,

I did a quick & dirty merge with arm_mhu, and I don't it's a good idea...

Please have a look at attached patch.

Regards,
Neil
-------------------------------------------------------------------------------------------
From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] mailbox: arm_mhu: Add support for Amlogic Meson MHU

To achieve this integration, add support for generic probe from amba
or platform.
Move all register offsets to a data structure passed in either amba id or
platform dt id match table.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mailbox/arm_mhu.c | 217 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 181 insertions(+), 36 deletions(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 99befa7..d7fb843 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -22,45 +22,68 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/amba/bus.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>

-#define INTR_STAT_OFS	0x0
-#define INTR_SET_OFS	0x8
-#define INTR_CLR_OFS	0x10
+#define MHU_INTR_STAT_OFS	0x0
+#define MHU_INTR_SET_OFS	0x8
+#define MHU_INTR_CLR_OFS	0x10

 #define MHU_LP_OFFSET	0x0
 #define MHU_HP_OFFSET	0x20
 #define MHU_SEC_OFFSET	0x200
-#define TX_REG_OFFSET	0x100
+#define MHU_TX_REG_OFFSET	0x100

-#define MHU_CHANS	3
+#define MESON_INTR_SET_OFS	0x0
+#define MESON_INTR_STAT_OFS	0x4
+#define MESON_INTR_CLR_OFS	0x8
+
+#define MESON_MHU_LP_OFFSET	0x10
+#define MESON_MHU_HP_OFFSET	0x1c
+#define MESON_MHU_TX_OFFSET	0x24
+
+#define MAX_MHU_CHANS	3

 struct mhu_link {
 	unsigned irq;
-	void __iomem *tx_reg;
-	void __iomem *rx_reg;
+	void __iomem *tx_stat_reg;
+	void __iomem *tx_set_reg;
+	void __iomem *tx_clr_reg;
+	void __iomem *rx_stat_reg;
+	void __iomem *rx_set_reg;
+	void __iomem *rx_clr_reg;
 };

 struct arm_mhu {
 	void __iomem *base;
-	struct mhu_link mlink[MHU_CHANS];
-	struct mbox_chan chan[MHU_CHANS];
+	struct mhu_link mlink[MAX_MHU_CHANS];
+	struct mbox_chan chan[MAX_MHU_CHANS];
 	struct mbox_controller mbox;
 };

+struct arm_mhu_data {
+	unsigned int channels;
+	int rx_offsets[MAX_MHU_CHANS];
+	int tx_offsets[MAX_MHU_CHANS];
+	unsigned int intr_stat_offs;
+	unsigned int intr_set_offs;
+	unsigned int intr_clr_offs;
+};
+
 static irqreturn_t mhu_rx_interrupt(int irq, void *p)
 {
 	struct mbox_chan *chan = p;
 	struct mhu_link *mlink = chan->con_priv;
 	u32 val;

-	val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
+	val = readl_relaxed(mlink->rx_stat_reg);
 	if (!val)
 		return IRQ_NONE;

 	mbox_chan_received_data(chan, (void *)&val);

-	writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
+	writel_relaxed(val, mlink->rx_clr_reg);

 	return IRQ_HANDLED;
 }
@@ -68,7 +91,7 @@ static irqreturn_t mhu_rx_interrupt(int irq, void *p)
 static bool mhu_last_tx_done(struct mbox_chan *chan)
 {
 	struct mhu_link *mlink = chan->con_priv;
-	u32 val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
+	u32 val = readl_relaxed(mlink->tx_stat_reg);

 	return (val == 0);
 }
@@ -78,7 +101,7 @@ static int mhu_send_data(struct mbox_chan *chan, void *data)
 	struct mhu_link *mlink = chan->con_priv;
 	u32 *arg = data;

-	writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
+	writel_relaxed(*arg, mlink->tx_set_reg);

 	return 0;
 }
@@ -89,8 +112,8 @@ static int mhu_startup(struct mbox_chan *chan)
 	u32 val;
 	int ret;

-	val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
-	writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
+	val = readl_relaxed(mlink->tx_stat_reg);
+	writel_relaxed(val, mlink->tx_clr_reg);

 	ret = request_irq(mlink->irq, mhu_rx_interrupt,
 			  IRQF_SHARED, "mhu_link", chan);
@@ -117,52 +140,155 @@ static const struct mbox_chan_ops mhu_ops = {
 	.last_tx_done = mhu_last_tx_done,
 };

-static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
+static struct arm_mhu_data arm_mhu_amba_data = {
+	.channels = 3,
+	.rx_offsets = {MHU_LP_OFFSET, MHU_HP_OFFSET, MHU_SEC_OFFSET},
+	.tx_offsets = {MHU_LP_OFFSET + MHU_TX_REG_OFFSET,
+		       MHU_HP_OFFSET + MHU_TX_REG_OFFSET,
+		       MHU_SEC_OFFSET + MHU_TX_REG_OFFSET},
+	.intr_stat_offs = MHU_INTR_STAT_OFS,
+	.intr_set_offs = MHU_INTR_SET_OFS,
+	.intr_clr_offs = MHU_INTR_CLR_OFS,
+};
+
+static const struct arm_mhu_data meson_mhu_data = {
+	.channels = 2,
+	.rx_offsets = {MESON_MHU_LP_OFFSET, MESON_MHU_HP_OFFSET},
+	.tx_offsets = {MESON_MHU_LP_OFFSET + MESON_MHU_TX_OFFSET,
+		       MESON_MHU_HP_OFFSET + MESON_MHU_TX_OFFSET},
+	.intr_stat_offs = MESON_INTR_STAT_OFS,
+	.intr_set_offs = MESON_INTR_SET_OFS,
+	.intr_clr_offs = MESON_INTR_CLR_OFS,
+};
+
+static struct arm_mhu *mhu_generic_probe(struct device *dev,
+					 struct resource *res,
+					 unsigned int irqs[],
+					 const struct arm_mhu_data *data)
 {
 	int i, err;
 	struct arm_mhu *mhu;
-	struct device *dev = &adev->dev;
-	int mhu_reg[MHU_CHANS] = {MHU_LP_OFFSET, MHU_HP_OFFSET, MHU_SEC_OFFSET};

 	/* Allocate memory for device */
 	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
 	if (!mhu)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);

-	mhu->base = devm_ioremap_resource(dev, &adev->res);
+	mhu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(mhu->base)) {
 		dev_err(dev, "ioremap failed\n");
-		return PTR_ERR(mhu->base);
+		return ERR_CAST(mhu->base);
 	}

-	for (i = 0; i < MHU_CHANS; i++) {
+	for (i = 0; i < data->channels; i++) {
+		void __iomem *reg_base;
 		mhu->chan[i].con_priv = &mhu->mlink[i];
-		mhu->mlink[i].irq = adev->irq[i];
-		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
-		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
+		mhu->mlink[i].irq = irqs[i];
+		reg_base = mhu->base + data->rx_offsets[i];
+		mhu->mlink[i].rx_stat_reg = reg_base + data->intr_stat_offs;
+		mhu->mlink[i].rx_set_reg = reg_base + data->intr_set_offs;
+		mhu->mlink[i].rx_clr_reg = reg_base + data->intr_clr_offs;
+		reg_base = mhu->base + data->tx_offsets[i];
+		mhu->mlink[i].rx_stat_reg = reg_base + data->intr_stat_offs;
+		mhu->mlink[i].rx_set_reg = reg_base + data->intr_set_offs;
+		mhu->mlink[i].rx_clr_reg = reg_base + data->intr_clr_offs;
 	}

 	mhu->mbox.dev = dev;
 	mhu->mbox.chans = &mhu->chan[0];
-	mhu->mbox.num_chans = MHU_CHANS;
+	mhu->mbox.num_chans = data->channels;
 	mhu->mbox.ops = &mhu_ops;
 	mhu->mbox.txdone_irq = false;
 	mhu->mbox.txdone_poll = true;
 	mhu->mbox.txpoll_period = 1;

-	amba_set_drvdata(adev, mhu);
-
 	err = mbox_controller_register(&mhu->mbox);
 	if (err) {
 		dev_err(dev, "Failed to register mailboxes %d\n", err);
-		return err;
+		return ERR_PTR(err);
 	}

 	dev_info(dev, "ARM MHU Mailbox registered\n");
 	return 0;
+};
+
+static const struct of_device_id mhu_dt_ids[] = {
+	{ .compatible = "amlogic,meson-gxbb-mhu", .data = &meson_mhu_data},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mhu_dt_ids);
+
+static int mhu_platform_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	unsigned int irqs[MAX_MHU_CHANS];
+	const struct arm_mhu_data *data;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct arm_mhu *mhu;
+	int i;
+
+	match = of_match_device(mhu_dt_ids, &pdev->dev);
+	if (!match)
+		return -EINVAL;
+
+	data = match->data;
+	if (!data)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (WARN_ON(!res))
+		return -EINVAL;
+
+	for (i = 0 ; i < data->channels ; ++i) {
+		irqs[i] = platform_get_irq(pdev, i);
+		if (WARN_ON(irqs[i] < 0))
+			return irqs[i];
+	}
+
+	mhu = mhu_generic_probe(dev, res, irqs, data);
+	if (IS_ERR(mhu))
+		return PTR_ERR(mhu);
+
+	platform_set_drvdata(pdev, mhu);
+
+	return 0;
+}
+
+static int mhu_platform_remove(struct platform_device *pdev)
+{
+	struct arm_mhu *mhu = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&mhu->mbox);
+
+	return 0;
+}
+
+static struct platform_driver mhu_platform_driver = {
+	.probe	= mhu_platform_probe,
+	.remove	= mhu_platform_remove,
+	.driver = {
+		.name = "meson-mhu",
+		.of_match_table	= mhu_dt_ids,
+	},
+};
+
+static int mhu_amba_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	const struct arm_mhu_data *data = id->data;
+	struct device *dev = &adev->dev;
+	struct arm_mhu *mhu;
+
+	mhu = mhu_generic_probe(dev, &adev->res, adev->irq, data);
+	if (IS_ERR(mhu))
+		return PTR_ERR(mhu);
+
+	amba_set_drvdata(adev, mhu);
+
+	return 0;
 }

-static int mhu_remove(struct amba_device *adev)
+static int mhu_amba_remove(struct amba_device *adev)
 {
 	struct arm_mhu *mhu = amba_get_drvdata(adev);

@@ -171,24 +297,43 @@ static int mhu_remove(struct amba_device *adev)
 	return 0;
 }

-static struct amba_id mhu_ids[] = {
+static struct amba_id mhu_amba_ids[] = {
 	{
 		.id	= 0x1bb098,
 		.mask	= 0xffffff,
+		.data	= &arm_mhu_amba_data,
 	},
 	{ 0, 0 },
 };
-MODULE_DEVICE_TABLE(amba, mhu_ids);
+MODULE_DEVICE_TABLE(amba, mhu_amba_ids);

 static struct amba_driver arm_mhu_driver = {
 	.drv = {
 		.name	= "mhu",
 	},
-	.id_table	= mhu_ids,
-	.probe		= mhu_probe,
-	.remove		= mhu_remove,
+	.id_table	= mhu_amba_ids,
+	.probe		= mhu_amba_probe,
+	.remove		= mhu_amba_remove,
 };
-module_amba_driver(arm_mhu_driver);
+
+static int __init mhu_module_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mhu_platform_driver);
+	if (ret)
+		return ret;
+
+	return amba_driver_register(&arm_mhu_driver);
+}
+module_init(mhu_module_init);
+
+static void __exit mhu_module_exit(void)
+{
+	platform_driver_unregister(&mhu_platform_driver);
+	amba_driver_unregister(&arm_mhu_driver);
+}
+module_exit(mhu_module_exit);

 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ARM MHU Driver");
-- 
2.7.0

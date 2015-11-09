From: dhdang@apm.com (Duc Dang)
Date: Mon,  9 Nov 2015 10:05:43 -0800
Subject: [PATCH v3 1/3] mailbox: Add support for APM X-Gene platform mailbox
 driver
In-Reply-To: <cover.1447091625.git.dhdang@apm.com>
References: <cover.1447091625.git.dhdang@apm.com>
Message-ID: <b6f12c4d5f45205c356a61acd26aecff70b54e68.1447091626.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X-Gene mailbox controller provides 8 mailbox channels, with
each channel has a dedicated interrupt line.

[dhdang: rebase over 4.3-rc5, some minor changes to
address comment in v2 patch set]
Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
---
 drivers/mailbox/Kconfig                 |   9 ++
 drivers/mailbox/Makefile                |   2 +
 drivers/mailbox/mailbox-xgene-slimpro.c | 264 ++++++++++++++++++++++++++++++++
 3 files changed, 275 insertions(+)
 create mode 100644 drivers/mailbox/mailbox-xgene-slimpro.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index bbec500..ae37d39 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -71,4 +71,13 @@ config BCM2835_MBOX
 	  the services of the Videocore. Say Y here if you want to use the
 	  BCM2835 Mailbox.
 
+config XGENE_SLIMPRO_MBOX
+	tristate "APM SoC X-Gene SLIMpro Mailbox Controller"
+	depends on ARCH_XGENE
+	help
+	  An implementation of the APM X-Gene Interprocessor Communication
+	  Mailbox (IPCM) between the ARM 64-bit cores and SLIMpro controller.
+	  It is used to send short messages between ARM64-bit cores and
+	  the SLIMpro Management Engine, primarily for PM. Say Y here if you
+	  want to use the APM X-Gene SLIMpro IPCM support.
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 8e6d822..6a78df7 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -13,3 +13,5 @@ obj-$(CONFIG_PCC)		+= pcc.o
 obj-$(CONFIG_ALTERA_MBOX)	+= mailbox-altera.o
 
 obj-$(CONFIG_BCM2835_MBOX)	+= bcm2835-mailbox.o
+
+obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
diff --git a/drivers/mailbox/mailbox-xgene-slimpro.c b/drivers/mailbox/mailbox-xgene-slimpro.c
new file mode 100644
index 0000000..4753353
--- /dev/null
+++ b/drivers/mailbox/mailbox-xgene-slimpro.c
@@ -0,0 +1,264 @@
+/*
+ * APM X-Gene SLIMpro MailBox Driver
+ *
+ * Copyright (c) 2015, Applied Micro Circuits Corporation
+ * Author: Feng Kan fkan at apm.com
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#define MBOX_CON_NAME			"slimpro-mbox"
+#define MBOX_REG_SET_OFFSET		0x1000
+#define MBOX_CNT			8
+#define MBOX_STATUS_AVAIL_MASK		BIT(16)
+#define MBOX_STATUS_ACK_MASK		BIT(0)
+
+/* Configuration and Status Registers */
+#define REG_DB_IN		0x00
+#define REG_DB_DIN0		0x04
+#define REG_DB_DIN1		0x08
+#define REG_DB_OUT		0x10
+#define REG_DB_DOUT0		0x14
+#define REG_DB_DOUT1		0x18
+#define REG_DB_STAT		0x20
+#define REG_DB_STATMASK		0x24
+
+struct slimpro_mbox_chan {
+	struct device *dev;
+	struct mbox_chan *chan;
+	void __iomem *reg;
+	int id;
+	int irq;
+	u32 rx_msg[3];
+};
+
+struct slimpro_mbox {
+	struct mbox_controller mb_ctrl;
+	struct slimpro_mbox_chan mc[MBOX_CNT];
+	struct mbox_chan chans[MBOX_CNT];
+};
+
+static void mb_chan_send_msg(struct slimpro_mbox_chan *mb_chan, u32 *msg)
+{
+	writel(msg[1], mb_chan->reg + REG_DB_DOUT0);
+	writel(msg[2], mb_chan->reg + REG_DB_DOUT1);
+	writel(msg[0], mb_chan->reg + REG_DB_OUT);
+}
+
+static void mb_chan_recv_msg(struct slimpro_mbox_chan *mb_chan)
+{
+	mb_chan->rx_msg[1] = readl(mb_chan->reg + REG_DB_DIN0);
+	mb_chan->rx_msg[2] = readl(mb_chan->reg + REG_DB_DIN1);
+	mb_chan->rx_msg[0] = readl(mb_chan->reg + REG_DB_IN);
+}
+
+static void mb_chan_enable_int(struct slimpro_mbox_chan *mb_chan, u32 mask)
+{
+	u32 val = readl(mb_chan->reg + REG_DB_STATMASK);
+
+	val &= ~mask;
+	writel(val, mb_chan->reg + REG_DB_STATMASK);
+}
+
+static void mb_chan_disable_int(struct slimpro_mbox_chan *mb_chan, u32 mask)
+{
+	u32 val = readl(mb_chan->reg + REG_DB_STATMASK);
+
+	val |= mask;
+	writel(val, mb_chan->reg + REG_DB_STATMASK);
+}
+
+static int mb_chan_status_ack(struct slimpro_mbox_chan *mb_chan)
+{
+	u32 val = readl(mb_chan->reg + REG_DB_STAT);
+
+	if (val & MBOX_STATUS_ACK_MASK) {
+		writel(MBOX_STATUS_ACK_MASK, mb_chan->reg + REG_DB_STAT);
+		return 1;
+	}
+	return 0;
+}
+
+static int mb_chan_status_avail(struct slimpro_mbox_chan *mb_chan)
+{
+	u32 val = readl(mb_chan->reg + REG_DB_STAT);
+
+	if (val & MBOX_STATUS_AVAIL_MASK) {
+		mb_chan_recv_msg(mb_chan);
+		writel(MBOX_STATUS_AVAIL_MASK, mb_chan->reg + REG_DB_STAT);
+		return 1;
+	}
+	return 0;
+}
+
+static irqreturn_t slimpro_mbox_irq(int irq, void *id)
+{
+	struct slimpro_mbox_chan *mb_chan = id;
+
+	if (mb_chan_status_ack(mb_chan))
+		mbox_chan_txdone(mb_chan->chan, 0);
+
+	if (mb_chan_status_avail(mb_chan))
+		mbox_chan_received_data(mb_chan->chan, mb_chan->rx_msg);
+
+	return IRQ_HANDLED;
+}
+
+static int slimpro_mbox_send_data(struct mbox_chan *chan, void *msg)
+{
+	struct slimpro_mbox_chan *mb_chan =
+				(struct slimpro_mbox_chan *)chan->con_priv;
+
+	mb_chan_send_msg(mb_chan, msg);
+	return 0;
+}
+
+static int slimpro_mbox_startup(struct mbox_chan *chan)
+{
+	struct slimpro_mbox_chan *mb_chan =
+				(struct slimpro_mbox_chan *)chan->con_priv;
+	int rc;
+
+	rc = devm_request_irq(mb_chan->dev, mb_chan->irq, slimpro_mbox_irq, 0,
+			      MBOX_CON_NAME, mb_chan);
+	if (unlikely(rc)) {
+		dev_err(mb_chan->dev, "failed to register mailbox interrupt %d\n",
+			mb_chan->irq);
+		return rc;
+	}
+
+	/* Enable HW interrupt */
+	writel(MBOX_STATUS_ACK_MASK | MBOX_STATUS_AVAIL_MASK,
+	       mb_chan->reg + REG_DB_STAT);
+	mb_chan_enable_int(mb_chan, MBOX_STATUS_ACK_MASK |
+					MBOX_STATUS_AVAIL_MASK);
+	return 0;
+}
+
+static void slimpro_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct slimpro_mbox_chan *mb_chan =
+				(struct slimpro_mbox_chan *)chan->con_priv;
+
+	mb_chan_disable_int(mb_chan, MBOX_STATUS_ACK_MASK |
+				  MBOX_STATUS_AVAIL_MASK);
+	devm_free_irq(mb_chan->dev, mb_chan->irq, mb_chan);
+}
+
+static struct mbox_chan_ops slimpro_mbox_ops = {
+	.send_data = slimpro_mbox_send_data,
+	.startup = slimpro_mbox_startup,
+	.shutdown = slimpro_mbox_shutdown,
+};
+
+static int __init slimpro_mbox_probe(struct platform_device *pdev)
+{
+	struct slimpro_mbox *ctx;
+	struct resource *regs;
+	void __iomem *mb_base;
+	int rc;
+	int i;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(struct slimpro_mbox), GFP_KERNEL);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	platform_set_drvdata(pdev, ctx);
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mb_base = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
+	if (IS_ERR(mb_base))
+		return PTR_ERR(mb_base);
+
+	/* Setup mailbox links */
+	for (i = 0; i < MBOX_CNT; i++) {
+		ctx->mc[i].irq = platform_get_irq(pdev, i);
+		if (ctx->mc[i].irq < 0) {
+			dev_err(&pdev->dev, "no IRQ at index %d\n",
+				ctx->mc[i].irq);
+			return -ENODEV;
+		}
+
+		ctx->mc[i].dev = &pdev->dev;
+		ctx->mc[i].reg = mb_base + i * MBOX_REG_SET_OFFSET;
+		ctx->mc[i].id = i;
+		ctx->mc[i].chan = &ctx->chans[i];
+		ctx->chans[i].con_priv = &ctx->mc[i];
+	}
+
+	/* Setup mailbox controller */
+	ctx->mb_ctrl.dev = &pdev->dev;
+	ctx->mb_ctrl.chans = ctx->chans;
+	ctx->mb_ctrl.txdone_irq = true;
+	ctx->mb_ctrl.ops = &slimpro_mbox_ops;
+	ctx->mb_ctrl.num_chans = MBOX_CNT;
+
+	rc = mbox_controller_register(&ctx->mb_ctrl);
+	if (rc) {
+		dev_err(&pdev->dev,
+			"APM X-Gene SLIMpro MailBox register failed:%d\n", rc);
+		return rc;
+	}
+
+	dev_info(&pdev->dev, "APM X-Gene SLIMpro MailBox registered\n");
+	return 0;
+}
+
+static int slimpro_mbox_remove(struct platform_device *pdev)
+{
+	struct slimpro_mbox *smb = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&smb->mb_ctrl);
+	return 0;
+}
+
+static const struct of_device_id slimpro_of_match[] = {
+	{.compatible = "apm,xgene-slimpro-mbox" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, slimpro_of_match);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id slimpro_acpi_ids[] = {
+	{"APMC0D01", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, slimpro_acpi_ids);
+#endif
+
+static struct platform_driver slimpro_mbox_driver = {
+	.probe	= slimpro_mbox_probe,
+	.remove = slimpro_mbox_remove,
+	.driver	= {
+		.name = "xgene-slimpro-mbox",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(slimpro_of_match),
+		.acpi_match_table = ACPI_PTR(slimpro_acpi_ids)
+	},
+};
+
+module_platform_driver(slimpro_mbox_driver);
+
+MODULE_DESCRIPTION("APM X-Gene SLIMpro Mailbox Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1

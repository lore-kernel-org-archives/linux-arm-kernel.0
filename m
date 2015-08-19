From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Aug 2015 12:20:05 +0800
Subject: [PATCH v3 4/8] rsb: sunxi: Add driver for Allwinner Reduced Serial
 Bus controller
In-Reply-To: <1439958009-14056-1-git-send-email-wens@csie.org>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
Message-ID: <1439958009-14056-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rsb/Kconfig     |  15 ++
 drivers/rsb/Makefile    |   2 +
 drivers/rsb/rsb-sunxi.c | 441 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 458 insertions(+)
 create mode 100644 drivers/rsb/rsb-sunxi.c

diff --git a/drivers/rsb/Kconfig b/drivers/rsb/Kconfig
index 6642e1db6d98..54a28a39e0e2 100644
--- a/drivers/rsb/Kconfig
+++ b/drivers/rsb/Kconfig
@@ -9,3 +9,18 @@ menuconfig RSB
 	  Integrated Circuits (PMIC) or other peripherals.
 
 	  These are commonly seen on newer Allwinner SoCs and X-Powers ICs.
+
+if RSB
+
+config RSB_SUNXI
+	tristate "Allwinner RSB Controller"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	default MACH_SUN8I || MACH_SUN9I
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in RSB controller on Allwinner sun8i/sun9i family SoCs.
+
+	  This is required for communicating with X-Powers PMICs and other
+	  devices that have the RSB interface.
+
+endif
diff --git a/drivers/rsb/Makefile b/drivers/rsb/Makefile
index 6fe56526fbf3..31cd615f7e58 100644
--- a/drivers/rsb/Makefile
+++ b/drivers/rsb/Makefile
@@ -2,3 +2,5 @@
 # Makefile for kernel RSB framework.
 #
 obj-$(CONFIG_RSB)	+= rsb-core.o
+
+obj-$(CONFIG_RSB_SUNXI)	+= rsb-sunxi.o
diff --git a/drivers/rsb/rsb-sunxi.c b/drivers/rsb/rsb-sunxi.c
new file mode 100644
index 000000000000..07b24291fe4d
--- /dev/null
+++ b/drivers/rsb/rsb-sunxi.c
@@ -0,0 +1,441 @@
+/*
+ * RSB (Reduced Serial Bus) driver.
+ *
+ * Author: Chen-Yu Tsai <wens@csie.org>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * The RSB controller looks like an SMBus controller which only supports
+ * byte and word data transfers. But, it differs from standard SMBus
+ * protocol on several aspects:
+ * - it uses addresses set at runtime to address slaves. Runtime addresses
+ *   are sent to slaves using their 12bit hardware addresses. Up to 15
+ *   runtime addresses are available.
+ * - it adds a parity bit every 8bits of data and address for read and
+ *   write accesses; this replaces the ack bit
+ * - only one read access is required to read a byte (instead of a write
+ *   followed by a read access in standard SMBus protocol)
+ * - there's no Ack bit after each read access
+ *
+ * This means this bus cannot be used to interface with standard SMBus
+ * devices. Devices known to support this interface include the AXP223,
+ * AXP809, and AXP806 PMICs, and the AC100 audio codec, all from X-Powers.
+ *
+ * A description of the operation and wire protocol can be found in the
+ * RSB section of Allwinner's A80 user manual, which can be found at
+ *
+ *     https://github.com/allwinner-zh/documents/tree/master/A80
+ *
+ * This document is officially released by Allwinner.
+ *
+ * This driver is based on i2c-sun6i-p2wi.c, the P2WI bus driver.
+ *
+ */
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/rsb.h>
+
+/* RSB registers */
+#define RSB_CTRL	0x0	/* Global control */
+#define RSB_CCR		0x4	/* Clock control */
+#define RSB_INTE	0x8	/* Interrupt controls */
+#define RSB_INTS	0xc	/* Interrupt status */
+#define RSB_ADDR	0x10	/* Address to send with read/write command */
+#define RSB_DATA	0x1c	/* Data to read/write */
+#define RSB_LCR		0x24	/* Line control */
+#define RSB_DMCR	0x28	/* Device mode (init) control */
+#define RSB_CMD		0x2c	/* RSB Command */
+#define RSB_DAR		0x30	/* Device address / runtime address */
+
+/* CTRL fields */
+#define RSB_CTRL_START_TRANS		BIT(7)
+#define RSB_CTRL_ABORT_TRANS		BIT(6)
+#define RSB_CTRL_GLOBAL_INT_ENB		BIT(1)
+#define RSB_CTRL_SOFT_RST		BIT(0)
+
+/* CLK CTRL fields */
+#define RSB_CCR_SDA_OUT_DELAY(v)	(((v) & 0x7) << 8)
+#define RSB_CCR_MAX_CLK_DIV		0xff
+#define RSB_CCR_CLK_DIV(v)		((v) & RSB_CCR_MAX_CLK_DIV)
+
+/* STATUS fields */
+#define RSB_INTS_TRANS_ERR_ACK		BIT(16)
+#define RSB_INTS_TRANS_ERR_DATA_BIT(v)	(((v) >> 8) & 0xf)
+#define RSB_INTS_TRANS_ERR_DATA		GENMASK(11, 8)
+#define RSB_INTS_LOAD_BSY		BIT(2)
+#define RSB_INTS_TRANS_ERR		BIT(1)
+#define RSB_INTS_TRANS_OVER		BIT(0)
+
+/* LINE CTRL fields*/
+#define RSB_LCR_SCL_STATE		BIT(5)
+#define RSB_LCR_SDA_STATE		BIT(4)
+#define RSB_LCR_SCL_CTL			BIT(3)
+#define RSB_LCR_SCL_CTL_EN		BIT(2)
+#define RSB_LCR_SDA_CTL			BIT(1)
+#define RSB_LCR_SDA_CTL_EN		BIT(0)
+
+/* DEVICE MODE CTRL field values */
+#define RSB_DMCR_DEVICE_START		BIT(31)
+#define RSB_DMCR_MODE_DATA		(0x7c << 16)
+#define RSB_DMCR_MODE_REG		(0x3e << 8)
+#define RSB_DMCR_DEV_ADDR		0x00
+
+/* CMD values */
+#define RSB_CMD_RD8			0x8b
+#define RSB_CMD_RD16			0x9c
+#define RSB_CMD_RD32			0xa6
+#define RSB_CMD_WR8			0x4e
+#define RSB_CMD_WR16			0x59
+#define RSB_CMD_WR32			0x63
+#define RSB_CMD_STRA			0xe8
+
+/* DAR fields */
+#define RSB_DAR_RTA(v)			(((v) & 0xff) << 16)
+#define RSB_DAR_DA(v)			((v) & 0xffff)
+
+#define RSB_MAX_FREQ			20000000
+
+#define RSB_CTRL_NAME			"sunxi-rsb"
+
+struct rsb {
+	struct rsb_controller *ctrl;
+	void __iomem *regs;
+	struct clk *clk;
+	struct reset_control *rstc;
+	struct completion complete;
+	unsigned int status;
+};
+
+static irqreturn_t rsb_interrupt(int irq, void *dev_id)
+{
+	struct rsb *rsb = dev_id;
+	u32 status;
+
+	/* Clear interrupts */
+	status = readl(rsb->regs + RSB_INTS);
+	rsb->status = status;
+	writel(status, rsb->regs + RSB_INTS);
+
+	complete(&rsb->complete);
+
+	return IRQ_HANDLED;
+}
+
+/* common code that starts a transfer */
+static int rsb_run_xfer(struct rsb *rsb)
+{
+	if (readl(rsb->regs + RSB_CTRL) & RSB_CTRL_START_TRANS) {
+		dev_dbg(&rsb->ctrl->dev, "RSB transfer still in progress\n");
+		return -EBUSY;
+	}
+
+	reinit_completion(&rsb->complete);
+
+	writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
+	       rsb->regs + RSB_INTE);
+	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
+	       rsb->regs + RSB_CTRL);
+
+	if (!wait_for_completion_io_timeout(&rsb->complete,
+					    msecs_to_jiffies(100))) {
+		dev_dbg(&rsb->ctrl->dev, "RSB timeout\n");
+
+		/* abort the transfer */
+		writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
+
+		/* clear any interrupt flags */
+		writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
+
+		return -ETIMEDOUT;
+	}
+
+	if (rsb->status & RSB_INTS_LOAD_BSY) {
+		dev_dbg(&rsb->ctrl->dev, "RSB busy\n");
+		return -EBUSY;
+	}
+
+	if (rsb->status & RSB_INTS_TRANS_ERR_ACK) {
+		dev_dbg(&rsb->ctrl->dev, "RSB slave nack\n");
+		return -EINVAL;
+	}
+
+	if (rsb->status & RSB_INTS_TRANS_ERR_DATA) {
+		dev_dbg(&rsb->ctrl->dev, "RSB transfer data error\n");
+		return -EIO;
+	}
+
+	/* This should be covered by the above 2 cases */
+	if (rsb->status & RSB_INTS_TRANS_ERR) {
+		dev_dbg(&rsb->ctrl->dev, "bus transfer error\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int rsb_read_cmd(struct rsb_controller *ctrl, u8 rtaddr,
+			u8 addr, u32 *buf, size_t len)
+{
+	struct rsb *rsb = rsb_controller_get_drvdata(ctrl);
+	u32 cmd;
+	int ret;
+
+	if (!buf)
+		return -EINVAL;
+
+	switch (len) {
+	case 1:
+		cmd = RSB_CMD_RD8;
+		break;
+	case 2:
+		cmd = RSB_CMD_RD16;
+		break;
+	case 4:
+		cmd = RSB_CMD_RD32;
+		break;
+	default:
+		dev_err(&ctrl->dev, "Invalid access width: %d", len);
+		return -EINVAL;
+	}
+
+	writel(addr, rsb->regs + RSB_ADDR);
+	writel(RSB_DAR_RTA(rtaddr), rsb->regs + RSB_DAR);
+	writel(cmd, rsb->regs + RSB_CMD);
+
+	ret = rsb_run_xfer(rsb);
+	if (ret)
+		return ret;
+
+	*buf = readl(rsb->regs + RSB_DATA);
+
+	return 0;
+}
+
+static int rsb_write_cmd(struct rsb_controller *ctrl, u8 rtaddr,
+			 u8 addr, const u32 *buf, size_t len)
+{
+	struct rsb *rsb = rsb_controller_get_drvdata(ctrl);
+	u32 cmd;
+
+	if (!buf)
+		return -EINVAL;
+
+	switch (len) {
+	case 1:
+		cmd = RSB_CMD_WR8;
+		break;
+	case 2:
+		cmd = RSB_CMD_WR16;
+		break;
+	case 4:
+		cmd = RSB_CMD_WR32;
+		break;
+	default:
+		dev_err(&ctrl->dev, "Invalid access width: %d", len);
+		return -EINVAL;
+	}
+
+	writel(addr, rsb->regs + RSB_ADDR);
+	writel(RSB_DAR_RTA(rtaddr), rsb->regs + RSB_DAR);
+	writel(*buf, rsb->regs + RSB_DATA);
+	writel(cmd, rsb->regs + RSB_CMD);
+
+	return rsb_run_xfer(rsb);
+}
+
+static int rsb_rtsaddr_cmd(struct rsb_controller *ctrl, u16 hwaddr, u8 rtaddr)
+{
+	struct rsb *rsb = rsb_controller_get_drvdata(ctrl);
+
+	/* setup command parameters */
+	writel(RSB_DAR_RTA(rtaddr) | RSB_DAR_DA(hwaddr), rsb->regs + RSB_DAR);
+	writel(RSB_CMD_STRA, rsb->regs + RSB_CMD);
+
+	/* send command */
+	return rsb_run_xfer(rsb);
+}
+
+static int rsb_init_cmd(struct rsb_controller *ctrl)
+{
+	struct rsb *rsb = rsb_controller_get_drvdata(ctrl);
+	int reg;
+
+	/* send init sequence */
+	writel(RSB_DMCR_DEVICE_START | RSB_DMCR_MODE_DATA |
+	       RSB_DMCR_MODE_REG | RSB_DMCR_DEV_ADDR, rsb->regs + RSB_DMCR);
+
+	readl_poll_timeout(rsb->regs + RSB_DMCR, reg,
+			   !(reg & RSB_DMCR_DEVICE_START), 100, 250000);
+	if (reg & RSB_DMCR_DEVICE_START)
+		dev_warn(&ctrl->dev, "send init sequence timeout\n");
+
+	/* clear any interrupt flags */
+	writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
+
+	return 0;
+}
+
+static const struct of_device_id rsb_of_match_table[] = {
+	{ .compatible = "allwinner,sun8i-a23-rsb" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rsb_of_match_table);
+
+static int rsb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *r;
+	struct rsb_controller *ctrl;
+	struct rsb *rsb;
+	unsigned long parent_clk_freq;
+	u32 clk_freq = 100000;
+	int clk_div;
+	int irq;
+	int ret;
+	u32 reg;
+
+	of_property_read_u32(np, "clock-frequency", &clk_freq);
+	if (clk_freq > RSB_MAX_FREQ) {
+		dev_err(dev,
+			"clock-frequency (%u Hz) is too high (max = 20MHz)",
+			clk_freq);
+		return -EINVAL;
+	}
+
+	ctrl = rsb_controller_alloc(dev, sizeof(*rsb));
+	if (!ctrl)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ctrl);
+
+	/* set callbacks */
+	ctrl->init_cmd = rsb_init_cmd;
+	ctrl->rtsaddr_cmd = rsb_rtsaddr_cmd;
+	ctrl->read_cmd = rsb_read_cmd;
+	ctrl->write_cmd = rsb_write_cmd;
+
+	rsb = rsb_controller_get_drvdata(ctrl);
+	rsb->ctrl = ctrl;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rsb->regs = devm_ioremap_resource(dev, r);
+	if (IS_ERR(rsb->regs)) {
+		ret = PTR_ERR(rsb->regs);
+		goto err_rsb_controller_put;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "failed to retrieve irq: %d\n", irq);
+		ret = irq;
+		goto err_rsb_controller_put;
+	}
+
+	rsb->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(rsb->clk)) {
+		ret = PTR_ERR(rsb->clk);
+		dev_err(dev, "failed to retrieve clk: %d\n", ret);
+		goto err_rsb_controller_put;
+	}
+
+	ret = clk_prepare_enable(rsb->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clk: %d\n", ret);
+		goto err_rsb_controller_put;
+	}
+
+	parent_clk_freq = clk_get_rate(rsb->clk);
+
+	rsb->rstc = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(rsb->rstc)) {
+		ret = PTR_ERR(rsb->rstc);
+		dev_err(dev, "failed to retrieve reset controller: %d\n", ret);
+		goto err_clk_disable;
+	}
+
+	ret = reset_control_deassert(rsb->rstc);
+	if (ret) {
+		dev_err(dev, "failed to deassert reset line: %d\n", ret);
+		goto err_clk_disable;
+	}
+
+	init_completion(&rsb->complete);
+
+	/* reset the controller */
+	writel(RSB_CTRL_SOFT_RST, rsb->regs + RSB_CTRL);
+	readl_poll_timeout(rsb->regs + RSB_CTRL, reg,
+			   !(reg & RSB_CTRL_SOFT_RST), 1000, 100000);
+
+	clk_div = parent_clk_freq / clk_freq;
+	if (!clk_div) {
+		dev_warn(dev,
+			 "clock-frequency is too high, setting it to %lu Hz\n",
+			 parent_clk_freq);
+		clk_div = 1;
+	} else if (clk_div > RSB_CCR_MAX_CLK_DIV + 1) {
+		dev_warn(dev,
+			 "clock-frequency is too low, setting it to %lu Hz\n",
+			 parent_clk_freq / (RSB_CCR_MAX_CLK_DIV + 1));
+		clk_div = RSB_CCR_MAX_CLK_DIV + 1;
+	}
+
+	writel(RSB_CCR_SDA_OUT_DELAY(1) | RSB_CCR_CLK_DIV(clk_div - 1),
+	       rsb->regs + RSB_CCR);
+
+	ret = devm_request_irq(dev, irq, rsb_interrupt, 0, RSB_CTRL_NAME, rsb);
+	if (ret) {
+		dev_err(dev, "can't register interrupt handler irq%d: %d\n",
+			irq, ret);
+		goto err_reset_assert;
+	}
+
+	ret = rsb_controller_add(ctrl);
+	if (!ret)
+		return 0;
+
+err_reset_assert:
+	reset_control_assert(rsb->rstc);
+
+err_clk_disable:
+	clk_disable_unprepare(rsb->clk);
+
+err_rsb_controller_put:
+	rsb_controller_put(ctrl);
+
+	return ret;
+}
+
+static int rsb_remove(struct platform_device *pdev)
+{
+	struct rsb_controller *ctrl = platform_get_drvdata(pdev);
+	struct rsb *rsb = rsb_controller_get_drvdata(ctrl);
+
+	rsb_controller_remove(ctrl);
+	reset_control_assert(rsb->rstc);
+	clk_disable_unprepare(rsb->clk);
+
+	return 0;
+}
+
+static struct platform_driver rsb_driver = {
+	.probe = rsb_probe,
+	.remove	= rsb_remove,
+	.driver	= {
+		.name = "rsb-sunxi",
+		.of_match_table = rsb_of_match_table,
+	},
+};
+module_platform_driver(rsb_driver);
+
+MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
+MODULE_DESCRIPTION("Allwinner RSB driver");
+MODULE_LICENSE("GPL v2");
-- 
2.5.0

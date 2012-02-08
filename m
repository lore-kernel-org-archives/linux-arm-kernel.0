From: 21cnbao@gmail.com (Barry Song)
Date: Wed,  8 Feb 2012 23:28:35 +0800
Subject: [PATCH v6] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Message-ID: <1328714915-12287-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiwu Song <Zhiwu.Song@csr.com>

SiRFprimaII is the latest generation application processor from CSR?s
multi-function SoC product family.
The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
3.0.
There are two I2C controllers on primaII, features include:
* Two I2C controller modules are on chip
* RISC I/O bus read write register
* Up to 16 bytes data buffer for issuing commands and writing data
  at the same time
* Up to 16 commands, and receiving read data 16 bytes at a time
* Error INT report (ACK check)
* No-ACK bus protocols (SCCB bus protocols)

Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye@csr.com>
Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v6:
 fix/cleanup lots of minor issues pointed out by wolfram;
 add OF property clock-frequency to support freq setting by DT;
 add lost devicetree binding document;

 Documentation/devicetree/bindings/i2c/sirf-i2c.txt |   19 +
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-sirf.c                      |  459 ++++++++++++++++++++
 4 files changed, 489 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/sirf-i2c.txt
 create mode 100644 drivers/i2c/busses/i2c-sirf.c

diff --git a/Documentation/devicetree/bindings/i2c/sirf-i2c.txt b/Documentation/devicetree/bindings/i2c/sirf-i2c.txt
new file mode 100644
index 0000000..7baf9e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/sirf-i2c.txt
@@ -0,0 +1,19 @@
+I2C for SiRFprimaII platforms
+
+Required properties :
+- compatible : Must be "sirf,prima2-i2c"
+- reg: physical base address of the controller and length of memory mapped
+     region.
+- interrupts: interrupt number to the cpu.
+
+Optional properties:
+- clock-frequency : Constains desired I2C/HS-I2C bus clock frequency in Hz.
+  The absence of the propoerty indicates the default frequency 100 kHz.
+
+Examples :
+
+i2c0: i2c at b00e0000 {
+    compatible = "sirf,prima2-i2c";
+    reg = <0xb00e0000 0x10000>;
+    interrupts = <24>;
+};
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 3101dd5..8fa8ae4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -630,6 +630,16 @@ config I2C_SIMTEC
 	  This driver can also be built as a module. If so, the module
 	  will be called i2c-simtec.
 
+config I2C_SIRF
+	tristate "CSR SiRFprimaII I2C interface"
+	depends on ARCH_PRIMA2
+	help
+	  If you say yes to this option, support will be included for the
+	  CSR SiRFprimaII I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sirf.
+
 config I2C_STU300
 	tristate "ST Microelectronics DDC I2C interface"
 	depends on MACH_U300
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index fba6da6..905832a 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_I2C_S6000)		+= i2c-s6000.o
 obj-$(CONFIG_I2C_SH7760)	+= i2c-sh7760.o
 obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
 obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
+obj-$(CONFIG_I2C_SIRF)		+= i2c-sirf.o
 obj-$(CONFIG_I2C_STU300)	+= i2c-stu300.o
 obj-$(CONFIG_I2C_TEGRA)		+= i2c-tegra.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
new file mode 100644
index 0000000..5574a47
--- /dev/null
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -0,0 +1,459 @@
+/*
+ * I2C bus driver for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#define SIRFSOC_I2C_CLK_CTRL		0x00
+#define SIRFSOC_I2C_STATUS		0x0C
+#define SIRFSOC_I2C_CTRL		0x10
+#define SIRFSOC_I2C_IO_CTRL		0x14
+#define SIRFSOC_I2C_SDA_DELAY		0x18
+#define SIRFSOC_I2C_CMD_START		0x1C
+#define SIRFSOC_I2C_CMD_BUF		0x30
+#define SIRFSOC_I2C_DATA_BUF		0x80
+
+#define SIRFSOC_I2C_CMD_BUF_MAX		16
+#define SIRFSOC_I2C_DATA_BUF_MAX	16
+
+#define SIRFSOC_I2C_CMD(x)		(SIRFSOC_I2C_CMD_BUF + (x)*0x04)
+#define SIRFSOC_I2C_DATA_MASK(x)        (0xFF<<(((x)&3)*8))
+#define SIRFSOC_I2C_DATA_SHIFT(x)       (((x)&3)*8)
+
+#define SIRFSOC_I2C_DIV_MASK		(0xFFFF)
+
+/* I2C status flags */
+#define SIRFSOC_I2C_STAT_BUSY		BIT(0)
+#define SIRFSOC_I2C_STAT_TIP		BIT(1)
+#define SIRFSOC_I2C_STAT_NACK		BIT(2)
+#define SIRFSOC_I2C_STAT_TR_INT		BIT(4)
+#define SIRFSOC_I2C_STAT_STOP		BIT(6)
+#define SIRFSOC_I2C_STAT_CMD_DONE	BIT(8)
+#define SIRFSOC_I2C_STAT_ERR		BIT(9)
+#define SIRFSOC_I2C_CMD_INDEX		(0x1F<<16)
+
+/* I2C control flags */
+#define SIRFSOC_I2C_RESET		BIT(0)
+#define SIRFSOC_I2C_CORE_EN		BIT(1)
+#define SIRFSOC_I2C_MASTER_MODE		BIT(2)
+#define SIRFSOC_I2C_CMD_DONE_EN		BIT(11)
+#define SIRFSOC_I2C_ERR_INT_EN		BIT(12)
+
+#define SIRFSOC_I2C_SDA_DELAY_MASK	(0xFF)
+#define SIRFSOC_I2C_SCLF_FILTER		(3<<8)
+
+#define SIRFSOC_I2C_START_CMD		BIT(0)
+
+#define SIRFSOC_I2C_CMD_RP(x)		((x)&0x7)
+#define SIRFSOC_I2C_NACK		BIT(3)
+#define SIRFSOC_I2C_WRITE		BIT(4)
+#define SIRFSOC_I2C_READ		BIT(5)
+#define SIRFSOC_I2C_STOP		BIT(6)
+#define SIRFSOC_I2C_START		BIT(7)
+
+#define SIRFSOC_I2C_DEFAULT_SPEED 100000
+
+struct sirfsoc_i2c {
+	void __iomem *base;
+	struct clk *clk;
+	u32 cmd_ptr;		/* Current position in CMD buffer */
+	u8 *buf;		/* Buffer passed by user */
+	u32 msg_len;		/* Message length */
+	u32 finished_len;	/* number of bytes read/written */
+	u32 read_cmd_len;	/* number of read cmd sent */
+	int msg_read;		/* 1 indicates a read message */
+	int err_status;		/* 1 indicates an error on bus */
+
+	u32 sda_delay;		/* For suspend/resume */
+	u32 clk_div;
+	int last;		/* Last message in transfer, STOP cmd can be sent */
+
+	struct completion done;	/* indicates completion of message transfer */
+	struct i2c_adapter adapter;
+};
+
+static void i2c_sirfsoc_read_data(struct sirfsoc_i2c *siic)
+{
+	u32 data = 0;
+	int i;
+
+	for (i = 0; i < siic->read_cmd_len; i++) {
+		if (!(i & 0x3))
+			data = readl(siic->base + SIRFSOC_I2C_DATA_BUF + i);
+		siic->buf[siic->finished_len++] =
+			(u8)((data & SIRFSOC_I2C_DATA_MASK(i)) >>
+				SIRFSOC_I2C_DATA_SHIFT(i));
+	}
+}
+
+static void i2c_sirfsoc_queue_cmd(struct sirfsoc_i2c *siic)
+{
+	u32 regval;
+	int i = 0;
+
+	if (siic->msg_read) {
+		while (((siic->finished_len + i) < siic->msg_len)
+				&& (siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
+			regval = SIRFSOC_I2C_READ | SIRFSOC_I2C_CMD_RP(0);
+			if (((siic->finished_len + i) ==
+					(siic->msg_len - 1)) && siic->last)
+				regval |= SIRFSOC_I2C_STOP | SIRFSOC_I2C_NACK;
+			writel(regval,
+				siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
+			i++;
+		}
+
+		siic->read_cmd_len = i;
+	} else {
+		while ((siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX - 1)
+				&& (siic->finished_len < siic->msg_len)) {
+			regval = SIRFSOC_I2C_WRITE | SIRFSOC_I2C_CMD_RP(0);
+			if ((siic->finished_len == (siic->msg_len - 1))
+				&& siic->last)
+				regval |= SIRFSOC_I2C_STOP;
+			writel(regval,
+				siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
+			writel(siic->buf[siic->finished_len++],
+				siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
+		}
+	}
+	siic->cmd_ptr = 0;
+
+	/* Trigger the transfer */
+	writel(SIRFSOC_I2C_START_CMD, siic->base + SIRFSOC_I2C_CMD_START);
+}
+
+static irqreturn_t i2c_sirfsoc_irq(int irq, void *dev_id)
+{
+	struct sirfsoc_i2c *siic = (struct sirfsoc_i2c *)dev_id;
+	u32 i2c_stat = readl(siic->base + SIRFSOC_I2C_STATUS);
+
+	if (i2c_stat & SIRFSOC_I2C_STAT_ERR) {
+		/* Error conditions */
+		siic->err_status = 1;
+		writel(SIRFSOC_I2C_STAT_ERR, siic->base + SIRFSOC_I2C_STATUS);
+
+		if (i2c_stat & SIRFSOC_I2C_STAT_NACK)
+			dev_err(&siic->adapter.dev, "ACK not received\n");
+		else
+			dev_err(&siic->adapter.dev, "I2C error\n");
+
+		complete(&siic->done);
+	} else if (i2c_stat & SIRFSOC_I2C_STAT_CMD_DONE) {
+		/* CMD buffer execution complete */
+		if (siic->msg_read)
+			i2c_sirfsoc_read_data(siic);
+		if (siic->finished_len == siic->msg_len)
+			complete(&siic->done);
+		else /* Fill a new CMD buffer for left data */
+			i2c_sirfsoc_queue_cmd(siic);
+
+		writel(SIRFSOC_I2C_STAT_CMD_DONE, siic->base + SIRFSOC_I2C_STATUS);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void i2c_sirfsoc_set_address(struct sirfsoc_i2c *siic,
+	struct i2c_msg *msg)
+{
+	unsigned char addr;
+	u32 regval = SIRFSOC_I2C_START | SIRFSOC_I2C_CMD_RP(0) | SIRFSOC_I2C_WRITE;
+
+	/* no data and last message -> add STOP */
+	if (siic->last && (msg->len == 0))
+		regval |= SIRFSOC_I2C_STOP;
+
+	writel(regval, siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
+
+	addr = msg->addr << 1;	/* Generate address */
+	if (msg->flags & I2C_M_RD)
+		addr |= 1;
+
+	writel(addr, siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
+}
+
+static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2c_msg *msg)
+{
+	u32 regval = readl(siic->base + SIRFSOC_I2C_CTRL);
+	/* timeout waiting for the xfer to finish or fail */
+	int timeout = msecs_to_jiffies((msg->len + 1) * 50);
+	int ret = 0;
+
+	i2c_sirfsoc_set_address(siic, msg);
+
+	writel(regval | SIRFSOC_I2C_CMD_DONE_EN | SIRFSOC_I2C_ERR_INT_EN,
+		siic->base + SIRFSOC_I2C_CTRL);
+	i2c_sirfsoc_queue_cmd(siic);
+
+	if (wait_for_completion_timeout(&siic->done, timeout) == 0) {
+		siic->err_status = 1;
+		dev_err(&siic->adapter.dev, "Transfer timeout\n");
+	}
+
+	writel(regval & ~(SIRFSOC_I2C_CMD_DONE_EN | SIRFSOC_I2C_ERR_INT_EN),
+		siic->base + SIRFSOC_I2C_CTRL);
+	writel(0, siic->base + SIRFSOC_I2C_CMD_START);
+
+	if (siic->err_status) {
+		writel(readl(siic->base + SIRFSOC_I2C_CTRL) | SIRFSOC_I2C_RESET,
+			siic->base + SIRFSOC_I2C_CTRL);
+		while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
+			cpu_relax();
+
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static u32 i2c_sirfsoc_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static int i2c_sirfsoc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+	int num)
+{
+	struct sirfsoc_i2c *siic = adap->algo_data;
+	int i, ret;
+
+	clk_enable(siic->clk);
+
+	for (i = 0; i < num; i++) {
+		siic->buf = msgs[i].buf;
+		siic->msg_len = msgs[i].len;
+		siic->msg_read = !!(msgs[i].flags & I2C_M_RD);
+		siic->err_status = 0;
+		siic->cmd_ptr = 0;
+		siic->finished_len = 0;
+		siic->last = (i == (num - 1));
+
+		ret = i2c_sirfsoc_xfer_msg(siic, &msgs[i]);
+		if (ret) {
+			clk_disable(siic->clk);
+			return ret;
+		}
+	}
+
+	clk_disable(siic->clk);
+	return num;
+}
+
+/* I2C algorithms associated with this master controller driver */
+static const struct i2c_algorithm i2c_sirfsoc_algo = {
+	.master_xfer = i2c_sirfsoc_xfer,
+	.functionality = i2c_sirfsoc_func,
+};
+
+static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
+{
+	struct sirfsoc_i2c *siic;
+	struct i2c_adapter *adap;
+	struct resource *mem_res;
+	struct clk *clk;
+	int bitrate;
+	int ctrl_speed;
+	int irq;
+
+	int err;
+	u32 regval;
+
+	clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		err = PTR_ERR(clk);
+		dev_err(&pdev->dev, "Clock get failed\n");
+		goto err_get_clk;
+	}
+
+	err = clk_prepare(clk);
+	if (err) {
+		dev_err(&pdev->dev, "Clock prepare failed\n");
+		goto err_clk_prep;
+	}
+
+	err = clk_enable(clk);
+	if (err) {
+		dev_err(&pdev->dev, "Clock enable failed\n");
+		goto err_clk_en;
+	}
+
+	ctrl_speed = clk_get_rate(clk);
+
+	siic = devm_kzalloc(&pdev->dev, sizeof(*siic), GFP_KERNEL);
+	if (!siic) {
+		dev_err(&pdev->dev, "Can't allocate driver data\n");
+		err = -ENOMEM;
+		goto out;
+	}
+	adap = &siic->adapter;
+	adap->class = I2C_CLASS_HWMON;
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (mem_res == NULL) {
+		dev_err(&pdev->dev, "Unable to get MEM resource\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	siic->base = devm_request_and_ioremap(&pdev->dev, mem_res);
+	if (siic->base == NULL) {
+		dev_err(&pdev->dev, "IO remap failed!\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		err = irq;
+		goto out;
+	}
+	err = devm_request_irq(&pdev->dev, irq, i2c_sirfsoc_irq, 0,
+		dev_name(&pdev->dev), siic);
+	if (err)
+		goto out;
+
+	adap->algo = &i2c_sirfsoc_algo;
+	adap->algo_data = siic;
+
+	adap->dev.parent = &pdev->dev;
+	adap->nr = pdev->id;
+
+	strlcpy(adap->name, "sirfsoc-i2c", sizeof(adap->name));
+
+	platform_set_drvdata(pdev, adap);
+	init_completion(&siic->done);
+
+	/* Controller Initalisation */
+
+	writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
+	while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
+		cpu_relax();
+	writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
+		siic->base + SIRFSOC_I2C_CTRL);
+
+	siic->clk = clk;
+
+	err = of_property_read_u32(pdev->dev.of_node,
+		"clock-frequency", &bitrate);
+	if (err < 0)
+		bitrate = SIRFSOC_I2C_DEFAULT_SPEED;
+
+	if (bitrate < 100000)
+		regval =
+			(2 * ctrl_speed) / (2 * bitrate * 11);
+	else
+		regval = ctrl_speed / (bitrate * 5);
+
+	writel(regval, siic->base + SIRFSOC_I2C_CLK_CTRL);
+	if (regval > 0xFF)
+		writel(0xFF, siic->base + SIRFSOC_I2C_SDA_DELAY);
+	else
+		writel(regval, siic->base + SIRFSOC_I2C_SDA_DELAY);
+
+	err = i2c_add_numbered_adapter(adap);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Can't add new i2c adapter\n");
+		goto out;
+	}
+
+	clk_disable(clk);
+
+	dev_info(&pdev->dev, " I2C adapter ready to operate\n");
+
+	return 0;
+
+out:
+	clk_disable(clk);
+err_clk_en:
+	clk_unprepare(clk);
+err_clk_prep:
+	clk_put(clk);
+err_get_clk:
+	return err;
+}
+
+static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
+{
+	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
+	struct sirfsoc_i2c *siic = adapter->algo_data;
+
+	writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
+	i2c_del_adapter(adapter);
+	clk_unprepare(siic->clk);
+	clk_put(siic->clk);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int i2c_sirfsoc_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
+	struct sirfsoc_i2c *siic = adapter->algo_data;
+
+	clk_enable(siic->clk);
+	siic->sda_delay = readl(siic->base + SIRFSOC_I2C_SDA_DELAY);
+	siic->clk_div = readl(siic->base + SIRFSOC_I2C_CLK_CTRL);
+	clk_disable(siic->clk);
+	return 0;
+}
+
+static int i2c_sirfsoc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
+	struct sirfsoc_i2c *siic = adapter->algo_data;
+
+	clk_enable(siic->clk);
+	writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
+	writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
+		siic->base + SIRFSOC_I2C_CTRL);
+	writel(siic->clk_div, siic->base + SIRFSOC_I2C_CLK_CTRL);
+	writel(siic->sda_delay, siic->base + SIRFSOC_I2C_SDA_DELAY);
+	clk_disable(siic->clk);
+	return 0;
+}
+
+static const struct dev_pm_ops i2c_sirfsoc_pm_ops = {
+	.suspend = i2c_sirfsoc_suspend,
+	.resume = i2c_sirfsoc_resume,
+};
+#endif
+
+static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
+	{ .compatible = "sirf,prima2-i2c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sirfsoc_i2c_of_match);
+
+static struct platform_driver i2c_sirfsoc_driver = {
+	.driver = {
+		.name = "sirfsoc_i2c",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &i2c_sirfsoc_pm_ops,
+#endif
+		.of_match_table = sirfsoc_i2c_of_match,
+	},
+	.probe = i2c_sirfsoc_probe,
+	.remove = __devexit_p(i2c_sirfsoc_remove),
+};
+module_platform_driver(i2c_sirfsoc_driver);
+
+MODULE_DESCRIPTION("SiRF SoC I2C master controller driver");
+MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song@csr.com>, "
+	"Xiangzhen Ye <Xiangzhen.Ye@csr.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4

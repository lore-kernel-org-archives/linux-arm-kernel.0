From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Oct 2015 19:51:59 +0900
Subject: [PATCH v2 1/2] i2c: uniphier: add UniPhier FIFO-less I2C driver
In-Reply-To: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1445597520-6299-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for on-chip I2C controller used on old UniPhier SoCs
such as PH1-LD4, PH1-sLD8, etc.  This adapter is so simple that
it has no FIFO in it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Delete if-block after platform_get_resource()
  - Add I2C_FUNC_SMBUS_EMUL to functionality
  - Add bindings document
  - Add entry to MAINTAINERS

 .../devicetree/bindings/i2c/i2c-uniphier.txt       |  25 ++
 MAINTAINERS                                        |   1 +
 drivers/i2c/busses/Kconfig                         |   8 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-uniphier.c                  | 441 +++++++++++++++++++++
 5 files changed, 476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
 create mode 100644 drivers/i2c/busses/i2c-uniphier.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-uniphier.txt b/Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
new file mode 100644
index 0000000..26f9d95
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
@@ -0,0 +1,25 @@
+UniPhier I2C controller (FIFO-less)
+
+Required properties:
+- compatible: should be "socionext,uniphier-i2c".
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+- reg: offset and length of the register set for the device.
+- interrupts: a single interrupt specifier.
+- clocks: phandle to the input clock.
+
+Optional properties:
+- clock-frequency: desired I2C bus frequency in Hz.  The maximum supported
+  value is 400000.  Defaults to 100000 if not specified.
+
+Examples:
+
+	i2c0: i2c at 58400000 {
+		compatible = "socionext,uniphier-i2c";
+		reg = <0x58400000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 1>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index fb7d2e4..b21c456 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1607,6 +1607,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/uniphier*
 F:	arch/arm/mach-uniphier/
+F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/pinctrl/uniphier/
 F:	drivers/tty/serial/8250/8250_uniphier.c
 N:	uniphier
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 08b8617..2a176b0 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -902,6 +902,14 @@ config I2C_TEGRA
 	  If you say yes to this option, support will be included for the
 	  I2C controller embedded in NVIDIA Tegra SOCs
 
+config I2C_UNIPHIER
+	tristate "UniPhier FIFO-less I2C controller"
+	depends on ARCH_UNIPHIER
+	help
+	  If you say yes to this option, support will be included for
+	  the UniPhier FIFO-less I2C interface embedded in PH1-LD4, PH1-sLD8,
+	  or older UniPhier SoCs.
+
 config I2C_VERSATILE
 	tristate "ARM Versatile/Realview I2C bus support"
 	depends on ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 6df3b30..f9f0902 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_I2C_ST)		+= i2c-st.o
 obj-$(CONFIG_I2C_STU300)	+= i2c-stu300.o
 obj-$(CONFIG_I2C_SUN6I_P2WI)	+= i2c-sun6i-p2wi.o
 obj-$(CONFIG_I2C_TEGRA)		+= i2c-tegra.o
+obj-$(CONFIG_I2C_UNIPHIER)	+= i2c-uniphier.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_WMT)		+= i2c-wmt.o
 obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
new file mode 100644
index 0000000..e3c3861
--- /dev/null
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -0,0 +1,441 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define UNIPHIER_I2C_DTRM	0x00	/* TX register */
+#define     UNIPHIER_I2C_DTRM_IRQEN	BIT(11)	/* enable interrupt */
+#define     UNIPHIER_I2C_DTRM_STA	BIT(10)	/* start condition */
+#define     UNIPHIER_I2C_DTRM_STO	BIT(9)	/* stop condition */
+#define     UNIPHIER_I2C_DTRM_NACK	BIT(8)	/* do not return ACK */
+#define     UNIPHIER_I2C_DTRM_RD	BIT(0)	/* read transaction */
+#define UNIPHIER_I2C_DREC	0x04	/* RX register */
+#define     UNIPHIER_I2C_DREC_MST	BIT(14)	/* 1 = master, 0 = slave */
+#define     UNIPHIER_I2C_DREC_TX	BIT(13)	/* 1 = transmit, 0 = receive */
+#define     UNIPHIER_I2C_DREC_STS	BIT(12)	/* stop condition detected */
+#define     UNIPHIER_I2C_DREC_LRB	BIT(11)	/* no ACK */
+#define     UNIPHIER_I2C_DREC_LAB	BIT(9)	/* arbitration lost */
+#define     UNIPHIER_I2C_DREC_BBN	BIT(8)	/* bus not busy */
+#define UNIPHIER_I2C_MYAD	0x08	/* slave address */
+#define UNIPHIER_I2C_CLK	0x0c	/* clock frequency control */
+#define UNIPHIER_I2C_BRST	0x10	/* bus reset */
+#define     UNIPHIER_I2C_BRST_FOEN	BIT(1)	/* normal operation */
+#define     UNIPHIER_I2C_BRST_RSCL	BIT(0)	/* release SCL */
+#define UNIPHIER_I2C_HOLD	0x14	/* hold time control */
+#define UNIPHIER_I2C_BSTS	0x18	/* bus status monitor */
+#define     UNIPHIER_I2C_BSTS_SDA	BIT(1)	/* readback of SDA line */
+#define     UNIPHIER_I2C_BSTS_SCL	BIT(0)	/* readback of SCL line */
+#define UNIPHIER_I2C_NOISE	0x1c	/* noise filter control */
+#define UNIPHIER_I2C_SETUP	0x20	/* setup time control */
+
+#define UNIPHIER_I2C_DEFAULT_SPEED	100000
+#define UNIPHIER_I2C_MAX_SPEED		400000
+
+struct uniphier_i2c_priv {
+	struct completion comp;
+	struct i2c_adapter adap;
+	void __iomem *membase;
+	struct clk *clk;
+	unsigned int busy_cnt;
+};
+
+static irqreturn_t uniphier_i2c_interrupt(int irq, void *dev_id)
+{
+	struct uniphier_i2c_priv *priv = dev_id;
+
+	/*
+	 * This hardware uses edge triggered interrupt.  Do not touch the
+	 * hardware registers in this handler to make sure to catch the next
+	 * interrupt edge.  Just send a complete signal and return.
+	 */
+	complete(&priv->comp);
+
+	return IRQ_HANDLED;
+}
+
+static int uniphier_i2c_xfer_byte(struct i2c_adapter *adap, u32 txdata,
+				  u32 *rxdatap)
+{
+	struct uniphier_i2c_priv *priv = i2c_get_adapdata(adap);
+	unsigned long time_left;
+	u32 rxdata;
+
+	reinit_completion(&priv->comp);
+
+	txdata |= UNIPHIER_I2C_DTRM_IRQEN;
+	dev_dbg(&adap->dev, "write data: 0x%04x\n", txdata);
+	writel(txdata, priv->membase + UNIPHIER_I2C_DTRM);
+
+	time_left = wait_for_completion_timeout(&priv->comp, adap->timeout);
+	if (unlikely(!time_left)) {
+		dev_err(&adap->dev, "transaction timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	rxdata = readl(priv->membase + UNIPHIER_I2C_DREC);
+	dev_dbg(&adap->dev, "read data: 0x%04x\n", rxdata);
+
+	if (rxdatap)
+		*rxdatap = rxdata;
+
+	return 0;
+}
+
+static int uniphier_i2c_send_byte(struct i2c_adapter *adap, u32 txdata)
+{
+	u32 rxdata;
+	int ret;
+
+	ret = uniphier_i2c_xfer_byte(adap, txdata, &rxdata);
+	if (ret)
+		return ret;
+
+	if (unlikely(rxdata & UNIPHIER_I2C_DREC_LAB)) {
+		dev_dbg(&adap->dev, "arbitration lost\n");
+		return -EAGAIN;
+	}
+	if (unlikely(rxdata & UNIPHIER_I2C_DREC_LRB)) {
+		dev_dbg(&adap->dev, "could not get ACK\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int uniphier_i2c_tx(struct i2c_adapter *adap, u16 addr, u16 len,
+			   const u8 *buf)
+{
+	int ret;
+
+	dev_dbg(&adap->dev, "start condition\n");
+	ret = uniphier_i2c_send_byte(adap, addr << 1 |
+				     UNIPHIER_I2C_DTRM_STA |
+				     UNIPHIER_I2C_DTRM_NACK);
+	if (ret)
+		return ret;
+
+	while (len--) {
+		ret = uniphier_i2c_send_byte(adap,
+					     UNIPHIER_I2C_DTRM_NACK | *buf++);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int uniphier_i2c_rx(struct i2c_adapter *adap, u16 addr, u16 len,
+			   u8 *buf)
+{
+	int ret;
+
+	dev_dbg(&adap->dev, "start condition\n");
+	ret = uniphier_i2c_send_byte(adap, addr << 1 |
+				     UNIPHIER_I2C_DTRM_STA |
+				     UNIPHIER_I2C_DTRM_NACK |
+				     UNIPHIER_I2C_DTRM_RD);
+	if (ret)
+		return ret;
+
+	while (len--) {
+		u32 rxdata;
+
+		ret = uniphier_i2c_xfer_byte(adap,
+					     len ? 0 : UNIPHIER_I2C_DTRM_NACK,
+					     &rxdata);
+		if (ret)
+			return ret;
+		*buf++ = rxdata;
+	}
+
+	return 0;
+}
+
+static int uniphier_i2c_stop(struct i2c_adapter *adap)
+{
+	dev_dbg(&adap->dev, "stop condition\n");
+	return uniphier_i2c_send_byte(adap, UNIPHIER_I2C_DTRM_STO |
+				      UNIPHIER_I2C_DTRM_NACK);
+}
+
+static int uniphier_i2c_master_xfer_one(struct i2c_adapter *adap,
+					struct i2c_msg *msg, bool stop)
+{
+	bool is_read = msg->flags & I2C_M_RD;
+	bool recovery = false;
+	int ret;
+
+	dev_dbg(&adap->dev, "%s: addr=0x%02x, len=%d, stop=%d\n",
+		is_read ? "receive" : "transmit", msg->addr, msg->len, stop);
+
+	if (is_read)
+		ret = uniphier_i2c_rx(adap, msg->addr, msg->len, msg->buf);
+	else
+		ret = uniphier_i2c_tx(adap, msg->addr, msg->len, msg->buf);
+
+	if (ret == -EAGAIN) /* could not acquire bus. bail out without STOP */
+		return ret;
+
+	if (ret == -ETIMEDOUT) {
+		/* This error is fatal.  Needs recovery. */
+		stop = false;
+		recovery = true;
+	}
+
+	if (stop) {
+		int ret2 = uniphier_i2c_stop(adap);
+
+		if (ret2) {
+			/* Failed to issue STOP.  The bus needs recovery. */
+			recovery = true;
+			ret = ret ?: ret2;
+		}
+	}
+
+	if (recovery)
+		i2c_recover_bus(adap);
+
+	return ret;
+}
+
+static int uniphier_i2c_check_bus_busy(struct i2c_adapter *adap)
+{
+	struct uniphier_i2c_priv *priv = i2c_get_adapdata(adap);
+
+	if (!(readl(priv->membase + UNIPHIER_I2C_DREC) &
+						UNIPHIER_I2C_DREC_BBN)) {
+		if (priv->busy_cnt++ > 3) {
+			/*
+			 * If bus busy continues too long, it is probably
+			 * in a wrong state.  Try bus recovery.
+			 */
+			i2c_recover_bus(adap);
+			priv->busy_cnt = 0;
+		}
+
+		return -EAGAIN;
+	}
+
+	priv->busy_cnt = 0;
+	return 0;
+}
+
+static int uniphier_i2c_master_xfer(struct i2c_adapter *adap,
+				    struct i2c_msg *msgs, int num)
+{
+	struct i2c_msg *msg, *emsg = msgs + num;
+	int ret;
+
+	ret = uniphier_i2c_check_bus_busy(adap);
+	if (ret)
+		return ret;
+
+	for (msg = msgs; msg < emsg; msg++) {
+		/* If next message is read, skip the stop condition */
+		bool stop = !(msg + 1 < emsg && msg[1].flags & I2C_M_RD);
+		/* but, force it if I2C_M_STOP is set */
+		if (msg->flags & I2C_M_STOP)
+			stop = true;
+
+		ret = uniphier_i2c_master_xfer_one(adap, msg, stop);
+		if (ret)
+			return ret;
+	}
+
+	return num;
+}
+
+static u32 uniphier_i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm uniphier_i2c_algo = {
+	.master_xfer = uniphier_i2c_master_xfer,
+	.functionality = uniphier_i2c_functionality,
+};
+
+static void uniphier_i2c_reset(struct uniphier_i2c_priv *priv, bool reset_on)
+{
+	u32 val = UNIPHIER_I2C_BRST_RSCL;
+
+	val |= reset_on ? 0 : UNIPHIER_I2C_BRST_FOEN;
+	writel(val, priv->membase + UNIPHIER_I2C_BRST);
+}
+
+static int uniphier_i2c_get_scl(struct i2c_adapter *adap)
+{
+	struct uniphier_i2c_priv *priv = i2c_get_adapdata(adap);
+
+	return !!(readl(priv->membase + UNIPHIER_I2C_BSTS) &
+							UNIPHIER_I2C_BSTS_SCL);
+}
+
+static void uniphier_i2c_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct uniphier_i2c_priv *priv = i2c_get_adapdata(adap);
+
+	writel(val ? UNIPHIER_I2C_BRST_RSCL : 0,
+	       priv->membase + UNIPHIER_I2C_BRST);
+}
+
+static int uniphier_i2c_get_sda(struct i2c_adapter *adap)
+{
+	struct uniphier_i2c_priv *priv = i2c_get_adapdata(adap);
+
+	return !!(readl(priv->membase + UNIPHIER_I2C_BSTS) &
+							UNIPHIER_I2C_BSTS_SDA);
+}
+
+static void uniphier_i2c_unprepare_recovery(struct i2c_adapter *adap)
+{
+	uniphier_i2c_reset(i2c_get_adapdata(adap), false);
+}
+
+static struct i2c_bus_recovery_info uniphier_i2c_bus_recovery_info = {
+	.recover_bus = i2c_generic_scl_recovery,
+	.get_scl = uniphier_i2c_get_scl,
+	.set_scl = uniphier_i2c_set_scl,
+	.get_sda = uniphier_i2c_get_sda,
+	.unprepare_recovery = uniphier_i2c_unprepare_recovery,
+};
+
+static int uniphier_i2c_clk_init(struct device *dev,
+				 struct uniphier_i2c_priv *priv)
+{
+	struct device_node *np = dev->of_node;
+	unsigned long clk_rate;
+	u32 bus_speed;
+	int ret;
+
+	if (of_property_read_u32(np, "clock-frequency", &bus_speed))
+		bus_speed = UNIPHIER_I2C_DEFAULT_SPEED;
+
+	if (bus_speed > UNIPHIER_I2C_MAX_SPEED)
+		bus_speed = UNIPHIER_I2C_MAX_SPEED;
+
+	/* Get input clk rate through clk driver */
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	clk_rate = clk_get_rate(priv->clk);
+
+	uniphier_i2c_reset(priv, true);
+
+	writel((clk_rate / bus_speed / 2 << 16) | (clk_rate / bus_speed),
+	       priv->membase + UNIPHIER_I2C_CLK);
+
+	uniphier_i2c_reset(priv, false);
+
+	return 0;
+}
+
+static int uniphier_i2c_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_i2c_priv *priv;
+	struct resource *regs;
+	int irq;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->membase = devm_ioremap_resource(dev, regs);
+	if (IS_ERR(priv->membase))
+		return PTR_ERR(priv->membase);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "failed to get IRQ number");
+		return irq;
+	}
+
+	init_completion(&priv->comp);
+	priv->adap.owner = THIS_MODULE;
+	priv->adap.algo = &uniphier_i2c_algo;
+	priv->adap.dev.parent = dev;
+	priv->adap.dev.of_node = dev->of_node;
+	strlcpy(priv->adap.name, "UniPhier I2C", sizeof(priv->adap.name));
+	priv->adap.bus_recovery_info = &uniphier_i2c_bus_recovery_info;
+	i2c_set_adapdata(&priv->adap, priv);
+	platform_set_drvdata(pdev, priv);
+
+	ret = uniphier_i2c_clk_init(dev, priv);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(dev, irq, uniphier_i2c_interrupt, 0, pdev->name,
+			       priv);
+	if (ret) {
+		dev_err(dev, "failed to request irq %d\n", irq);
+		goto err;
+	}
+
+	ret = i2c_add_adapter(&priv->adap);
+	if (ret) {
+		dev_err(dev, "failed to add I2C adapter\n");
+		goto err;
+	}
+
+err:
+	if (ret)
+		clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+static int uniphier_i2c_remove(struct platform_device *pdev)
+{
+	struct uniphier_i2c_priv *priv = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(&priv->adap);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct of_device_id uniphier_i2c_match[] = {
+	{ .compatible = "socionext,uniphier-i2c" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, uniphier_i2c_match);
+
+static struct platform_driver uniphier_i2c_drv = {
+	.probe  = uniphier_i2c_probe,
+	.remove = uniphier_i2c_remove,
+	.driver = {
+		.name  = "uniphier-i2c",
+		.of_match_table = uniphier_i2c_match,
+	},
+};
+module_platform_driver(uniphier_i2c_drv);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier I2C bus driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1

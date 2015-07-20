From: danindrey@mail.ru (Andrey Danin)
Date: Mon, 20 Jul 2015 23:35:43 +0300
Subject: [PATCH v3 1/4] i2c: tegra: implement slave mode
In-Reply-To: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
Message-ID: <1437424546-30405-2-git-send-email-danindrey@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialization code is based on NVEC driver.

There is a HW bug in AP20 that was also mentioned in kernel sources
for Toshiba AC100.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
Changes for v3:
- handle 10-bit clients properly

Changes for v2:
- remove hack from tegra_i2c_clock_disable
- replace slave status helper functions with local variables
- add constant for default delay count value
- add 10-bit address support
- remove read_slave_start_delay init as zero
- don't reset controller during slave registration
- slave isr returns int instead of bool
- make status related variables in slave u32 instead of unsigned int
- enable i2c slave in Kconfig
- rebase on top of new i2c slave framework
- delay workaround was added from nvec

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
 drivers/i2c/busses/Kconfig     |   1 +
 drivers/i2c/busses/i2c-tegra.c | 119 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0b798ae..3c02041 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -888,6 +888,7 @@ config I2C_SUN6I_P2WI
 config I2C_TEGRA
 	tristate "NVIDIA Tegra internal I2C controller"
 	depends on ARCH_TEGRA
+	select I2C_SLAVE
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C controller embedded in NVIDIA Tegra SOCs
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 78a3668..f6ecd28 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -42,8 +42,17 @@
 #define I2C_SL_CNFG				0x020
 #define I2C_SL_CNFG_NACK			(1<<1)
 #define I2C_SL_CNFG_NEWSL			(1<<2)
+#define I2C_SL_RCVD				0x024
+#define I2C_SL_STATUS				0x028
+#define I2C_SL_ST_IRQ				(1<<3)
+#define I2C_SL_ST_END_TRANS			(1<<4)
+#define I2C_SL_ST_RCVD				(1<<2)
+#define I2C_SL_ST_RNW				(1<<1)
 #define I2C_SL_ADDR1				0x02c
 #define I2C_SL_ADDR2				0x030
+#define I2C_SL_ADDR2_TEN_BIT_MODE		1
+#define I2C_SL_DELAY_COUNT			0x03c
+#define I2C_SL_DELAY_COUNT_DEFAULT		0x1E
 #define I2C_TX_FIFO				0x050
 #define I2C_RX_FIFO				0x054
 #define I2C_PACKET_TRANSFER_STATUS		0x058
@@ -125,6 +134,8 @@ enum msg_end_type {
  * @clk_divisor_std_fast_mode: Clock divisor in standard/fast mode. It is
  *		applicable if there is no fast clock source i.e. single clock
  *		source.
+ * @slave_read_start_delay: Workaround for AP20 I2C Slave Controller bug. Delay
+ *              before writing data byte into register I2C_SL_RCVD.
  */
 
 struct tegra_i2c_hw_feature {
@@ -133,6 +144,7 @@ struct tegra_i2c_hw_feature {
 	bool has_single_clk_source;
 	int clk_divisor_hs_mode;
 	int clk_divisor_std_fast_mode;
+	int slave_read_start_delay;
 };
 
 /**
@@ -173,6 +185,7 @@ struct tegra_i2c_dev {
 	int msg_read;
 	u32 bus_clk_rate;
 	bool is_suspended;
+	struct i2c_client *slave;
 };
 
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val, unsigned long reg)
@@ -461,12 +474,78 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 	return err;
 }
 
+static void tegra_i2c_slave_write(struct tegra_i2c_dev *i2c_dev, u32 val)
+{
+	i2c_writel(i2c_dev, val, I2C_SL_RCVD);
+
+	/*
+	 * TODO: A correct fix needs to be found for this.
+	 *
+	 * We experience less incomplete messages with this delay than without
+	 * it, but we don't know why. Help is appreciated.
+	 */
+	udelay(100);
+}
+
+static int tegra_i2c_slave_isr(int irq, struct tegra_i2c_dev *i2c_dev)
+{
+	u32 status;
+	u8 value;
+	u8 dummy;
+	u32 is_slave_irq, is_read, is_trans_start, is_trans_end;
+
+	if (!i2c_dev->slave || !i2c_dev->slave->slave_cb)
+		return -EINVAL;
+
+	status = i2c_readl(i2c_dev, I2C_SL_STATUS);
+
+	is_slave_irq = (status & I2C_SL_ST_IRQ);
+	is_read = (status & I2C_SL_ST_RNW);
+	is_trans_start = (status & I2C_SL_ST_RCVD);
+	is_trans_end = (status & I2C_SL_ST_END_TRANS);
+
+	if (!is_slave_irq)
+		return -EINVAL;
+
+	/* master sent stop */
+	if (is_trans_end) {
+		i2c_slave_event(i2c_dev->slave, I2C_SLAVE_STOP, &dummy);
+		if (!is_trans_start)
+			return 0;
+	}
+
+	if (is_read) {
+		/* i2c master reads data from us */
+		i2c_slave_event(i2c_dev->slave,
+				is_trans_start ? I2C_SLAVE_READ_REQUESTED
+					       : I2C_SLAVE_READ_PROCESSED,
+				&value);
+		if (is_trans_start && i2c_dev->hw->slave_read_start_delay)
+			udelay(i2c_dev->hw->slave_read_start_delay);
+		tegra_i2c_slave_write(i2c_dev, value);
+	} else {
+		/* i2c master sends data to us */
+		value = i2c_readl(i2c_dev, I2C_SL_RCVD);
+		if (is_trans_start)
+			tegra_i2c_slave_write(i2c_dev, 0);
+		i2c_slave_event(i2c_dev->slave,
+				is_trans_start ? I2C_SLAVE_WRITE_REQUESTED
+					       : I2C_SLAVE_WRITE_RECEIVED,
+				&value);
+	}
+
+	return 0;
+}
+
 static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 {
 	u32 status;
 	const u32 status_err = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
 	struct tegra_i2c_dev *i2c_dev = dev_id;
 
+	if (!tegra_i2c_slave_isr(irq, i2c_dev))
+		return IRQ_HANDLED;
+
 	status = i2c_readl(i2c_dev, I2C_INT_STATUS);
 
 	if (status == 0) {
@@ -664,9 +743,48 @@ static u32 tegra_i2c_func(struct i2c_adapter *adap)
 	return ret;
 }
 
+static int tegra_reg_slave(struct i2c_client *slave)
+{
+	struct tegra_i2c_dev *i2c_dev = i2c_get_adapdata(slave->adapter);
+	int addr2 = 0;
+
+	if (i2c_dev->slave)
+		return -EBUSY;
+
+	i2c_dev->slave = slave;
+
+	tegra_i2c_clock_enable(i2c_dev);
+
+	i2c_writel(i2c_dev, I2C_SL_CNFG_NEWSL, I2C_SL_CNFG);
+	i2c_writel(i2c_dev, I2C_SL_DELAY_COUNT_DEFAULT, I2C_SL_DELAY_COUNT);
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		addr2 = (slave->addr >> 7) | I2C_SL_ADDR2_TEN_BIT_MODE;
+
+	i2c_writel(i2c_dev, slave->addr, I2C_SL_ADDR1);
+	i2c_writel(i2c_dev, addr2, I2C_SL_ADDR2);
+
+	return 0;
+}
+
+static int tegra_unreg_slave(struct i2c_client *slave)
+{
+	struct tegra_i2c_dev *i2c_dev = i2c_get_adapdata(slave->adapter);
+
+	WARN_ON(!i2c_dev->slave);
+
+	i2c_writel(i2c_dev, 0, I2C_SL_CNFG);
+
+	i2c_dev->slave = NULL;
+
+	return 0;
+}
+
 static const struct i2c_algorithm tegra_i2c_algo = {
 	.master_xfer	= tegra_i2c_xfer,
 	.functionality	= tegra_i2c_func,
+	.reg_slave	= tegra_reg_slave,
+	.unreg_slave	= tegra_unreg_slave,
 };
 
 /* payload size is only 12 bit */
@@ -681,6 +799,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_single_clk_source = false,
 	.clk_divisor_hs_mode = 3,
 	.clk_divisor_std_fast_mode = 0,
+	.slave_read_start_delay = 8,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
-- 
1.9.1

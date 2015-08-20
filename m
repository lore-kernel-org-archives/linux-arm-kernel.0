From: danindrey@mail.ru (Andrey Danin)
Date: Thu, 20 Aug 2015 15:14:34 +0300
Subject: [PATCH v3 1/4] i2c: tegra: implement slave mode
In-Reply-To: <20150724105251.GA22787@katana>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <1437424546-30405-2-git-send-email-danindrey@mail.ru>
 <20150724092720.GA1597@katana> <55B210F4.6030700@mail.ru>
 <20150724105251.GA22787@katana>
Message-ID: <55D5C4AA.2000307@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.07.2015 13:52, Wolfram Sang wrote:
>
>> At the begin of my work on this patchset I even denied clock disable call if
>> slave is registered (to minimize code that can affect transfer).
>
> I hacked something like this, but it seems it was not enough.
>
>> If only slave mode is used, then this logic is not needed.
>
> This is not sufficent. We shouldn't break being a master only because we
> also listen to a slave address (as long as the HW supports that of
> course).
>
>> tegra_i2c_init is called on probe and resume. Also it is called in case of
>> xfer fail. If xfer is ok, then I think slave addr must be kept unchanged.
>
> This is fragile. Try scanning the bus with i2cdetect and slave setup
> will be gone.
>
>> As far as I understand it is a loopback mode. Probably it will not work
>> (Stephen Warren already mentioned this).
>
> Just to make clear: I am not saying we should support talking to our own
> slave address. But it should still be possible to communicate with other
> remote devices on the bus.

Sorry for the long delay. I tried to analyze the issue. Attached patch 
works on AC100 (Misha Komarovsky helped me with testing).

Wolfram could you please try the patch with your environment?


Thanks.

-------------- next part --------------
>From 0927b4007786b19e51415c4900863dd4e74fa034 Mon Sep 17 00:00:00 2001
From: Andrey Danin <danindrey@mail.ru>
Date: Thu, 20 Aug 2015 00:41:39 +0300
Subject: [PATCH] i2c: tegra: don't reset I2C slave address on init

Init function is called multuple times. If I2C controller works
in slave mode, then driver must keep slave registers otherwise
slave configuration will be reseted.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
 drivers/i2c/busses/i2c-tegra.c |   42 +++++++++++++++++++++++++--------------
 1 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 6467ce0..50250a1 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -402,6 +402,22 @@ static void tegra_dvc_init(struct tegra_i2c_dev *i2c_dev)
 	dvc_writel(i2c_dev, val, DVC_CTRL_REG1);
 }
 
+static int tegra_i2c_init_slave(struct tegra_i2c_dev *i2c_dev, u32 addr, u32 flags)
+{
+	int addr2 = 0;
+
+	i2c_writel(i2c_dev, I2C_SL_CNFG_NEWSL, I2C_SL_CNFG);
+	i2c_writel(i2c_dev, I2C_SL_DELAY_COUNT_DEFAULT, I2C_SL_DELAY_COUNT);
+
+	if (flags & I2C_CLIENT_TEN)
+		addr2 = (addr >> 7) | I2C_SL_ADDR2_TEN_BIT_MODE;
+
+	i2c_writel(i2c_dev, addr, I2C_SL_ADDR1);
+	i2c_writel(i2c_dev, addr2, I2C_SL_ADDR2);
+
+	return 0;
+}
+
 static inline int tegra_i2c_clock_enable(struct tegra_i2c_dev *i2c_dev)
 {
 	int ret;
@@ -461,12 +477,16 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 	i2c_writel(i2c_dev, clk_divisor, I2C_CLK_DIVISOR);
 
 	if (!i2c_dev->is_dvc) {
-		u32 sl_cfg = i2c_readl(i2c_dev, I2C_SL_CNFG);
-		sl_cfg |= I2C_SL_CNFG_NACK | I2C_SL_CNFG_NEWSL;
-		i2c_writel(i2c_dev, sl_cfg, I2C_SL_CNFG);
-		i2c_writel(i2c_dev, 0xfc, I2C_SL_ADDR1);
-		i2c_writel(i2c_dev, 0x00, I2C_SL_ADDR2);
-
+		if (i2c_dev->slave) {
+			tegra_i2c_init_slave(i2c_dev, i2c_dev->slave->addr,
+					i2c_dev->slave->flags);
+		} else {
+			u32 sl_cfg = i2c_readl(i2c_dev, I2C_SL_CNFG);
+			sl_cfg |= I2C_SL_CNFG_NACK | I2C_SL_CNFG_NEWSL;
+			i2c_writel(i2c_dev, sl_cfg, I2C_SL_CNFG);
+			i2c_writel(i2c_dev, 0xfc, I2C_SL_ADDR1);
+			i2c_writel(i2c_dev, 0x00, I2C_SL_ADDR2);
+		}
 	}
 
 	val = 7 << I2C_FIFO_CONTROL_TX_TRIG_SHIFT |
@@ -767,7 +787,6 @@ static u32 tegra_i2c_func(struct i2c_adapter *adap)
 static int tegra_reg_slave(struct i2c_client *slave)
 {
 	struct tegra_i2c_dev *i2c_dev = i2c_get_adapdata(slave->adapter);
-	int addr2 = 0;
 
 	if (i2c_dev->slave)
 		return -EBUSY;
@@ -776,14 +795,7 @@ static int tegra_reg_slave(struct i2c_client *slave)
 
 	tegra_i2c_clock_enable(i2c_dev);
 
-	i2c_writel(i2c_dev, I2C_SL_CNFG_NEWSL, I2C_SL_CNFG);
-	i2c_writel(i2c_dev, I2C_SL_DELAY_COUNT_DEFAULT, I2C_SL_DELAY_COUNT);
-
-	if (slave->flags & I2C_CLIENT_TEN)
-		addr2 = (slave->addr >> 7) | I2C_SL_ADDR2_TEN_BIT_MODE;
-
-	i2c_writel(i2c_dev, slave->addr, I2C_SL_ADDR1);
-	i2c_writel(i2c_dev, addr2, I2C_SL_ADDR2);
+	tegra_i2c_init_slave(i2c_dev, slave->addr, slave->flags);
 
 	return 0;
 }
-- 
1.7.1

From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 19:02:47 +0530
Subject: [PATCH 2/3] i2c: pxa: Add support for hardware lock
In-Reply-To: <1432819968-17515-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432819968-17515-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432819968-17515-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of PXA910 silicon, both AP and CP are present and
these two ARM cores are sharing one pair of I2C pins.

In order to keep I2C transaction operated with atomic, hardware lock
(RIPC) is required.

This patch extends support for atomic operation by adding hardware lock.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/pxa-i2c.h  |  4 +++
 2 files changed, 79 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f51d512..eb26eb1 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -167,6 +167,7 @@ struct pxa_i2c {
 	void __iomem		*reg_isar;
 	void __iomem		*reg_ilcr;
 	void __iomem		*reg_iwcr;
+	void __iomem		*hwlock_addr;
 
 	unsigned long		iobase;
 	unsigned long		iosize;
@@ -368,6 +369,9 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
 static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
 
+spinlock_t lock_for_ripc;
+static int ripc_status;
+
 /* enable/disable i2c unit */
 static inline void i2c_pxa_enable(struct pxa_i2c *i2c, bool enable)
 {
@@ -378,6 +382,57 @@ static inline void i2c_pxa_enable(struct pxa_i2c *i2c, bool enable)
 	udelay(100);
 }
 
+void mmp_hwlock_lock(struct i2c_adapter *adap)
+{
+	int cnt = 0;
+	unsigned long flags;
+
+	struct pxa_i2c *i2c = adap->algo_data;
+
+	spin_lock_irqsave(&lock_for_ripc, flags);
+	while(__raw_readl(i2c->hwlock_addr)) {
+		ripc_status = false;
+		spin_unlock_irqrestore(&lock_for_ripc, flags);
+		cpu_relax();
+		udelay(50);
+		cnt++;
+		if (cnt >= 10000) {
+			pr_warn("AP: fail to lock ripc!\n");
+			cnt = 0;
+		}
+	}
+	/* sure to hold ripc */
+	ripc_status = true;
+
+	spin_unlock_irqrestore(&lock_for_ripc, flags);
+}
+
+void mmp_hwlock_unlock(struct i2c_adapter *adap)
+{
+	unsigned long flags;
+
+	struct pxa_i2c *i2c = adap->algo_data;
+
+	spin_lock_irqsave(&lock_for_ripc, flags);
+	__raw_writel(1, i2c->hwlock_addr);
+	ripc_status = false;
+
+	spin_unlock_irqrestore(&lock_for_ripc, flags);
+}
+
+int mmp_hwlock_trylock(struct i2c_adapter *adap)
+{
+	unsigned long flags;
+
+	struct pxa_i2c *i2c = adap->algo_data;
+
+	spin_lock_irqsave(&lock_for_ripc, flags);
+	ripc_status = !__raw_readl(i2c->hwlock_addr);
+	spin_unlock_irqrestore(&lock_for_ripc, flags);
+
+	return ripc_status;
+}
+
 static inline int i2c_pxa_is_slavemode(struct pxa_i2c *i2c)
 {
 	return !(readl(_ICR(i2c)) & ICR_SCLE);
@@ -1347,6 +1402,14 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	i2c->iobase = res->start;
 	i2c->iosize = resource_size(res);
 
+	res = platform_get_resource(dev, IORESOURCE_MEM, 1);
+	if (res) {
+		i2c->hwlock_addr = ioremap(res->start, resource_size(res));
+		dev_info(&dev->dev, "hardware lock address: 0x%p\n",
+			 i2c->hwlock_addr);
+	} else
+		dev_dbg(&dev->dev, "no hardware lock used\n");
+
 	i2c->irq = irq;
 
 	i2c->slave_addr = I2C_PXA_SLAVE_ADDR;
@@ -1360,6 +1423,18 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->ilcr = plat->ilcr;
 		i2c->iwcr = plat->iwcr;
 		i2c->adap.class = plat->class;
+
+		i2c->adap.hardware_lock = plat->hardware_lock;
+		i2c->adap.hardware_unlock = plat->hardware_unlock;
+		i2c->adap.hardware_trylock = plat->hardware_trylock;
+	} else {
+		if (i2c->hwlock_addr) {
+			spin_lock_init(&lock_for_ripc);
+
+			i2c->adap.hardware_lock = mmp_hwlock_lock;
+			i2c->adap.hardware_unlock = mmp_hwlock_unlock;
+			i2c->adap.hardware_trylock = mmp_hwlock_trylock;
+		}
 	}
 
 	if (i2c->high_mode) {
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index d1a44e8..e6f5981 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -72,6 +72,10 @@ struct i2c_pxa_platform_data {
 	unsigned long		rate;
 	unsigned int		ilcr;
 	unsigned int		iwcr;
+	void			(*hardware_lock)(struct i2c_adapter *);
+	void			(*hardware_unlock)(struct i2c_adapter *);
+	int			(*hardware_trylock)(struct i2c_adapter *);
+
 };
 
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
-- 
1.9.1

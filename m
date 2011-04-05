From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue,  5 Apr 2011 17:38:04 -0400
Subject: [PATCH 1/6] i2c-davinci: register dump before attempted bus recovery
In-Reply-To: <cover.1302031487.git.bengardiner@nanometrics.ca>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
Message-ID: <1f1cfc8d37d01097ccfd860098807d1aafd89a49.1302031487.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Produce a dump of the register contents of the I2C controller (at the debug
level) whenever an i2c recovery is initiated.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Bastian Ruppert <Bastian.Ruppert@sewerin.de>
Cc: Brad Griffis <bgriffis@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>

---

The motivation for the introduction of this additional debugging information is
that when I2C recovery on da850 began discussion in the e2e forums [1] a
register dump was requested.

[1] http://e2e.ti.com/support/dsp/omap_applications_processors/f/42/p/99895/350610.aspx#350610

 drivers/i2c/busses/i2c-davinci.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 5795c83..7011222 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -133,6 +133,37 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
 
+static void i2c_davinci_dump_regs(struct davinci_i2c_dev *dev)
+{
+	dev_dbg(dev->dev, "PSC  = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_PSC_REG));
+	dev_dbg(dev->dev, "CLKL = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
+	dev_dbg(dev->dev, "CLKH = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
+	dev_dbg(dev->dev, "MDR = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG));
+
+	dev_dbg(dev->dev, "OAR = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_OAR_REG));
+	dev_dbg(dev->dev, "IMR = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG));
+	dev_dbg(dev->dev, "STR = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG));
+	dev_dbg(dev->dev, "CNT = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_CNT_REG));
+	dev_dbg(dev->dev, "DRR = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_DRR_REG));
+	dev_dbg(dev->dev, "SAR = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_SAR_REG));
+	dev_dbg(dev->dev, "DXR = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_DXR_REG));
+	dev_dbg(dev->dev, "IVR = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG));
+	dev_dbg(dev->dev, "EMDR = %08x\n",
+		davinci_i2c_read_reg(dev, DAVINCI_I2C_EMDR_REG));
+}
+
 /* Generate a pulse on the i2c clock pin. */
 static void generic_i2c_clock_pulse(unsigned int scl_pin)
 {
@@ -157,6 +188,7 @@ static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 	u32 flag = 0;
 	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
 
+	i2c_davinci_dump_regs(dev);
 	dev_err(dev->dev, "initiating i2c bus recovery\n");
 	/* Send NACK to the slave */
 	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-- 
1.7.1

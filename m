From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue,  5 Apr 2011 17:38:08 -0400
Subject: [PATCH 5/6] i2c-davinci: if device has pfunc register,
	dump that group also
In-Reply-To: <cover.1302031487.git.bengardiner@nanometrics.ca>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
Message-ID: <3a177f7c5f48db679db25035911abd2f53203122.1302031487.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the platform has indicated that this I2c controller has the ICPFUNC
regsiters then also dump their contents when producing a debug register dump.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Bastian Ruppert <Bastian.Ruppert@sewerin.de>
Cc: Brad Griffis <bgriffis@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>

---
 drivers/i2c/busses/i2c-davinci.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 5bdc98c..a084e50 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -164,6 +164,8 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
 
 static void i2c_davinci_dump_regs(struct davinci_i2c_dev *dev)
 {
+	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+
 	dev_dbg(dev->dev, "PSC  = %08x\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_PSC_REG));
 	dev_dbg(dev->dev, "CLKL = %08x\n",
@@ -191,6 +193,19 @@ static void i2c_davinci_dump_regs(struct davinci_i2c_dev *dev)
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG));
 	dev_dbg(dev->dev, "EMDR = %08x\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_EMDR_REG));
+
+	if (pdata->has_pfunc) {
+		dev_dbg(dev->dev, "PFUNC = %08x\n",
+			davinci_i2c_read_reg(dev, DAVINCI_I2C_PFUNC_REG));
+		dev_dbg(dev->dev, "PDIR = %08x\n",
+			davinci_i2c_read_reg(dev, DAVINCI_I2C_PDIR_REG));
+		dev_dbg(dev->dev, "PDIN = %08x\n",
+			davinci_i2c_read_reg(dev, DAVINCI_I2C_PDIN_REG));
+		dev_dbg(dev->dev, "DSET = %08x\n",
+			davinci_i2c_read_reg(dev, DAVINCI_I2C_DSET_REG));
+		dev_dbg(dev->dev, "DCLR = %08x\n",
+			davinci_i2c_read_reg(dev, DAVINCI_I2C_DCLR_REG));
+	}
 }
 
 /* Generate a pulse on the i2c clock pin. */
-- 
1.7.1

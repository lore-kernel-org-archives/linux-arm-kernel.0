From: romain.perier@free-electrons.com (Romain Perier)
Date: Thu,  1 Dec 2016 12:04:37 +0100
Subject: [PATCH v7 1/4] i2c: pxa: Add definition of fast and high speed modes
 via the regs layout
In-Reply-To: <20161201110440.27530-1-romain.perier@free-electrons.com>
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
Message-ID: <20161201110440.27530-2-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, the bit masks for the fast and high speed mode were statically
defined. Some IP blocks might use different bits for these modes.

This commit introduces new fields in order to enable the definition of
different bit masks for these features. If these fields are undefined,
ICR_FM and ICR_HS are selected to preserve backward compatibility with
other IPs.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---

Changes in v7:
 - Fixed line over 80 characters for fm_mask and hs_mask in the probe
   function.

 drivers/i2c/busses/i2c-pxa.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index e28b825..b4ac235 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -48,6 +48,8 @@ struct pxa_reg_layout {
 	u32 isar;
 	u32 ilcr;
 	u32 iwcr;
+	u32 fm;
+	u32 hs;
 };
 
 enum pxa_i2c_types {
@@ -193,6 +195,8 @@ struct pxa_i2c {
 	unsigned char		master_code;
 	unsigned long		rate;
 	bool			highmode_enter;
+	u32			fm_mask;
+	u32			hs_mask;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -503,8 +507,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 		writel(i2c->slave_addr, _ISAR(i2c));
 
 	/* set control register values */
-	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
-	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
+	writel(I2C_ICR_INIT | (i2c->fast_mode ? i2c->fm_mask : 0), _ICR(i2c));
+	writel(readl(_ICR(i2c)) | (i2c->high_mode ? i2c->hs_mask : 0), _ICR(i2c));
 
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
@@ -1234,6 +1238,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
 	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[i2c_type].icr;
 	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[i2c_type].isr;
+	i2c->fm_mask = pxa_reg_layout[i2c_type].fm ? : ICR_FM;
+	i2c->hs_mask = pxa_reg_layout[i2c_type].hs ? : ICR_HS;
+
 	if (i2c_type != REGS_CE4100)
 		i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
 
-- 
2.9.3

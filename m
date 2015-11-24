From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 24 Nov 2015 14:47:40 +0100
Subject: [PATCH 1/3] i2c: at91: add setting HOLD field of TWIHS_CWGR via DT
Message-ID: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

Add the HOLD field management. Some i2c devices need a longer data hold
time than the one given in the i2c bus specification. Since this value
depends on the i2c device connected to the bus, add a DT property to
configure it: "atmel,twd-hold-cycles".

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 10835d1..b3595ea 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -64,6 +64,7 @@
 #define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
 
 #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
+#define	AT91_TWI_CWGR_HOLD(x)	(((x) & 0x1f) << 24)
 
 #define	AT91_TWI_SR		0x0020	/* Status Register */
 #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
@@ -185,7 +186,8 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
  * Calculate symmetric clock as stated in datasheet:
  * twi_clk = F_MAIN / (2 * (cdiv * (1 << ckdiv) + offset))
  */
-static void at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
+static void at91_calc_twi_clock(struct at91_twi_dev *dev,
+				int twi_clk, u32 twd_hold)
 {
 	int ckdiv, cdiv, div;
 	struct at91_twi_pdata *pdata = dev->pdata;
@@ -204,7 +206,9 @@ static void at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
 		cdiv = 255;
 	}
 
-	dev->twi_cwgr_reg = (ckdiv << 16) | (cdiv << 8) | cdiv;
+	dev->twi_cwgr_reg = (ckdiv << 16) | (cdiv << 8) | cdiv
+			    | AT91_TWI_CWGR_HOLD(twd_hold);
+
 	dev_dbg(dev->dev, "cdiv %d ckdiv %d\n", cdiv, ckdiv);
 }
 
@@ -994,6 +998,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 	int rc;
 	u32 phy_addr;
 	u32 bus_clk_rate;
+	u32 twd_hold_cycles = 0;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -1050,7 +1055,10 @@ static int at91_twi_probe(struct platform_device *pdev)
 	if (rc)
 		bus_clk_rate = DEFAULT_TWI_CLK_HZ;
 
-	at91_calc_twi_clock(dev, bus_clk_rate);
+	of_property_read_u32(dev->dev->of_node, "atmel,twd-hold-cycles",
+			     &twd_hold_cycles);
+
+	at91_calc_twi_clock(dev, bus_clk_rate, twd_hold_cycles);
 	at91_init_twi_bus(dev);
 
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
-- 
2.5.0

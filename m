From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:37 +0200
Subject: [PATCH 28/32] i2c: bcm2835: Set up the rising/falling edge delays.
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-29-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

We were leaving them in the power on state (or the state the firmware
had set up for some client, if we were taking over from them).  The
boot state was 30 core clocks, when we actually want to sample some
time after (to make sure that the new input bit has actually arrived).

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/i2c/busses/i2c-bcm2835.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index d4f3239..d1d17e4 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -50,6 +50,9 @@
 #define BCM2835_I2C_S_CLKT	BIT(9)
 #define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
 
+#define BCM2835_I2C_FEDL_SHIFT	16
+#define BCM2835_I2C_REDL_SHIFT	0
+
 #define BCM2835_I2C_BITMSK_S	0x03FF
 
 #define BCM2835_I2C_CDIV_MIN	0x0002
@@ -235,7 +238,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 {
 	struct bcm2835_i2c_dev *i2c_dev;
 	struct resource *mem, *irq;
-	u32 bus_clk_rate, divider;
+	u32 bus_clk_rate, divider, redl, fedl;
 	int ret;
 	struct i2c_adapter *adap;
 
@@ -281,6 +284,20 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	}
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
 
+	/* Number of core clocks to wait after falling edge before
+	 * outputting the next data bit.  Note that both FEDL and REDL
+	 * can't be greater than CDIV/2.
+	 */
+	fedl = max(divider / 16, 1u);
+	/* Number of core clocks to wait after rising edge before
+	 * sampling the next incoming data bit.
+	 */
+	redl = max(divider / 4, 1u);
+
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DEL,
+			   (fedl << BCM2835_I2C_FEDL_SHIFT) |
+			   (redl << BCM2835_I2C_REDL_SHIFT));
+
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!irq) {
 		dev_err(&pdev->dev, "No IRQ resource\n");
-- 
1.8.3.1

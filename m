From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Nov 2015 18:53:34 +0900
Subject: [PATCH 2/4] i2c: uniphier: error out if bus speed is zero
In-Reply-To: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1448877216-32286-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is code to divide by "bus_speed" some lines below.
To eliminate the possibility of division by zero, bail out if
"clock-frequency" is specified as zero.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 2b2c20b..1f4f3f5 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -327,6 +327,11 @@ static int uniphier_i2c_clk_init(struct device *dev,
 	if (of_property_read_u32(np, "clock-frequency", &bus_speed))
 		bus_speed = UNIPHIER_I2C_DEFAULT_SPEED;
 
+	if (!bus_speed) {
+		dev_err(dev, "clock-freqyency should not be zero\n");
+		return -EINVAL;
+	}
+
 	if (bus_speed > UNIPHIER_I2C_MAX_SPEED)
 		bus_speed = UNIPHIER_I2C_MAX_SPEED;
 
-- 
1.9.1

From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Nov 2015 18:53:36 +0900
Subject: [PATCH 4/4] i2c: uniphier_f: error out if bus speed is zero
In-Reply-To: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1448877216-32286-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is code to divide by "bus_speed" some lines below.
To eliminate the possibility of division by zero, bail out if
"clock-frequency" is specified as zero.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 67109e1..f3e5ff8 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -466,6 +466,11 @@ static int uniphier_fi2c_clk_init(struct device *dev,
 	if (of_property_read_u32(np, "clock-frequency", &bus_speed))
 		bus_speed = UNIPHIER_FI2C_DEFAULT_SPEED;
 
+	if (!bus_speed) {
+		dev_err(dev, "clock-freqyency should not be zero\n");
+		return -EINVAL;
+	}
+
 	if (bus_speed > UNIPHIER_FI2C_MAX_SPEED)
 		bus_speed = UNIPHIER_FI2C_MAX_SPEED;
 
-- 
1.9.1

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 21 Jun 2013 15:32:06 +0200
Subject: [PATCH v3 1/4] i2c-mv64xxx: Set bus frequency to 100kHz if
 clock-frequency is not provided
In-Reply-To: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1371821529-13791-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds checking whether clock-frequency property acquisition
has succeeded. If not, the frequency is set to 100kHz by default.

The Device Tree binding documentation is updated accordingly.

Based on the intials patches from Zbigniew Bodek

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Zbigniew Bodek <zbb@semihalf.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 6 +++++-
 drivers/i2c/busses/i2c-mv64xxx.c                      | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index f46d928..a1ee681 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -6,7 +6,11 @@ Required properties :
  - reg             : Offset and length of the register set for the device
  - compatible      : Should be "marvell,mv64xxx-i2c"
  - interrupts      : The interrupt number
- - clock-frequency : Desired I2C bus clock frequency in Hz.
+
+Optional properties :
+
+ - clock-frequency : Desired I2C bus clock frequency in Hz. If not set the
+default frequency is 100kHz
 
 Examples:
 
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 7a0e39b..d5d46db 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -578,7 +578,11 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		goto out;
 	}
 	tclk = clk_get_rate(drv_data->clk);
-	of_property_read_u32(np, "clock-frequency", &bus_freq);
+
+	rc = of_property_read_u32(np, "clock-frequency", &bus_freq);
+	if (rc)
+		bus_freq = 100000; /* 100kHz by default */
+
 	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
 				       &drv_data->freq_n, &drv_data->freq_m)) {
 		rc = -EINVAL;
-- 
1.8.1.2

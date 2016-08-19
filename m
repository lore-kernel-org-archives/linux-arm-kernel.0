From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 19 Aug 2016 15:42:23 +0800
Subject: [PATCH v6 1/4] rtc: ac100: support clock-output-names in device tree
 binding
In-Reply-To: <20160819074226.16636-1-wens@csie.org>
References: <20160819074226.16636-1-wens@csie.org>
Message-ID: <20160819074226.16636-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ac100 device tree binding specifies the usage of clock-output-names
to specify the names of its 3 clock outputs. This is needed for orphan
clock resolution, when the ac100 is probed much later than any clocks
that consume any of its outputs. This wasn't supported by the driver.

Add support for this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v5:

  - New patch, based on mfd-rtc immutable branch given in

     http://www.spinics.net/lists/devicetree/msg137991.html

---
 drivers/rtc/rtc-ac100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 70b4fd0f6122..2d0bb02a25d9 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -327,6 +327,8 @@ static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
 			.flags = 0,
 		};
 
+		of_property_read_string_index(np, "clock-output-names",
+					      i, &init.name);
 		clk->regmap = chip->regmap;
 		clk->offset = AC100_CLKOUT_CTRL1 + i;
 		clk->hw.init = &init;
-- 
2.9.3

From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 12:01:25 +0200
Subject: [PATCH 21/23] ARM: u300: probe the U300 dummy-spichip from device tree
Message-ID: <1366624885-6966-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This probes the U300 dummy-spichip from the device tree
and adds the apropriate node to the tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts    | 5 +++++
 arch/arm/mach-u300/dummyspichip.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 979d96c..9a163e1 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -220,6 +220,11 @@
 			reg = <0xc0006000 0x1000>;
 			interrupt-parent = <&vica>;
 			interrupts = <23>;
+			spi-dummy at 1 {
+				compatible = "arm,pl022-dummy";
+				reg = <1>;
+				spi-max-frequency = <20000000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index 2785cb6..52962bf 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -263,10 +263,16 @@ static int pl022_dummy_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id pl022_dummy_dt_match[] = {
+	{ .compatible = "arm,pl022-dummy" },
+	{},
+};
+
 static struct spi_driver pl022_dummy_driver = {
 	.driver = {
 		.name	= "spi-dummy",
 		.owner	= THIS_MODULE,
+		.of_match_table = pl022_dummy_dt_match,
 	},
 	.probe	= pl022_dummy_probe,
 	.remove	= pl022_dummy_remove,
-- 
1.7.11.3

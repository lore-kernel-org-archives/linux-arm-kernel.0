From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Sep 2018 12:53:57 +0800
Subject: [PATCH] arm64: dts: rockchip: Enable SPI NOR flash on Rock64
Message-ID: <20180926045357.20722-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 Rock64 board comes with a GigaDevice GD25Q128CSIG
or GD25Q127CSIG chip, which is a 128 Mbit SPI NOR flash chip
that supports the JEDEC read-ID command.

This patch enables the SPI controller and adds a device node
for the flash chip using the generic "jedec,spi-nor" comaptible.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This was working on linux-next 20180910, but now fails on linux-next
20180925, with the following error messages:

    m25p80 spi0.0: error -22 reading 9f
    m25p80: probe of spi0.0 failed with error -2

Reverting the spi/for-next branch makes it work again:

    m25p80 spi0.0: gd25q128 (16384 Kbytes)

Not sure what's up.

---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 9ee4f57557f3..2170cf63845e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -290,6 +290,18 @@
 	};
 };
 
+&spi0 {
+	status = "okay";
+
+	spiflash at 0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		/* maximum speed for Rockchip SPI */
+		spi-max-frequency = <50000000>;
+	};
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <0>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.19.0

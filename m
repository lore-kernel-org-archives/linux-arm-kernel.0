From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  7 Oct 2017 18:29:38 +0200
Subject: [PATCH 0/2] Enable the Amlogic Meson SDIO MMC controller
Message-ID: <20171007162940.14595-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the SDIO MMC driver is queued for v4.15 we need to prepare
our platform so boards can actually use this driver.
This adds the Meson SDIO MMC controller to the .dts files and
enables the corresponding driver in the multi_v7_defconfig.

Below is an example to enable the SD card using "port 1" of
the SDIO MMC controller.
cd-gpios, cd-inverted and vmmc-supply need to be configured
based on the board design (as well as the "reg" property
if the SD card is not connected to the MMC controller's slot
called "port 0").

&sdio {
	status = "okay";

	pinctrl-0 = <&sd_b_pins>;
	pinctrl-names = "default";

	/* SD card */
	sd_card_slot: slot at 1 {
		compatible = "mmc-slot";
		reg = <1>;
		status = "okay";

		bus-width = <4>;
		no-sdio;
		cap-mmc-highspeed;
		cap-sd-highspeed;
		disable-wp;

		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
		cd-inverted;

		vmmc-supply = <&vcc_3v3>;
	};
};


Martin Blumenstingl (2):
  ARM: dts: meson: add the SDIO MMC controller
  ARM: multi_v7_defconfig: enable the Meson MX SDIO/MMC controller

 arch/arm/boot/dts/meson.dtsi        | 9 +++++++++
 arch/arm/boot/dts/meson8.dtsi       | 6 ++++++
 arch/arm/boot/dts/meson8b.dtsi      | 6 ++++++
 arch/arm/configs/multi_v7_defconfig | 1 +
 4 files changed, 22 insertions(+)

-- 
2.14.2

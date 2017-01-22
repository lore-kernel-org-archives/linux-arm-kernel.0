From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Jan 2017 22:05:25 +0100
Subject: [PATCH 0/3] meson-gx: add pwm_AO_ab
Message-ID: <20170122210528.892-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the PWM controller in the AO domain.
pinctrl support for GXBB already exists (in both, pinctrl-meson-gxbb.c
and meson-gxbb.dtsi). This patch adds at least the pwm_ao_b pin for
GXL and GXM - these are not documented in Amlogic's kernel, so I had
to borrow the magic numbers from the Khadas VIM kernel (released under
the GPL): [0]

The bits for pwm_AO_a_pins are unknown at the time of writing, but these
can still be added later.

I have successfully tested this on my GXL S905X based Khadas VIM board
with the following .dts snippets (the PWM LED can simply be dimmed
through sysfs):
	&pwm_AO_ab {
		status = "okay";
		pinctrl-0 = <&pwm_ao_b_pins>;
		pinctrl-names = "default";
		clocks = <&clkc CLKID_FCLK_DIV4>;
		clock-names = "clkin0";
	};

	pwmleds {
		compatible = "pwm-leds";

		power {
			label = "vim:red:power";
			pwms = <&pwm_AO_ab 1 7812500 0>;
			max-brightness = <255>;
		};
	};

(if anyone is interested in more of my Khadas VIM patches - these are
still work-in-progress, which is why I have not sent them yet - can
take a look at this: [1])

NOTE: The .dts changes from this series are based on top of my SAR ADC
patches.

[0] https://github.com/khadas/linux/blob/94602ef5562978a8d8b5c7770c113074a714dbdb/drivers/amlogic/led/led_trigger_breathe.c#L75
[1] https://github.com/xdarklight/linux/commits/meson-gx-integration-4.11-20170122

Martin Blumenstingl (3):
  ARM64: dts: meson-gx: add the missing pwm_AO_ab node
  pinctrl: meson: meson-gxl: add the pwm_ao_b pin
  ARM64: dts: meson-gxl: add the pwm_ao_b pin

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 7 +++++++
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 8 ++++++++
 3 files changed, 22 insertions(+)

-- 
2.11.0

From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 29 Nov 2018 00:48:39 +0200
Subject: [PATCH 0/2] gpio: lpc18xx: add GPIO pin interrupt controller support
Message-ID: <20181128224841.3646-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From LPC18xx and LPC43xx User Manuals the GPIO controller consists of
the following blocks:
* GPIO pin interrupt block at 0x40087000, this change adds its support,
* GPIO GROUP0 interrupt block at 0x40088000,
* GPIO GROUP1 interrupt block at 0x40089000,
* GPIO port block at 0x400F4000, it is supported by the original driver.

While the blocks are relatively independant and potentially they can
be defined under their own device tree nodes, all blocks share the
same clock to enable access to register interfaces and the same reset
signal.

The change extends the existing gpio at 400f4000 device tree node described
in arch/arm/boot/dts/lpc18xx.dtsi by adding 'reg-names' property to

	gpio: gpio at 400f4000 {
		compatible = "nxp,lpc1850-gpio";
		reg = <0x400f4000 0x4000>, <0x40087000 0x1000>,
		      <0x40088000 0x1000>, <0x40089000 0x1000>;
		reg-names = "gpio", "gpio-pin-ic",
			    "gpio-group0-ic", "gpio-gpoup1-ic";
		clocks = <&ccu1 CLK_CPU_GPIO>;
		resets = <&rgu 28>;
		gpio-controller;
		#gpio-cells = <2>;
		interrupt-controller;
		#interrupt-cells = <2>;
	};

Note that all 4 blocks find their place, but the functional change adds
support of the GPIO pin interrupt contoller only.

Alternative and probably better representation of the GPIO pin interrupt
contoller block can be like this one added in parallel to gpio at 400f4000 {}:

	gpio_pin: interrupt-controller at 40087000 {
		compatible = "nxp,lpc1850-gpio-pin-ic";
		reg = <0x40087000 0x1000>;
		clocks = <&ccu1 CLK_CPU_GPIO>;
		resets = <&rgu 28>;
		interrupt-controller;
		#interrupt-cells = <2>;
	};

The unpleasant side effects associated with this representation are:

1) both gpio at 400f4000 and interrupt-controller at 40087000 (plus potential
   interrupt-controller at 40088000 and interrupt-controller at 40089000) share
   the same reset and the same clock,
2) separate device node and 'compatible' imply a new drivers/irqchip/
   driver, it is totally okay, but
3) while Linux device drivers provide interfaces and support well usage
   of the same reset or clock, interrupt controller drivers does not
   depend on clock providers, of_clk_get() will ask for defer, but
   IRQCHIP_DECLARE()d initialization won't be reprobed,
4) it might be more or less reliably assumed that GPIO pin interrupt
   controller does not get any consumer in runtime, who is not the
   consumer of the same GPIO which serves as an interrupt, so implicitly
   access to the interrupt controller functions will happen after
   the registration of the GPIO controller driver, which in turn enables
   the shared clock, and thus access to the interrupt controller registers
   will be successful then, but you see, the complexity and indirection
   leads to unavoidable fragility.

So, I go ahead with the extension of the exisitng GPIO controller device
node, comments and other opinions are welcome as usual.

The change depends on a minor clean-up series, which was sent aforehand:
* https://marc.info/?l=linux-gpio&m=154344413726424&w=1

The actual lpc18xx.dtsi change will be sent afterwards after getting
the acceptance of the proposed device tree node changes.

Marc, this is the change, which I had a luck to discuss with you on ELCE.

Vladimir Zapolskiy (2):
  dt-bindings: gpio: lpc18xx: describe interrupt controllers of GPIO controller
  gpio: lpc18xx: add GPIO pin interrupt controller support

 .../bindings/gpio/nxp,lpc1850-gpio.txt        |  38 ++-
 drivers/gpio/Kconfig                          |   1 +
 drivers/gpio/gpio-lpc18xx.c                   | 267 +++++++++++++++++-
 3 files changed, 293 insertions(+), 13 deletions(-)

-- 
2.17.1

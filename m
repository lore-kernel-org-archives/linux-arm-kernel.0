From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Aug 2017 11:24:24 +0200
Subject: linux-next regression caused by "gpiolib: request the gpio before
 querying its direction"
Message-ID: <20170830112424.7a3a7c36@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Commit "gpiolib: request the gpio before querying its
direction" (108d23e322a247d9f89ba2e2742520ead0944cc9) is causing a
regression on Marvell platforms, and potentially other platforms as
well. With this commit applied, we lose the serial console. Reverting
this commit makes the serial console functional again.

On the Marvell Armada 8K, the UART pins are pin-muxed, with the choice
of GPIO or UART as functionality. Currently, the Armada 8K Device Tree
do not have the pin-mux information for the UART, because the pinctrl
driver didn't exist when we first added support for the platform, so we
continue to rely on the bootloader having configured the UART muxing.

Therefore, with Timur's commit applied, when the system boots, we get
serial output, up to the point where gpiochip_add_data() is called, and
requests all GPIOs. Since our UART pins are not requested at the
pinctrl level, the gpio_request succeeds and re-muxes those pins as
GPIOs: we lose the UART.

So, this is a clear regression, as with the current Device Tree for the
Armada 8K platforms, linux-next has the serial console broken.

If we add the relevant pinctrl muxing details in the DT, things are
working again of course. *But* it is still not good, because there is a
window of time during which we don't get serial port messages: between
the moment the pins are muxed as GPIOs by gpiochip_add_data(), and the
moment the UART driver probes, requests the pins, and they get remuxed
as UART. With earlycon enabled, it means we loose kernel messages.

I believe the UART pins are quite critical, and therefore they
shouldn't be remuxed as GPIOs automatically that early at boot time.

What do you suggest to fix this problem ?

Some more details about the platform:

 - DT is arch/arm64/boot/dts/marvell/armada-8040-db.dts

 - Affected GPIO/pinctrl is described in
   arch/arm64/boot/dts/marvell/armada-ap806.dtsi, nodes ap_pinctrl and
   ap_gpio.

 - The drivers/gpio/gpio-mvebu.c probe() function calls
   devm_gpiochip_add_data(), which calls gpiochip_add_data(), which
   iterates through all pins and requests them as GPIOs.

 - The UART pins are described in the pinctrl driver
   drivers/pinctrl/mvebu/pinctrl-armada-ap806.c. The most problematic
   one is pin 11, which is UART0 TXD, and gets remuxed as GPIO, causing
   the bug.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Mar 2017 21:50:37 +0100
Subject: [PATCH v2 0/7] Add support for pinctrl/gpio on Armada 37xx Was Re:
 [PATCH v2 0/7] Hi,
In-Reply-To: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Tue, 21 Mar 2017 19:28:29 +0100")
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
Message-ID: <87pohafj6q.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Obviously this cover letter is wrong. Actually I forgot to commit it in
git series. Here it is the correct one:

After several months here it is the second version of the series adding
support for the pin and gpio controllers present on the Armada 37xx
SoCs.

Each Armada 37xx SoC comes with 2 pin controllers: one on the south
bridge (managing 28 pins) and one on the north bridge (managing 36 pins).

At the hardware level the controller configure the pins by group and not
pin by pin.

The gpio controller is also capable to handle interrupt from gpio.

In the second version several changes has been done:

- Update binding documentation making clear that mfd and syscon must
  be used (patch 1).

- Split the fist patch adding pin controller support for Armada 37xx
  in arm64 part (for kconfig) and pinctrl part (patch 2 and 3)

- Add MFD_SYSCON dependency (patch 3)

- Add kerneldoc for the armada_37xx_pin_group struct (patch 3)

- Rename _add_function() to armada_37xx_add_function() (patch 3)

- Use an inline function to update the reg offset (patch 4)

- Rename gpiolib_register to gpiochip_register (patch 4)

- Add a comment about the two registers limit (patch 4)

- Add explicit gpio node in the device tree (patch 4)

- Convert the driver to use GPIOLIB_IRQCHIP (patch 5)

- Add a critical section when accessing the hardware registers (patch 5)

- Use the gpio sub-node (patch 5)

With these change most of the comment of the first revision have been addressed.

Thanks,

Gregory

Gregory CLEMENT (7):
  pinctrl: dt-bindings: Add documentation for Armada 37xx pin controllers
  arm64: marvell: enable the Armada 37xx pinctrl driver
  pinctrl: armada-37xx: Add pin controller support for Armada 37xx
  pinctrl: armada-37xx: Add gpio support
  pinctrl: aramda-37xx: Add irqchip support
  ARM64: dts: marvell: Add pinctrl nodes for Armada 3700
  ARM64: dts: marvell: armada37xx: add pinctrl definition

 Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt         |   7 +-
 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt | 143 +++++++++++-
 arch/arm64/Kconfig.platforms                                              |   2 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts                            |   8 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                              |  71 +++++-
 drivers/pinctrl/Makefile                                                  |   2 +-
 drivers/pinctrl/mvebu/Kconfig                                             |   7 +-
 drivers/pinctrl/mvebu/Makefile                                            |   3 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                               | 918 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 1153 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c

Sorry for the noise,

Gregory


 On mar., mars 21 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> this series add support for the pin and gpio controllers present on
> the Armada 37xx SoCs.
>
> Each Armada 37xx SoC comes with 2 pin controllers: one on the south
> bridge (managing 28 pins) and one on the north bridge (managing 36 pins).
>
> At the hardware level the controller configure the pins by group and not
> pin by pin.
>
> The gpio controller is also capable to handle interrupt from gpio.
>
> Gregory
>
> Gregory CLEMENT (7):
>   pinctrl: dt-bindings: Add documentation for Armada 37xx pin controllers
>   arm64: marvell: enable the Armada 37xx pinctrl driver
>   pinctrl: armada-37xx: Add pin controller support for Armada 37xx
>   pinctrl: armada-37xx: Add gpio support
>   pinctrl: aramda-37xx: Add irqchip support
>   ARM64: dts: marvell: Add pinctrl nodes for Armada 3700
>   ARM64: dts: marvell: armada37xx: add pinctrl definition
>
>  Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt         |   7 +-
>  Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt | 143 +++++++++++-
>  arch/arm64/Kconfig.platforms                                              |   2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts                            |   8 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi                              |  71 +++++-
>  drivers/pinctrl/Makefile                                                  |   2 +-
>  drivers/pinctrl/mvebu/Kconfig                                             |   7 +-
>  drivers/pinctrl/mvebu/Makefile                                            |   3 +-
>  drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                               | 918 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  9 files changed, 1153 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
>  create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
>
> base-commit: c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201
> -- 
> git-series 0.9.1

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

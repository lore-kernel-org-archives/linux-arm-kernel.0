From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 16 Jun 2014 20:02:28 +0200
Subject: [PATCH v2 00/10] Add Maxim 77802 PMIC support
Message-ID: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAX77802 is a PMIC that contains 10 high efficiency Buck regulators,
32 Low-dropout (LDO) regulators, two 32kHz buffered clock outputs,
a Real-Time-Clock (RTC) and a I2C interface to program the individual
regulators, clocks and the RTC.

This second version of the patch-set addresses several issues pointed
out by Krzysztof Kozlowski, Mark Brown and Lee Jones. The individual
changes are added on each patch change log.

The series are based on drivers added by Simon Glass to the Chrome OS
kernel and adds support for the Maxim 77802 Power Management IC, their
regulators, clocks, RTC and I2C interface. It's composed of patches:

[PATCH v2 1/10] mfd: max77686: Convert to use regmap_irq
[PATCH v2 2/10] clk: max77686: add DT include for MAX77686 PMIC clock
[PATCH v2 3/10] Documentation: dt: improve Maxim 77686 PMIC clocks binding
[PATCH v2 4/10] clk: Add generic driver for Maxim PMIC clocks
[PATCH v2 5/10] clk: max77686: convert to the generic max clock driver
[PATCH v2 6/10] mfd: Add driver for Maxim 77802 Power Management IC
[PATCH v2 7/10] regulator: Add driver for Maxim 77802 PMIC regulators
[PATCH v2 8/10] clk: Add driver for Maxim 77802 PMIC clocks
[PATCH v2 9/10] rtc: Add driver for Maxim 77802 PMIC Real-Time-Clock
[PATCH v2 10/10] ARM: dts: Add max77802 device node for exynos5420-peach-pit

Patches 1-3 are improvements to the max77686 driver, Patch 4 adds a generic
clock driver that can be shared by both max77686 and max77802 clock drivers
and Patch 5 converts the former.

Patches 6-9 add support for the different 77802 devices and Patch 10 enables
the MAX77802 PMIC on the Exynos5420 based Peach pit board.

The patch-set has been tested on both Daisy/Snow (max77686) and Peach pit
(max77802) Chromebooks.

NOTE: Since this series convert the max77686 driver to use regmap_irq API
(getting rid of drivers/mfd/max77686-irq.c) and refactor the clock driver,
the amount of duplicated code between 77686 and 77802 drivers were reduced
significantly since v1. Still there is room for more code consolidation if
the max77686 core mfd driver is extended to support max77802 instead.

drivers/mfd/max14577.c is an example of such a combined driver that support
two different Maxim PMIC (14577 and 77836) but I'm not convinced that having
a single driver to support both 77686 and 77802 lead to a cleaner and more
maintainable code than having two separate (and now smaller) mfd core drivers.

Thanks a lot and best regards,
Javier

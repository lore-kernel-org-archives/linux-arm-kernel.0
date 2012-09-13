From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Sep 2012 17:54:13 +0200
Subject: [PATCH v4] gpio: mvebu: new gpio driver for mvebu platforms
Message-ID: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

This patch set adds a new GPIO driver for Marvell EBU SoCs, which aims
at replacing the existing GPIO driver from plat-orion/gpio.c. The
driver comes with the necessary DT changes to make it work on Armada
370 and Armada XP, and it has been tested successfully by Sebastian
Hesselbarth on Dove.

It should also work flawlessly on other Marvell EBU SoCs (Kirkwood,
Orion, Discovery), but this remains to be tested by the relevant
maintainers. This isn't however a problem, as those older platforms
need to explictly be converted over to the new pinctrl-mvebu driver
and the new gpio driver. Until that, they will happily continue to use
the old, known-working, gpio driver. So this patch set has no chance
to break any of the existing Marvell platforms. The old gpio driver is
scheduled to be removed once all Marvell SoCs have switched to the new
driver.

This new driver reuses a lot of code from the existing
plat-orion/gpio.c driver, but has a number of advantages:

 *) Support for Armada 370 and Armada XP
 *) It is integrated with the mvebu pinctrl driver so that GPIO pins
    are properly muxed, and the GPIO driver knows which GPIO pins are
    output-only or input-only.
 *) Properly placed in drivers/gpio
 *) More extensible mechanism to support platform differences. The
    plat-orion driver uses a simple mask-offset DT property, which
    works fine for Discovery MV78200 but not for Armada XP. The new
    driver uses different compatible strings to identify the different
    variants of the GPIO controllers.

This patch set should be applied on top of the pinctrl-mvebu patch set
v4 from Sebastian Hesselbarth, as it depends on it.

Changes since v2:
 * Use inline functions for the register accessors, and rename them
   lower-case since they are functions, as suggested by
   Jean-Christophe Plagnol-Villard.
 * Use _relaxed() variants of readl/writel, as suggested by
   Jean-Christophe Plagnol-Villard.
 * Use switch() instead of long list of if() conditions in
   mvebu_gpio_irq_set_type(), as suggested by Jean-Christophe
   Plagnol-Villard.
 * Add DT aliases gpio0, gpio1, gpio2, and then use of_alias_get_id()
   to get the number of GPIO bank, and deduce the GPIO base from
   it. We don't use automatic allocation because we really want the
   internal SoC GPIOs to have 0-31, 32-63, 64-... numbers (while
   automatic allocation allocates 224... for the first bank 202... for
   the second bank, etc.). This strategy was recommended by Uwe
   Kleine-Koenig and is already used in gpio-mxs.c.
 * Use gpio-cells = <2> instead of gpio-cells = <1>, as suggested by
   Olof Johansson. This allows to re-use the default .xlate()
   function, and therefore make the GPIO DT binding actually work (it
   was broken in previous versions of this patch set).
 * Use dev_name() to fill the gpio_chip->name field, instead of
   manually computing a name. This allows to get rid of the global
   variable counting GPIO chips.
 * Rebase on top of the latest pinctrl work from Sebastian
   Hesselbarth.
 * Added the Acked-by from Linus Walleij on the DT binding
   documentation patch.

Changes since v1:
 * Added fixes for Dove from Sebastian Hesselbarth, and his Tested-by
   on the driver patch.

Thanks,

Thomas

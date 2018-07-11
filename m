From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 11 Jul 2018 18:14:43 +0200
Subject: [PATCH] ARM: at91: remove unnecessary
 of_platform_default_populate calls
In-Reply-To: <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
References: <20180619214020.18608-1-robh@kernel.org>
 <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
Message-ID: <20180711161443.GY16084@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/07/2018 09:50:47-0600, Rob Herring wrote:
> On Tue, Jun 19, 2018 at 3:40 PM Rob Herring <robh@kernel.org> wrote:
> >
> > The DT core will call of_platform_default_populate, so it is not
> > necessary for machine specific code to call it unless there are custom
> > match entries, auxdata or parent device. Neither of those apply here, so
> > remove the call.
> >
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arm/mach-at91/at91rm9200.c | 5 -----
> >  arch/arm/mach-at91/at91sam9.c   | 5 -----
> >  arch/arm/mach-at91/sama5.c      | 5 -----
> >  3 files changed, 15 deletions(-)
> 
> Ping?
> 

This breaks the platform in two different ways:
 - PM is not working anymore because of the missing SRAM node
 - the pinctrl driver fails to probe and so many drivers are
   deferring the probe forever

Relevant messages (once the earlycon crap is removed to let earlyprintk
do its job):

at91_pm_sram_init: failed to find sram device!
AT91: PM not supported, due to no SRAM allocated

pinctrl-at91 ahb:apb:pinctrl at fc06a000: you need to specify at least one gpio-controller
pinctrl-at91: probe of ahb:apb:pinctrl at fc06a000 failed with error -22
gpio-at91 fc06a000.gpio: at address (ptrval)
gpio-at91 fc06b000.gpio: at address (ptrval)
gpio-at91 fc06c000.gpio: at address (ptrval)
gpio-at91 fc068000.gpio: at address (ptrval)
gpio-at91 fc06d000.gpio: at address (ptrval)

at91_i2c f8014000.i2c: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/i2c0/i2c0-0, deferring probe
atmel_usart f8004000.serial: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/uart0/uart0-0, deferring probe
atmel_usart fc00c000.serial: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/usart3/usart3-0, deferring probe
atmel_usart fc010000.serial: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/usart4/usart4-0, deferring probe
atmel_spi f8010000.spi: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/spi0/spi0-0, deferring probe
atmel_spi fc018000.spi: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/spi1/spi1-0, deferring probe
macb f8020000.ethernet: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/macb0/macb0_rmii-0, deferring probe
atmel_mci fc000000.mmc: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/mmc1/mmc1_clk_cmd_dat0, deferring probe
at91_adc fc034000.adc: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/adc0/adc0_ad0, deferring probe
gpio-keys gpio_keys: could not find pctldev for node /ahb/apb/pinctrl at fc06a000/board/key_gpio_0, deferring probe


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

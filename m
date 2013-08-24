From: b.brezillon@overkiz.com (boris brezillon)
Date: Sat, 24 Aug 2013 23:43:14 +0200
Subject: [RFC PATCH 0/3] pinctrl: at91: add support for generic pinconf
In-Reply-To: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
References: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <521928F2.4060605@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/2013 23:32, Boris BREZILLON wrote:
> Hello,
>
> This patch series is an attempt to add support for generic pin config
> syntax to at91 pinctrl driver.
>
> My primary goal is to add support for output configuration from dt definition.
> This is needed to fully move at91rm9200ek board to dt (other boards may have
> the same needs).
> This board use a pin to drive an external switch which select between 2
> functionnalities:
>   - mmc interface
>   - spi interface
> The pin level is currently configured in the board init (init_machine) function
> based on user config choices (CONFIG_MTD_AT91_DATAFLASH_CARD).
>
> Instead of adding a new flag to the current (native) pin config binding, I
> tried to add support for the generic pin config used by some pinctrl drivers
> (i.e. rockchip).
>
> Is this the right way to do this or should I add a new at91 native flags for
> output config (OUTPUT_HIGH/LOW) ?
>
> The second patch introduce a new config parameter to add a glitch filter on a
> specific pin.
The first patch, not the second.
> Glitch filter is similar to bounce filter (or debounce) but with a smaller
> delay (expressed in nsecs ?).
>
> I'm not sure this is the right approach.
> Maybe we should reuse the debounce parameter and add a flag to specify the delay
> unit (usec or nsec).
>
> What do you think ?
>
> The third patch migrate sama5 dt boards to the new generic config syntax.
>
> Please feel free to share your thoughts.
>
> Best Regards,
>
> Boris
>
>
> Boris BREZILLON (3):
>    pinctrl: add new generic pinconf config for deglitch filter
>    pinctrl: at91: add support for generic pinconf
>    ARM: at91/dt: move sama5 to generic pinconf
>
>   .../bindings/pinctrl/atmel,at91-pinctrl.txt        |   43 ++-
>   .../bindings/pinctrl/pinctrl-bindings.txt          |    1 +
>   arch/arm/boot/dts/sama5d3.dtsi                     |  363 ++++++++++----------
>   arch/arm/boot/dts/sama5d3xdm.dtsi                  |    2 +-
>   arch/arm/boot/dts/sama5d3xmb.dtsi                  |   12 +-
>   drivers/pinctrl/Kconfig                            |    2 +-
>   drivers/pinctrl/pinconf-generic.c                  |    2 +
>   drivers/pinctrl/pinctrl-at91.c                     |  265 +++++++++++++-
>   include/linux/pinctrl/pinconf-generic.h            |    5 +
>   9 files changed, 494 insertions(+), 201 deletions(-)
>

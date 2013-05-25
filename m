From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 25 May 2013 18:54:09 +0200
Subject: [PATCH 00/21] ARM: kirkwood: improve pinmux configs in Device Tree
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130525165409.GZ26249@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 11:44:37AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This series of patches has the goal of adding support for the Init
> button on OpenBlocks A6, but takes this opportunity to do a little bit
> of cleanup in the pinmux configurations of the various Kirkwood Device
> Trees.
> 
> Until now, all pinmux configurations were "owned" by the pinctrl
> driver, because back when they were introduced, the driver core was
> not selecting the pinmux configuration, each driver had to do it
> manually (and not all drivers were doing so). Now that the driver core
> selects the default pinmux configuration when available, it makes
> sense to associate the pinmux configuration to the particular device
> it is related to.
> 
> It allows pinctrl to show nice informations in debugfs, which
> associates a particular pin with the particular device using it:
> 
> # cat pinctrl/f1010000.pinctrl/pinmux-pins 
> Pinmux settings per pin
> Format: pin (name): mux_owner gpio_owner hog?
> pin 0 (PIN0): f4000000.nand (GPIO UNCLAIMED) function nand group mpp0
> pin 1 (PIN1): f4000000.nand (GPIO UNCLAIMED) function nand group mpp1
> pin 2 (PIN2): f4000000.nand (GPIO UNCLAIMED) function nand group mpp2
> pin 3 (PIN3): f4000000.nand (GPIO UNCLAIMED) function nand group mpp3
> pin 4 (PIN4): f4000000.nand (GPIO UNCLAIMED) function nand group mpp4
> pin 5 (PIN5): f4000000.nand (GPIO UNCLAIMED) function nand group mpp5
> pin 6 (PIN6): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 7 (PIN7): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 8 (PIN8): f1012100.serial (GPIO UNCLAIMED) function uart1 group mpp8
> pin 9 (PIN9): f1012100.serial (GPIO UNCLAIMED) function uart1 group mpp9
> pin 10 (PIN10): f1012000.serial (GPIO UNCLAIMED) function uart0 group mpp10
> pin 11 (PIN11): f1012000.serial (GPIO UNCLAIMED) function uart0 group mpp11
> pin 12 (PIN12): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 13 (PIN13): f1012100.serial (GPIO UNCLAIMED) function uart1 group mpp13
> pin 14 (PIN14): f1012100.serial (GPIO UNCLAIMED) function uart1 group mpp14
> pin 15 (PIN15): f1012000.serial (GPIO UNCLAIMED) function uart0 group mpp15
> pin 16 (PIN16): f1012000.serial (GPIO UNCLAIMED) function uart0 group mpp16
> pin 17 (PIN17): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 18 (PIN18): f4000000.nand (GPIO UNCLAIMED) function nand group mpp18
> pin 19 (PIN19): f4000000.nand (GPIO UNCLAIMED) function nand group mpp19
> pin 20 (PIN20): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp20
> pin 21 (PIN21): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp21
> pin 22 (PIN22): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp22
> pin 23 (PIN23): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp23
> pin 24 (PIN24): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp24
> pin 25 (PIN25): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp25
> pin 26 (PIN26): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp26
> pin 27 (PIN27): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp27
> pin 28 (PIN28): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp28
> pin 29 (PIN29): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp29
> pin 30 (PIN30): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp30
> pin 31 (PIN31): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp31
> pin 32 (PIN32): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 33 (PIN33): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 34 (PIN34): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 35 (PIN35): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 36 (PIN36): f1011100.i2c (GPIO UNCLAIMED) function twsi1 group mpp36
> pin 37 (PIN37): f1011100.i2c (GPIO UNCLAIMED) function twsi1 group mpp37
> pin 38 (PIN38): gpio_keys.2 mvebu-gpio:38 function gpio group mpp38
> pin 39 (PIN39): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 40 (PIN40): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 41 (PIN41): gpio-leds.1 mvebu-gpio:41 function gpio group mpp41
> pin 42 (PIN42): gpio-leds.1 mvebu-gpio:42 function gpio group mpp42
> pin 43 (PIN43): gpio-leds.1 mvebu-gpio:43 function gpio group mpp43
> pin 44 (PIN44): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 45 (PIN45): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 46 (PIN46): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 47 (PIN47): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 48 (PIN48): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 49 (PIN49): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> 
> Without this patch set, all pins appear to be owned by
> "f1010000.pinctrl".
> 
> Even though GPIO muxing is automatically done when a device driver
> requests a GPIO, Andrew Lunn and I had agreed to make the pinmuxing
> explicit, in order to have correct informations in debugfs. See our
> discussion at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/158190.html.
> 
> The last patch finally adds support for the init button of the
> Plathome OpenBlocks A6 platform.
> 
> Best regards,
> 
> Thomas

Hi Thomas, Jason

You can add a

Tested-By: Andrew Lunn <andrew@lunn.ch>

to the topkick and ts219 patches, and a general 

Acked-by: Andrew Lunn <andrew@lunn.ch>

to the rest.

	 Andrew

> 
> Thomas Petazzoni (21):
>   arm: kirkwood: cloudbox: affect pinmux configs to the right devices
>   arm: kirkwood: dlink dns: affect pinmux configs to the right devices
>   arm: kirkwood: dockstar: affect pinmux configs to the right devices
>   arm: kirkwood: dreamplug: affect pinmux configs to the right devices
>   arm: kirkwood: goflexnet: affect pinmux configs to the right devices
>   arm: kirkwood: guruplug: affect pinmux configs to the right devices
>   arm: kirkwood: ib62x0: affect pinmux configs to the right devices
>   arm: kirkwood: iconnect: give meaningful names to pinmux configs
>   arm: kirkwood: iconnect: affect pinmux configs to the right devices
>   arm: kirkwood: iomega ix2-200: affect pinmux configs to the right
>     devices
>   arm: kirkwood: ns2: affect pinmux configs to the right devices
>   arm: kirkwood: keymile: affect pinmux configs to the right devices
>   arm: kirkwood: buffalo linkstation: affect pinmux configs to the
>     right devices
>   arm: kirkwood: mplcec4: affect pinmux configs to the right devices
>   arm: kirkwood: readynas: affect pinmux configs to the right devices
>   arm: kirkwood: nsa310: affect pinmux configs to the right devices
>   arm: kirkwood: openblocks_a6: affect pinmux configs to the right
>     devices
>   arm: kirkwood: topkick: affect pinmux configs to the right devices
>   arm: kirkwood: ts219: affect pinmux configs to the right devices
>   arm: kirkwood: openblocks-a6: group pinmux configurations
>   arm: kirkwood: openblocks-a6: add support for Init button
> 
>  arch/arm/boot/dts/kirkwood-cloudbox.dts            |   10 +-
>  arch/arm/boot/dts/kirkwood-dns320.dts              |    7 ++
>  arch/arm/boot/dts/kirkwood-dns325.dts              |    5 +
>  arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   32 +++---
>  arch/arm/boot/dts/kirkwood-dockstar.dts            |    9 +-
>  arch/arm/boot/dts/kirkwood-dreamplug.dts           |   11 +-
>  arch/arm/boot/dts/kirkwood-goflexnet.dts           |   18 ++--
>  .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |    8 +-
>  arch/arm/boot/dts/kirkwood-ib62x0.dts              |   17 +--
>  arch/arm/boot/dts/kirkwood-iconnect.dts            |   36 +++----
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |   15 +--
>  arch/arm/boot/dts/kirkwood-is2.dts                 |    2 +
>  arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |    6 +-
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi               |   22 ++--
>  arch/arm/boot/dts/kirkwood-mplcec4.dts             |   23 +++--
>  .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |   22 ++--
>  arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   10 +-
>  arch/arm/boot/dts/kirkwood-ns2.dts                 |    2 +
>  arch/arm/boot/dts/kirkwood-ns2lite.dts             |    2 +
>  arch/arm/boot/dts/kirkwood-ns2max.dts              |    2 +
>  arch/arm/boot/dts/kirkwood-ns2mini.dts             |    2 +
>  arch/arm/boot/dts/kirkwood-nsa310.dts              |   29 +++---
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  108 ++++++--------------
>  arch/arm/boot/dts/kirkwood-topkick.dts             |   51 ++++-----
>  arch/arm/boot/dts/kirkwood-ts219-6281.dts          |    8 +-
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts          |    8 +-
>  arch/arm/boot/dts/kirkwood-ts219.dtsi              |   10 ++
>  27 files changed, 235 insertions(+), 240 deletions(-)
> 
> -- 
> 1.7.9.5
> 

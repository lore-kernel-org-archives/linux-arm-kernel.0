From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Oct 2016 21:12:09 +0800
Subject: [PATCH 0/7] ARM: dts: support I2SE Duckbill device
In-Reply-To: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
References: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
Message-ID: <20161024131209.GK30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 22, 2016 at 09:22:23PM +0200, Michael Heimpold wrote:
> This series updates/adds Device Tree support for I2SE's Duckbill
> device family.
> 
> The Duckbill devices are small, pen-drive sized boards based on
> NXP's i.MX28 SoC. While the initial variants (Duckbill series) were
> equipped with a micro SD card slot only, the latest generation
> (Duckbill 2 series) have an additional internal eMMC onboard.
> 
> Both device generations consists of four "family members":
> 
> - Duckbill/Duckbill 2: generic board, intented to be used as
>   baseboard for custom designs and/or as development board
> 
> - Duckbill EnOcean/Duckbill 2 EnOcean: come with an EnOcean
>   daugther board equipped with the popular TCM310 module
> 
> - Duckbill 485/Duckbill 2 485: as the name implies, these
>   devices are intended to be used as Ethernet - RS485 converters
> 
> - Duckbill SPI/Duckbill 2 SPI: not sold separately, but used
>   in I2SE's development kits for Green PHY HomePlug Powerline
>   communication

So we basically need to maintain 8 dts/dtb files for imx28-duckbill
board.  This is not pleasant.  Can you please investigate if Device Tree
overlay is going to help here?

Shawn

[1] http://free-electrons.com/blog/dt-overlay-uboot-libfdt/

> Since all devices are very similar and only differ in few
> aspects, the following patch series introduces first common
> device tree snippets which are then included by the real
> devices. For better understanding, I tried to illustrate the
> hierarchy:
> 
> +--------------------+                      +----------------------+
> | imx28-duckbill.dts |                      | imx28-duckbill-2.dts |
> +--------------------+                      +----------------------+
>   ^                                           ^
>   |  +----------------------------+           |  +------------------------------+
>   |  | imx28-duckbill-enocean.dts |           |  | imx28-duckbill-2-enocean.dts |
>   |  +----------------------------+           |  +------------------------------+
>   |    ^                                      |    ^
>   |    |  +------------------------+          |    |  +--------------------------+
>   |    |  | imx28-duckbill-485.dts |          |    |  | imx28-duckbill-2-485.dts |
>   |    |  +------------------------+          |    |  +--------------------------+
>   |    |    ^                                 |    |    ^
>   |    |    |  +------------------------+     |    |    |  +--------------------------+
>   |    |    |  | imx28-duckbill-spi.dts |     |    |    |  | imx28-duckbill-2-spi.dts |
>   |    |    |  +------------------------+     |    |    |  +--------------------------+
>   |    |    |    ^                            |    |    |    ^
>   |    |    |    |                            |    |    |    |
>   |    |    |    |                            |    |    |    |
> +---------------------------------------+   +-----------------------------------------+
> |      imx28-duckbill-common.dtsi       |   |       imx28-duckbill-2-common.dtsi      |
> +---------------------------------------+   +-----------------------------------------+
>                               ^                      ^
>                               |                      |
>                            +----------------------------+
>                            |  imx28-duckbill-base.dtsi  |
>                            +----------------------------+
>                                           ^
>                                           |
>                                     +------------+
>                                     | imx28.dtsi |
>                                     +------------+
> 
> Michael Heimpold (7):
>   ARM: dts: imx28: add alternative pinmuxing for mmc2
>   ARM: dts: imx28: rename mmc2_sck_cfg to prepare for an alternative
>     muxing setup
>   ARM: dts: imx28: add alternative muxing for mmc2_sck_cfg
>   ARM: dts: add I2SE Duckbill common definitions
>   ARM: dts: duckbill: simplify DT and use common definitions
>   ARM: dts: add support for remaining members of Duckbill series
>   ARM: dts: add support for Duckbill 2 series devices
> 
>  arch/arm/boot/dts/Makefile                     |   7 ++
>  arch/arm/boot/dts/imx28-duckbill-2-485.dts     |  70 ++++++++++++++++
>  arch/arm/boot/dts/imx28-duckbill-2-common.dtsi | 110 +++++++++++++++++++++++++
>  arch/arm/boot/dts/imx28-duckbill-2-enocean.dts | 100 ++++++++++++++++++++++
>  arch/arm/boot/dts/imx28-duckbill-2-spi.dts     |  63 ++++++++++++++
>  arch/arm/boot/dts/imx28-duckbill-2.dts         |  46 +++++++++++
>  arch/arm/boot/dts/imx28-duckbill-485.dts       |  60 ++++++++++++++
>  arch/arm/boot/dts/imx28-duckbill-base.dtsi     |  88 ++++++++++++++++++++
>  arch/arm/boot/dts/imx28-duckbill-common.dtsi   |  80 ++++++++++++++++++
>  arch/arm/boot/dts/imx28-duckbill-enocean.dts   |  90 ++++++++++++++++++++
>  arch/arm/boot/dts/imx28-duckbill-spi.dts       |  64 ++++++++++++++
>  arch/arm/boot/dts/imx28-duckbill.dts           |  99 +++-------------------
>  arch/arm/boot/dts/imx28-m28cu3.dts             |   2 +-
>  arch/arm/boot/dts/imx28.dtsi                   |  28 ++++++-
>  14 files changed, 817 insertions(+), 90 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-485.dts
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-common.dtsi
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-spi.dts
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-2.dts
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-485.dts
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-base.dtsi
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-common.dtsi
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-enocean.dts
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-spi.dts
> 
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

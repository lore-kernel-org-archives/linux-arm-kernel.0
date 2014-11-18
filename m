From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 18 Nov 2014 11:43:45 +0100
Subject: [PATCHv3 00/12] arm: mvebu: add Synology DS213j and DS414 .dts
 files
In-Reply-To: <cover.1416266432.git.arno@natisbad.org>
References: <cover.1416266432.git.arno@natisbad.org>
Message-ID: <546B22E1.4020507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2014 12:26 AM, Arnaud Ebalard wrote:
> This series adds .dts files for Synology DS213j (armada 370 2-bay NAS) and
> DS414 (armada XP 4-bay NAS) devices. It is based on comments received on
> a v0 submission of DS213j .dts file [1] and Andrew's comments on a v1 (
> for both DS213j and DS414 .dts files) [2] and Andrew/Sebastian' comments
> on v2 regarding pinctrl improvements [3].
>
> Cheers,
>
> a+
>
> [1]: http://thread.gmane.org/gmane.linux.drivers.devicetree/95401
> [2]: http://thread.gmane.org/gmane.linux.drivers.devicetree/98830
> [3]: http://thread.gmane.org/gmane.linux.drivers.devicetree/98892
>
> Changes since v2:
>
> - Added various patches to improve/refactor Armada 370/XP pinctrl
>    nodes/properties and use sensible defaults when possible.

Arnaud,

sorry I didn't remember earlier, but there has been a similar patch
set that already deals with Armada-XP pinctrl and ethernet settings
[1].

[1] 
https://lkml.kernel.org/g/1411157684-6991-1-git-send-email-sebastian.hesselbarth at gmail.com

It has already been merged by Jason into mvebu/dt for v3.19, so it
seems you'll have to rebase your patches on top of it. AFAIKS, you
can drop pinctrl node consolidation for the SoCs (XP at least) and
RGMII consolidation. The other changes you did for common 370/XP
dtsi, UART, and SPI are valuable and you should keep them.

If I find some time, I'll have a closer look at both patch sets.
Sorry again for not remembering earlier!

Sebastian

> - changed gpio-fan,speed-map to better match max rotation speed
>    (1900 RPM) for DS213j
>
> Changes since v1:
>
> - Added a patch to fix Seiko Instruments, Inc. prefix from "ssi" to
>    "sii" for s35390 RTC chip in kirkwood-synology.dtsi as reported by
>    Andrew
> - Fixed DS414 and DS213j .dts files which had the same issue due to
>    a blind copy-and-paste.
> - Added a patch for armada-xp-lenovo-ix4-300d.dts to use uart alias
>    for stdout-path, as suggested by Andrew.
> - removed pinctrl properties for ethernet interface wrongly referencing
>    a RGMII pin configuration: the PHY is connected using SGMII.
> - moved some DS213j pinctrl entries (spi0, uart0) in armada-370.dtsi
> - same thing for DS414 pinctrl entries (ge0/1, spi0) moved to
>    armada-xp-mv78230.dtsi
> - changed pinctrl nodes and labels to match naming convention found
>    in .dtsi: pmx_*: pmx- changed to *_pin: -pin.
> - same thing for DS414
> - added a comment in the .dts file about DS414 being susceptible at
>    boot when an USB/serial converter is connected to the UART pins.
>
> Changes since v0:
>
> - Added a comment at the beginning of DS213j and DS414j .dts file regarding
>    the need for a recent Marvell bootloader. Arnd suggested to do a specific
>    .dtb file for new and old bootloaders but I think if we follow this path
>    for DS414 and DS213j, we will probably have to do it for all Armada-based
>    synology NAS and possibly for other Armada 370/XP based devices. Opting
>    for recent bootloaders config and having a comment is easier. It is likely
>    that a user already has a recent bootloader. Otherwise, upgrade is a one
>    click process anyway. If a user thinks it is easier to have two different
>    .dts files in the kernel, she will still be able to push a patch.
> - Added a comment in the .dts file about the bootloader screwing the kernel
>    if the environment is saved.
> - Kept GPL licence for .dts file
> - Fixed bad naming of node and alias (_ vs -)
> - Added micron vendor prefix for n25q064 flash
> - Disabled SoC RTC; a Seiko S-35390A is used as main RTC
> - Added comments about the purpose of each serial port
> - Added stdout-path = &uart0; to help barebox. A specific patch is included
>    in the series to provide labels for uart serial nodes
> - Added patch for DS414 .dts file
>
>
> Arnaud Ebalard (12):
>    of: add "micron" vendor prefix for Micron
>    arm: mvebu: fix vendor prefix typo in kirkwood-synology.dtsi
>    arm: mvebu: add uartX labels for Armada SoC serial nodes
>    arm: mvebu: use recently introduced uart label for stdout-path
>    arm: mvebu: remove duplications in pinctrl nodes for Armada 370/XP
>    arm: mvebu: define and use common Armada 370 SPI pinctrl settings
>    arm: mvebu: define and use common Armada 370 UART pinctrl settings
>    arm: mvebu: define and use common Armada XP UART2/3 pinctrl settings
>    arm: mvebu: define and use ge0/1 rgmii pinctrl settings for armada XP
>    arm: mvebu: define and use common Armada XP SPI pinctrl setting
>    arm: mvebu: add .dts file for Synology DS213j
>    arm: mvebu: add .dts file for Synology DS414
>
>   .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>   arch/arm/boot/dts/Makefile                         |   6 +-
>   arch/arm/boot/dts/armada-370-db.dts                |   2 +
>   arch/arm/boot/dts/armada-370-synology-ds213j.dts   | 321 ++++++++++++++++++++
>   arch/arm/boot/dts/armada-370-xp.dtsi               |   9 +-
>   arch/arm/boot/dts/armada-370.dtsi                  |  58 +++-
>   arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  25 +-
>   arch/arm/boot/dts/armada-xp-db.dts                 |   4 +
>   arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   6 +-
>   arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   7 -
>   arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   7 -
>   arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   7 -
>   arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |   4 +
>   arch/arm/boot/dts/armada-xp-synology-ds414.dts     | 330 +++++++++++++++++++++
>   arch/arm/boot/dts/armada-xp.dtsi                   |  52 +++-
>   arch/arm/boot/dts/kirkwood-synology.dtsi           |   2 +-
>   16 files changed, 788 insertions(+), 53 deletions(-)
>   create mode 100644 arch/arm/boot/dts/armada-370-synology-ds213j.dts
>   create mode 100644 arch/arm/boot/dts/armada-xp-synology-ds414.dts
>

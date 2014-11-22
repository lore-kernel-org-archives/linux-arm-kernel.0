From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Nov 2014 23:54:30 -0500
Subject: [PATCHv6 00/10] arm: mvebu: add Synology DS213j and DS414 .dts
 files
In-Reply-To: <cover.1416613429.git.arno@natisbad.org>
References: <cover.1416613429.git.arno@natisbad.org>
Message-ID: <20141122045430.GU22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

On Sat, Nov 22, 2014 at 12:45:06AM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> This series adds .dts files for Synology DS213j (armada 370 2-bay NAS) and
> DS414 (armada XP 4-bay NAS) devices. Most of the patches at the bottom of
> the series result:
> 
>  - from a v0 submission of DS213j .dts file [1]
>  - Andrew's comments on a v1 (for both DS213j and DS414 .dts files) [2]
>  - Andrew/Sebastian' comments on v2 regarding pinctrl factoring [3]
>  - Sebastian's feedback on changes included in Jason's branch for 3.19 [4]
>  - Additional comments on v4 by Jason, Arnd, Uwe, Thomas [5].
>  - Andrew's review on v5 []
> 
> Cheers,
> 
> a+
> 
> [1]: http://thread.gmane.org/gmane.linux.drivers.devicetree/95401
> [2]: http://thread.gmane.org/gmane.linux.drivers.devicetree/98830
> [3]: http://thread.gmane.org/gmane.linux.drivers.devicetree/98892
> [4]: http://thread.gmane.org/gmane.linux.drivers.devicetree/99181
> [5]: http://www.spinics.net/lists/devicetree/index.html#58661
> [6]: http://www.spinics.net/lists/arm-kernel/threads.html#380169
> 
> Changes since v5:
> - Ordered nodes by increasing address order as pointed by Andrew
> - Removed useless MPP4 pin definition
> - Added Andrew's Acked-by on the whole series
> 
> Changes since v4:
> - Added a missing newline spotted by Uwe
> - Added two Reviewed-by by Thomas
> - Added a note about i2c devices not relying on optional vendor prefix
> 
> Changes since v3:
> 
> - As pointed by Sebastian, some of the changes included in v3 were
>   already sitting in Jason's mvebu/dt for 3.19. While rebasing the
>   series on mvebu/dt for 3.19, I made pinctrl node definition and
>   alias common to 370 and XP SoCs, and then completed for 370 what
>   had been started by Sebastian in 264a05e19bf5 ("ARM: mvebu:
>   armada-xp: Add node alias to pinctrl and add base address") and
>   01c434225ee6 ("ARM: mvebu: armada-xp: Use pinctrl node alias")
>   for XP.
> - Removed the patch adding micron prefix; Rob pointed he already
>   had such a patch
> 
> Changes since v2:
> 
> - Added various patches to improve/refactor Armada 370/XP pinctrl
>   nodes/properties and use sensible defaults when possible.
> - changed gpio-fan,speed-map to better match max rotation speed
>   (1900 RPM) for DS213j
> 
> Changes since v1:
> 
> - Added a patch to fix Seiko Instruments, Inc. prefix from "ssi" to
>   "sii" for s35390 RTC chip in kirkwood-synology.dtsi as reported by
>   Andrew
> - Fixed DS414 and DS213j .dts files which had the same issue due to
>   a blind copy-and-paste.
> - Added a patch for armada-xp-lenovo-ix4-300d.dts to use uart alias
>   for stdout-path, as suggested by Andrew.
> - removed pinctrl properties for ethernet interface wrongly referencing
>   a RGMII pin configuration: the PHY is connected using SGMII.
> - moved some DS213j pinctrl entries (spi0, uart0) in armada-370.dtsi
> - same thing for DS414 pinctrl entries (ge0/1, spi0) moved to
>   armada-xp-mv78230.dtsi
> - changed pinctrl nodes and labels to match naming convention found
>   in .dtsi: pmx_*: pmx- changed to *_pin: -pin.
> - same thing for DS414
> - added a comment in the .dts file about DS414 being susceptible at
>   boot when an USB/serial converter is connected to the UART pins.
> 
> Changes since v0:
> 
> - Added a comment at the beginning of DS213j and DS414j .dts file regarding
>   the need for a recent Marvell bootloader. Arnd suggested to do a specific
>   .dtb file for new and old bootloaders but I think if we follow this path
>   for DS414 and DS213j, we will probably have to do it for all Armada-based
>   synology NAS and possibly for other Armada 370/XP based devices. Opting
>   for recent bootloaders config and having a comment is easier. It is likely
>   that a user already has a recent bootloader. Otherwise, upgrade is a one
>   click process anyway. If a user thinks it is easier to have two different
>   .dts files in the kernel, she will still be able to push a patch.
> - Added a comment in the .dts file about the bootloader screwing the kernel
>   if the environment is saved.
> - Kept GPL licence for .dts file
> - Fixed bad naming of node and alias (_ vs -)
> - Added micron vendor prefix for n25q064 flash
> - Disabled SoC RTC; a Seiko S-35390A is used as main RTC
> - Added comments about the purpose of each serial port
> - Added stdout-path = &uart0; to help barebox. A specific patch is included
>   in the series to provide labels for uart serial nodes
> - Added patch for DS414 .dts file
> 
> 
> 
> Arnaud Ebalard (10):

These three patches had trouble:

>   arm: mvebu: move Armada 370/XP pinctrl node definition armada-370-xp.dtsi

armada-370-db needed to be hand-jammed.  Please double-check that it
went through correctly.  The error was something about missing repository
info.  Usually that means the patch was based on something weird...

>   arm: mvebu: define and use common Armada 370 UART pinctrl settings

Same here, 'patch -Np1 <...patch' went fine, though.  Please double
check.

>   arm: mvebu: add .dts file for Synology DS414

This broke the build :(  I did s/ge[01]_rgmii_pins/pmx_ge[01]_rgmii/ to
fix the issue.  Did you run 'make dtbs' before you sent?

At any rate, whole series applied to mvebu/dt.

thx,

Jason.

From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Aug 2013 11:06:51 -0400
Subject: [PATCH 00/15] Armada 370/XP watchdog support
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130827150651.GF19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

it's a good idea to Cc devicetree ML on the coverletter so that folks
can have the context at hand.

thx,

Jason.

On Tue, Aug 27, 2013 at 11:34:24AM -0300, Ezequiel Garcia wrote:
> This patchset adds support for Armada 370/XP SoC watchdog using the
> orion-wdt driver. Several issues were blocking this addition, each
> of which has timely discussed and (at least initially) agreed.
> 
> Namely, the issues are:
> 
> * Handling of clock input differences, which was related
>   to Armada 370/XP clocksource reference 25 MHz issue.
>   This is already solved by the work in [1] (merge pending).
> 
> * Shared register handling. It was agreed to introduce an atomic
>   read/modify API for such accesses [2]. Once the API is merged we'll use
>   it to access the timer control register shared between clocksource
>   and watchdog drivers.
> 
> * Watchdog RSTOUT enable. It was decided [3] that this was better
>   handled at each machine initialization (and so this patchset
>   does such change). This change allows to remove the mach-specific
>   header in orion-wdt,  allowing multiplatform build.
> 
> The current patchset is based and superseeds the previous v2 on
> Orion watchdog:
> 
>   http://www.spinics.net/lists/arm-kernel/msg269526.html
> 
> However, this is a new patchset that allow to support Armada 370/XP
> watchdog.
> 
> Patches 1-5 removes and reworks the orion-wdt to allow to remove the
> mach-specific header.
> 
> Patches 6-9 adds the infrastructure required to support multiple SoCs
> in the orion-wdt driver, and then uses it to support Armada 370 and
> Armada XP.
> 
> Patches 9-15 completes the support by updating the devicetree binding
> documentation, devicetree files, and default configuration.
> 
> This series is based in v3.11-rc6 and has been tested on:
> 
>  * Kirkwood Openblocks A6
>  * Armada XP Openblocks AX3
>  * Armada 370 Mirabox
> 
> (I must thank Plat'home for donating those beatiful boxes!)
> 
> [1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/261861
> [2] http://lwn.net/Articles/564709/
> [3] http://www.spinics.net/lists/arm-kernel/msg269994.html
> 
> Thanks!
> 
> Ezequiel Garcia (15):
>   watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
>   ARM: orion: Assert watchdog RSTOUT enable bit
>   ARM: mvebu: Add watchdog RSTOUT enable in system-controller init
>   watchdog: orion: Remove RSTOUT bit enable/disable
>   watchdog: orion: Allow to build in any Orion platform
>   watchdog: orion: Introduce an orion_watchdog device structure
>   watchdog: orion: Introduce per-compatible of_device_id data
>   watchdog: orion: Add per-compatible clock initialization
>   watchdog: orion: Add support for Armada 370 and Armada XP SoC
>   ARM: mvebu: Add RSTOUT cell to system-controller DT node
>   ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
>   watchdog: orion: Rename device-tree binding documentation
>   watchdog: orion: Add other compatibles to devicetree binding
>   ARM: mvebu: system-controller: Add second reg cell devicetree
>     specification
>   ARM: mvebu: Enable watchdog in defconfig
> 
>  .../bindings/arm/mvebu-system-controller.txt       |   7 +-
>  .../devicetree/bindings/watchdog/marvel.txt        |  19 --
>  .../devicetree/bindings/watchdog/orion-wdt.txt     |  34 +++
>  arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +
>  arch/arm/boot/dts/armada-370.dtsi                  |   7 +-
>  arch/arm/boot/dts/armada-xp.dtsi                   |   8 +-
>  arch/arm/configs/mvebu_defconfig                   |   3 +
>  arch/arm/mach-dove/board-dt.c                      |   2 +
>  arch/arm/mach-dove/common.c                        |   2 +
>  arch/arm/mach-dove/include/mach/bridge-regs.h      |   1 +
>  arch/arm/mach-kirkwood/board-dt.c                  |   2 +
>  arch/arm/mach-kirkwood/common.c                    |   2 +
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   1 +
>  arch/arm/mach-mv78xx0/common.c                     |   2 +
>  arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |   1 +
>  arch/arm/mach-mvebu/system-controller.c            |  22 ++
>  arch/arm/mach-orion5x/board-dt.c                   |   4 +
>  arch/arm/mach-orion5x/common.c                     |   2 +
>  arch/arm/mach-orion5x/include/mach/bridge-regs.h   |   1 +
>  arch/arm/plat-orion/common.c                       |   5 +
>  arch/arm/plat-orion/include/plat/common.h          |   1 +
>  drivers/watchdog/Kconfig                           |   2 +-
>  drivers/watchdog/orion_wdt.c                       | 244 +++++++++++++++------
>  23 files changed, 283 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/marvel.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> 
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 14:26:32 +0200
Subject: [PATCH V3 00/19] mmc: mmci: Improve DT support
In-Reply-To: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
References: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAPDyKFpcoFvPE1fMHGs=hWnZ+zwYJ26yen3LFgdVZY-gfrr=DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2014 14:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Step by step, improve the DT support for the mmci host driver.
>
> This enables us to move the final pieces of platform data for mmci for ux500
> into DT. We are then able to remove yet another machine specific file for ux500.
>
> This patchset needs to be merged together. I suggest we go through Russell's
> ARM tree, since most of the patches are mmci specific which he maintains -
> unless someone think there is a better alternative.
>
> I will thus seek acks from the SOC maintainers for the SOC specific patches.
>
> The goal is to queue this for 3.16, thus I might need to rebase the patches for
> 3.15 rc[n]. Still I would appreciate any comments at this point.
>
> Changes in v3:
>         - Adopting to review comments from Michal Simek for patch 2.
>         - Rebased patches and added some acks/reviewed by tags.
>
> Changes in v2:
>         - Adopting to review comments from Rob Herring and Linus Walleij. More
>         or less causing each an every patch to be rebased.
>         - Removed the patch for regulator for the db8500-prcmu from this
>         patchset, since Mark Brown already queued it for 3.15.
>
> Ulf Hansson (19):
>   mmc: mmci: Convert to the mmc gpio API
>   mmc: mmci: Convert to devm functions
>   mmc: mmci: Update DT documentation
>   mmc: mmci: Add DT bindings for signal direction
>   mmc: mmci: Add DT bindings for feedback clock pin
>   mmc: mmci: Use the common mmc DT parser
>   ARM: ux500: Add mmci signal directions and feeback clock in DT for
>     href
>   ARM: ux500: Convert to the common mmc DT bindings for highspeed mode
>   ARM: nomadik: Convert to the common mmc DT bindings for highspeed
>     mode
>   ARM: u300: Convert to the common mmc DT bindings for highspeed mode
>   mmc: mmci: Mark the DT bindings for highspeed mode as deprecated
>   mmc: mmci: Enable MMC_CAP_CMD23
>   ARM: ux500: Add the mmc capabilities flags to DT
>   ARM: ux500: Add a vmmc regulator through DT for the poped eMMC for
>     href
>   ARM: ux500: Remove redundant board file for mmci platform data
>   mmc: mmci: Enforce DT for signal direction and feedback clock
>   mmc: mmci: Enforce mmc capabilities through DT
>   mmc: mmci: Enforce DMA configuration through DT
>   mmc: mmci: Enforce max frequency configuration through DT
>
>  Documentation/devicetree/bindings/mmc/mmci.txt |   54 ++++-
>  arch/arm/boot/dts/ste-ccu9540.dts              |    6 +-
>  arch/arm/boot/dts/ste-href.dtsi                |   19 +-
>  arch/arm/boot/dts/ste-nomadik-stn8815.dtsi     |    4 +-
>  arch/arm/boot/dts/ste-snowball.dts             |    4 +-
>  arch/arm/boot/dts/ste-u300.dts                 |    4 +-
>  arch/arm/mach-ux500/Makefile                   |    3 +-
>  arch/arm/mach-ux500/board-mop500-sdi.c         |  166 ---------------
>  arch/arm/mach-ux500/board-mop500.h             |    5 -
>  arch/arm/mach-ux500/cpu-db8500.c               |    4 -
>  drivers/mmc/host/mmci.c                        |  265 +++++++-----------------
>  drivers/mmc/host/mmci.h                        |   14 +-
>  include/linux/amba/mmci.h                      |   42 ----
>  13 files changed, 157 insertions(+), 433 deletions(-)
>  delete mode 100644 arch/arm/mach-ux500/board-mop500-sdi.c
>
> --
> 1.7.9.5
>
>
>

Some cut/paste errors below. Please ignore the patchset summary above,
the below is the correct one.

Kind regards
Ulf Hansson

>
>
>
> Ulf Hansson (19):
>   mmc: mmci: Convert to the mmc gpio API
>   mmc: mmci: Convert to devm functions
>   mmc: mmci: Update DT documentation
>   mmc: mmci: Add DT bindings for signal direction
>   mmc: mmci: Add DT bindings for feedback clock pin
>   mmc: mmci: Use the common mmc DT parser
>   ARM: ux500: Add mmci signal directions and feeback clock in DT for
>     href
>   ARM: ux500: Convert to the common mmc DT bindings for highspeed mode
>   ARM: nomadik: Convert to the common mmc DT bindings for highspeed
>     mode
>   ARM: u300: Convert to the common mmc DT bindings for highspeed mode
>   mmc: mmci: Mark the DT bindings for highspeed mode as deprecated
>   mmc: mmci: Enable MMC_CAP_CMD23
>   ARM: ux500: Add the mmc capabilities flags to DT
>   ARM: ux500: Add a vmmc regulator through DT for the poped eMMC for
>     href
>   ARM: ux500: Remove redundant board file for mmci platform data
>   mmc: mmci: Enforce DT for signal direction and feedback clock
>   mmc: mmci: Enforce mmc capabilities through DT
>   mmc: mmci: Enforce DMA configuration through DT
>   mmc: mmci: Enforce max frequency configuration through DT
>
>  Documentation/devicetree/bindings/mmc/mmci.txt |   54 ++++-
>  arch/arm/boot/dts/ste-ccu9540.dts              |    6 +-
>  arch/arm/boot/dts/ste-href.dtsi                |   19 +-
>  arch/arm/boot/dts/ste-nomadik-stn8815.dtsi     |    4 +-
>  arch/arm/boot/dts/ste-snowball.dts             |    4 +-
>  arch/arm/boot/dts/ste-u300.dts                 |    4 +-
>  arch/arm/mach-ux500/Makefile                   |    3 +-
>  arch/arm/mach-ux500/board-mop500-sdi.c         |  166 ---------------
>  arch/arm/mach-ux500/board-mop500.h             |    5 -
>  arch/arm/mach-ux500/cpu-db8500.c               |    4 -
>  drivers/mmc/host/mmci.c                        |  264 ++++++------------------
>  drivers/mmc/host/mmci.h                        |   14 +-
>  include/linux/amba/mmci.h                      |   42 ----
>  13 files changed, 154 insertions(+), 435 deletions(-)
>  delete mode 100644 arch/arm/mach-ux500/board-mop500-sdi.c
>
> --
> 1.7.9.5
>

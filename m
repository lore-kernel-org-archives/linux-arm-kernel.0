From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 9 Aug 2013 08:44:46 -0400
Subject: [PATCH v2 0/6] Armada 370/XP clocksource fixes
In-Reply-To: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130809124446.GR8204@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

Are you going to be able to take patches 1-5 for v3.12?  Assuming the DT
maintainers are ok with the binding change, of course.

thx,

Jason.

On Thu, Aug 08, 2013 at 08:32:26AM -0300, Ezequiel Garcia wrote:
> This small patchset fixes a somewhat minor issue found in the clocksource
> driver for Armada 370/XP SoC.
> 
> On one side the Armada 370 SoC has no 25 MHz fixed timer.
> On the other side the Armada XP SoC cannot work properly without such 25 MHz
> fixed timer selected, because otherwise the base clock frequency would vary
> when doing cpufreq frequency changes.
> 
> Therefore we can consider the SoCs as not being compatible, being better to
> have two compatible strings, one for each SoC. The previous compatible and
> its behavior has been maintained to preserve backwards compatibility.
> 
> In addition, CLOCKSOURCE_OF_DECLARE is used to simplify the initialization.
> 
> This patchset is based on v3.11-rc4. Also, to ease maintainer's task this
> is based on these two patches which are in linux-next:
> 
>   commit be14114934545f52be2ffddbe401ba0951007c59
>   Author: Stephen Boyd <sboyd@codeaurora.org>
>   "clocksource: time-armada-370-xp: Divorce from local timer API"
> 
>   commit 4047c794ae18c467a5ea987265238186bc253f61
>   Author: Stephen Boyd <sboyd@codeaurora.org>
>   "clocksource: time-armada-370-xp: Fix sparse warning"
> 
> Any testing and feedback is highly appreciated!
> 
> Changes from v1:
> 
>   * Declare TIMER_CTRL register access helpers as static,
>     as reported by Andrew Lunn.
> 
>   * Add some documentation about the deprecated compatible string
>     in the clocksource driver, as suggested by Andrew Lunn.
> 
>   * Add to the series a cosmetic patch to use BIT()
> 
>   * Rebased on top of two patches for the armada-370-xp clocksource
>     driver, that are already in linux-next.
> 
>   * Reordered the patches: bare cleanup first, improvements later.
> 
> Ezequiel Garcia (6):
>   clocksource: armada-370-xp: Use BIT()
>   clocksource: armada-370-xp: Simplify TIMER_CTRL register access
>   clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE
>   clocksource: armada-370-xp: Introduce new compatibles
>   clocksource: armada-370-xp: Fix device-tree binding
>   ARM: mvebu: Fix the Armada 370/XP timer compatible strings
> 
>  .../bindings/timer/marvell,armada-370-xp-timer.txt |  29 +++-
>  arch/arm/boot/dts/armada-370-xp.dtsi               |   1 -
>  arch/arm/boot/dts/armada-370.dtsi                  |   4 +
>  arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
>  arch/arm/mach-mvebu/armada-370-xp.c                |   4 +-
>  drivers/clocksource/time-armada-370-xp.c           | 155 ++++++++++++++-------
>  include/linux/time-armada-370-xp.h                 |  16 ---
>  7 files changed, 134 insertions(+), 77 deletions(-)
>  delete mode 100644 include/linux/time-armada-370-xp.h
> 
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

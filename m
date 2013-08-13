From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Aug 2013 13:58:24 -0400
Subject: [PATCH v4 0/6] Armada 370/XP clocksource fixes
In-Reply-To: <520A7178.3040100@linaro.org>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <520A5D58.10902@linaro.org>
 <20130813165223.GC25111@titan.lakedaemon.net>
 <520A7178.3040100@linaro.org>
Message-ID: <20130813175824.GE25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 07:48:40PM +0200, Daniel Lezcano wrote:
> On 08/13/2013 06:52 PM, Jason Cooper wrote:
> > Daniel,
> > 
> > On Tue, Aug 13, 2013 at 06:22:48PM +0200, Daniel Lezcano wrote:
> >> On 08/13/2013 04:43 PM, Ezequiel Garcia wrote:
> >>> This small patchset fixes a somewhat minor issue found in the clocksource
> >>> driver for Armada 370/XP SoC.
> >>>
> >>> On one side the Armada 370 SoC has no 25 MHz fixed timer.
> >>> On the other side the Armada XP SoC cannot work properly without such 25 MHz
> >>> fixed timer selected, because otherwise the base clock frequency would vary
> >>> when doing cpufreq frequency changes.
> >>>
> >>> Therefore we can consider the SoCs as not being compatible, being better to
> >>> have two compatible strings, one for each SoC. The previous compatible and
> >>> its behavior has been removed, considering there are no DT-enabled boards
> >>> in use in the field.
> >>>
> >>> In addition, CLOCKSOURCE_OF_DECLARE is used to simplify the initialization.
> >>>
> >>> This patchset is based on tip/timers/core.
> >>>
> >>
> >> Applied to my tree as 3.12 material.
> > 
> > Did you take patch #6 as well?
> 
> Yes. Not good ?

I usually try to keep all the *.dts? changes in one tree so I can
resolve the conflicts internally because our dts files have been subject
to large changes (adding pcie/mbus, relocating nodes under the proper
parents, etc).

By way of example:

$ git diff --stat v3.11-rc1..for-next -- arch/arm/boot/dts/armada-*
 arch/arm/boot/dts/armada-370-db.dts              |   5 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         |  37 +-
 arch/arm/boot/dts/armada-370-rd.dts              |  37 +-
 arch/arm/boot/dts/armada-370-xp.dtsi             | 114 ++++---
 arch/arm/boot/dts/armada-370.dtsi                | 127 ++++---
 arch/arm/boot/dts/armada-xp-db.dts               | 131 ++++---
 arch/arm/boot/dts/armada-xp-gp.dts               | 107 +++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi         | 229 +++++++------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         | 270 ++++++++-------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         | 418 ++++++++++++-----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  88 +++--
 arch/arm/boot/dts/armada-xp.dtsi                 |  19 +-
 12 files changed, 849 insertions(+), 733 deletions(-)

I would prefer not to subject arm-soc or Linus to resolving those when
they are best resolved at our level.

Is it possible for you to drop that one so we can take it?

thx,

Jason.

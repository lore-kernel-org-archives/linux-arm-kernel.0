From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:29 +0200
Subject: [PATCH 00/14] ARM: berlin: bisect compatible simple-mfd conversion
Message-ID: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a patch set reworking Antoine's patches to move Berlin's system and
chip controller nodes to simple-mfd registered sub-nodes in a bisect compatible
way.

Compared to Antoine's patches, I basically first converted the drivers to
deal with both single node and simple-mfd sub-node registration, then move the
DT nodes over to simple-mfd, and finally drop the old way of registration.

I decided to squash the BG2/BG2CD/BG2Q DT changes into a single patch where
applicable instead of the clock node rework patches. I also left the Acked-by
from Phillip Zabel (reset), Linus Walleij (pinctrl), and Stephen Boyd (clk)
in place for the driver changes as the outcome is the same at the end.

I am still planing to get this into v4.2 as soon as possible, so if Arnd is
now happy with the dependency of the patches and none of the maintainers is
against it, I'll prepare a PR next week.

@Arnd: This is still based on v4.1-rc1 as I cannot see a stable branch for
simple-mfd support. Anything specific you want me to remind you that this
depends on simple-mfd?

Sebastian

Antoine Tenart (14):
  ARM: berlin: select MFD_SYSCON by default
  ARM: berlin: prepare simple-mfd/syscon conversion of sys/chip ctrl
    nodes
  reset: berlin: convert to a platform driver
  ARM: berlin: move reset to simple-mfd nodes
  reset: berlin: drop arch_initcall initialization
  pinctrl: berlin: prepare to use regmap provided by syscon
  ARM: berlin: move pinctrl to simple-mfd nodes
  pinctrl: berlin: drop SoC stub provided regmap
  clk: berlin: prepare simple-mfd conversion
  ARM: berlin: move BG2 clock node
  ARM: berlin: move BG2CD clock node
  ARM: berlin: move BG2Q clock node
  clk: berlin: drop direct of_iomap of nodes reg property
  ARM: berlin: remove useless chip and system ctrl compatibles

 arch/arm/boot/dts/berlin2.dtsi        |  90 +++++++++++++++-----------
 arch/arm/boot/dts/berlin2cd.dtsi      |  66 +++++++++++--------
 arch/arm/boot/dts/berlin2q.dtsi       | 115 +++++++++++++++++++---------------
 arch/arm/mach-berlin/Kconfig          |   1 +
 drivers/clk/berlin/bg2.c              |   7 +--
 drivers/clk/berlin/bg2q.c             |   7 ++-
 drivers/pinctrl/berlin/berlin-bg2.c   |  26 +-------
 drivers/pinctrl/berlin/berlin-bg2cd.c |  26 +-------
 drivers/pinctrl/berlin/berlin-bg2q.c  |  26 +-------
 drivers/pinctrl/berlin/berlin.c       |   9 ++-
 drivers/reset/reset-berlin.c          |  74 +++++++++-------------
 11 files changed, 206 insertions(+), 241 deletions(-)

---
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
-- 
2.1.0

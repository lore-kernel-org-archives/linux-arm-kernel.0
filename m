From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 20 Sep 2016 22:58:28 +0200
Subject: [PATCH v3 0/5] AT91: sckc improvements
Message-ID: <20160920205833.19638-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set improves the slow clock controller driver.

The first patch simply moves some code around to avoid having extern
functions declared.

The second patch adds support for the SCKC found on sama5d4 and later.
It is notably missing the OSC32EN bit.

The third patch is an optimization. Trying to find wether the slow
oscillator is already stable to avoid waiting 1.2s twice in the boot
process.

Like discussed on IRC, the clk patches can probably go in v4.9 through the clk
tree. I'll take both dtsi patches through the at91 tree for v4.10.

Changes in v3:
 - rebased on clk-next to get the clk_hw rework
 - use a fixed clock for the rc oscillator on sama5d4
 - reordered patches

Changes in v2:
 - Fixed a typo pointed by Boris


Alexandre Belloni (5):
  clk: at91: move slow clock controller clocks to sckc.c
  clk: at91: Add sama5d4 sckc support
  clk: at91: sckc: optimize boot time
  ARM: dts: at91: sama5d4: use proper sckc compatible
  ARM: dts: at91: sama5d2: use correct sckc compatible

 .../devicetree/bindings/clock/at91-clock.txt       |   3 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  26 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |  27 +-
 drivers/clk/at91/clk-slow.c                        | 365 ----------------
 drivers/clk/at91/sckc.c                            | 464 ++++++++++++++++++++-
 drivers/clk/at91/sckc.h                            |  22 -
 6 files changed, 473 insertions(+), 434 deletions(-)
 delete mode 100644 drivers/clk/at91/sckc.h

-- 
2.9.3

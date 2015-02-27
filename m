From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Feb 2015 21:14:30 +0000
Subject: [PATCH 0/4] clk: Provide support for always-on clocks
Message-ID: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some hardware contains bunches of clocks which must never be
turned off.  If drivers a) fail to obtain a reference to any
of these or b) give up a previously obtained reference
during suspend, the common clk framework will attempt to
disable them and a platform can fail irrecoverably as a
result.  Usually the only way to recover from these failures
is to reboot.

To avoid either of these two scenarios from catastrophically
disabling an otherwise perfectly healthy running system,
clocks can be identified as always-on using this property
from inside a clocksource's node.  The CLK_IGNORE_UNUSED
flag will be applied to each clock instance named in this
property, thus preventing them from being shut down by the
framework.

Lee Jones (4):
  ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
  ARM: sti: stih410-clocks: Identify critical clocks as always-on
  clk: Provide always-on clock support
  clk: dt: Introduce binding for always-on clock support

 .../devicetree/bindings/clock/clock-bindings.txt   | 34 ++++++++++++++++++++++
 arch/arm/boot/dts/stih410-clock.dtsi               | 10 +++++++
 drivers/clk/clk.c                                  | 11 +++++++
 include/dt-bindings/clock/stih407-clks.h           |  4 +++
 4 files changed, 59 insertions(+)

-- 
1.9.1

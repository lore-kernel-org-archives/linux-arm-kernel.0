From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Feb 2015 16:14:57 +0000
Subject: No subject
Message-ID: <1424276101-30137-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject: [PATCH v2 0/4] clk: st: New clock domain

v1 => v2:
  - Turned the ST specific driver into a generic one 

Hardware can have a bunch of clocks which must not be turned off.
If drivers a) fail to obtain a reference to any of these or b) give
up a previously obtained reference during suspend, the common clk
framework will attempt to turn them off and the hardware will
subsequently die.  The only way to recover from this failure is to
restart.
 
To avoid either of these two scenarios from catastrophically
disabling the running system we have implemented a clock domain
where clocks are consumed and references are taken, thus preventing
them from being shut down by the framework.

Lee Jones (4):
  ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
  ARM: sti: stih407-family: Provide Clock Domain information
  clk: Provide an always-on clock domain framework
  clk: dt: Introduce always-on clock domain documentation

 .../devicetree/bindings/clock/clk-domain.txt       | 35 ++++++++++++
 arch/arm/boot/dts/stih407-family.dtsi              | 13 +++++
 drivers/clk/Makefile                               |  1 +
 drivers/clk/clkdomain.c                            | 63 ++++++++++++++++++++++
 include/dt-bindings/clock/stih407-clks.h           |  4 ++
 5 files changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clk-domain.txt
 create mode 100644 drivers/clk/clkdomain.c

-- 
1.9.1

From: joel@jms.id.au (Joel Stanley)
Date: Wed, 27 Sep 2017 15:56:57 +0930
Subject: [PATCH v3 0/5] clk: Add Aspeed clock driver
Message-ID: <20170927062702.11350-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver supports the ast2500, ast2400 (and derivative) BMC SoCs from
Aspeed.

This is version three of the series. Version one contained two patches; an update
to the binding document and a single patch for the driver. Lee has merged the
bindings change, so that is dropped from this series, and I split the driver
out into a series of patches to make them easier to review. Version three
addresses reivew from Andrew and has seen more testing on hardware.

All of the important clocks are supported, with most non-essential ones
also implemented where information is available. I am working with
Aspeed to clear up some of the missing information, including the
missing parent-sibling relationships.

We need to know the rate of the apb clock in order to correctly program
the clocksource driver, so the apb and it's parents are created in the
CLK_OF_DECLARE_DRIVER callback.

The rest of the clocks are created at normal driver probe time. I
followed the Gemini driver's lead with using the regmap where I could,
but also having a pointer to the base address for use with the common
clock callbacks.

The driver borrows from the clk_gate common clock infra spruce, but modifies
it in order to support the clock gate and reset pair that most of the clocks
have. This pair must be reset-ungated-released, with appropriate delays,
according to the datasheet.

The first patch introduces the core clock registration parts, and describes
the clocks. The second creates the core clocks, giving the system enough to
boot (but without uart). Next come the non-core clocks, and finally the reset
controller that is used for the few cocks that don't have a gate to go with their
reset pair.

Please review!

Cheers,

Joel

Joel Stanley (5):
  clk: Add clock driver for ASPEED BMC SoCs
  clk: aspeed: Register core clocks
  clk: aspeed: Add platform driver and register PLLs
  clk: aspeed: Register gated clocks
  clk: aspeed: Add reset controller

 drivers/clk/Kconfig                      |  12 +
 drivers/clk/Makefile                     |   1 +
 drivers/clk/clk-aspeed.c                 | 654 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/aspeed-clock.h |  52 +++
 4 files changed, 719 insertions(+)
 create mode 100644 drivers/clk/clk-aspeed.c
 create mode 100644 include/dt-bindings/clock/aspeed-clock.h

-- 
2.14.1

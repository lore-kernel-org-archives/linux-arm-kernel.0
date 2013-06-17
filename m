From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 16 Jun 2013 19:58:20 -0700
Subject: [PATCH v2 0/5] clk: dt: bindings for mux, divider & gate clocks
Message-ID: <1371437905-15567-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces binding definitions for common register-mapped
clock multiplexer, divider and gate IP blocks along with the
corresponding setup functions for matching DT data.  The bindings are
similar to the struct definitions but please don't hold that against the
binding: the struct definitions closely model the hardware register
layout.

This version incorporates review comments from the last RFC and includes
the basic gate clock as well. This version is not considered RFC and
hopefully can be agreed upon for 3.11, review comments notwithstanding.

Also this second version of the series converts the divider
implementation to use a bitmask internally. The registration APIs are
not changed so existing users are not affected. This gives us a cleaner
binding and a more flexible representation for more exotic hardware
designs.

I'm currently looking at the best way to match and setup these basic
clocks without requiring every platform to write a small clock driver
that matches the basic types. That is missing from this series but can
be merged later as a separate change.

Testing was done on OMAP4460 Panda ES using the experimental out-of-tree
OMAP CCF conversion patches posted recently.

Heiko, enough changed here such that I did not keep your Acked-by's and
Tested-by's. But I am happy to take them again :-)

Mike Turquette (5):
  clk: divider: replace bitfield width with mask
  clk: of: helper for determining number of parent clocks
  clk: dt: binding for basic multiplexer clock
  clk: dt: binding for basic divider clock
  clk: dt: binding for basic gate clock

 .../devicetree/bindings/clock/divider-clock.txt    |  87 +++++++++++++++
 .../devicetree/bindings/clock/gate-clock.txt       |  34 ++++++
 .../devicetree/bindings/clock/mux-clock.txt        |  77 +++++++++++++
 arch/arm/mach-imx/clk-busy.c                       |   2 +-
 drivers/clk/clk-divider.c                          | 121 ++++++++++++++++++---
 drivers/clk/clk-gate.c                             |  40 +++++++
 drivers/clk/clk-mux.c                              |  62 ++++++++++-
 drivers/clk/clk.c                                  |   6 +
 drivers/clk/mxs/clk-div.c                          |   2 +-
 include/linux/clk-private.h                        |   2 +-
 include/linux/clk-provider.h                       |  12 +-
 11 files changed, 422 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/divider-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/gate-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mux-clock.txt

-- 
1.8.1.2

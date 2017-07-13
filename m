From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 13 Jul 2017 16:02:30 +0200
Subject: [PATCH v5 0/2] clk: stm32h7: Add stm32h743 clock driver
Message-ID: <1499954552-20075-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

v5:
  - return bool instead int for enable_power_domain_write_protection()
  - add comment to explain use of CLK_OF_DECLARE_DRIVER()
  - add comment to explain why we can't use read_poll_timeout()
  - expose clk_gate_ops::is_enabled
  - use of __clk_mux_determine_rate & clk_gate_is_enabled to avoid wrapper
	function.

v4:
  - rename lock into stm32rcc_lock
  - don't use clk_readl() 
  - remove useless parentheses with GENMASK
  - fix parents of timer_x clocks
  - suppress pll configuration from DT
  - fix kbuild warning

v3:
  - fix compatible string "stm32h7-pll" into "st,stm32h7-pll"
  - fix bad parent name for mco2 clock
  - set CLK_SET_RATE_PARENT for ltdc clock
  - set CLK_IGNORE_UNUSED for pll1
  - disable power domain write protection on disable ops if needed


v2:
  - rename compatible string "stm32,pll" into "stm32h7-pll"
  - suppress "st,pllrge" property
  - suppress "st, frac-status" property
  - change management of "st,frac"  property
	0 : enable 0 pll integer mode 
	other values : enable pll in fractional mode (value is
	the fractional factor)

Gabriel Fernandez (2):
  clk: gate: expose clk_gate_ops::is_enabled
  clk: stm32h7: Add stm32h743 clock driver

 .../devicetree/bindings/clock/st,stm32h7-rcc.txt   |   81 ++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-gate.c                             |    2 +-
 drivers/clk/clk-stm32h7.c                          | 1522 ++++++++++++++++++++
 include/dt-bindings/clock/stm32h7-clks.h           |  165 +++
 include/dt-bindings/mfd/stm32h7-rcc.h              |  136 ++
 include/linux/clk-provider.h                       |    1 +
 7 files changed, 1907 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
 create mode 100644 drivers/clk/clk-stm32h7.c
 create mode 100644 include/dt-bindings/clock/stm32h7-clks.h
 create mode 100644 include/dt-bindings/mfd/stm32h7-rcc.h

-- 
1.9.1

From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 16 Nov 2018 14:59:31 +0000
Subject: [PATCH v6 0/6] clk: Add functions to get optional clocks
Message-ID: <20181116145937.27660-1-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a few drivers get an optional clock, e.g. a bus clock required to 
access peripheral's registers that is always enabled on some devices. This
series adds of_clk_get_by_name_optional(), clk_get_optional() and
devm_clk_get_optional() functions for this purpose.

The functions behave the same as of_clk_get_by_name(), clk_get() and
devm_clk_get() except that they will return NULL instead of -ENOENT. This
allows for simpler error handling in the callers.

*Note*
This changes the return values for of_clk_get_by_name() in some cases, see
[PATCH 1/6] clk: Add of_clk_get_by_name_optional() function.

v6:
 - Rework the __of_clk_get_by_name() logic so as to avoid duplicate tests.
 - Add doxygen style comment for devm_clk_get_optional() args
 - Add clk_get_optional() to archs that don't use the commom clk framework.

Phil Edworthy (6):
  clk: Add of_clk_get_by_name_optional() function
  clk: Add functions to get optional clocks
  m68k: coldfire: Add clk_get_optional() function
  MIPS: AR7: Add clk_get_optional() function
  MIPS: Loongson 2F: Add clk_get_optional() function
  arch/unicore32/kernel/clock.c: Add clk_get_optional() function

 arch/m68k/coldfire/clk.c               | 11 ++++
 arch/mips/ar7/clock.c                  | 11 ++++
 arch/mips/loongson64/lemote-2f/clock.c | 11 ++++
 arch/unicore32/kernel/clock.c          | 11 ++++
 drivers/clk/clk-devres.c               | 18 ++++-
 drivers/clk/clkdev.c                   | 91 ++++++++++++++++++++++----
 include/linux/clk.h                    | 38 +++++++++++
 7 files changed, 175 insertions(+), 16 deletions(-)

-- 
2.17.1

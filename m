From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  2 Oct 2014 15:04:55 +0200
Subject: [PATCH 0/2] Per-user clock constraints
Message-ID: <1412255097-15928-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

these patches add the possibility of setting constraints on the frequency of
clocks. In contrast to my two previous approaches, this is accomplished with
per-user clocks, but without requiring changes to existing drivers. An
exception to the latter are a few boards in mach-omap2, which still register
their clocks statically and thus had to be changed to initialize struct
clk_core. Hopefully the whole of clk-private.h can be removed once those boards
have been converted to initialize their clocks with DTS files.

The first patch implements per-user clocks properly, and the second adds the
constraint API.

Thanks,

Tomeu

Tomeu Vizoso (2):
  clk: Make clk API return per-user struct clk instances
  clk: Add floor and ceiling constraints to clock rates

 arch/arm/mach-omap2/cclock3xxx_data.c   | 108 +++--
 arch/arm/mach-omap2/clock.h             |  11 +-
 arch/arm/mach-omap2/clock_common_data.c |   5 +-
 drivers/clk/clk.c                       | 723 +++++++++++++++++++++-----------
 drivers/clk/clk.h                       |   8 +
 drivers/clk/clkdev.c                    |  23 +-
 include/linux/clk-private.h             |  40 +-
 include/linux/clk-provider.h            |  27 +-
 include/linux/clk.h                     |  18 +
 9 files changed, 656 insertions(+), 307 deletions(-)

-- 
1.9.3

From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 31 Mar 2014 18:41:54 +0200
Subject: [PATCH RFC v4 0/2] clk: Support for DT assigned clock parents and
 rates
Message-ID: <1396284116-19178-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a DT binding documentation for new 'clock-parents'
and 'clock-rates' DT properties and a helper function to parse them.
The helper is now being called from within the driver core, similarly
as it is done for the pins configuration binding to a device.

Patch 1/2 adds a variant of of_clk_get() function which accepts name of
a DT property containing list of phandle + clock specifier pairs, as
opposed to hard coded "clocks" property name in of_clk_get().

Patch 2/2 actually adds the code searching for related DT properties
at device node and performing re-parenting and/or clock frequency
setting as specified.

I didn't add sorting of clocks depending on parentship relation when
setting the clock rates, it could be added in next iteration if it's
decided it's required.

Thank you for all the review comments.

Changes since v3:
 - improved documentation of the DT binding,
 - fixed build errors for !CONFIG_OF, the parsing helpers are only
   compiled in if CONFIG_OF is set.

Changes since v2:
 - code reordering to ensure there is no build errors, the clock
   configuration code moved to a separate file,
 - introduced an 'assigned-clocks' DT node which is supposed to contain
   clocks, clock-parents, clock-rates properties and be child node
   a clock provider node, and a code parsing it called from of_clk_init();
   It's for clocks which are not directly connected to consumer devices.
   An alternative would be to list such assigned clocks in 'clocks'
   property, along with "proper" parent clocks, but then there would
   be phandles in clocks property of a node pointing to itself and it
   would require proper handling in of_clock_init().
   I actually tried it but it looked a bit ugly and chose this time to
   use an extra subnode.

Changes since v1:
 - updated DT binding documentation,
 - dropped the platform bus notifier, the clock setup routine is now
   being called directly from the driver core before a driver probe() call;
   this has an advantage such as all bus types are handled and any errors
   are propagated, so that, for instance a driver probe() can be deferred
   also when resources specified by clock-parents/clock-rates properties
   are not yet available; an alternative would be to let drivers call
   of_clk_device_setup() directly,
 - dropped the patch adding a macro definition for maximum DT property
   name length for now.

Open issues:
 - handling of errors from of_clk_get_by_property() could be improved,
   currently ENOENT is returned by this function not only for a null
   entry.

This series has been tested on ARM, on Exynos4412 Trats2 board.

Sylwester Nawrocki (2):
  clk: Add function parsing arbitrary clock list DT property
  clk: Add handling of clk parent and rate assigned from DT

 .../devicetree/bindings/clock/clock-bindings.txt   |   42 ++++++++++
 drivers/base/dd.c                                  |    7 ++
 drivers/clk/Makefile                               |    3 +
 drivers/clk/clk-conf.c                             |   87 ++++++++++++++++++++
 drivers/clk/clk.c                                  |   10 ++-
 drivers/clk/clkdev.c                               |   25 +++++-
 include/linux/clk.h                                |    7 ++
 include/linux/clk/clk-conf.h                       |   19 +++++
 8 files changed, 195 insertions(+), 5 deletions(-)
 create mode 100644 drivers/clk/clk-conf.c
 create mode 100644 include/linux/clk/clk-conf.h

--
1.7.9.5

From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 03 Mar 2014 19:15:31 +0100
Subject: [RFC PATCH v2 0/2] clk: Support for DT assigned clock parents and
 rates
Message-ID: <1393870533-20845-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a DT binding documentation for new 'clock-parents'
and 'clock-rates' DT properties and a helper function to parse them.
The helper is now being called from within the driver core, similarly
as it is done for the pins configuration binding to a device.

Patch 1/2 adds a variant of of_clk_get() function which accepts name of
a DT property containing list of phandle + clock specifier pairs, as
opposed to hard coded "clocks" property name in of_clk_get().
As Mike suggested I've renamed this function to of_clk_get_by_property().

Patch 2/2 actually adds the code searching for related DT properties at
device node and performing re-parenting and/or clock frequency setting
as specified.

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
RFC v1 can be found at:
http://www.spinics.net/lists/arm-kernel/msg309241.html

Sylwester Nawrocki (2):
  clk: Add function parsing arbitrary clock list DT property
  clk: Add handling of clk parent and rate assigned from DT

 .../devicetree/bindings/clock/clock-bindings.txt   |   23 ++++++
 drivers/base/dd.c                                  |    5 ++
 drivers/clk/clk.c                                  |   77 ++++++++++++++++++++
 drivers/clk/clk.h                                  |    3 +
 drivers/clk/clkdev.c                               |   25 ++++++-
 include/linux/clk-provider.h                       |    6 ++
 6 files changed, 135 insertions(+), 4 deletions(-)

--
1.7.9.5

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Dec 2017 19:53:10 +0100
Subject: [PATCH 0/3] clocksource/drivers: introduce DT based selection
Message-ID: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Currently, many drivers implement their own strategy when trying to find
which timer to use as the clocksource or the clockevent.

The main issue is that this selection is happen early in the boot
process and the kernel doesn't always have all the information to take
that decision.

So we end up with suboptimal solutions, especially in a multiplatform
kernel setting, as the MXC_USE_EPIT or ATMEL_TCB_CLKSRC_BLOCK kernel
config option.

There is also the clocksource kernel parameter only implemented in
mach-omap2.

Other drivers are registering the first seen timer as a clockevent, the
other one as a clocksource.

Also, this will help in the goal of separating clocksource and
clockevent drivers (see 376bc27150f180d9f5eddec6a14117780177589d)

Patch 1 documents the binding, patch 2 implements the parsing of the
chosen node and finally, patch 3 makes use of the parsing in a driver to
give an overview of how it is working.

Alexandre Belloni (3):
  dt-bindings: chosen: Add clocksource and clockevent selection
  clocksource/drivers: timer-of: parse the chosen node
  clocksource/drivers: integrator-ap: parse the chosen node

 Documentation/devicetree/bindings/chosen.txt | 20 ++++++++++++++++++++
 drivers/clocksource/Kconfig                  |  1 +
 drivers/clocksource/timer-integrator-ap.c    | 11 +++++++++++
 drivers/clocksource/timer-of.c               | 22 ++++++++++++++++++++++
 drivers/clocksource/timer-of.h               |  3 +++
 5 files changed, 57 insertions(+)

-- 
2.15.1

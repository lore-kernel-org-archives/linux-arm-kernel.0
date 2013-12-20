From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 20 Dec 2013 22:08:45 +0000
Subject: [RFC 0/2] clk: dt: generic DT preset clock frequency bindings
Message-ID: <1387577327-5007-1-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add a property "clock-N-frequency" to the clock consumer
bindings to specify the frequency that a clock should be configured to
when it is made use of. N is the index of a clock specifier in the
clocks property, starting at 0.

It's RFC since there are plenty of ways it could be handled, I've pretty
much just tried the simplest, but I'd like to get some thoughts from
others:
 - Adding such properties to individual device drivers / bindings. The
   bindings could be standardised and handled generically like in this
   patch, although it's not very nicely extensible to more complex
   settings (e.g. setting a particular clock's parent up the hierarchy a
   bit).
 - Adding named phandles like pinctrl clients do for pin configuration
   but to describe clock configuration, the "default" of which is set up
   automatically when a device is probed. This is more extensible, and
   certainly more complex. I suspect it may be overkill.

The point is to avoid the need to add clock-frequency properties to
individual device bindings or modify drivers to set the frequency of
clocks to that requested in device tree. Instead the driver can just
read the rate of the clock as if it was fixed without needing to know
how it has been configured.

This is aimed at devices where it's difficult for drivers to determine
what a clock should be set to, and either there is a recommended
frequency for the particular system or a chosen frequency for the
particular application of the system (which makes it essentially
configuration data).

James Hogan (2):
  dt: binding: add clock-N-frequency to common clock bindings
  clk: implement generic DT preset clock frequency

 .../devicetree/bindings/clock/clock-bindings.txt   |  3 ++
 drivers/clk/clk.c                                  | 34 ++++++++++++++++++++++
 drivers/clk/clkdev.c                               |  3 ++
 include/linux/clk.h                                |  5 ++++
 4 files changed, 45 insertions(+)

-- 
1.8.3.2

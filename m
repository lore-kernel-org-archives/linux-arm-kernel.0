From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 06 Aug 2013 17:51:55 +0200
Subject: [PATCH RFC 0/2] Clock unregistration support in the common clock
 framework
Message-ID: <1375804317-10576-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This short patch set aims to fix issues in the common clock framework WRT
support of the clock suppliers as loadable modules. The thread [1] might
be a good summary and pre-requisiste reading on what this patch series is
trying to achieve.

The first patch adds common implementation of the __clk_get(), __clk_put()
helpers for the common clock framework. Currently these functions are empty
and the modules that registered clocks are prone to removal and leaving
invalid clock references.

The second patch adds implementation of the clk_unregister() function and
is based on patch [2].

I have some doubts whether we need to be taking reference on a module in
clk_get() _and_ use kref to keep track of references to a clock. Taking
reference on a module only seems insufficient, since a clock supplier
driver can be unbound from its device through sysfs, even if the module
stays in place.

We could be doing only reference counting on the clock, but then there
are issues as Russell clearly explained in [1]. It is not obvious what
to do with a clock when it has consumers and its supplier driver is
being deinitialized/unloaded [3]. IMHO clock suppliers should be normally
prevented from being removed when resources they provide are in use,
otherwise it all may get a bit hairy.

Thanks,
Sylwester

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/183302.html
[2] http://www.spinics.net/lists/arm-kernel/msg247548.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/183292.html


Sylwester Nawrocki (2):
  clk: add common __clk_get(), __clk_put() implementations
  clk: implement clk_unregister

 arch/arm/include/asm/clkdev.h      |    2 +
 arch/blackfin/include/asm/clkdev.h |    2 +
 arch/mips/include/asm/clkdev.h     |    2 +
 arch/sh/include/asm/clkdev.h       |    2 +
 drivers/clk/clk.c                  |  147 +++++++++++++++++++++++++++++++++++-
 include/linux/clk-private.h        |    5 ++
 include/linux/clkdev.h             |    5 ++
 7 files changed, 162 insertions(+), 3 deletions(-)

--
1.7.9.5

From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 Aug 2013 18:34:04 +0200
Subject: [PATCH RFC 0/2] clk: Fix potential race condition in clk_get()
Message-ID: <1376066046-16037-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series depends on my patches adding clk deregistration support [1].
It attempts to fix a race condition in the clock lookup from device tree,
which surfaced during further testing.

In the original clkdev code there is no issues since clock lookup and
__clk_get() are being called with the clocks list mutex held.

In the device tree related part of clk_get() function those operations
are separated which turned out to be unsafe.

The first patch adds the clock providers list locking helpers and
an unlocked version of of_clk_get_from_provider() function.

The second one moves __clk_get() call from clk_get() to of_clk_get()
and modifies of_clk_get() so the clock lookup and __clk_get()
operations are both done with the clocks lists mutex held.

This race condition issue is only present when __clk_get() is
implemented and is only visible with my previous patchset [1] applied.

[1] http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg481861.html

Sylwester Nawrocki (2):
  clk: Provide not locked variant of of_clk_get_from_provider()
  clkdev: Fix race condition in clock lookup from device tree

 drivers/clk/clk.c    |   36 ++++++++++++++++++++++++++++--------
 drivers/clk/clkdev.c |   10 ++++++++--
 include/linux/clk.h  |    3 +++
 3 files changed, 39 insertions(+), 10 deletions(-)

--
1.7.9.5

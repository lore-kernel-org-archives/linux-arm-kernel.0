From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Apr 2015 17:34:09 +0200
Subject: [PATCH 0/4] clk: improve handling of orphan clocks
Message-ID: <1427988853-9549-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resurrects a patch from Doug Anderson from november that fixes the
enable counts when previous orphan-clocks get reparented to a newly
probed parent clock.

In the ensuing discussion Russell rightfully pointed out that orphan
clocks should probably not be used at all, as things like dividers
won't be able to set meaningful / safe values at all. But Doug's reply
also rightfully mentioned the fact that we most likely cannot change
the behaviour for all orphans as maybe some arches depend on the
current behaviour and it's not really possible to find all possible
affected clocks.

So this series is two-part. Patch1 is the fix from Doug fixing the
actual enable mismatch when an enabled orphan gets reparented to
a real parent and patches 2-4 try to provide a way to let the clock
core defer clk_gets on orphan clocks.
If at some point the majority of clock drivers make use of deferrals
this could then become the default behaviour.


Doug Anderson (1):
  clk: Propagate prepare and enable when reparenting orphans

Heiko Stuebner (3):
  clk: add clk_is_orphan() to check if a clocks inherits from an orphan
    clock
  clk: add CLK_DEFER_ORPHAN flag to prevent orphans from being used
  clk: rockchip: enable CLK_DEFER_ORPHAN for all branches

 drivers/clk/clk.c            | 69 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/rockchip/clk.c   |  3 ++
 include/linux/clk-provider.h |  1 +
 3 files changed, 71 insertions(+), 2 deletions(-)

-- 
2.1.4

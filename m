From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 22 Mar 2013 15:43:48 +0000
Subject: [RFC PATCH v1 0/3] clk: implement remuxing during set_rate
Message-ID: <1363967031-22781-1-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for automatic selection of the best parent
for a clock mux, i.e. the one which can provide the closest clock rate
to that requested. It can be controlled by a new CLK_SET_RATE_REMUX flag
so that it doesn't happen unless explicitly allowed.

This works by way of adding a parameter to the round_rate clock op which
allows the clock driver to optionally select a different parent index.
This is used in clk_calc_new_rates to decide whether to initiate a
set_parent operation. This would obviously require the argument to be
added to all users of round_rate, something this patchset doesn't do as
I'm not sure if it's really the preferred method (hence the RFC).

An alternative would be to add a new callback, but that would complicate
the code in clk.c somewhat. I suppose it would also be possible for the
round_rate callback to call a function to set a struct clk member to
mark that the parent should change (it's all within mutex protected
code after all). Comments anyone?

James Hogan (3):
  clk: abstract parent cache
  clk: add support for clock remuxing
  clk: clk-mux: implement remuxing

 drivers/clk/clk-mux.c        |  47 ++++++++++++++++++
 drivers/clk/clk.c            | 115 ++++++++++++++++++++++++++++++-------------
 include/linux/clk-provider.h |   7 ++-
 3 files changed, 133 insertions(+), 36 deletions(-)

-- 
1.8.1.2

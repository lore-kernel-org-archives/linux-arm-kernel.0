From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 29 Aug 2018 22:41:05 +0800
Subject: [PATCH V5 0/4] clk: new APIs to handle all available clocks
Message-ID: <1535553669-30250-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a continue of discussion from here,
https://patchwork.kernel.org/patch/9986293/
that some users may want to handle all available clocks from device
tree without need to know the detailed clock information likes clock
numbers and names. This is useful in writing some generic drivers to
handle clock part.

Note:
This patch series is tested on MX6Q SDB cpufreq driver with a minor change
to switch to use clk_bulk_get_all.
But patch 4 only test compiling. Hopefully someone could help test
the function.

v3->v4:
 * improve 'devres->clks = *clks' according to Stephen's suggestion
v2->v3:
 * address all comments from Stephen
 * fix build warnings on other architectures.
v1->v2:
 * add clk_bulk_{get|put}_all() which only supports DT platform currently
 * remove _all variants and the wrapper struct clk_bulk
 * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
   proves they need it because they don't have a struct device pointer.

Dong Aisheng (4):
  clk: bulk: add of_clk_bulk_get()
  clk: add new APIs to operate on all available clocks
  clk: add managed version of clk_bulk_get_all
  video: simplefb: switch to use clk_bulk API to simplify clock
    operations

 drivers/clk/clk-bulk.c         | 80 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-devres.c       | 24 +++++++++++++
 drivers/video/fbdev/simplefb.c | 68 ++++++++---------------------------
 include/linux/clk.h            | 65 +++++++++++++++++++++++++++++++++-
 4 files changed, 182 insertions(+), 55 deletions(-)

-- 
2.7.4

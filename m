From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Apr 2015 22:53:04 +0200
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
Message-ID: <1429735986-18592-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using orphan clocks can introduce strange behaviour as they don't have
rate information at all and also of course don't track 

This v2/v3 takes into account suggestions from Stephen Boyd to not try to
walk the clock tree at runtime but instead keep track of orphan states
on clock tree changes and making it mandatory for everybody from the
start as orphaned clocks should not be used at all.


This fixes an issue on most rk3288 platforms, where some soc-clocks
are supplied by a 32khz clock from an external i2c-chip which often
is only probed later in the boot process and maybe even after the
drivers using these soc-clocks like the tsadc temperature sensor.
In this case the driver using the clock should of course defer probing
until the clock is actually usable.


As this changes the behaviour for orphan clocks, it would of course
benefit from more testing than on my Rockchip boards. To keep the
recipent-list reasonable and not spam to much I selected one (the topmost)
from the get_maintainer output of each drivers/clk entry.
Hopefully some will provide Tested-by-tags :-)


Thanks
Heiko

changes since v2:
adapt to comments from Stephen Boyd
- rename to clk_core_update_orphan_status
- use bools instead of 0/1 for the status
- remove redundant check in clk_is_orphan
changes since v1:
- track orphan status on clock tree changes instead of walking the
  tree on clk_get operations
- make get-deferals mandatory for everybody

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alex Elder <elder@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: kernel at pengutronix.de
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Chao Xie <chao.xie@marvell.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Barry Song <baohua@kernel.org>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: emilio at elopez.com.ar
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Michal Simek <michal.simek@xilinx.com>


Heiko Stuebner (2):
  clk: track the orphan status of clocks and their children
  clk: prevent orphan clocks from being used

 drivers/clk/clk.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

-- 
2.1.4

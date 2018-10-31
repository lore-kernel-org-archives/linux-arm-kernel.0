From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Wed, 31 Oct 2018 10:29:53 +0200
Subject: [PATCH 0/8] clk: clkdev: managed clk lookup and provider registrations
Message-ID: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch series adding managed clkdev and of_provider registrations

Few clk drivers appear to be leaking clkdev lookup registrations at
driver remove. The patch series adds devm versions of lookup
registrations and cleans up few drivers. There is no intended functional
changes besides adding clean-ups at remove or simplifying the clean-up
code by using devm. So this patch series is not fixing any potential
issues on binding the cleanups to parent device - this series only
changes the cleanup to be done using devm.

Driver clean-up patches have not been tested as I lack the HW. All testing
and comments if driver/device removal is even possible for changed drivers
is highly appreciated. If removal is not possible I will gladly drop the
relevant patches from series - although leaking lookups may serve as bad
example for new developers =)

Changed drivers are:
clk-max77686, clk-s3c2410-dclk, clk-st, clk-hi655x, rk808, clk-twl6040
and apcs-msm8916.

New devm registration variants have been tested on BeagleBoneBlack
using ROHM BD71837 PMIC driver.

Same devm variants were earlier proposed together with BD71837/BD71847
PMIC clk driver in this series:
https://lore.kernel.org/linux-clk/cover.1535630942.git.matti.vaittinen at fi.rohmeurope.com/

The BD71837/BD71847 work is currently pending for related MFD commits to
get merged in clk-tree and the devm functions are now submitted in this
series.

This patch series is based on clk-next

---

Matti Vaittinen (8):
  clk: clkdev/of_clk - add managed lookup and provider registrations
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-s3c2410-dclk: clean up clkdev lookup leak
  clk: clk-st: avoid clkdev lookup leak at remove
  clk: clk-hi655x: Free of_provider at remove
  clk: rk808: use managed version of of_provider registration
  clk: clk-twl6040: Free of_provider at remove
  clk: apcs-msm8916: simplify probe cleanup by using devm

 Documentation/driver-model/devres.txt  |   3 +
 drivers/clk/clk-hi655x.c               |   4 +-
 drivers/clk/clk-max77686.c             |  25 ++-----
 drivers/clk/clk-rk808.c                |  15 +---
 drivers/clk/clk-twl6040.c              |   5 +-
 drivers/clk/clk.c                      |  28 ++++++--
 drivers/clk/clkdev.c                   | 122 ++++++++++++++++++++++++++-------
 drivers/clk/qcom/apcs-msm8916.c        |   5 +-
 drivers/clk/samsung/clk-s3c2410-dclk.c |  15 ++--
 drivers/clk/x86/clk-st.c               |   3 +-
 include/linux/clk-provider.h           |   4 ++
 include/linux/clkdev.h                 |   4 ++
 12 files changed, 151 insertions(+), 82 deletions(-)

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors
~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

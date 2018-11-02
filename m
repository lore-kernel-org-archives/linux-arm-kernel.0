From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Fri, 2 Nov 2018 14:34:26 +0200
Subject: [PATCH v3 0/7] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <cover.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch series adding managed clkdev and of_provider registrations

Few clk drivers appear to be leaking clkdev lookup registrations at
driver remove. The patch series adds devm versions of lookup
registrations and cleans up few drivers. Driver clean-up patches have
not been tested as I lack the HW. All testing and comments if
driver/device removal is even possible for changed drivers is highly
appreciated. If removal is not possible I will gladly drop the patches
from series - although leaking lookups may serve as bad example for new
developers =)

Changed drivers are:
clk-max77686, clk-st, clk-hi655x, rk808, clk-twl6040
and apcs-msm8916.

New devm registration variants have been tested on BeagleBoneBlack
using ROHM BD71837 PMIC driver.

Same devm variants were earlier proposed together with BD71837/BD71847
PMIC clk driver in this series:
https://lore.kernel.org/linux-clk/cover.1535630942.git.matti.vaittinen at fi.rohmeurope.com/

The BD71837/BD71847 work is currently pending for related MFD commits to
get merged in clk-tree and the devm functions are now submitted in this
series.

Changelog v3
Address issues spotted by Krzysztof Kozlowski
- Drop patch 3 for clk-s3c2410-dclk as this device can never be removed
- Fix indentiation for clk-max77686
- Rest  of the patches are unchanged.

Changelog v2
Issue spotted by 0-Day test suite
- Add a stub function 'devm_of_clk_add_parent_hw_provider' for no OF config.
- patches 2-8 are unchanged.

This patch series is based on clk-next

---

Matti Vaittinen (7):
  clk: clkdev/of_clk - add managed lookup and provider registrations
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-st: avoid clkdev lookup leak at remove
  clk: clk-hi655x: Free of_provider at remove
  clk: rk808: use managed version of of_provider registration
  clk: clk-twl6040: Free of_provider at remove
  clk: apcs-msm8916: simplify probe cleanup by using devm

 Documentation/driver-model/devres.txt |   3 +
 drivers/clk/clk-hi655x.c              |   4 +-
 drivers/clk/clk-max77686.c            |  29 ++------
 drivers/clk/clk-rk808.c               |  15 +----
 drivers/clk/clk-twl6040.c             |   5 +-
 drivers/clk/clk.c                     |  28 ++++++--
 drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++++--------
 drivers/clk/qcom/apcs-msm8916.c       |   5 +-
 drivers/clk/x86/clk-st.c              |   3 +-
 include/linux/clk-provider.h          |  11 +++
 include/linux/clkdev.h                |   4 ++
 11 files changed, 153 insertions(+), 76 deletions(-)

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

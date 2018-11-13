From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Tue, 13 Nov 2018 13:54:48 +0200
Subject: [PATCH v4 0/8] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series add bd71837/bd71837 PMIC clock support + managed interfaces

Few clk drivers appear to be leaking clkdev lookup registrations at
driver remove. The patch series adds devm versions of lookup
registrations and cleans up few drivers. Driver clean-up patches have
not been tested as I lack the HW. All testing and comments if
driver/device removal is even possible for changed drivers is highly
appreciated. If removal is not possible I will gladly drop the patches
from series - although leaking lookups may serve as bad example for new
developers =)

Patch 8 adds support for clock gate in ROHM bd71837 and bd71847 PMICs.
This change is included in the series because it depends on new managed
interfaces introduced in this series.

bd718x7 driver and devm interfaces are tested on BeagleBoneBlack and 
bd71837 break-out board. Clk area register interface of bd71847 is
identical to bd71837.

Changed drivers are:
clk-max77686, clk-st, clk-hi655x, rk808, clk-twl6040
and apcs-msm8916. New driver is clk-bd718x7

This series has been discussed for a while now. For those who want to
see whole discussion:

The bd71837 driver was originally proposed here
https://lore.kernel.org/lkml/d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen at fi.rohmeurope.com/

clk portion was separated from that series and devm variants were
proposed here
https://lore.kernel.org/linux-clk/cover.1535630942.git.matti.vaittinen at fi.rohmeurope.com/

Cleanup to other drivers was initiated in this series while waiting for
MFD portions of bd718x7 to be applied. And now when MFD dependencies are in-tree
his version (4) combines bd718x7 driver back to this series.

Changelog (for this series) v4
- Add support for ROHM bd718x7 PMIC clock gate. Included in this patch
  series because it depends on managed interfaces added in patch 1.

Changelog (for this series) v3
Address issues spotted by Krzysztof Kozlowski
- Drop patch 3 for clk-s3c2410-dclk as this device can never be removed
- Fix indentiation for clk-max77686
- Rest  of the patches are unchanged.

Changelog (for this series) v2
Issue spotted by 0-Day test suite
- Add a stub function 'devm_of_clk_add_parent_hw_provider' for no OF config.
- patches 2-8 are unchanged.

This patch series is based on clk-next

---

Matti Vaittinen (8):
  clk: clkdev/of_clk - add managed lookup and provider registrations
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-st: avoid clkdev lookup leak at remove
  clk: clk-hi655x: Free of_provider at remove
  clk: rk808: use managed version of of_provider registration
  clk: clk-twl6040: Free of_provider at remove
  clk: apcs-msm8916: simplify probe cleanup by using devm
  clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock

 Documentation/driver-model/devres.txt |   3 +
 drivers/clk/Kconfig                   |   7 ++
 drivers/clk/Makefile                  |   1 +
 drivers/clk/clk-bd718x7.c             | 131 ++++++++++++++++++++++++++++++++++
 drivers/clk/clk-hi655x.c              |   4 +-
 drivers/clk/clk-max77686.c            |  29 ++------
 drivers/clk/clk-rk808.c               |  15 +---
 drivers/clk/clk-twl6040.c             |   5 +-
 drivers/clk/clk.c                     |  28 ++++++--
 drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++-------
 drivers/clk/qcom/apcs-msm8916.c       |   5 +-
 drivers/clk/x86/clk-st.c              |   3 +-
 include/linux/clk-provider.h          |  11 +++
 include/linux/clkdev.h                |   4 ++
 14 files changed, 292 insertions(+), 76 deletions(-)
 create mode 100644 drivers/clk/clk-bd718x7.c

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

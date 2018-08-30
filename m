From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Thu, 30 Aug 2018 15:13:57 +0300
Subject: [PATCH 0/2] clk: Support ROHM BD71837 (BD71847)
Message-ID: <cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for clk gate included in ROHM BD71837
(and BD71847) Power Management ICs. Additionally patch series adds support
for new managed interfaces for clkdev lookup and parent_of_provider
registrations.

Please note that the patch has not been tested on BD71847 - I will
verify the BD71847 part and do appropriate documentation/naming changes
after verification. Hence only BD71837 support is announced here even
though the BD71847 should be identical what comes to clk registers.

BD71837 driver in the patch series depends on defines submitted as part of
this patch set:
https://lore.kernel.org/lkml/cover.1535545377.git.matti.vaittinen at fi.rohmeurope.com/

The managed interfaces are continuation of discussion started here:
https://lore.kernel.org/lkml/20180730125550.GD8862 at localhost.localdomain/
Difference to previous patch:
 - dropped devm_clk_register_clkdev
 - added new interfaces to Documentation/driver-model/devres.txt
 - did not rename __clk_register_clkdev
 - simplified IS_ERR - checks/code dublication by dropping checks from
   devm_clk_hw_register_clkdev.
   As negative point is this causes devres_alloc to be done before checking
   for IS_ERR(hw) inside do_clk_register_clkdev.

and BD71837 driver is continuation for patch discussion started here:
https://lore.kernel.org/lkml/d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen at fi.rohmeurope.com/
Difference to previous patch:
 - Simply fail out if no parent clock is found from DT. This simplifies
   driver a lot and encourages proper clk tree modelling in DT.

patch series is based on linux-next tag next-20180823

Patch 1:
	Add new managed interfaces
Patch 2:
	Support BD71837

Matti Vaittinen (2):
  clk: clkdev/of_clk - add managed lookup and provider registrations
  clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock

 Documentation/driver-model/devres.txt |   3 +
 drivers/clk/Kconfig                   |   6 ++
 drivers/clk/Makefile                  |   1 +
 drivers/clk/clk-bd718x7.c             | 131 ++++++++++++++++++++++++++++++++++
 drivers/clk/clk.c                     |  28 ++++++--
 drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++-------
 include/linux/clk-provider.h          |   4 ++
 include/linux/clkdev.h                |   4 ++
 8 files changed, 267 insertions(+), 32 deletions(-)
 create mode 100644 drivers/clk/clk-bd718x7.c

-- 
2.14.3

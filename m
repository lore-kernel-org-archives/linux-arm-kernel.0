From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 27 May 2014 11:38:49 +0200
Subject: [PATCH v3 0/6] mfd: axp20x: add AXP221 PMIC support
Message-ID: <1401183535-31003-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds basic support for the X-Powers' AXP221 PMIC.

At the moment the MFD device only exposes the AXP221 regulators but other
subdevices might be added later.

I'm still waiting for inputs regarding the ipsout regulator representation:
 * The ipsout regulator is currently represented as a fixed regulator
   providing a 5v output, and this is not exactly the case.
   AFAIU (here's is the datasheet traduction if you want to check [1]), the
   ipsout output is a multiplexer that choose among vbus (5V), acin (12V
   which is then converted to 5V) and the battery power supply (3,5 -> 4,2 V).
   This means the output voltage of ipsout vary between 3,5V and 5V.
   How can we express this kind of muxer in the regulator framework (is there
   already something available ?) ?
   Note that the power supply selection is automatic, though we could force
   one power supply, but then we loose the ability to unplug one power supply
   without impacting the system.

Best Regards,

Boris

[1] http://linux-sunxi.org/AXP221#Regulators

Changes since v2:
 - add helper functions for regulator set registration
 - fix a copy/paste error in the axp20x mfd driver
Changes since v1:
 - merge code with the axp20x driver

Boris BREZILLON (6):
  mfd: axp20x: add AXP221 PMIC support
  regulator: axp20x: prepare support for multiple AXP chip families
  regulator: axp20x: add support for AXP221 regulators
  regulator: axp20x: reset probe data before each probe
  regulator: add support for regulator set registration
  regulator: axp20x: make use of devm_regulator_set_register

 drivers/mfd/axp20x.c                 |  58 +++++++++-
 drivers/regulator/axp20x-regulator.c | 202 ++++++++++++++++++++++++-----------
 drivers/regulator/core.c             | 106 ++++++++++++++++++
 drivers/regulator/devres.c           |  68 ++++++++++++
 include/linux/mfd/axp20x.h           |  56 ++++++++++
 include/linux/regulator/driver.h     |  51 +++++++++
 6 files changed, 478 insertions(+), 63 deletions(-)

-- 
1.8.3.2

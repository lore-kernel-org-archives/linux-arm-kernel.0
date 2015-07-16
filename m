From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 16 Jul 2015 23:46:53 +0530
Subject: [PATCH 0/5] regulator: 88pm800: Add 88pm860 regulator support
Message-ID: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 falls under 88pm800 family of devices, with additional feature
enhancements, like,
  - 88pm860 had additional BUCK regulator (BUCK6 and BUCK1B)
  - Additional LDO (LDO20)
  - different voltage and current capability

This patch adds 88PM860 related buck/ldo voltage/current data to
the driver, and creates the regulator_desc table.

With addition of new device to the driver, couple of unavoidable
changes,

  - Fixes the code for indentation issue while defining data structures
  - Updated the driver to use devm_regulator_register() fn
  - The table gets referenced using regulator ID (PM800_ID_xxx),
    so table also needs to be created using ID.
  - The naming convention of voltage tables would no longer be
    mapped to respective ldos/bucks, so this patch also renames
    to more generic name.
  - And adds dual phase enable support based on max current constraint,
    resulting in supporting set_current_limit() call back.

V1 => V1:
=========
Please __note__ that, I am starting patch-series all over again, as
only one patch is getting carry-forwarded into this series. All other patches
are newly implemented and 1 patch got already merged to upstream.

Testing:
  - Boot tested on PXA1928 based platform, where all BUCK's and LDO's got
    registered successfully 
  - Verified that MMC driver is getting regulator successfully
  - Printed all LDO and BUCK resgiter before and after regulator registration,
    early boot and late boot, where based on consumer regulator is either enabled
    or disabled.

TODO:
  - Validation on 88PM800 device, looking for some help here, as I do
    not have any platform with 88PM800 device.


Vaibhav Hiremath (5):
  regulator: 88pm800: Fix indentation of assignments of data structures
  regulator: 88pm800: Update driver to use devm_regulator_register fn
  regulator: 88pm800: Use regulator_nodes/of_match in the descriptor
  regulator: 88pm800: Add 88pm860 regulator support
  regulator: 88pm800: Add support for configuration of dual phase on
    BUCK1

 drivers/regulator/88pm800.c | 339 +++++++++++++++++++++++---------------------
 include/linux/mfd/88pm80x.h |   6 +
 2 files changed, 184 insertions(+), 161 deletions(-)

-- 
1.9.1

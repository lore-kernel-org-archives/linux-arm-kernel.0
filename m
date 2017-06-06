From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue,  6 Jun 2017 16:51:35 +0800
Subject: [PATCH v4 0/8] MFD: add driver for HiSilicon Hi6421v530 PMIC
Message-ID: <20170606085143.13154-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds driver for HiSilicon Hi6421v530 PMIC.

Mainline kernel already has driver support to a similar chip, Hi6421.
Hi6421 and Hi6421v530 are both from the same vendor, HiSilicon, but
they are at different revisions. They both use the same Memory-mapped
I/O method to communicate with Main SoC. However, they differ quite a
lot in their regulator designs. Eg. they have completely different LDO
voltage points.

Patch 1 and 2 are hi6421-pmic cleaning up.
Patch 3 and 4 extends hi6421-pmic-core.c to support Hi6421v530 revision.
Patch 5 add hi6421v530-regulator.c driver for LDO regulators.
Patch 6 fixes an issue for hi6421 regulator, which is not related to v530
         but it's found in this review.
Patch 7 is dts change, it depends on and can be applied to hi3660/hikey960
        patchset [1].
Patch 8 enables the relevant config items.

[1], http://www.spinics.net/lists/devicetree/msg178303.html

Major changes in v4:
 - put hi6421-pmic cleanup in separate patches.
 - solve review comments from Lee Johes.
 - regulator-name should not have '/' character. Otherwise it "Failed to
     create debugfs directory"

Major changes in v3:
 - in hi6421-pmic-core.c
    * use shorter license script.
    * arrange #include in alphabetical order.
    * using recommended error log messages from Lee Jones.
 - in hi6421v530-regulator.c
    * remove unused #include files
    * arrange remaining ones in alphabetical order.

Major changes in v2:
 - instead of writing a new driver, extend hi6421-pmic-core.c
     to support its v530 revision
 - update hi6421v530-regulator.c to use modern regulator driver
     design logics.

Guodong Xu (6):
  mfd: hi6421-pmic: cleanup: change license text to shorter form
  mfd: hi6421-pmic: cleanup: update dev_err messages
  dt-bindings: mfd: hi6421: Add hi6421v530 compatible string
  mfd: hi6421-pmic: add support for HiSilicon Hi6421v530
  regulator: hi6421: Describe consumed platform device
  arm64: defconfig: enable support hi6421v530 PMIC

Wang Xiaoyin (2):
  regulator: hi6421v530: add driver for hi6421v530 voltage regulator
  arm64: dts: hikey960: add device node for pmic and regulators

 Documentation/devicetree/bindings/mfd/hi6421.txt  |   4 +-
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  46 +++++
 arch/arm64/configs/defconfig                      |   2 +
 drivers/mfd/hi6421-pmic-core.c                    |  87 +++++----
 drivers/regulator/Kconfig                         |  10 ++
 drivers/regulator/Makefile                        |   1 +
 drivers/regulator/hi6421-regulator.c              |   7 +
 drivers/regulator/hi6421v530-regulator.c          | 207 ++++++++++++++++++++++
 include/linux/mfd/hi6421-pmic.h                   |   5 +
 9 files changed, 336 insertions(+), 33 deletions(-)
 create mode 100644 drivers/regulator/hi6421v530-regulator.c

-- 
2.10.2

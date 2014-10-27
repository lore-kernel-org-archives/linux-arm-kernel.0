From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 13:11:46 +0100
Subject: [PATCH v5 0/4] regulator: max77686/trats2: Disable some regulators in
 suspend
Message-ID: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Changes since v4
================
1. New patch: 2/4. Store the current value of opmode in
   non-shifted form. Along with changes in defines used for opmodes
   this simplifies everything a lot. Suggested by Javier.
2. Drop Javier's review-by from patch 1 because I changed the
   defines to cover both LDO and buck at the same time.
3. Patch 3/4: adding suspend disable is now simpler - just re-use
   the existing function.

Changes since v3
================
1. Dropped patch 3/4 ("mfd/regulator: dt-bindings: max77686: Document
   regulators off in suspend"), applied by Lee Jones.
2. Patch 2/3: Fix missing shift when checking if current opmode is
   equal to off in suspend. The shift is various so I added a simple
   function max77686_set_opmode_enable(). Dropped Javier's review-by.
3. Patch 1/3: Add Javier's review-by.
4. Patch 3/3: Add Chanwoo's review-by.

Changes since v2
================
1. Patch 1/4: Fully describe different values used for controlling
   the regulators (low power modes, enable, disable). Remove "opmode"
   from new defines. Suggested by Javier.
2. Patch 2/4: minor nits after changing patch 1.
3. Add Javier's reviewed-by to 2, 3 and 4 patch.
4. Patch 3/4 (changes in documentation) should be picked up by Lee
   Jones but I'm resending it anyway.

Changes since v1
================
1. Add patch 1/4 and 3/4.
2. Patch 2/4: Extend existing set_suspend_disable (for bucks) with
   LDO support. Implement set_suspend_enable. Suggested by Javier.
3. Patch 4/4: Add regulator suspend properties only to regulators
   actually supporting this. Other regulators, not implementing
   suspend enable/disable, will warn ("VCC_1.8V_IO: No configuration").
4. Patch 4/4: In suspend enable VHSIC_1.0V and VHSIC_1.8V regulators.
   Suggested by Chanwoo Choi.


Description
===========
This patchset makes use of Javier Martinez Cainllas changes [1].
It allows disabling some of the regulators during suspend to RAM.

Javier's patchset is necessary only to test it.

[1] [PATCH v3 0/2] ARM: EXYNOS: Call regulator suspend prepare/finish
    https://lkml.org/lkml/2014/10/20/545


Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  regulator: max77686: Replace hard-coded opmode values with defines
  regulator: max77686: Store opmode non-shifted
  regulator: max77686: Implement suspend disable for some LDOs
  ARM: dts: exynos4412-trats: Add suspend configuration for max77686
    regulators

 arch/arm/boot/dts/exynos4412-trats2.dts | 72 +++++++++++++++++------------
 drivers/gpu/arm/mali400/ump/arch        |  1 +
 drivers/regulator/max77686.c            | 81 +++++++++++++++++++++++++--------
 3 files changed, 105 insertions(+), 49 deletions(-)
 create mode 120000 drivers/gpu/arm/mali400/ump/arch

-- 
1.9.1

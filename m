From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 25 Mar 2017 19:26:51 +0300
Subject: [PATCH v3 0/3] crypto: hw_random - Add new Exynos RNG driver
Message-ID: <20170325162654.3827-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


This is a follow up of my questions around exynos-rng [1].

Changes since v2:
=================
1. Do not re-use random numbers for re-seed (neither for system resume
   nor for periodic re-seed).  Instead the driver will just generate new
   random numbers (suggested by Stephan M?ller).

   Suspend path tested with suspend-to-freeze, not real suspend. Testing
   on Trats2 would be welcomed.

Changes since v1:
=================
1. Re-work the code for seeding after system resume, following suggestions
   and review by Stephan M?ller.

2. Re-seed itself from time to time (every 100 ms), suggested by Stephan
   M?ller.

3. Use a define for retries (Bartlomiej Zolnierkiewicz).
4. Add some docs.


Description:
============
The existing exynos-rng has many issues.  The most important one is that
it is a pseudo RNG device but uses hw_random interface which does not allow
proper seeding.

The RNG module on Exynos4 requires seeding.  On newer SoCs (like Exynos5420)
it can seed itself from a true RNG.  Converting the existing driver
to use TRNG would effectively drop support for Exynos4 and break
compatibility with existing users.

Instead I decided to convert it to crypto API.  In the future I hope
to add support for seeding from TRNG module.

Tested with app [2].

Patches are independent. I will take the defconfig changes (2/3 and 3/3)
through samsung-soc tree.

Best regards,
Krzysztof

[1] https://www.spinics.net/lists/arm-kernel/msg569641.html
[2] https://www.spinics.net/lists/arm-kernel/msg571184.html


Krzysztof Kozlowski (3):
  crypto: hw_random - Add new Exynos RNG driver
  ARM: exynos_defconfig: Enable Exynos RNG and user-space crypto API
  ARM: multi_v7_defconfig: Enable Exynos RNG and user-space crypto API

 MAINTAINERS                         |   8 +
 arch/arm/configs/exynos_defconfig   |   6 +
 arch/arm/configs/multi_v7_defconfig |   6 +
 drivers/char/hw_random/Kconfig      |  14 --
 drivers/char/hw_random/Makefile     |   1 -
 drivers/char/hw_random/exynos-rng.c | 231 ---------------------
 drivers/crypto/Kconfig              |  15 ++
 drivers/crypto/Makefile             |   1 +
 drivers/crypto/exynos-rng.c         | 390 ++++++++++++++++++++++++++++++++++++
 9 files changed, 426 insertions(+), 246 deletions(-)
 delete mode 100644 drivers/char/hw_random/exynos-rng.c
 create mode 100644 drivers/crypto/exynos-rng.c

-- 
2.9.3

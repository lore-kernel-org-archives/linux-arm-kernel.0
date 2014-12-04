From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 04 Dec 2014 11:47:52 +0100
Subject: [PATCH v3 0/3] Fix Arndale Octa/Peach Pi boot on Audio subsystem
 clocks
Message-ID: <1417690075-13483-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Changes since v2
================
1. Patch 1 applied ("clk: samsung: Fix double add of syscore ops after
   driver rebind"), remove it.
2. Squash patch 5 with "clk: samsung: Fix clock disable
   failure because domain being gated". Suggested by Sylwester.
3. Patch 1/3: Fix issues pointed by Sylwester.
4. Patch 2/3: Fix redundant clk_disable when removing driver (clk is
   already disabled). Add missing check !=null when removing driver.
5. Patch 3/3: Extend commit message.

Changes since v1
================
1. clocks-audss: Reimplement own clock register functions instead
   changing clk API. Minor fixes. (after idea from Tomasz Figa)
2. Add new patches: fix for pinctrl and minor fixes in clk-audss.

Description
===========
This patchset tries to solve dependency between AudioSS components
(clocks and GPIO) and main clock controller on Exynos 5420 platform.

This solves boot failure of Peach Pi/Pit and Arndale Octa [1].

Any access to memory of audss block (like checking if clock is enabled
or configuring GPIO) will hang if main audss clock is gated.

Tested on Arndale Octa board.

[1] http://www.spinics.net/lists/linux-samsung-soc/msg39331.html

Best regards,
Krzysztof Kozlowski


Krzysztof Kozlowski (3):
  clk: samsung: Fix clock disable failure because domain being gated
  pinctrl: exynos: Fix GPIO setup failure because domain clock being
    gated
  ARM: dts: exynos5420: Add clock for audss pinctrl (fixing GPIO setup
    failure)

 .../bindings/pinctrl/samsung-pinctrl.txt           |   6 +
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   3 +
 drivers/clk/samsung/clk-exynos-audss.c             | 357 ++++++++++++++++++---
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 111 ++++++-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   2 +
 5 files changed, 436 insertions(+), 43 deletions(-)

-- 
1.9.1

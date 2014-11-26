From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 26 Nov 2014 15:24:12 +0100
Subject: [PATCH v2 0/5] Fix Arndale Octa/Peach Pi boot on Audio subsystem
 clocks
Message-ID: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes since v1
================
1. clocks-audss: Reimplement own clock register functions instead
   changing clk API. Minor fixes. (after idea from Tomasz Figa)
2. Add new patches: fix for pinctrl and minor fixes in clk-audss.

Description
===========
This patchset tries to solve dependency between AudioSS components
(clocks and GPIO) and main clock controller on Exynos platform.

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
  ARM: dts: exynos5420: Add clock for audss pinctrl

 .../bindings/pinctrl/samsung-pinctrl.txt           |   6 +
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   3 +
 drivers/clk/samsung/clk-exynos-audss.c             | 367 +++++++++++++++++++--
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 110 +++++-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   2 +
 5 files changed, 446 insertions(+), 42 deletions(-)

-- 
1.9.1

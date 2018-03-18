From: andre.przywara@arm.com (Andre Przywara)
Date: Sun, 18 Mar 2018 23:28:43 +0000
Subject: [PATCH v2 0/4] drivers: pwm: sun4i: Improve support for A64 SoCs
Message-ID: <20180318232847.14278-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A rework addressing the comments. I dropped the H6 and the reset support
for now, to simplify merging this series.

This series adds PWM support for new Allwinner SoCs. Actually the A64 PWM 
is fully compatible with the A13 and H3 PWM IP, so the driver does not
need any additional code. But I use this opportunity to provide some
cleanup.
Patch 1 removes a no longer used parameter from our per-SoC data structure,
to simplify patch 2, which groups SoCs with a compatible PWM controller.
Patch 3 adds the new compatible strings to the binding documentation
(and just there, we expect to use "allwinner,sun5i-a13-pwm" as a fallback
compatible string).
The final patch 4 adds the respective PWM nodes to the A64 .dtsi.
This eventually does not enable the PWM on any new board at the moment, as
the PWM pins are either not usable (muxed with Ethernet) or exposed on
a header pin not dedicated to PWM. But the Pinebook (and Teres I) should be
able to use the PWM for the LCD backlights, plus users can enable the
R_PWM on their Pine64 boards, if they like.

Tested by manually enabling r_pwm on a Pine64-LTS.

Cheers,
Andre.

Andre Przywara (4):
  pwm: sun4i: drop unused .has_rdy member
  pwm: sun4i: simplify controller mapping
  dt-bindings: pwm: sunxi: add new compatible strings
  dts: sunxi: A64: Add PWM controllers

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  2 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 28 +++++++++++++++++++
 drivers/pwm/pwm-sun4i.c                            | 32 ++++++----------------
 3 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.14.1

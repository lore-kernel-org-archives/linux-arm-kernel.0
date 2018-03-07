From: andre.przywara@arm.com (Andre Przywara)
Date: Wed,  7 Mar 2018 02:07:14 +0000
Subject: [PATCH 0/5] drivers: pwm: sun4i: Improve support for A64 and H6 SoCs
Message-ID: <20180307020719.6675-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds PWM support for new Allwinner SoCs. Actually the A64 PWM 
is fully compatible with the A13 and H3 PWM IP, so the driver does not
need any additional code. But I use this opportunity to provide some
cleanup and to add optional reset controller support, which will be needed
for the H6.
Patch 1 removes a no longer used parameter from our per-SoC data structure,
to simplify patch 2, which groups SoCs with a compatible PWM controller.
Patch 3 adds optional reset controller support, the line will be deasserted
and asserted at the same time we enable and disable the clock. Patch 4 adds
the new compatible strings to the binding documentation (and just there,
we expect to use "allwinner,sun5i-a13-pwm" as a fallback compatible string).
The final patch 5 adds the respective PWM nodes to the A64 .dtsi.
This eventually does not enable the PWM on any new board at the moment, as
the PWM pins are either not usable (muxed with Ethernet) or exposed on
a header pin not dedicated to PWM. But the Pinebook (and Teres I) should be
able to use the PWM for the LCD backlights, plus users can enable the
R_PWM on their Pine64 boards, if they like.

Tested by manually enabling r_pwm on a Pine64-LTS.

Let me know how you like it and what needs to change.

Cheers,
Andre.

Andre Przywara (5):
  pwm: sun4i: drop unused .has_rdy member
  pwm: sun4i: simplify controller mapping
  pwm: sun4i: Introduce (optional) reset support
  dt-bindings: pwm: sunxi: add new compatible strings
  dts: sunxi: A64: Add PWM controllers

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  6 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 28 +++++++++
 drivers/pwm/pwm-sun4i.c                            | 66 ++++++++++++----------
 3 files changed, 69 insertions(+), 31 deletions(-)

-- 
2.14.1

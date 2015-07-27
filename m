From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jul 2015 14:41:56 +0200
Subject: [PATCH v2 0/2] pinctrl: sunxi: Implement proper irq DT parsing
Message-ID: <1438000918-9026-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

So far the GPIO and pinctrl driver had a limited support for
interrupts, and no documentation about the DT bindings. A few DT ended
up using these external interrupts, relying on the default DT parsing
logic.

However, this doesn't really work, since there's still no
documentation describing the expected behaviour, and we ended up with
bindings different if you want to use a GPIO as interrupt (using the
gpios property), or an interrupt over a GPIO (using the interrupts
property) that doesn't really make sense and only brings confusion.

Moreover, the "new" SoCs from Allwinner have multiple interrupt banks,
while the previous generation had only one, which means that we cannot
really express those interrupts with the default bindings anymore
either.

The point of this serie is to fix the current situation by introducing
some custom DT parsing code to have a consistent binding with the GPIO
one, which will also fix the multiple banks issues, and document it.

Let me know what you think,
Maxime

Changes from v1:
  - Rebased on top of pinctrl/devel
  - Added Hans' Reviewed-by

Maxime Ripard (2):
  pinctrl: sunxi: Add custom irq_domain_ops
  ARM: sunxi: dt: Convert users to the PIO interrupts binding

 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   | 37 +++++++++++++++++++++-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  3 +-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  2 +-
 arch/arm/boot/dts/sun5i.dtsi                       |  3 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  3 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  2 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |  2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  3 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  3 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              | 35 ++++++++++++++++++--
 10 files changed, 77 insertions(+), 16 deletions(-)

-- 
2.4.6

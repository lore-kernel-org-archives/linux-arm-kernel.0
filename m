From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jul 2015 14:41:10 +0200
Subject: [PATCH 0/4] pinctrl: sunxi: Implement proper irq DT parsing
Message-ID: <1437396074-15791-1-git-send-email-maxime.ripard@free-electrons.com>
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
some custom DT parsing code to have a consistant binding with the GPIO
one, which will also fix the multiple banks issues, and document it.

Let me know what you think,
Maxime

Maxime Ripard (4):
  pinctrl: sunxi: Use common functions to change irq_chip and handler
  pinctrl: sunxi: Add irq_chip name
  pinctrl: sunxi: Add custom irq_domain_ops
  ARM: sunxi: dt: Convert users to the PIO interrupts binding

 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   | 37 ++++++++++++++-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  3 +-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  2 +-
 arch/arm/boot/dts/sun5i.dtsi                       |  3 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  3 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  2 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |  2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  3 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  3 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              | 55 +++++++++++++++++-----
 10 files changed, 88 insertions(+), 25 deletions(-)

-- 
2.4.5

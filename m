From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 30 Apr 2014 00:07:12 +0200
Subject: [RFC/PATCH 0/8] pinctrl-rockchip: Change wrong initial assumptions
Message-ID: <1414506.B4e2jZujVm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From the "wet behind the ears" files:

Initially due to lack of documentation and (personal) understanding
I assumed that the area holding the iomux settings would be separate
from everything else, while in fact the grf registers contain not only
pinctrl stuff but also dma, usb-phy and general soc-status settings.
Also things like drive-strength we do not support currently are intermixed.

The same is true for the pmu, which does not only contain power domains
but also the system reset as well as well as general registers surviving
system-resets. Additionally the rk3188 moved parts of the pull-setting
registers into the pmu space.

While this wasn't a problem until now, the upcoming rk3288 introduces
additional changes to both the grf and pmu areas. On it even part of
the pinmux registers move into the pmu space.

For this my current gut-feeling is, that providing both the grf and pmu
as syscons to the pinctrl driver might be more future proof for the next
socs. But as I'm not sure on this, I'd like of course comments :-)

The code in it's current form supports both the old as well as the
changed binding.

The other option would be to leave the grf as it is and create separate
syscons for real small individual parts like the soc-conf and usb-phys.
But apart from creating these real small syscons that would
also make it necessary to introduce another register map for the
drive-strength settings of the pin-controller, which are sitting in the
middle of everything at least on rk3066 and rk3188.


So I'd really like comments here :-)


@Max: sorry to come up with this now, but I feel this should be resolved
(in whatever direction) before we introduce any grf syscon. Because due
to dt being an API we will be tied for a long time to it.


Heiko Stuebner (8):
  pinctrl: rockchip: do not require 2nd register area
  pinctrl: rockchip: use regmaps instead of raw mappings
  pinctrl: rockchip: rockchip_pinctrl in rockchip_get_bank_data
  pinctrl: rockchip: let pmu registers be supplied by a syscon
  pinctrl: rockchip: only map bank0-pull-region when pmu regmap missing
  pinctrl: rockchip: base regmap supplied by a syscon
  dt-bindings: adapt rockchip-pinctrl documentation to changed bindings
  ARM: dts: rockchip: convert pinctrl nodes to new bindings

 .../bindings/pinctrl/rockchip,pinctrl.txt          |  28 +++-
 arch/arm/boot/dts/rk3066a.dtsi                     |   2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   9 +-
 arch/arm/boot/dts/rk3xxx.dtsi                      |   9 +-
 drivers/pinctrl/pinctrl-rockchip.c                 | 178 +++++++++++++++------
 5 files changed, 164 insertions(+), 62 deletions(-)

-- 
1.9.0

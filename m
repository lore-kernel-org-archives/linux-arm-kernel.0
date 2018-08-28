From: urjaman@gmail.com (Urja Rannikko)
Date: Tue, 28 Aug 2018 18:55:06 +0000
Subject: [PATCH 0/7] [RFC] rk3288 veyron chromebook hdmi frequencies
Message-ID: <20180828185513.13216-1-urjaman@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is a series trying to make the "hack" of dedicating a pll (npll)
on these chromebooks to one of the VOPs (that is used for HDMI)
more acceptable for upstream.
Notably it should change nothing for non-chromebook rk3288 designs,
and allows enough configurability that such designs could later
use this feature for either VOP if it is desirable.

I expect the first patch to be acceptable (atleast almost) as-is.
It just adds the PLL frequencies used for HDMI into the PLL configuration
list, so they're ready to be used for hdmi whether by fixed configuration,
automagic magicness or dedicating a PLL.

For the device tree bindings, I added a binding for the list of 
allowed hdmi frequencies (that quite closely a hardware property both
due to EMI/RF considerations and clock/PLL configuration...) as
"rockchip,hdmi-rates-hz" but i think this could have a common name.
Suggestions?

This has been tested on my ASUS C201, and effectively gives
the same display compatibility as ChromeOS has. (This journey
started with me plugging in my 1920x1200 samsung 2443BW and
getting 1280x1024 at 55.555... Hz.)

Urja Rannikko (7):
  clk: rockchip: improve rk3288 pll rates for better hdmi output
  dt-bindings: clock: rk3288-cru: Add property to dedicate NPLL for VOPx
  drivers: clk-rk3288: support for dedicating NPLL to a VOP
  dt-bindings: display/rockchip: dw_hdmi: Add property for HDMI
    frequency list
  drm: dw_hdmi-rockchip: better clock selection logic and dts-based rate
    list
  dts: rk3288: support for dedicating npll to a vop
  dts: rk3288-veyron-chromebook: dedicate npll to VOP0/HDMI + HDMI rates

 .../bindings/clock/rockchip,rk3288-cru.txt    |   3 +
 .../display/rockchip/dw_hdmi-rockchip.txt     |   1 +
 .../boot/dts/rk3288-veyron-chromebook.dtsi    |  67 +++++
 arch/arm/boot/dts/rk3288.dtsi                 |   6 +-
 drivers/clk/rockchip/clk-rk3288.c             |  98 +++++--
 drivers/clk/rockchip/clk.h                    |   3 +
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   | 269 ++++++++++++------
 7 files changed, 335 insertions(+), 112 deletions(-)

-- 
2.18.0

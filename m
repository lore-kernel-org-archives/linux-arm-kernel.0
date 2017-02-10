From: briannorris@chromium.org (Brian Norris)
Date: Thu,  9 Feb 2017 17:05:15 -0800
Subject: [PATCH v2 0/6] arm64: dts: rockchip: support Google Kevin
Message-ID: <20170210010521.78872-1-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2, adding basic support for Google Kevin, a board in the Gru device
family. I do not add a leaf .dts board file for Gru, but I have retained the
split between "things that apply to the Gru family" (rk3399-gru.dtsi) and
"things that apply to Kevin only" (rk3399-gru-kevin.dtsi).

I know it's close to the 4.11 merge window, so I expect this won't make it for
that. But since I got it ready for testing anyway, I thought I might as well
get it out the door, ready for 4.12.

I've included resends of two patches (adding cros-ec*.dtsi symlinks, and adding
RK3399 DWC3). The former is unmodified, but the latter is rewritten to match
current upstream bindings better, and to allow it to function w/o extcon
support (USB2 only).

AFAICT, all these bindings are in -next, except for the root node compatible
property (added doc in this series).

I elaborate on what's working/not working below, but one of the big missing
pieces is cpufreq support. We still need some more work on getting good
bindings and driver support upstream for the PWM regulator + OVP circuit on
these boards. See patch 5 for more info.

Working and tested (to some extent):
 * EC support -- including keyboard, battery, PWM, and probably more
 * UART / console
 * Thermal
 * Touchscreen
 * Touchpad
 * Digitizer (regulator still WIP; working on this in another series)
 * PCIe / Wifi
 * Bluetooth / Webcam
 * SD card
 * eMMC
 * USB2 on TypeC
   - This works much of the time, but USB3 devices may or may not detect
     properly. Waiting on proper extcon support for USB3 over TypeC.
   - Depends on XHCI/DWC3 fixes for ARM64 that still haven't landed
 * Backlight

Not working:
 * CPUFreq -- relies on special OVP support for our PWM regulator
   circuits
 * EC / extcon support -- and with it, USB3/TypeC/DP
 * DRM -- won't even build on ARM64, so all display, eDP, etc. is not
   enabled

Not tested:
 * Audio


I include a more detailed changelog in the patches themselves, but a rough
summary:

v1 -> v2:
 * merge the OPP and CPU regulators into 1 patch; don't support them on non-Gru
   boards yet, as that will break them (and we're not sure if the same table is
   applicable anyway)
 * drop some patches that were applied already
 * update copyrights
 * match USB bindings more closely
 * drop digitizer regulator patches; this isn't ready (working on in another
   series)


Brian Norris (5):
  arm64: dts: rockchip: support dwc3 USB for rk3399
  dt-bindings: Document rk3399 Gru/Kevin
  arm64: dts: rockchip: add Gru/Kevin DTS
  arm64: dts: rockchip: describe Gru/Kevin OPPs + CPU regulators
  arm64: dts: rockchip: sort rk3399 by unit address

Douglas Anderson (1):
  arm64: dts: Add symlinks for cros-ec-keyboard and cros-ec-sbs

 Documentation/devicetree/bindings/arm/rockchip.txt |   20 +
 .../boot/dts/include/common/cros-ec-keyboard.dtsi  |    1 +
 .../arm64/boot/dts/include/common/cros-ec-sbs.dtsi |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  312 ++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 1165 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi       |  145 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  142 ++-
 8 files changed, 1743 insertions(+), 44 deletions(-)
 create mode 120000 arch/arm64/boot/dts/include/common/cros-ec-keyboard.dtsi
 create mode 120000 arch/arm64/boot/dts/include/common/cros-ec-sbs.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi

-- 
2.11.0.483.g087da7b7c-goog

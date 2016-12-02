From: briannorris@chromium.org (Brian Norris)
Date: Thu,  1 Dec 2016 18:27:24 -0800
Subject: [PATCH 0/9] arm64: dts: rockchip: support Google Kevin
Message-ID: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds basic support for Google Kevin, a board in the Gru device
family. I do not add a leaf .dts board file for Gru, but I have retained the
split between "things that apply to the Gru family" (rk3399-gru.dtsi) and
"things that apply to Kevin only" (rk3399-gru-kevin.dtsi).

I've included resends of two patches (adding cros-ec*.dtsi symlinks, and adding
RK3399 DWC3). The former is unmodified, but the latter is rewritten to match
current upstream bindings better, and to allow it to function w/o extcon
support (USB2 only).

AFAICT, all these bindings are in -next, except for the root node compatible
property (added doc in this series) and some of the HID digitizer bindings (see
patch 9; bindings were sent separately).

I elaborate on what's working/not working below, but one of the big missing
pieces is cpufreq support. We still need some more work on getting good
bindings and driver support upstream for the PWM regulator + OVP circuit on
these boards. See patch 8 for more info.

Working and tested (to some extent):
 * EC support -- including keyboard, battery, PWM, and probably more
 * UART / console
 * Thermal
 * Touchscreen
 * Touchpad
 * Digitizer (regulator still WIP)
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


Brian Norris (8):
  arm64: dts: rockchip: add rk3399 thermal_zones phandle
  arm64: dts: rockchip: add rk3399 eDP HPD pinctrl
  arm64: dts: rockchip: support dwc3 USB for rk3399
  arm64: dts: rockchip: add rk3399 OPPs
  dt-bindings: Document rk3399 Gru/Kevin
  arm64: dts: rockchip: add Gru/Kevin DTS
  arm64: dts: rockchip: partially describe PWM regulators for Gru
  arm64: dts: rockchip: add regulator info for Kevin digitizer

Douglas Anderson (1):
  arm64: dts: Add symlinks for cros-ec-keyboard and cros-ec-sbs

 Documentation/devicetree/bindings/arm/rockchip.txt |   20 +
 .../boot/dts/include/common/cros-ec-keyboard.dtsi  |    1 +
 .../arm64/boot/dts/include/common/cros-ec-sbs.dtsi |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  315 ++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 1152 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi       |  145 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   70 +-
 8 files changed, 1704 insertions(+), 1 deletion(-)
 create mode 120000 arch/arm64/boot/dts/include/common/cros-ec-keyboard.dtsi
 create mode 120000 arch/arm64/boot/dts/include/common/cros-ec-sbs.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi

-- 
2.8.0.rc3.226.g39d4020

From: briannorris@chromium.org (Brian Norris)
Date: Mon, 20 Mar 2017 16:53:40 -0700
Subject: [PATCH v3 0/4] arm64: dts: rockchip: support Google Kevin
Message-ID: <20170320235344.126298-1-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3, adding basic support for Google Kevin, a board in the Gru device
family. It has gotten smaller, as pieces have been merged already, and the DT
bindings have been ack'ed. It gained a new dependency on Heiko's work here:

  [PATCH 2/2] arm64: dts: add arm/arm64 include symlinks
  https://patchwork.kernel.org/patch/9592177/

Otherwise, there's not a whole lot of note new in this series. Hopefully it'll
be ready to merge (*crosses fingers*). The rest of this cover letter is
basically the same as previous revisions. I've updated the changelogs below and
in each patch.

---

I do not add a leaf .dts board file for Gru, but I have retained the split
between "things that apply to the Gru family" (rk3399-gru.dtsi) and "things
that apply to Kevin only" (rk3399-gru-kevin.dtsi).

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


v2 -> v3:
 * reintroduced the digitizer/regulator patch, as the bindings and driver code
   have been merged in -next
 * reference {pmu-,}io-domain nodes from main rk3399.dtsi
 * drop some now-superfluous comments
 * use new proposed '#include <arm/...>' DTSI include path (symlink)

v1 -> v2:
 * merge the OPP and CPU regulators into 1 patch; don't support them on non-Gru
   boards yet, as that will break them (and we're not sure if the same table is
   applicable anyway)
 * drop some patches that were applied already
 * update copyrights
 * match USB bindings more closely
 * drop digitizer regulator patches; this isn't ready (working on in another
   series)


Brian Norris (4):
  dt-bindings: Document rk3399 Gru/Kevin
  arm64: dts: rockchip: add Gru/Kevin DTS
  arm64: dts: rockchip: describe Gru/Kevin OPPs + CPU regulators
  arm64: dts: rockchip: add regulator info for Kevin digitizer

 Documentation/devicetree/bindings/arm/rockchip.txt |   20 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  315 ++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 1135 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi       |  145 +++
 5 files changed, 1616 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi

-- 
2.12.0.367.g23dc2f6d3c-goog

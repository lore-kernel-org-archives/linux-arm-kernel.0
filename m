From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 26 Nov 2016 15:56:30 +0100
Subject: [PATCH 0/5] Meson GXL and GXM USB support
Message-ID: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB support on GXL and GXM differs a lot from Meson8b and GXBB:
The most obvious change is that GXL and GXM now have one dwc3
controller and one dwc2 controller (instead of two dwc2 controllers).
With that there are also new USB PHYs.

Due to lack of hardware I was only able to test this on a board with
GXM, but as far as I understand the hardware my preparations should be
correct (so it should also work on GXL).

dwc2 will probably stay unused on most GXM devices since it's limited
to device mode via some dwc2 hardware configuration register.

dwc3 is probably used on all devices, even if there is more than just
one USB port. dwc3 has a built-in USB2 hub - on GXL this hub has two
ports enabled, while on GXM there are three ports enabled (see below
for lsusb output). There are no USB3 ports enabled in the dwc3 hardware
configuration, meaning that the SoC is limited to high-speed mode.
On my GXM device the dwc3 hardware configuration forces it into "host
only" mode.

The SoCs contain two PHY blocks: one USB3 PHY and up to four USB2 PHYs
(on GXM there are only three enabled, but the registers should support
up to four).
The USB3 PHY also handles the OTG interrupts, but since dwc3's hardware
configuration enforces "host only" mode I was not able to test this. It
simply takes care of an interrupt and then notifies all related PHYs
about the new mode.
The USB2 PHY block is a bit different: I created one PHY driver which
spans all "PHY ports" because the handling is a bit tricky. It turns
out that for each available USB port in dwc3's hub the corresponding
PHY must be enabled (even if there is no physical port - in my case
port 3 is not connected to anything, but disabling the PHY breaks
ports 1 and 2 as well).
I decided not not pass the USB2 PHYs directly to dwc3 due to three
reasons: 1. the USB3 PHY (which holds a reference to all relevant
USB2 PHY ports) controls the mode of the USB2 PHY ports (since both
are used with the same controller and thus it makes sense to keep the
mode consistent across all ports) 2. the dwc3 driver does not support
passing multiple USB2 PHYs (only one USB2 and one USB3 PHY can be
passed to it) 3. it is similar to how the vendor reference driver
manages the PHYs. Please note that this coupling is not a fixed, this
is all configurable via devicetree (so if the third USB2 PHY has to
be passed two the dwc2 controller then this is still possible by
just moving on PHY reference in the .dts).

The coupling of the USB2 and USB3 PHYs is the reason why I sent the
two drivers in one patch, even though they are handling different IP
blocks (different registers, etc.).

Unfortunately there are no datasheets available for any of these PHYs.
Both drivers were written by reading the reference drivers provided by
Amlogic and analyzing the registers on the kernel that was shipped with
my board.

As a last note: the dwc3 driver currently only explicitly enables the
first USB port "DWC3_GUSB2PHYCFG(0)" in the internal hub. The hardware
seems to enable the other two (DWC3_GUSB2PHYCFG(1) and
DWC3_GUSB2PHYCFG(2)) automatically. I will ask the dwc3 maintainers if
changes to dwc3 are desired any how these should look like, but for now
it's working fine even without changes there.

lsusb output on GXM for the dwc3 hub:
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
...
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power

NOTE: The devicetree changes depend on my previous series:
"[PATCH 0/2] minor GXL and GXM improvements" - see [0]

NOTE2: This series depends on an upstream dwc3/xhci-plat DMA fix
(special thanks to Arnd Bergmann and Sriram Dash for fixing that):
"[PATCH v5 0/6] inherit dma configuration from parent dev" - see [1]

I have a tree with all dependencies applied available at [2] if
someone wants a quick way to test this (I don't take any responsibility
if anything explodes though).

[0] http://lists.infradead.org/pipermail/linux-amlogic/2016-November/001665.html
[1] http://marc.info/?l=linux-usb&m=147938307209685&w=2
[2] https://github.com/xdarklight/linux/commits/meson-gx-integration-4.10-20161126

Martin Blumenstingl (5):
  Documentation: dt-bindings: Add documentation for Meson GXL USB2/3
    PHYs
  phy: meson: add USB2 and USB3 PHY support for Meson GXL
  arm64: dts: meson-gxl: add USB support
  ARM64: dts: meson-gxm: add GXM specific USB configuration
  ARM64: dts: meson-gx-p23x-q20x: enable USB on P23x and Q20x boards

 .../devicetree/bindings/phy/meson-gxl-usb2-phy.txt |  25 ++
 .../devicetree/bindings/phy/meson-gxl-usb3-phy.txt |  27 ++
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  12 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  49 +++
 .../arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts |  17 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |  10 +
 drivers/phy/Kconfig                                |  13 +
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-meson-gxl-usb2.c                   | 374 ++++++++++++++++++++
 drivers/phy/phy-meson-gxl-usb3.c                   | 377 +++++++++++++++++++++
 10 files changed, 906 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt
 create mode 100644 drivers/phy/phy-meson-gxl-usb2.c
 create mode 100644 drivers/phy/phy-meson-gxl-usb3.c

-- 
2.10.2

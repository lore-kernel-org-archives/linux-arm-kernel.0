From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 22 Sep 2011 15:06:03 -0600
Subject: [PATCH 0/4] arm/tegra: Convert gpio & pinmux to platform devices
Message-ID: <1316725567-17881-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series converts the Tegra GPIO and pinmux drivers to be regular
platform devices.

The series is extracted from an earlier series I posted that augmented
these drivers to initialize HW state from the device-tree. I'm holding
off on that aspect of the changes, since it's not entirely clear to me
whether the new pinmux API should drive the initial pinmux state setup
via "system hog" definitions, or whether pinmux drivers should indeed
do their own thing.

Dependencies:
* The patches need to be merged in one branch in order for bisectability.

* At least patch 3 depends on changes in Russell's gpio branch, since it
  edits a file renamed there. I imagine the series will be merged into
  that branch.

* The whole series is based off next-20110922 plus a couple patches in the
  ARM patch system (7094, 7095).

* This series affects both the GPIO and pinmux drivers. Potentially, the
  changes to the two driver could be split into separate series, but this
  would be complicated by the fact patch 1 edits all the board files to
  make the same change for both GPIO and pinmux; if split up, merging that
  all back together would cause conflicts.

* Patch 1's changes to board-seaboard-pinmux.c will have some merge
  conflicts with the patches Peter De Schrijver recently posted to enhance
  that file to support Ventana; each of our patches will change the context
  changes in the others' diffs. I'm not sure how best to manage this.
 
Stephen Warren (4):
  arm/tegra: Prep boards for gpio/pinmux conversion to pdevs
  arm/dt: Tegra: Add pinmux node to tegra20.dtsi
  gpio/tegra: Convert to a platform device
  arm/tegra: Convert pinmux driver to a platform device

 .../devicetree/bindings/pinmux/pinmux_nvidia.txt   |    5 +++
 arch/arm/boot/dts/tegra20.dtsi                     |    5 +++
 arch/arm/mach-tegra/board-harmony-pinmux.c         |    8 +++++
 arch/arm/mach-tegra/board-paz00-pinmux.c           |    8 +++++
 arch/arm/mach-tegra/board-seaboard-pinmux.c        |    9 ++++-
 arch/arm/mach-tegra/board-trimslice-pinmux.c       |    7 ++++
 arch/arm/mach-tegra/devices.c                      |   10 ++++++
 arch/arm/mach-tegra/devices.h                      |    2 +
 arch/arm/mach-tegra/pinmux.c                       |   26 ++++++++++++++++
 drivers/gpio/gpio-tegra.c                          |   31 +++++++++++++-------
 10 files changed, 98 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt

From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 10:50:52 -0800
Subject: [PATCH v7 0/5] Support qcom's HSIC USB and rewrite USB2 HS support
Message-ID: <20170120185057.16206-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series continues the usb chipidea rewrite for 
Qualcommm platforms. I've dropped the patches that were applied
to Peter's tree for chipidea. Now the phy drivers are left,
along with a new hook to set the vbus in the phy and changes
to chipidea to call the new hook.

I've left the HSIC phy driver here, because it wasn't merged in
the last round. Nothing has changed in that driver, so I believe
it is ready to be merged now. The real changes are the new
set_vbus() hook and how we're supposed to handle that in the HS
phy driver.

The only dependencies between subsystems is the set_vbus callback.
If that can go into some stable branch in the phy tree, then Kishon
can apply the phy patches on top of that and Peter can apply the small
chipidea patch on top of that. Or everything can go in parallel, except
for the chipidea patch that adds the set_vbus hook. That hook can be
added after rc1 when dependencies merge.

Patches based on v4.10-rc1 + first 22 patches from v5. Full
branch is here[1].

Changes from v6:
 * Dropped first 22 applied patches
 * Rewrote phy_set_mode() patch to be msm specific
 * New set_vbus() callback in phy framework
 * Updated HS phy driver for set_vbus() callback

Changes from v5:
 * Replaced "Emulate OTGSC interrupt enable path" patch with a patch
   from Peter
 * Updated HS phy driver to support set_mode callback to handle pullup
 * New patch to set the mode to device or host in chipidea udc pullup
   function to toggle the pullup for HS mode
 * New patch to drop lock around event_notify callback to avoid lockdep
   issues
 * Removal of extcon usage from HS phy driver
 * Picked up acks from Heikki and Peter on ULPI core patch

Changes from v4:
 * Picked up Acks from Rob
 * Updated HS phy init sequence DT property to restrict it to offsets

Changes from v3:
 * Picked up Acks from Peter
 * Updated extcon consolidation patch per Peter's comments
 * Folded in simplification from Heikki for ULPI DT matching

Changes from v2:
 * Added SoC specific compatibles in phy bindings
 * Dropped AVVIS patch for OTG statemachine
 * New patch to consolidate extcon handlers
 * Picked up Acks from Peter
 * Rebased onto v4.8-rc1
 * Reworked ULPI OF code to look at vid == 0 instead of pid == 0
 * Dropped ULPI bindings for vid and pid overrides

Changes from v1:
 * Reworked ULPI device probing to keep using vendor/product ids that
   come from DT if needed and falls back to OF style match when product id
   is 0
 * PHY init later patch was rejected so that moved to a quirk flag and
   the msm wrapper started managing the phy on/off
 * Updated clk requirements for HSIC phy in binding doc
 * Added optional clk in wrapper for "housekeeping" found on older qcom
   platforms
 * Bug fix to OTGSC polling function
 * Changed runtime PM patch to set as active instead of get/put

TODO:
 * DMA fails on arm64 so we need something like [2] to make it work.
 * The db410c needs a driver to toggle the onboard switch to connect
   the usb hub instead of micro port when the usb cable is disconnected.
   I've sent a patch set for this[3], which needs some further
   discussion/development. The current plan is to reintroduce the usb
   mux framework.
 * apq8064 platforms need a vbus regulator to really use otg and I haven't
   tried out the RPM based regulators yet
 * The HSIC phy on the apq8074 dragonboard is connected to a usb4604
   device which requires the i2c driver to probe and send an i2c
   sequence before the HSIC controller enumerates or HSIC doesn't work.
   Right now I have a hack to force the controller to probe defer
   once so that usb4604 probes first. This needs a more proper solution
   like having the DT describe a linkage between the controller and
   the usb device so we can enforce probe ordering. My current plan
   is to use DT graphs/endpoints for this.

[1] https://git.linaro.org/people/stephen.boyd/linux.git/log/?h=usb-hsic-8074
[2] https://patchwork.kernel.org/patch/9319527/
[3] https://lkml.kernel.org/r/20160914014246.31847-1-stephen.boyd at linaro.org

Stephen Boyd (5):
  phy: Add support for Qualcomm's USB HSIC phy
  usb: chipidea: msm: Configure phy for appropriate mode
  phy: Add set_vbus callback
  usb: chipidea: Signal vbus state to phy
  phy: Add support for Qualcomm's USB HS phy

 .../devicetree/bindings/phy/qcom,usb-hs-phy.txt    |  78 +++++++
 .../devicetree/bindings/phy/qcom,usb-hsic-phy.txt  |  65 ++++++
 drivers/phy/Kconfig                                |  15 ++
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-core.c                             |  15 ++
 drivers/phy/phy-qcom-usb-hs.c                      | 256 +++++++++++++++++++++
 drivers/phy/phy-qcom-usb-hsic.c                    | 160 +++++++++++++
 drivers/usb/chipidea/ci.h                          |   7 +-
 drivers/usb/chipidea/ci_hdrc_msm.c                 |   4 +
 drivers/usb/chipidea/otg.c                         |   7 +-
 include/linux/phy/phy.h                            |  10 +
 11 files changed, 615 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
 create mode 100644 drivers/phy/phy-qcom-usb-hs.c
 create mode 100644 drivers/phy/phy-qcom-usb-hsic.c

-- 
2.10.0.297.gf6727b0

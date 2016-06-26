From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sun, 26 Jun 2016 00:28:17 -0700
Subject: [PATCH 00/21] Support qcom's HSIC USB and rewrite USB2 HS phy support
Message-ID: <20160626072838.28082-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The state of USB ChipIdea support on Qualcomm's platforms is not great.
The DT description of these devices requires up to three different nodes
for what amounts to be the same hardware block, when there should really
only be one. Furthermore, the "phy" driver that is in mainline (phy-msm-usb.c)
duplicates the OTG state machine and touches the ci controller wrapper
registers when it should really be focused on the phy and the ULPI accesses
needed to get the phy working. There's also a slimmed down phy driver for
the msm8916 platform, but really the phy hardware is the same as other MSMs,
so we have two drivers doing pretty much the same thing. This leads to a
situtaion where we have the chipidea core driver, the "phy" driver, and
sometimes the ehci-msm.c driver operating the same device all at the same
time with very little coordination. This just isn't very safe and is
confusing from a driver perspective when trying to figure out who does what.
Finally, there isn't any HSIC support on platforms like apq8074 so we
should add that.

This patch series updates the ChipIdea driver and the MSM wrapper
(ci_hdrc_msm.c) to properly handle the PHY and wrapper bits at the right
times in the right places. To get there, we update the ChipIdea core to
have support for the ULPI phy bus introduced by Heikki. Along the way
we fix bugs with the extcon handling for peripheral and OTG mode controllers
and move the parts of phy-usb-msm.c that are touching the CI controller
wrapper into the wrapper driver (ci_hdrc_msm.c). Finally we add support
for the HSIC phy based on the ULPI bus and rewrite the HS phy driver
(phy-usb-msm.c) as a standard ULPI phy driver.

Once this series is accepted, we should be able to delete the phy-usb-msm.c
phy-qcom-8x16-usb.c, and ehci-msm.c drivers from the tree and use the ULPI
based phy driver (which also lives in drivers/phy/ instead of drivers/usb/phy/)
and the chipidea host core instead.

I've also sent seperate patches for other minor pieces to make this
all work. The full tree can be found here[3], hacks and all to get
things working. I've tested this on the db410c, apq8074 dragonboard,
and ifc6410 with configfs gadgets and otg cables.

TODO:
 * DMA fails on arm64 so we need something like [1] to make it work.

 * The HSIC phy on the apq8074 dragonboard is connected to a usb4604
   device which requires the i2c driver to probe and send an i2c
   sequence before the HSIC controller enumerates or HSIC doesn't work.
   Right now I have a hack to force the controller to probe defer
   once so that usb4604 probes first. This needs a more proper solution
   like having the DT describe a linkage between the controller and
   the usb device so we can enforce probe ordering.
 
 * OTG support requires a working VBUS supply on apq8074 dragonboard
   and that requires changes to the smbb_charger driver to support
   the OTG OVP switch as a regulator[2]. This series needs revival.

 * Sleeping while atomic problems exist when trying to do phy operations
   underneath some spinlocks in the ci core. I have a patch to remove a
   spinlock, but that needs more thought if it's correct. At the least
   it's necessary though because of how we need to initialize the HSIC
   phy after the reset bit is toggled in USBCMD.

[1] https://lkml.org/lkml/2016/2/22/7
[2] http://lkml.kernel.org/g/1449621618-11900-1-git-send-email-tim.bird at sonymobile.com
[3] https://git.linaro.org/people/stephen.boyd/linux.git/shortlog/refs/heads/usb-hsic-8074

Stephen Boyd (21):
  of: device: Support loading a module with OF based modalias
  usb: ulpi: Support device discovery via DT
  usb: ulpi: Avoid reading/writing in device creation with OF devices
  usb: chipidea: Only read/write OTGSC from one place
  usb: chipidea: Handle extcon events properly
  usb: chipidea: Initialize and reinitialize phy later
  usb: chipidea: Notify of reset when switching into host mode
  usb: chipidea: Kick OTG state machine for AVVIS with vbus extcon
  usb: chipidea: Add support for ULPI PHY bus
  usb: chipidea: msm: Rely on core to override AHBBURST
  usb: chipidea: msm: Use hw_write_id_reg() instead of writel directly
  usb: chipidea: msm: Keep device runtime enabled
  usb: chipidea: msm: Allow core to get usb phy
  usb: chipidea: msm: Add proper clk and reset support
  usb: chipidea: msm: Mux over secondary phy at the right time
  usb: chipidea: msm: Restore wrapper settings after reset
  usb: chipidea: msm: Make platform data driver local instead of global
  usb: chipidea: msm: Add reset controller for PHY POR bit
  usb: chipidea: msm: Be silent on probe defer errors
  phy: Add support for Qualcomm's USB HSIC phy
  phy: Add support for Qualcomm's USB HS phy

 .../devicetree/bindings/phy/qcom,usb-hs-phy.txt    |  71 ++++++
 .../devicetree/bindings/phy/qcom,usb-hsic-phy.txt  |  60 +++++
 Documentation/devicetree/bindings/usb/ulpi.txt     |  20 ++
 drivers/of/device.c                                |  50 ++++
 drivers/phy/Kconfig                                |  15 ++
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-qcom-usb-hs.c                      | 283 +++++++++++++++++++++
 drivers/phy/phy-qcom-usb-hsic.c                    | 161 ++++++++++++
 drivers/usb/chipidea/Kconfig                       |   7 +
 drivers/usb/chipidea/Makefile                      |   1 +
 drivers/usb/chipidea/ci.h                          |  23 +-
 drivers/usb/chipidea/ci_hdrc_msm.c                 | 264 ++++++++++++++++---
 drivers/usb/chipidea/core.c                        |  85 +++----
 drivers/usb/chipidea/host.c                        |   6 +-
 drivers/usb/chipidea/otg.c                         |  81 +++++-
 drivers/usb/chipidea/otg_fsm.c                     |  17 ++
 drivers/usb/chipidea/udc.c                         |   2 +
 drivers/usb/chipidea/ulpi.c                        | 113 ++++++++
 drivers/usb/common/ulpi.c                          |  92 +++++--
 include/linux/of_device.h                          |   6 +
 include/linux/usb/chipidea.h                       |   2 +
 21 files changed, 1238 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt
 create mode 100644 drivers/phy/phy-qcom-usb-hs.c
 create mode 100644 drivers/phy/phy-qcom-usb-hsic.c
 create mode 100644 drivers/usb/chipidea/ulpi.c

-- 
2.9.0.rc2.8.ga28705d

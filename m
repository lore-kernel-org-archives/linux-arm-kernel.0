From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Thu, 27 Oct 2016 15:01:52 +0200
Subject: [PATCH V6 0/4] Add driver for GE B850v3 LVDS/DP++ Bridge
Message-ID: <cover.1477572814.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds a driver that creates a drm_bridge and a drm_connector for the
LVDS to DP++ display bridge of the GE B850v3.

There are two physical bridges on the video signal pipeline: a STDP4028(LVDS to
DP) and a STDP2690(DP to DP++).  The hardware and firmware made it complicated
for this binding to comprise two device tree nodes, as the design goal is to
configure both bridges based on the LVDS signal, which leave the driver
powerless to control the video processing pipeline. The two bridges behaves as
a single bridge, and the driver is only needed for telling the host about EDID /
HPD, and for giving the host powers to ack interrupts. The video signal
pipeline is as follows:

  Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output

This series depends on commit dc80d7038883 ("drm/imx-ldb: Add support to
drm-bridge") which is already on linux-next.

The patches from the series:
 [1/4] Devicetree documentation for the GE B850v3 LVDS/DP++ Bridge

 [2/4] Update the MAINTAINERS file

 [3/4] Add the driver, make changes to Kconfig and Makefile

 [4/4] Make the changes to the B850v3 dts file to enable the GE B850v3
       LVDS/DP++ Bridge.

Tested on next20161027.

Changes from V5:
 - Change to MAINTAINERS in a separate patch
 - Reworked interrupt handler initialization
 - Removed useless calls to: drm_connector_register(),
   drm_helper_hpd_irq_event(), and drm_bridge_enable()

Changes from V4:
 - Renamed the i2c_driver.name from "ge,b850v3-lvds-dp" to "b850v3-lvds-dp" to
   remove the comma from the driver name

Changes from V3:
 - Removed the patch that was configuring the mapping between IPUs and external
   displays on the dts file

Peter Senna Tschudin (4):
  Documentation/devicetree/bindings: b850v3_lvds_dp
  MAINTAINERS: Add entry for GE B850v3 LVDS/DP++ Bridge
  drm/bridge: Add driver for GE B850v3 LVDS/DP++ Bridge
  dts/imx6q-b850v3: Use GE B850v3 LVDS/DP++ Bridge

 .../devicetree/bindings/ge/b850v3-lvds-dp.txt      |  37 ++
 MAINTAINERS                                        |   8 +
 arch/arm/boot/dts/imx6q-b850v3.dts                 |  30 ++
 drivers/gpu/drm/bridge/Kconfig                     |  11 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c         | 395 +++++++++++++++++++++
 6 files changed, 482 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt
 create mode 100644 drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c

-- 
2.5.5

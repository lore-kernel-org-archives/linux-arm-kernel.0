From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Mon, 30 May 2016 18:39:40 +0200
Subject: [PATCH 0/5] Add driver for GE B850v3 LVDS/DP++ Bridge
Message-ID: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds a driver that creates a drm_bridge and a drm_connector for the
LVDS to DP++ display bridge of the GE B850v3. There are two physical bridges on
the video signal pipeline: a STDP4028(LVDS to DP) and a STDP2690(DP to DP++).
However the physical bridges are automatically configured by the input video
signal, and the driver has no access to the video processing pipeline. The
driver is only needed to read EDID from the STDP2690 and to handle HPD events
from the STDP4028. The driver communicates with both bridges over i2c. The
video signal pipeline is as follows:

  Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output

The patches from the series:
 [1/5] Change the imx-ldb driver to allow attaching a bridge and not only a LVDS
       panel.

 [2/5] Configure the mapping between IPUs and external displays on the dts file
       of the B850v3. Needed so the GPU can drive two Full-HD monitors.

 [3/5] Devicetree documentation for the GE B850v3 LVDS/DP++ Bridge

 [4/5] Add the driver, make changes to MAINTAINERS, Kconfig and Makefile

 [5/5] Make the changes to the B850v3 dts file to enalbe the GE B850v3
       LVDS/DP++ Bridge.

Peter Senna Tschudin (5):
  drm/imx-ldb: Add support to drm-bridge
  dts/imx6q-b850v3: Configure IPU assignment order
  Documentation/devicetree/bindings: b850v3_lvds_dp
  drm/bridge: Add driver for GE B850v3 LVDS/DP++ Bridge
  dts/imx6q-b850v3: Use GE B850v3 LVDS/DP++ Bridge

 .../devicetree/bindings/ge/b850v3_lvds_dp.txt      |  38 ++
 MAINTAINERS                                        |   8 +
 arch/arm/boot/dts/imx6q-b850v3.dts                 |  36 ++
 drivers/gpu/drm/bridge/Kconfig                     |   8 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c         | 397 +++++++++++++++++++++
 drivers/gpu/drm/imx/imx-ldb.c                      |  75 ++--
 7 files changed, 542 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
 create mode 100644 drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c

-- 
2.5.5

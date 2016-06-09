From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Thu,  9 Jun 2016 18:25:00 +0200
Subject: [PATCH V2 0/5] Add driver for GE B850v3 LVDS/DP++ Bridge
In-Reply-To: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
Message-ID: <cover.1465486875.git.peter.senna@collabora.com>
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

The patches from the series:
 [1/5] Change the imx-ldb driver to allow attaching a bridge and not only a LVDS
       panel.

 [2/5] Configure the mapping between IPUs and external displays on the dts file
       of the B850v3. Needed if connect two Full-HD monitors.

 [3/5] Devicetree documentation for the GE B850v3 LVDS/DP++ Bridge

 [4/5] Add the driver, make changes to MAINTAINERS, Kconfig and Makefile

 [5/5] Make the changes to the B850v3 dts file to enable the GE B850v3
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
 drivers/gpu/drm/bridge/Kconfig                     |  11 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c         | 392 +++++++++++++++++++++
 drivers/gpu/drm/imx/imx-ldb.c                      | 121 ++++---
 7 files changed, 565 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
 create mode 100644 drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c

-- 
2.5.5

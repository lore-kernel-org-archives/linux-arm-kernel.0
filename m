From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 21 Mar 2014 11:27:45 +0100
Subject: [PATCH RFC v2 0/6] drm/i2c: Move tda998x to a couple encoder/connector
Message-ID: <cover.1395397665.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'slave encoder' structure of the tda998x driver asks for glue
between the DRM driver and the encoder/connector structures.

Changing the tda998x driver to a simple encoder/connector simplifies
the code of the tilcdc driver. This change is permitted by
Russell's infrastructure for componentised subsystems.

The proposed patch set does not include changes to the Armada DRM driver.
These changes should already have been prepared by Russell King, as
told in the message
  https://www.mail-archive.com/linux-media at vger.kernel.org/msg71202.html

The tilcdc part of this patch set has not been tested.

This patch set applies after the patchs:
	drm/i2c: tda998x: Fix lack of required reg in DT documentation
	drm/i2c: tda998x: Change the compatible strings

- v2
	- fix lack of call to component_bind_all() in tilcdc_drv.c
	- add tda998x configuration for non-DT systems

Jean-Francois Moine (6):
  drm/i2c: tda998x: Add the required port property
  drm/i2c: tda998x: Move tda998x to a couple encoder/connector
  drm/tilcd: dts: Add the video output port
  drm/tilcdc: Change the interface with the tda998x driver
  drm/tilcd: dts: Remove unused slave description
  ARM: AM33XX: dts: Change the tda998x description

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  11 +-
 .../devicetree/bindings/drm/tilcdc/slave.txt       |  18 -
 .../devicetree/bindings/drm/tilcdc/tilcdc.txt      |  14 +
 arch/arm/boot/dts/am335x-base0033.dts              |  28 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |  21 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 323 +++++++++-------
 drivers/gpu/drm/tilcdc/Makefile                    |   1 -
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  85 ++++-
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              | 406 ---------------------
 drivers/gpu/drm/tilcdc/tilcdc_slave.h              |  26 --
 10 files changed, 315 insertions(+), 618 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/drm/tilcdc/slave.txt
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h

-- 
1.9.1

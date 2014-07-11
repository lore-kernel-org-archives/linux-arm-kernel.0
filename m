From: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 11 Jul 2014 21:03:44 +0100
Subject: [GIT PULL] Armada DRM devel updates
Message-ID: <20140711200344.GA7973@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

Please incorporate the latest Armada DRM updates, which can be found at:

  git://ftp.arm.linux.org.uk/~rmk/linux-arm.git drm-armada-devel

with SHA1 9611cb93fa65dde199f4f888bd034ffc80c7adf0, based on v3.16-rc3.

This pull includes the component helpers which have been merged into
Greg's driver-devel tree, and the new DRM OF helper file, which
Rob has reviewed, along with the Armada DRM updates.

The Armada DRM changes:
- move the interrupt handling solely into the CRTC layer, otherwise
  we have problems as each CRTC has its own interrupt signal.
- change the way CRTCs are numbered, to use the number of CRTCs which
  have already been registered.  This ultimately equates to the same
  number, so we achieve the same thing but in a simpler way.
- move the variant initialisation from the DRM driver layer to the CRTC
  layer, which is really where it's needed, and make the variant
  handling purely a CRTC thing.
- augment Armada DRM with the component helper to allow multiple
  struct device's to describe the DRM subsystem.  This will be necessary
  for DT support, as each LCD controller is described as a separate node
  in DT, thus creating separate device structures for each LCD controller.
- tweak the external reference clock name to match the documentation
  more exactly - there is no underscore before the '1'.
- allow CRTCs to be registered as separate devices, thereby allowing
  DT to describe the LCD controllers, while preserving the remainder of
  the original behaviour.  (The original driver behaviour is still
  available at this time.)
- register the CRTCs with the DT node so that the recently introduced
  DRM OF helper can be used by encoders to locate their associated
  CRTCs.

This will update the following files:

 .../bindings/drm/armada/marvell,dove-lcd.txt       |  30 +++
 drivers/base/component.c                           | 192 +++++++++++++---
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/armada/armada_510.c                |  23 +-
 drivers/gpu/drm/armada/armada_crtc.c               | 187 ++++++++++++++--
 drivers/gpu/drm/armada/armada_crtc.h               |  11 +-
 drivers/gpu/drm/armada/armada_drm.h                |  13 +-
 drivers/gpu/drm/armada/armada_drv.c                | 245 +++++++++++++++------
 drivers/gpu/drm/drm_of.c                           |  67 ++++++
 include/drm/drm_crtc.h                             |   2 +
 include/drm/drm_of.h                               |  18 ++
 include/linux/component.h                          |   7 +
 12 files changed, 642 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/armada/marvell,dove-lcd.txt
 create mode 100644 drivers/gpu/drm/drm_of.c
 create mode 100644 include/drm/drm_of.h

through these changes:

Russell King (15):
      component: fix missed cleanup in case of devres failure
      component: ignore multiple additions of the same component
      component: add support for component match array
      drm/armada: move IRQ handling into CRTC
      drm/armada: use number of CRTCs registered
      drm/armada: move variant initialisation to CRTC init
      drm/armada: make variant a CRTC thing
      component: fix bug with legacy API
      drm: add of_graph endpoint helper to find possible CRTCs
      Merge branches 'drm-devel' and 'component-for-driver' into armada-drm
      drm/armada: convert to componentized support
      drm/armada: update Armada 510 (Dove) to use "ext_ref_clk1" as the clock
      dt-bindings: add Marvell Dove LCD controller documentation
      drm/armada: permit CRTCs to be registered as separate devices
      drm/armada: register crtc with port

Many thanks.

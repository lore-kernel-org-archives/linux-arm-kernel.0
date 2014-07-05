From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Jul 2014 11:37:24 +0100
Subject: [PATCH RFC 00/15] Armada DRM updates
Message-ID: <20140705103724.GN21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series updates the Armada DRM driver to be more DT friendly
by converting it to the component helper.  This is an incomplete
conversion as we also need to convert the TDA998x as well, hence it
currently retains the existing method of initialisation using the slave
encoder mechanism.  The old mechanism will be removed once the
conversion is complete.

This series includes the component updates (patches 1-3 which have been
recently merged into Greg's driver tree, patch 9 which is scheduled to
be merged) and the recently posted DRM OF helper for encoders (patch 8).
Hence patches 1-3 and 9 are only included for reference purposes.
Please direct comments for patch 8 to the previously posted RFC for
that single patch.

The general idea here is to permit each CRTC device to exist as a
separate device node in DT (as it should be) with all the appropriate
properties such as base address, interrupt and pixel clocks.

The encoders (which may be off-SoC) will be specified separately in DT,
and the connectivity specified via the DT's graph bindings.

The diffstat below is for the entire series, which includes the
component helpre updates and the DRM OF helper.

 .../bindings/drm/armada/marvell,dove-lcd.txt       |  30 +++
 arch/arm/boot/dts/dove.dtsi                        |  14 ++
 drivers/base/component.c                           | 192 +++++++++++++----
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/armada/armada_510.c                |  23 +-
 drivers/gpu/drm/armada/armada_crtc.c               | 188 +++++++++++++++--
 drivers/gpu/drm/armada/armada_crtc.h               |   9 +-
 drivers/gpu/drm/armada/armada_drm.h                |  13 +-
 drivers/gpu/drm/armada/armada_drv.c                | 233 ++++++++++++++-------
 drivers/gpu/drm/drm_of.c                           |  65 ++++++
 include/drm/drm_crtc.h                             |   2 +
 include/drm/drm_of.h                               |  18 ++
 include/linux/component.h                          |   7 +
 13 files changed, 642 insertions(+), 153 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

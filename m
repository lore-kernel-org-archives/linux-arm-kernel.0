From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Mon, 20 Jul 2015 10:54:25 +0300
Subject: [PATCH v2 0/4] Add VIC support for Tegra124
Message-ID: <1437378869-10451-1-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From Arto's original cover letter:

This series adds Video-Image-Compositor (VIC) support for Tegra124. The unit
replaced gr2d engine on T124 and it is effectively used for similar
operations: making simple surface copy and fill operations.

[..]

The series has been tested on Jetson TK1 by first disabling IOMMU (*),
enabling CMA and running a VIC clear test case that is posted to dri-devel
and linux-tegra mailing lists. The firmware image for VIC is publicly
available as part of Linux For Tegra driver package [0].

[0] https://developer.nvidia.com/linux-tegra

(*) Currently Tegra DRM does not support mapping the host1x command buffers
into kernel address space in case IOMMU is enabled.

End of original cover letter.

The aforementioned VIC clear test can be found at
https://patchwork.kernel.org/patch/6454821/.

This series is now composed of a commit that adds a general Falcon helper
library to be used by drivers whose hardware contains a Falcon, which
includes many Host1x clients; and then separately of the VIC driver that
uses that Falcon library. The fixes to host1x this series used to include
are in the 'Host1x/TegraDRM fixes/improvements' series I posted earlier;
that series is a dependency for this series.

Thanks,
Mikko.

Arto Merilainen (3):
  drm/tegra: Add falcon helper library
  drm/tegra: Add VIC support
  ARM: tegra: Add VIC for Tegra124

Mikko Perttunen (1):
  of: Add NVIDIA Tegra VIC binding

 .../bindings/gpu/nvidia,tegra20-host1x.txt         |  15 +
 arch/arm/boot/dts/tegra124.dtsi                    |  12 +
 drivers/gpu/drm/tegra/Makefile                     |   4 +-
 drivers/gpu/drm/tegra/drm.c                        |   7 +
 drivers/gpu/drm/tegra/drm.h                        |   1 +
 drivers/gpu/drm/tegra/falcon.c                     | 256 ++++++++++++
 drivers/gpu/drm/tegra/falcon.h                     | 130 ++++++
 drivers/gpu/drm/tegra/vic.c                        | 456 +++++++++++++++++++++
 drivers/gpu/drm/tegra/vic.h                        |  35 ++
 include/linux/host1x.h                             |   1 +
 10 files changed, 916 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/tegra/falcon.c
 create mode 100644 drivers/gpu/drm/tegra/falcon.h
 create mode 100644 drivers/gpu/drm/tegra/vic.c
 create mode 100644 drivers/gpu/drm/tegra/vic.h

-- 
2.1.4

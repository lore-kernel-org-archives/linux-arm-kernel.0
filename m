From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jan 2014 21:25:28 +0000
Subject: [PATCH RFC 00/46] Preview of imx-drm cleanup series
Message-ID: <20140102212528.GD7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is my large patch series which cleans up imx-drm, and gets it ready
to move out of drivers/staging.  This is a preview only.

One of these patches introduces a generic helper in drivers/base which
can be used by any subsystem to assemble a sub-devices together and
complete the probe of a subsystem when all devices are present - and
tear it down when any of those devices go away - this is patch 26.

Example usage (with imx-drm) is illustrated in patches 27 through to
41.

Some of this duplicates Fabio's imx-drm HDMI patch; indeed some of
the changes which were fed back to Fabio are here as their individual
patches.  I've not updated Fabio's patch in this series since he sent
an updated version to Greg for merging.

I've also included here support for ALSA based HDMI audio - if you
omit the new HDMI drivers from this, it gives a net reduction in LoC.

Finally, the last patch attempts to resolve a problem with the way
imx-drm works - but this is fundamentally unsolvable without
introducing new DT properties to properly specify the mux IDs.

I'm only sending this to a limited number of people for comments at
present since it's a large series, and the selection of people from
maintainers is rather large.

 arch/arm/boot/dts/imx51-babbage.dts         |   10 +-
 arch/arm/boot/dts/imx53-m53evk.dts          |    8 +-
 arch/arm/boot/dts/imx53-mba53.dts           |    6 +
 arch/arm/boot/dts/imx53-qsb.dts             |    8 +-
 arch/arm/boot/dts/imx6dl.dtsi               |    5 +
 arch/arm/boot/dts/imx6q.dtsi                |    5 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi      |    6 +
 arch/arm/boot/dts/imx6qdl.dtsi              |    9 +
 drivers/base/Makefile                       |    2 +-
 drivers/base/component.c                    |  379 ++++++
 drivers/gpu/drm/drm_crtc_helper.c           |   39 +-
 drivers/staging/imx-drm/Kconfig             |    6 +
 drivers/staging/imx-drm/Makefile            |    5 +-
 drivers/staging/imx-drm/dw-hdmi-audio.c     |  550 ++++++++
 drivers/staging/imx-drm/dw-hdmi-audio.h     |   13 +
 drivers/staging/imx-drm/imx-drm-core.c      |  827 ++++---------
 drivers/staging/imx-drm/imx-drm.h           |   38 +-
 drivers/staging/imx-drm/imx-fb.c            |   47 -
 drivers/staging/imx-drm/imx-fbdev.c         |   74 --
 drivers/staging/imx-drm/imx-hdmi.c          | 1796 +++++++++++++++++++++++++++
 drivers/staging/imx-drm/imx-hdmi.h          | 1037 ++++++++++++++++
 drivers/staging/imx-drm/imx-ldb.c           |  125 +--
 drivers/staging/imx-drm/imx-tve.c           |  134 +-
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |    1 +
 drivers/staging/imx-drm/ipu-v3/ipu-common.c |   15 +-
 drivers/staging/imx-drm/ipu-v3/ipu-di.c     |  317 ++---
 drivers/staging/imx-drm/ipuv3-crtc.c        |   59 +-
 drivers/staging/imx-drm/parallel-display.c  |  100 +-
 include/drm/drm_crtc_helper.h               |    1 +
 include/linux/component.h                   |   31 +
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |    1 +
 31 files changed, 4519 insertions(+), 1135 deletions(-)
 create mode 100644 drivers/base/component.c
 create mode 100644 drivers/staging/imx-drm/dw-hdmi-audio.c
 create mode 100644 drivers/staging/imx-drm/dw-hdmi-audio.h
 delete mode 100644 drivers/staging/imx-drm/imx-fb.c
 delete mode 100644 drivers/staging/imx-drm/imx-fbdev.c
 create mode 100644 drivers/staging/imx-drm/imx-hdmi.c
 create mode 100644 drivers/staging/imx-drm/imx-hdmi.h
 create mode 100644 include/linux/component.h

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

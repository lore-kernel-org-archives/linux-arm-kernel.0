From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Wed,  9 Jan 2013 19:11:24 +0530
Subject: [PATCH RFC 0/3] vpif capture support for async subdevice probing
Message-ID: <1357738887-8701-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for vpif capture driver to support
asynchronously register subdevices. The second patch add support for
tvp514x decoder to support v4l-async and the last patch adds support
for da850 evm to support v4l-async for vpif capture.

This patch is based on v4l2-async patch
(http://www.spinics.net/lists/linux-media/msg58420.html) from Guennadi.

Need for this support:
Currently bridge device drivers register devices for all subdevices 
synchronously, tupically, during their probing. E.g. if an I2C CMOS sensor 
is attached to a video bridge device, the bridge driver will create an I2C 
device and wait for the respective I2C driver to probe. This makes linking 
of devices straight forward, but this approach cannot be used with 
intrinsically asynchronous and unordered device registration systems like 
the Flattened Device Tree.

Similar impletation is to be done for vpif disaply, based on review comments
on this series.

Lad, Prabhakar (3):
  davinci: vpif: capture: add V4L2-async support
  tvp514x: support asynchronous probing
  ARM: da850/omap-l138: vpif capture convert to asynchronously register
    of subdev

 arch/arm/mach-davinci/board-da850-evm.c       |   57 +++++++-
 drivers/media/i2c/tvp514x.c                   |   20 ++-
 drivers/media/platform/davinci/vpif_capture.c |  171 ++++++++++++++++++-------
 drivers/media/platform/davinci/vpif_capture.h |    2 +
 include/media/davinci/vpif_types.h            |    2 +
 5 files changed, 192 insertions(+), 60 deletions(-)

-- 
1.7.4.1

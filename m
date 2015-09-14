From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 14 Sep 2015 14:21:39 +0200
Subject: [PATCH v2 0/2] [media] Fix race between graph enumeration and
 entities registration
Message-ID: <1442233301-25181-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The Media Controller framework has an issue in which the media device node
is registered before all the media entities and pads links are created so
if user-space tries to enumerate the graph too early, it may get a partial
graph since not everything has been registered yet.

This series fixes the issue by separate the media device registration from
the initialization so drives can first initialize the media device, create
the graph and then finally register the media device node once is finished.
The solution was suggested by Sakari Ailus.

This is the second version of the series that fixes issues pointed out by
Sakari Ailus. The first version was [0].

Patch #1 adds a check to the media_device_unregister() function to know if
the media device has been registed yet so calling it will be safe and the
cleanup functions of the drivers won't need to be changed in case register
failed.

Patch #2 does the init and registration split, changing all the drivers to
make the change atomic and also adds a cleanup function for media devices.

The patches are on top of Mauro's "[PATCH v8 00/55] MC next generation" [1]
but is not a dependency for that series, it was only be based on that patch
series to avoid conflicts with in-flight patches.

The patches have been tested on an OMAP3 IGEPv2 board that has a OMAP3 ISP
device and an Exynos5800 Chromebook with a built-in UVC camera.

[0]: https://lkml.org/lkml/2015/9/10/311
[1]: http://permalink.gmane.org/gmane.linux.drivers.driver-project.devel/74515

Best regards,
Javier

Changes in v2:
- Reword the documentation for media_device_unregister(). Suggested by Sakari.
- Added Sakari's Acked-by tag for patch #1.
- Change media_device_init() to return void instead of an error.
  Suggested by Sakari Ailus.
- Remove the error messages when media_device_register() fails.
  Suggested by Sakari Ailus.
- Fix typos in commit message of patch #2. Suggested by Sakari Ailus.

Javier Martinez Canillas (2):
  [media] media-device: check before unregister if mdev was registered
  [media] media-device: split media initialization and registration

 drivers/media/common/siano/smsdvb-main.c      |  1 +
 drivers/media/media-device.c                  | 43 ++++++++++++++++++++++-----
 drivers/media/platform/exynos4-is/media-dev.c | 15 +++++-----
 drivers/media/platform/omap3isp/isp.c         | 14 ++++-----
 drivers/media/platform/s3c-camif/camif-core.c | 15 ++++++----
 drivers/media/platform/vsp1/vsp1_drv.c        | 12 ++++----
 drivers/media/platform/xilinx/xilinx-vipp.c   | 12 +++-----
 drivers/media/usb/au0828/au0828-core.c        | 27 ++++++++---------
 drivers/media/usb/cx231xx/cx231xx-cards.c     | 30 +++++++++----------
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c   | 23 +++++++-------
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c       | 24 ++++++++-------
 drivers/media/usb/siano/smsusb.c              |  5 ++--
 drivers/media/usb/uvc/uvc_driver.c            | 10 +++++--
 include/media/media-device.h                  |  2 ++
 14 files changed, 136 insertions(+), 97 deletions(-)

-- 
2.4.3

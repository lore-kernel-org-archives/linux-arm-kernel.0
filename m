From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 28 May 2016 18:01:10 -0400
Subject: [PATCH V6 0/8] vfio, platform: add ACPI support
Message-ID: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree code checks for the presence of a reset driver and calls
the of_reset function pointer by looking up the reset driver as a module.

ACPI defines _RST method to perform device level reset. After the _RST
method is executed, the OS can resume using the device.

This patch checks the presence of _RST method and calls the _RST
method when reset is requested.

Changes from V5:
1. Handle reset function call failures in open and release (new patch).
2. Bring out extra debug information when failure happens (new patch).
3. Address review comments from Eric in ACPI _RST patch.

Sinan Kaya (8):
  vfio: platform: move reset call to a common function
  vfio: platform: determine reset capability
  vfio: platform: add support for ACPI probe
  vfio: platform: add extra debug info argument to call reset
  vfio: platform: call _RST method when using ACPI
  vfio, platform: make reset driver a requirement by default
  vfio: platform: check reset call return code during open
  vfio: platform: check reset call return code during release

 drivers/vfio/platform/vfio_amba.c             |   5 +
 drivers/vfio/platform/vfio_platform.c         |   5 +
 drivers/vfio/platform/vfio_platform_common.c  | 169 ++++++++++++++++++++++----
 drivers/vfio/platform/vfio_platform_private.h |   2 +
 4 files changed, 159 insertions(+), 22 deletions(-)

-- 
1.8.2.1

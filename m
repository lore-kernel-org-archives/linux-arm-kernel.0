From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Jul 2016 09:01:40 -0400
Subject: [PATCH V11 0/9] vfio, platform: add ACPI support
Message-ID: <1468933309-19735-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code only supports the device tree based platforms.
The code checks for the presence of a reset driver and calls the reset
function pointer by looking up the reset driver as a module.

ACPI defines _RST method to perform device level reset. After the _RST
method is executed, the OS can resume using the device.

The patchset is moving the device tree specific pieces out of the code
to common functions so that ACPI support is added without impacting the
rest of the code.

During probe, the ACPI HID of the object will be saved and will be used to
determine if this is an ACPI capable platform or not. If acpihid is NULL
then, device tree functions are called.

In addition to plumbing ACPI support, reset functionality is now a
requirement by default.

The code was allowing platform devices to be used without a supporting
VFIO reset driver. The hardware can be left in some inconsistent state
after a guest machine abort.

The reset driver will put the hardware back to safe state and disable
interrupts before returning the control back to the host machine.

Adding a new reset_required kernel module option to platform
VFIO drivers with a default value of true.

New requirements are:
1. A reset function needs to be implemented by the corresponding driver
via DT/ACPI.
2. The reset function needs to be discovered via DT/ACPI.

The probe of the driver will fail if any of the above conditions are
not satisfied.

Changes from V10:
1. Get rid of redundant if check in the acpi_probe since we are now using
WARN_ON.
2. Change the error code order according to Alex's recommendation.

Sinan Kaya (9):
  vfio: platform: rename reset function
  vfio: platform: move reset call to a common function
  vfio: platform: determine reset capability
  vfio: platform: add support for ACPI probe
  vfio: platform: add extra debug info argument to call reset
  vfio: platform: call _RST method when using ACPI
  vfio, platform: make reset driver a requirement by default
  vfio: platform: check reset call return code during open
  vfio: platform: check reset call return code during release

 drivers/vfio/platform/vfio_amba.c             |   1 +
 drivers/vfio/platform/vfio_platform.c         |   5 +
 drivers/vfio/platform/vfio_platform_common.c  | 192 +++++++++++++++++++++-----
 drivers/vfio/platform/vfio_platform_private.h |   9 +-
 4 files changed, 173 insertions(+), 34 deletions(-)

-- 
1.8.2.1

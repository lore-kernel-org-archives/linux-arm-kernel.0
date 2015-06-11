From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 11 Jun 2015 14:08:43 +0200
Subject: [PATCH v3 0/4] VFIO platform reset
Message-ID: <1434024527-13869-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In situations where the userspace driver is stopped abnormally and the
VFIO platform device is released, the assigned HW device currently is
left running. As a consequence the HW device might continue issuing IRQs
and performing DMA accesses.

On release, no physical IRQ handler is setup anymore. Also the DMA buffers
are unmapped leading to IOMMU aborts. So there is no serious consequence.

However when assigning that HW device again to another userspace driver,
this latter might face some unexpected IRQs and DMA accesses, which are
the result of the previous assignment.

In virtualization use-case, a VM newly granted with that HW device may be
impacted by the assignment of that device to a previous VM:
- IRQs may be injected very early when booting the new guest, even before
  the guest driver has initialized leading to possible driver state
  inconsistency.
- DMA accesses may hit the newly mapped VM address space at addresses that
  may jeopardize the integrity of the newly installed VM.

Obviously the criticity depends on the assigned HW device.

As opposed to PCI, there is no standard mechanism to reset the platform
device.

This series proposes to implement device specific reset functions in
separate vfio reset modules (in-kernel or external). The vfio-platform
driver holds a whitelist of implemented triplets (compat string, module
name, function name). When the vfio-platform driver is probed it identifies
the fellow reset module/function matching the compat string of the
device, if any, and forces the load of this reset module.

A first reset module is provided: the vfio-platform-calxedaxgmac
module which implements a basic reset for the Calxeda xgmac.

The series can be found at
https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.1-rc7-reset-v3

History:
v2 -> v3:
- remove void module_init/exit functions in calxeda reset module
- remove enum vfio_platform_reset_type
- for reset lookup, use ARRAY_SIZE
- in reset put use symbol_put_addr

v1 -> v2:
- much simplified compared to v1 although principle of external modules is
  kept: removed mechanism of dynamic registration of reset functions
- list is replaced by whitelist lookup table
- name of the reset function also stored in the lookup table
- autoload of reset modules

RFC -> PATCH v1:
- solution now based on a lookup list instead of specialized driver

Eric Auger (4):
  VFIO: platform: add reset struct and lookup table
  VFIO: platform: add reset callback
  VFIO: platform: populate the reset function on probe
  VFIO: platform: Calxeda xgmac reset module

 drivers/vfio/platform/Kconfig                      |  2 +
 drivers/vfio/platform/Makefile                     |  2 +
 drivers/vfio/platform/reset/Kconfig                |  7 ++
 drivers/vfio/platform/reset/Makefile               |  5 ++
 .../platform/reset/vfio_platform_calxedaxgmac.c    | 86 ++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_common.c       | 60 ++++++++++++++-
 drivers/vfio/platform/vfio_platform_private.h      |  7 ++
 7 files changed, 166 insertions(+), 3 deletions(-)
 create mode 100644 drivers/vfio/platform/reset/Kconfig
 create mode 100644 drivers/vfio/platform/reset/Makefile
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c

-- 
1.9.1

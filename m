From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 20 Jul 2016 08:53:56 -0500
Subject: [PATCH V3 0/4] Change fixed mmio handlers to a variable number
Message-ID: <1469022840-2142-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The maximum number of mmio handlers that are allowed is limited to
a macro MAX_IO_HANDLER(16), which is not enough for supporting per CPU
Redistributor regions. We need at least MAX_IO_HANDLER+CONFIG_NR_CPUS
mmio handlers in order to support ACPI based XEN boot.

This patchset uses the dynamic allocation strategy to allocate memory
resource dynamically depends on the number of Redistributor regions
that are described in the APCI MADT table.

Shanker Donthineni (4):
  arm/io: Use separate memory allocation for mmio handlers
  xen: Add generic implementation of binary search
  xen/arm: io: Use binary search for mmio handler lookup
  arm/vgic: Change fixed number of mmio handlers to variable number

 xen/arch/arm/domain.c      | 12 +++++++----
 xen/arch/arm/io.c          | 52 +++++++++++++++++++++++++++++++---------------
 xen/arch/arm/vgic-v2.c     |  3 ++-
 xen/arch/arm/vgic-v3.c     |  5 ++++-
 xen/arch/arm/vgic.c        | 10 +++------
 xen/common/Makefile        |  1 +
 xen/common/bsearch.c       | 51 +++++++++++++++++++++++++++++++++++++++++++++
 xen/include/asm-arm/mmio.h |  7 +++++--
 xen/include/asm-arm/vgic.h |  5 +++--
 xen/include/xen/lib.h      |  3 +++
 10 files changed, 115 insertions(+), 34 deletions(-)
 create mode 100644 xen/common/bsearch.c

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

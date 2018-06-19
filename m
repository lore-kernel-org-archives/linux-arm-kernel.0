From: mhkelley58@gmail.com (Michael Kelley)
Date: Tue, 19 Jun 2018 14:23:10 -0700
Subject: [PATCH 0/5] Enable Linux guests on Hyper-V on ARM64
Message-ID: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables Linux guests running on Hyper-V on ARM64
hardware. New ARM64-specific code in arch/arm64/hyperv initializes
Hyper-V, including its synthetic clocks and hypercall mechanism.
Existing architecture independent drivers for Hyper-V's VMbus and
synthetic devices just work when built for ARM64. Hyper-V code is
built and included in the image and modules only if CONFIG_HYPERV
is enabled.

The five patches are organized as follows:
1) Implement slow_virt_to_phys() function for ARM64.  This
function parallels the same function for x86/x64, and is used
by the Hyper-V synthetic network driver.

2) Add include files that define the Hyper-V interface as
described in the Hyper-V Top Level Functional Spec (TLFS), plus
additional definitions specific to Linux running on Hyper-V.

3) Add core Hyper-V support on ARM64, including hypercalls,
synthetic clock initialization, and interrupt handlers.

4) Update the existing VMbus driver to generalize interrupt
management across x86/x64 and ARM64.

5) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.

Some areas of Linux guests on Hyper-V on ARM64 are a work-
in-progress, primarily due to work still being done in Hyper-V:

* Hyper-V on ARM64 currently runs with a 4 Kbyte page size, and only
  supports guests with a 4 Kbyte page size. Because Hyper-V uses
  shared pages to communicate between the guest and the hypervisor,
  there are open design decisions on the page size to use when
  the guest is using 16K/64K pages.  Once those issues are
  resolved and Hyper-V fully supports 16K/64K guest pages, changes
  may be needed in the Linux drivers for Hyper-V synthetic devices.

* Hyper-V on ARM64 does not currently support mapping PCI devices
  into the guest address space. The Hyper-V PCI driver at
  drivers/pci/host/pci-hyperv.c has x86/x64-specific code and is
  not being built for ARM64.

In a few cases, terminology from the x86/x64 world has been carried
over into the ARM64 code ("MSR", "TSC").  Hyper-V still uses the
x86/x64 terminology and has not replaced it with something more
generic, so the code uses the Hyper-V terminology.  This will be
fixed when Hyper-V updates the usage in the TLFS.

Michael Kelley (5):
  arm64: mm: Add slow_virt_to_phys()
  arm64: hyperv: Add core Hyper-V include files
  arm64: hyperv: Add support for Hyper-V as a hypervisor
  Drivers: hv: vmbus: Add hooks for per-CPU IRQ
  Drivers: hv: Enable CONFIG_HYPERV on ARM64

 MAINTAINERS                          |   3 +
 arch/arm64/Makefile                  |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_hvc.S           |  54 +++++
 arch/arm64/hyperv/hv_init.c          | 411 +++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         | 178 +++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h | 353 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/memory.h      |   6 +
 arch/arm64/include/asm/mshyperv.h    | 291 +++++++++++++++++++++++++
 arch/arm64/mm/pageattr.c             |  37 ++++
 arch/x86/include/asm/mshyperv.h      |   4 +
 drivers/hv/Kconfig                   |   3 +-
 drivers/hv/hv.c                      |   2 +
 13 files changed, 1344 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_hvc.S
 create mode 100644 arch/arm64/hyperv/hv_init.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

-- 
1.8.3.1

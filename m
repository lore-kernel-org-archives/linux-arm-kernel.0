From: julien.grall@arm.com (Julien Grall)
Date: Thu, 18 Oct 2018 14:37:39 +0100
Subject: [KVMTOOL][PATCH v2 0/9] arm: Allow the user specifying where the RAM
 is place in the memory
Message-ID: <20181018133748.32577-1-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

At the moment, a user is only able to specify the amount of RAM used by the
guest. Where the RAM will live is left to the software and hardcoded.

It could be useful for testing purpose to move the RAM in different place.
This series adds the possibility for the user to specify multiple RAM region.

The option -m/--mem is extended to specify the address using the following
format: <size>@<addr>. The option needs to be repeated as many times as the
number of RAM region in the guest layout.

For instance, if you want 512MB at 3GB and 512MB 4GB it would look like:
    -m 512 at 0xc0000000 -m 512 at 0x100000000

Note that the memory layout is not yet fully configurable by the user, so the
MMIO region is still living below 2GB. This means RAM cannot live in the
region 0-2GB. This could be changed in the future.

Cheers,

Julien Grall (7):
  kvm__arch_init: Don't pass hugetlbfs_path and ram_size in parameter
  virtio/scsi: Allow to use multiple banks
  Fold kvm__init_ram call in kvm__arch_init
  arm: Add an helper to sanitize KVM configuration
  arm: Move anything related to RAM initialization in kvm__init_ram
  Allow the user to specify where the RAM is placed in the memory
  arm: Add support for multi memory regions

Suzuki K Poulose (2):
  arm: Allow use of hugepage with 16K pagesize host
  kvmtool: Allow standard size specifiers for memory bank

 arm/aarch32/include/kvm/kvm-arch.h |   2 +-
 arm/aarch64/include/kvm/kvm-arch.h |   4 +-
 arm/fdt.c                          |  19 +++--
 arm/include/arm-common/kvm-arch.h  |  24 ++++--
 arm/kvm.c                          | 160 ++++++++++++++++++++++++++++++-------
 builtin-run.c                      | 129 +++++++++++++++++++++++++++---
 include/kvm/kvm-config.h           |  16 +++-
 include/kvm/kvm.h                  |  24 ++++--
 kvm.c                              |   8 +-
 mips/kvm.c                         |  47 ++++++-----
 powerpc/kvm.c                      |  33 +++++---
 virtio/scsi.c                      |  21 +++--
 x86/bios.c                         |   8 +-
 x86/kvm.c                          |  54 ++++++++-----
 14 files changed, 417 insertions(+), 132 deletions(-)

-- 
2.11.0

From: julien.grall@arm.com (Julien Grall)
Date: Thu, 10 May 2018 15:14:41 +0100
Subject: [RFC 00/13] arm: Allow the user specifying where the RAM is place
 in the memory
In-Reply-To: <20180510140441.24573-1-julien.grall@arm.com>
References: <20180510140441.24573-1-julien.grall@arm.com>
Message-ID: <dc6210e2-300f-0279-863e-9b8dc286fe9f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I forgot to mention in the title that the series is for kvmtools. Sorry 
for the confusion.

Cheers,

On 10/05/18 15:04, Julien Grall wrote:
> Hi all,
> 
> At the moment, a user is only able to specify the amount of RAM used by the
> guest. Where the RAM will live is left to the software and hardcoded.
> 
> It could be useful for testing purpose to move the RAM in different place.
> This series adds the possibility for the user to specify multiple RAM region.
> 
> The option -m/--mem is extended to specify the address using the following
> format: <size>@<addr>. The option needs to be repeated as many times as the
> number of RAM region in the guest layout.
> 
> For instance, if you want 512MB at 3GB and 512MB 4GB it would look like:
>      -m 512 at 0xc0000000 -m 512 at 0x100000000
> 
> Note that the memory layout is not yet fully configurable by the user, so the
> MMIO region is still living below 2GB. This means RAM cannot live in the
> region 0-2GB. This could be changed in the future.
> 
> This new version also integrates work from Suzuki to allow the user specifying
> the IPA size for the guest. This was previously sent separately on kvmarm [1].
> 
> Cheers,
> 
> [1] https://lkml.org/lkml/2018/3/27/437
> 
> Julien Grall (7):
>    kvm__arch_init: Don't pass hugetlbfs_path and ram_size in parameter
>    virtio/scsi: Allow to use multiple banks
>    Fold kvm__init_ram call in kvm__arch_init
>    kvm__arch_sanitize_cfg
>    arm: Move anything related to RAM initialization in kvm__init_ram
>    Allow the user to specify where the RAM is placed in the memory
>    arm: Add support for multi memory regions
> 
> Suzuki K Poulose (6):
>    arm: Allow use of hugepage with 16K pagesize host
>    virtio: Handle aborts using invalid PFN
>    kvmtool: Allow backends to run checks on the KVM device fd
>    kvmtool: arm64: Add support for guest physical address size
>    kvmtool: arm64: Switch memory layout
>    kvmtool: arm/arm64: Add support for creating VM with PA size
> 
>   arm/aarch32/include/kvm/kvm-arch.h        |   3 +-
>   arm/aarch64/include/kvm/kvm-arch.h        |  15 ++-
>   arm/aarch64/include/kvm/kvm-config-arch.h |   5 +-
>   arm/fdt.c                                 |  17 ++-
>   arm/include/arm-common/kvm-arch.h         |  32 ++++--
>   arm/include/arm-common/kvm-config-arch.h  |   1 +
>   arm/kvm.c                                 | 183 +++++++++++++++++++++++++-----
>   builtin-run.c                             |  87 ++++++++++++--
>   include/kvm/kvm-config.h                  |  16 ++-
>   include/kvm/kvm.h                         |  28 ++++-
>   kvm.c                                     |  10 +-
>   mips/kvm.c                                |  47 +++++---
>   powerpc/kvm.c                             |  33 +++---
>   virtio/mmio.c                             |  14 ++-
>   virtio/pci.c                              |  10 +-
>   virtio/scsi.c                             |  21 ++--
>   x86/bios.c                                |   8 +-
>   x86/kvm.c                                 |  54 +++++----
>   18 files changed, 443 insertions(+), 141 deletions(-)
> 

-- 
Julien Grall

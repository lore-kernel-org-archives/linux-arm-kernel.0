From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 12 Jan 2015 22:46:56 +0100
Subject: [PATCH v2 0/5] ARM: KVM: Enable the ioeventfd capability of KVM
 on ARM
In-Reply-To: <20141207093641.17563.84226.stgit@i3820>
References: <20141207093641.17563.84226.stgit@i3820>
Message-ID: <54B440D0.6090707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolay,

looks good to me overall. A rebase on Christoffer's vgic init series and
Andre's v6 series will help in reviewing & testing.

Best Regards

Eric

On 12/07/2014 10:37 AM, Nikolay Nikolaev wrote:
> The IOEVENTFD KVM capability is a prerequisite for vhost support.
> 
> This series enables the ioeventfd KVM capability on ARM.
> 
> The implementation routes MMIO access in the IO abort handler to the KVM IO bus.
> If there is already a registered ioeventfd handler for this address, the file
> descriptor will be triggered.
> 
> We extended the KVM IO bus API to expose the VCPU struct pointer. Now the VGIC
> MMIO access is done through this API. For this to operate the VGIC registers a
> kvm_io_device which represents the whole dist MMIO region.
> 
> The patches are implemented on top of the latest Andre's vGICv3 work from here:
> http://www.linux-arm.org/git?p=linux-ap.git;a=shortlog;h=refs/heads/kvm-gicv3/v4
> 
> The code was tested on Dual Cortex-A15 Exynos5250 (ARM Chromebook).
> ARM64 build was verified, but not run on actual HW.
> 
> Changes since v1:
>  - fixed x86 compilation
>  - GICv3/GICv3 dist base selection
>  - added vgic_unregister_kvm_io_dev to free the iodev resources
>  - enable eventfd on ARM64
> 
> ---
> 
> Nikolay Nikolaev (5):
>       KVM: Redesign kvm_io_bus_ API to pass VCPU structure to the callbacks.
>       KVM: ARM: on IO mem abort - route the call to KVM MMIO bus
>       KVM: ARM VGIC add kvm_io_bus_ frontend
>       ARM/ARM64: enable linking against eventfd
>       ARM: enable KVM_CAP_IOEVENTFD
> 
> 
>  arch/arm/kvm/Kconfig       |    1 
>  arch/arm/kvm/Makefile      |    2 -
>  arch/arm/kvm/arm.c         |    3 +
>  arch/arm/kvm/mmio.c        |   32 +++++++++++
>  arch/arm64/kvm/Kconfig     |    1 
>  arch/arm64/kvm/Makefile    |    2 -
>  arch/ia64/kvm/kvm-ia64.c   |    4 +
>  arch/powerpc/kvm/mpic.c    |   10 ++-
>  arch/powerpc/kvm/powerpc.c |    4 +
>  arch/s390/kvm/diag.c       |    2 -
>  arch/x86/kvm/i8254.c       |   14 +++--
>  arch/x86/kvm/i8259.c       |   12 ++--
>  arch/x86/kvm/lapic.c       |    4 +
>  arch/x86/kvm/vmx.c         |    2 -
>  arch/x86/kvm/x86.c         |   13 ++---
>  include/kvm/arm_vgic.h     |    3 -
>  include/linux/kvm_host.h   |   10 ++-
>  virt/kvm/arm/vgic.c        |  127 +++++++++++++++++++++++++++++++++++++++++---
>  virt/kvm/coalesced_mmio.c  |    5 +-
>  virt/kvm/eventfd.c         |    4 +
>  virt/kvm/ioapic.c          |    8 +--
>  virt/kvm/iodev.h           |   23 +++++---
>  virt/kvm/kvm_main.c        |   32 ++++++-----
>  23 files changed, 237 insertions(+), 81 deletions(-)
> 
> --
> Signature
> 

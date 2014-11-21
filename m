From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 21 Nov 2014 13:58:06 +0100
Subject: [PATCH v1] ARM/ARM64: support KVM_IOEVENTFD
In-Reply-To: <1416374181-28415-1-git-send-email-ming.lei@canonical.com>
References: <1416374181-28415-1-git-send-email-ming.lei@canonical.com>
Message-ID: <546F36DE.5060004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ming,

for your information there is a series written by Antonios (added in CC)
https://lists.cs.columbia.edu/pipermail/kvmarm/2014-March/008416.html
exactly on the same topic.

The thread was reactivated by Nikolay latterly on Nov (see
http://www.gossamer-threads.com/lists/linux/kernel/1886716?page=last).

I am also convinced we must progress on ioeventfd topic concurrently
with irqfd one. What starting point do we use then for further comments?

Best Regards

Eric



On 11/19/2014 06:16 AM, Ming Lei wrote:
> From Documentation/virtual/kvm/api.txt, all ARCHs should support
> ioeventfd.
> 
> Also ARM VM has supported PCI bus already, and ARM64 will do too,
> ioeventfd is required for some popular devices, like virtio-blk
> and virtio-scsi dataplane in QEMU.
> 
> Without this patch, virtio-blk-pci dataplane can't work in QEMU.
> 
> This patch has been tested on both ARM and ARM64.
> 
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
> v1:
> 	- make eventfd.o built in ARM64
>  arch/arm/kvm/Kconfig    |    1 +
>  arch/arm/kvm/Makefile   |    2 +-
>  arch/arm/kvm/arm.c      |    1 +
>  arch/arm/kvm/mmio.c     |   19 +++++++++++++++++++
>  arch/arm64/kvm/Kconfig  |    1 +
>  arch/arm64/kvm/Makefile |    2 +-
>  6 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 466bd29..25bd83a 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -23,6 +23,7 @@ config KVM
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select KVM_MMIO
>  	select KVM_ARM_HOST
> +	select HAVE_KVM_EVENTFD
>  	depends on ARM_VIRT_EXT && ARM_LPAE
>  	---help---
>  	  Support hosting virtualized guest machines. You will also
> diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
> index f7057ed..859db09 100644
> --- a/arch/arm/kvm/Makefile
> +++ b/arch/arm/kvm/Makefile
> @@ -15,7 +15,7 @@ AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
>  AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
>  
>  KVM := ../../../virt/kvm
> -kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
> +kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
>  
>  obj-y += kvm-arm.o init.o interrupts.o
>  obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 9e193c8..d90d989 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -172,6 +172,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_IRQCHIP:
>  		r = vgic_present;
>  		break;
> +	case KVM_CAP_IOEVENTFD:
>  	case KVM_CAP_DEVICE_CTRL:
>  	case KVM_CAP_USER_MEMORY:
>  	case KVM_CAP_SYNC_MMU:
> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
> index 4cb5a93..ee332a7 100644
> --- a/arch/arm/kvm/mmio.c
> +++ b/arch/arm/kvm/mmio.c
> @@ -162,6 +162,21 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	return 0;
>  }
>  
> +static int handle_io_bus_rw(struct kvm_vcpu *vcpu, gpa_t addr,
> +			    int len, void *val, bool write)
> +{
> +	int idx, ret;
> +
> +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> +	if (write)
> +		ret = kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, addr, len, val);
> +	else
> +		ret = kvm_io_bus_read(vcpu->kvm, KVM_MMIO_BUS, addr, len, val);
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +
> +	return ret;
> +}
> +
>  int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		 phys_addr_t fault_ipa)
>  {
> @@ -200,6 +215,10 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	if (vgic_handle_mmio(vcpu, run, &mmio))
>  		return 1;
>  
> +	if (!handle_io_bus_rw(vcpu, fault_ipa, mmio.len, &mmio.data,
> +	    mmio.is_write))
> +		return 1;
> +
>  	kvm_prepare_mmio(run, &mmio);
>  	return 0;
>  }
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 8ba85e9..642f57c 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -26,6 +26,7 @@ config KVM
>  	select KVM_ARM_HOST
>  	select KVM_ARM_VGIC
>  	select KVM_ARM_TIMER
> +	select HAVE_KVM_EVENTFD
>  	---help---
>  	  Support hosting virtualized guest machines.
>  
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 32a0961..2e6b827 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -11,7 +11,7 @@ ARM=../../../arch/arm/kvm
>  
>  obj-$(CONFIG_KVM_ARM_HOST) += kvm.o
>  
> -kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
> +kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/arm.o $(ARM)/mmu.o $(ARM)/mmio.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/psci.o $(ARM)/perf.o
>  
> 

From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 19 Nov 2014 13:14:27 +0800
Subject: [PATCH] ARM/ARM64: support KVM_IOEVENTFD
In-Reply-To: <1416324255-30116-1-git-send-email-ming.lei@canonical.com>
References: <1416324255-30116-1-git-send-email-ming.lei@canonical.com>
Message-ID: <CACVXFVPfeUpwobFrN466NbG2hmJqKqvEnj2dCGkL==L4s6fGKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 11:24 PM, Ming Lei <ming.lei@canonical.com> wrote:
> From Documentation/virtual/kvm/api.txt, all ARCHs should support
> ioeventfd.
>
> Also ARM VM has supported PCI bus already, and ARM64 will do too,
> ioeventfd is required for some popular devices, like virtio-blk
> and virtio-scsi dataplane in QEMU.
>
> Without this patch, virtio-blk-pci dataplane can't work in QEMU.

Please ignore this one because eventfd.o is missed to build in arm64.

>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
>  arch/arm/kvm/Kconfig   |    1 +
>  arch/arm/kvm/Makefile  |    2 +-
>  arch/arm/kvm/arm.c     |    1 +
>  arch/arm/kvm/mmio.c    |   19 +++++++++++++++++++
>  arch/arm64/kvm/Kconfig |    1 +
>  5 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 466bd29..25bd83a 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -23,6 +23,7 @@ config KVM
>         select HAVE_KVM_CPU_RELAX_INTERCEPT
>         select KVM_MMIO
>         select KVM_ARM_HOST
> +       select HAVE_KVM_EVENTFD
>         depends on ARM_VIRT_EXT && ARM_LPAE
>         ---help---
>           Support hosting virtualized guest machines. You will also
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
>         case KVM_CAP_IRQCHIP:
>                 r = vgic_present;
>                 break;
> +       case KVM_CAP_IOEVENTFD:
>         case KVM_CAP_DEVICE_CTRL:
>         case KVM_CAP_USER_MEMORY:
>         case KVM_CAP_SYNC_MMU:
> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
> index 4cb5a93..ee332a7 100644
> --- a/arch/arm/kvm/mmio.c
> +++ b/arch/arm/kvm/mmio.c
> @@ -162,6 +162,21 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>         return 0;
>  }
>
> +static int handle_io_bus_rw(struct kvm_vcpu *vcpu, gpa_t addr,
> +                           int len, void *val, bool write)
> +{
> +       int idx, ret;
> +
> +       idx = srcu_read_lock(&vcpu->kvm->srcu);
> +       if (write)
> +               ret = kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, addr, len, val);
> +       else
> +               ret = kvm_io_bus_read(vcpu->kvm, KVM_MMIO_BUS, addr, len, val);
> +       srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +
> +       return ret;
> +}
> +
>  int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                  phys_addr_t fault_ipa)
>  {
> @@ -200,6 +215,10 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>         if (vgic_handle_mmio(vcpu, run, &mmio))
>                 return 1;
>
> +       if (!handle_io_bus_rw(vcpu, fault_ipa, mmio.len, &mmio.data,
> +           mmio.is_write))
> +               return 1;
> +
>         kvm_prepare_mmio(run, &mmio);
>         return 0;
>  }
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 8ba85e9..642f57c 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -26,6 +26,7 @@ config KVM
>         select KVM_ARM_HOST
>         select KVM_ARM_VGIC
>         select KVM_ARM_TIMER
> +       select HAVE_KVM_EVENTFD
>         ---help---
>           Support hosting virtualized guest machines.
>
> --
> 1.7.9.5
>

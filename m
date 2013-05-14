From: xiantao.zhang@intel.com (Zhang, Xiantao)
Date: Tue, 14 May 2013 13:14:15 +0000
Subject: [PATCH v2 2/2] KVM: get rid of $(addprefix ../../../virt/kvm/,
 ...) in Makefiles
In-Reply-To: <1368534653-23133-3-git-send-email-marc.zyngier@arm.com>
References: <1368534653-23133-1-git-send-email-marc.zyngier@arm.com>
 <1368534653-23133-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <B6C2EB9186482D47BD0C5A9A4834564404308C1B@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks!  Acked-by: Xiantao Zhang <xiantao.zhang@intel.com>

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Tuesday, May 14, 2013 8:31 PM
> To: linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu;
> kvm at vger.kernel.org
> Cc: Paolo Bonzini; Gleb Natapov; Christoffer Dall; Zhang, Xiantao; Luck, Tony;
> Yu, Fenghua; Alexander Graf; Benjamin Herrenschmidt; Christian Borntraeger;
> Cornelia Huck
> Subject: [PATCH v2 2/2] KVM: get rid of $(addprefix ../../../virt/kvm/, ...) in
> Makefiles
> 
> As requested by the KVM maintainers, remove the addprefix used to
> refer to the main KVM code from the arch code, and replace it with
> a KVM variable that does the same thing.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@redhat.com>
> Cc: Christoffer Dall <cdall@cs.columbia.edu>
> Cc: Xiantao Zhang <xiantao.zhang@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/Makefile     |  2 +-
>  arch/ia64/kvm/Makefile    |  7 ++++---
>  arch/powerpc/kvm/Makefile | 13 +++++++------
>  arch/s390/kvm/Makefile    |  3 ++-
>  arch/x86/kvm/Makefile     | 13 +++++++------
>  5 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
> index 9184a49..d99bee4 100644
> --- a/arch/arm/kvm/Makefile
> +++ b/arch/arm/kvm/Makefile
> @@ -15,7 +15,7 @@ AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
>  AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
> 
>  KVM := ../../../virt/kvm
> -kvm-arm-y = $(addprefix $(KVM)/, kvm_main.o coalesced_mmio.o)
> +kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
> 
>  obj-y += kvm-arm.o init.o interrupts.o
>  obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
> diff --git a/arch/ia64/kvm/Makefile b/arch/ia64/kvm/Makefile
> index 1a40537..18e45ec 100644
> --- a/arch/ia64/kvm/Makefile
> +++ b/arch/ia64/kvm/Makefile
> @@ -47,12 +47,13 @@ FORCE : $(obj)/$(offsets-file)
> 
>  ccflags-y := -Ivirt/kvm -Iarch/ia64/kvm/
>  asflags-y := -Ivirt/kvm -Iarch/ia64/kvm/
> +KVM := ../../../virt/kvm
> 
> -common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o ioapic.o \
> -		coalesced_mmio.o irq_comm.o)
> +common-objs = $(KVM)/kvm_main.o $(KVM)/ioapic.o \
> +		$(KVM)/coalesced_mmio.o $(KVM)/irq_comm.o
> 
>  ifeq ($(CONFIG_KVM_DEVICE_ASSIGNMENT),y)
> -common-objs += $(addprefix ../../../virt/kvm/, assigned-dev.o iommu.o)
> +common-objs += $(KVM)/assigned-dev.o $(KVM)/iommu.o
>  endif
> 
>  kvm-objs := $(common-objs) kvm-ia64.o kvm_fw.o
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index 422de3f..008cd85 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -5,9 +5,10 @@
>  subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
> 
>  ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
> +KVM := ../../../virt/kvm
> 
> -common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o
> \
> -						eventfd.o)
> +common-objs-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
> +		$(KVM)/eventfd.o
> 
>  CFLAGS_44x_tlb.o  := -I.
>  CFLAGS_e500_mmu.o := -I.
> @@ -53,7 +54,7 @@ kvm-e500mc-objs := \
>  kvm-objs-$(CONFIG_KVM_E500MC) := $(kvm-e500mc-objs)
> 
>  kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_PR) := \
> -	../../../virt/kvm/coalesced_mmio.o \
> +	$(KVM)/coalesced_mmio.o \
>  	fpu.o \
>  	book3s_paired_singles.o \
>  	book3s_pr.o \
> @@ -86,8 +87,8 @@ kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
>  	book3s_xics.o
> 
>  kvm-book3s_64-module-objs := \
> -	../../../virt/kvm/kvm_main.o \
> -	../../../virt/kvm/eventfd.o \
> +	$(KVM)/kvm_main.o \
> +	$(KVM)/eventfd.o \
>  	powerpc.o \
>  	emulate.o \
>  	book3s.o \
> @@ -111,7 +112,7 @@ kvm-book3s_32-objs := \
>  kvm-objs-$(CONFIG_KVM_BOOK3S_32) := $(kvm-book3s_32-objs)
> 
>  kvm-objs-$(CONFIG_KVM_MPIC) += mpic.o
> -kvm-objs-$(CONFIG_HAVE_KVM_IRQ_ROUTING) +=
> $(addprefix ../../../virt/kvm/, irqchip.o)
> +kvm-objs-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
> 
>  kvm-objs := $(kvm-objs-m) $(kvm-objs-y)
> 
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index 8fe9d65..40b4c64 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -6,7 +6,8 @@
>  # it under the terms of the GNU General Public License (version 2 only)
>  # as published by the Free Software Foundation.
> 
> -common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o eventfd.o)
> +KVM := ../../../virt/kvm
> +common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o
> 
>  ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
> 
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index d609e1d..21d5703 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -5,12 +5,13 @@ CFLAGS_x86.o := -I.
>  CFLAGS_svm.o := -I.
>  CFLAGS_vmx.o := -I.
> 
> -kvm-y			+= $(addprefix ../../../virt/kvm/, kvm_main.o ioapic.o \
> -				coalesced_mmio.o irq_comm.o eventfd.o \
> -				irqchip.o)
> -kvm-$(CONFIG_KVM_DEVICE_ASSIGNMENT)	+=
> $(addprefix ../../../virt/kvm/, \
> -				assigned-dev.o iommu.o)
> -kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(addprefix ../../../virt/kvm/,
> async_pf.o)
> +KVM := ../../../virt/kvm
> +
> +kvm-y			+= $(KVM)/kvm_main.o $(KVM)/ioapic.o \
> +				$(KVM)/coalesced_mmio.o
> $(KVM)/irq_comm.o
> +				$(KVM)/eventfd.o $(KVM)/irqchip.o
> +kvm-$(CONFIG_KVM_DEVICE_ASSIGNMENT)	+= $(KVM)/assigned-dev.o
> $(KVM)/iommu.o
> +kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
> 
>  kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
>  			   i8254.o cpuid.o pmu.o
> --
> 1.8.2.3
> 

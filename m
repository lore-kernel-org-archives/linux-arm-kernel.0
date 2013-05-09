From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Thu, 9 May 2013 11:11:01 -0700
Subject: [RFC PATCH 1/2] ARM: KVM: move GIC/timer code to a common location
In-Reply-To: <1367589773-5609-2-git-send-email-marc.zyngier@arm.com>
References: <1367589773-5609-1-git-send-email-marc.zyngier@arm.com>
 <1367589773-5609-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130509181101.GA17253@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 03:02:52PM +0100, Marc Zyngier wrote:
> As KVM/arm64 is looming on the horizon, it makes sense to move some
> of the common code to a single location in order to reduce duplication.
> 
> The code could live anywhere. Actually, most of KVM is already built
> with a bunch of ugly ../../.. hacks in the various Makefiles, so we're
> not exactly talking about style here. But maybe it is time to start
> moving into a less ugly direction.
> 
> The include files must be in a "public" location, as they are accessed
> from non-KVM files (arch/arm/kernel/asm-offsets.c).
> 
> For this purpose, introduce two new locations:
> - virt/kvm/arm/ : x86 and ia64 already share the ioapic code in
>   virt/kvm, so this could be seen as a (very ugly) precedent.
> - include/kvm/  : there is already an include/xen, and while the
>   intent is slightly different, this seems as good a location as
>   any

This overall looks ok, just a few points:

1. Should we have a namespace per arch in the include directory, as in
   include/kvm/arm?

2. We could drop the kvm_ prefix from the include files now

> 
> Eventually, we should probably have independant Makefiles at every
> levels (just like everywhere else in the kernel), but this is just
> the first step.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h                        | 4 ++--
>  arch/arm/kvm/Makefile                                  | 7 ++++---
>  {arch/arm/include/asm => include/kvm}/kvm_arch_timer.h | 0
>  {arch/arm/include/asm => include/kvm}/kvm_vgic.h       | 0
>  {arch/arm/kvm => virt/kvm/arm}/arch_timer.c            | 4 ++--
>  {arch/arm/kvm => virt/kvm/arm}/vgic.c                  | 0
>  6 files changed, 8 insertions(+), 7 deletions(-)
>  rename {arch/arm/include/asm => include/kvm}/kvm_arch_timer.h (100%)
>  rename {arch/arm/include/asm => include/kvm}/kvm_vgic.h (100%)
>  rename {arch/arm/kvm => virt/kvm/arm}/arch_timer.c (99%)
>  rename {arch/arm/kvm => virt/kvm/arm}/vgic.c (100%)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index ff49193..4ad51e6 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -23,7 +23,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmio.h>
>  #include <asm/fpstate.h>
> -#include <asm/kvm_arch_timer.h>
> +#include <kvm/kvm_arch_timer.h>
>  
>  #define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
>  #define KVM_USER_MEM_SLOTS 32
> @@ -38,7 +38,7 @@
>  #define KVM_NR_PAGE_SIZES	1
>  #define KVM_PAGES_PER_HPAGE(x)	(1UL<<31)
>  
> -#include <asm/kvm_vgic.h>
> +#include <kvm/kvm_vgic.h>
>  
>  struct kvm_vcpu;
>  u32 *kvm_vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode);
> diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
> index 53c5ed8..110d6da 100644
> --- a/arch/arm/kvm/Makefile
> +++ b/arch/arm/kvm/Makefile
> @@ -14,10 +14,11 @@ CFLAGS_mmu.o := -I.
>  AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
>  AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
>  
> -kvm-arm-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
> +KVM := ../../../virt/kvm
> +kvm-arm-y = $(addprefix $(KVM)/, kvm_main.o coalesced_mmio.o)
>  
>  obj-y += kvm-arm.o init.o interrupts.o
>  obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
>  obj-y += coproc.o coproc_a15.o mmio.o psci.o perf.o
> -obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
> -obj-$(CONFIG_KVM_ARM_TIMER) += arch_timer.o
> +obj-$(CONFIG_KVM_ARM_VGIC) += $(addprefix $(KVM)/arm/, vgic.o)
> +obj-$(CONFIG_KVM_ARM_TIMER) += $(addprefix $(KVM)/arm/, arch_timer.o)
> diff --git a/arch/arm/include/asm/kvm_arch_timer.h b/include/kvm/kvm_arch_timer.h
> similarity index 100%
> rename from arch/arm/include/asm/kvm_arch_timer.h
> rename to include/kvm/kvm_arch_timer.h
> diff --git a/arch/arm/include/asm/kvm_vgic.h b/include/kvm/kvm_vgic.h
> similarity index 100%
> rename from arch/arm/include/asm/kvm_vgic.h
> rename to include/kvm/kvm_vgic.h
> diff --git a/arch/arm/kvm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> similarity index 99%
> rename from arch/arm/kvm/arch_timer.c
> rename to virt/kvm/arm/arch_timer.c
> index 49a7516..0728904 100644
> --- a/arch/arm/kvm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -25,8 +25,8 @@
>  #include <clocksource/arm_arch_timer.h>
>  #include <asm/arch_timer.h>
>  
> -#include <asm/kvm_vgic.h>
> -#include <asm/kvm_arch_timer.h>
> +#include <kvm/kvm_vgic.h>
> +#include <kvm/kvm_arch_timer.h>
>  
>  static struct timecounter *timecounter;
>  static struct workqueue_struct *wqueue;
> diff --git a/arch/arm/kvm/vgic.c b/virt/kvm/arm/vgic.c
> similarity index 100%
> rename from arch/arm/kvm/vgic.c
> rename to virt/kvm/arm/vgic.c
> -- 
> 1.8.2.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

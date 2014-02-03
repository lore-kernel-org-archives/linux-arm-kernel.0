From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 03 Feb 2014 09:34:18 +0000
Subject: [PATCH] arm64: KVM: Add VGIC device control for arm64
In-Reply-To: <1391377262-30188-1-git-send-email-christoffer.dall@linaro.org>
References: <1391377262-30188-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <cbe51aae56c181605efa0b3f1b5bbcf7@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-02-02 21:41, Christoffer Dall wrote:
> This fixes the build breakage introduced by
> c07a0191ef2de1f9510f12d1f88e3b0b5cd8d66f and adds support for the 
> device
> control API and save/restore of the VGIC state for ARMv8.
>
> The defines were simply missing from the arm64 header files and
> uaccess.h must be implicitly imported from somewhere else on arm.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

         M.

> ---
>  arch/arm64/include/uapi/asm/kvm.h | 9 +++++++++
>  virt/kvm/arm/vgic.c               | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/arm64/include/uapi/asm/kvm.h
> b/arch/arm64/include/uapi/asm/kvm.h
> index 495ab6f..eaf54a3 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -148,6 +148,15 @@ struct kvm_arch_memory_slot {
>  #define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
>  #define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
>
> +/* Device Control API: ARM VGIC */
> +#define KVM_DEV_ARM_VGIC_GRP_ADDR	0
> +#define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
> +#define KVM_DEV_ARM_VGIC_GRP_CPU_REGS	2
> +#define   KVM_DEV_ARM_VGIC_CPUID_SHIFT	32
> +#define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL <<
> KVM_DEV_ARM_VGIC_CPUID_SHIFT)
> +#define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
> +#define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL <<
> KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
> +
>  /* KVM_IRQ_LINE irq field index values */
>  #define KVM_ARM_IRQ_TYPE_SHIFT		24
>  #define KVM_ARM_IRQ_TYPE_MASK		0xff
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index be456ce..8ca405c 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -24,6 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/uaccess.h>
>
>  #include <linux/irqchip/arm-gic.h>

-- 
Fast, cheap, reliable. Pick two.

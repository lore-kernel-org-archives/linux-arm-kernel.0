From: robherring2@gmail.com (Rob Herring)
Date: Wed, 19 Mar 2014 08:22:21 -0500
Subject: [PATCH v4 02/10] ARM/ARM64: KVM: Add base for PSCI v0.2 emulation
In-Reply-To: <1391686302-19451-3-git-send-email-anup.patel@linaro.org>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-3-git-send-email-anup.patel@linaro.org>
Message-ID: <CAL_JsqJqUrSD26gXL+sRVJCO8+nLL-72=MCoMDY47Woe5LON6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 6, 2014 at 5:31 AM, Anup Patel <anup.patel@linaro.org> wrote:
> Currently, the in-kernel PSCI emulation provides PSCI v0.1 interface to
> VCPUs. This patch extends current in-kernel PSCI emulation to provide
> PSCI v0.2 interface to VCPUs.

[snip]

> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index ef0c878..9c922d9 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -83,6 +83,7 @@ struct kvm_regs {
>  #define KVM_VGIC_V2_CPU_SIZE           0x2000
>
>  #define KVM_ARM_VCPU_POWER_OFF         0 /* CPU is started in OFF state */
> +#define KVM_ARM_VCPU_PSCI_0_2          1 /* CPU uses PSCI v0.2 */
>
>  struct kvm_vcpu_init {
>         __u32 target;
> @@ -192,7 +193,7 @@ struct kvm_arch_memory_slot {
>  /* Highest supported SPI, from VGIC_NR_IRQS */
>  #define KVM_ARM_IRQ_GIC_MAX            127
>
> -/* PSCI interface */
> +/* PSCI v0.1 interface */
>  #define KVM_PSCI_FN_BASE               0x95c1ba5e
>  #define KVM_PSCI_FN(n)                 (KVM_PSCI_FN_BASE + (n))

While this is really KVM specific since the base can be anything...

> @@ -201,9 +202,41 @@ struct kvm_arch_memory_slot {
>  #define KVM_PSCI_FN_CPU_ON             KVM_PSCI_FN(2)
>  #define KVM_PSCI_FN_MIGRATE            KVM_PSCI_FN(3)
>
> +/* PSCI v0.2 interface */
> +#define KVM_PSCI_0_2_FN_BASE           0x84000000
> +#define KVM_PSCI_0_2_FN(n)             (KVM_PSCI_0_2_FN_BASE + (n))
> +#define KVM_PSCI_0_2_FN64_BASE         0xC4000000
> +#define KVM_PSCI_0_2_FN64(n)           (KVM_PSCI_0_2_FN64_BASE + (n))
> +
> +#define KVM_PSCI_0_2_FN_PSCI_VERSION   KVM_PSCI_0_2_FN(0)
> +#define KVM_PSCI_0_2_FN_CPU_SUSPEND    KVM_PSCI_0_2_FN(1)
> +#define KVM_PSCI_0_2_FN_CPU_OFF                KVM_PSCI_0_2_FN(2)
> +#define KVM_PSCI_0_2_FN_CPU_ON         KVM_PSCI_0_2_FN(3)
> +#define KVM_PSCI_0_2_FN_AFFINITY_INFO  KVM_PSCI_0_2_FN(4)
> +#define KVM_PSCI_0_2_FN_MIGRATE                KVM_PSCI_0_2_FN(5)
> +#define KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE \
> +                                       KVM_PSCI_0_2_FN(6)
> +#define KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU \
> +                                       KVM_PSCI_0_2_FN(7)
> +#define KVM_PSCI_0_2_FN_SYSTEM_OFF     KVM_PSCI_0_2_FN(8)
> +#define KVM_PSCI_0_2_FN_SYSTEM_RESET   KVM_PSCI_0_2_FN(9)
> +
> +#define KVM_PSCI_0_2_FN64_CPU_SUSPEND  KVM_PSCI_0_2_FN64(1)
> +#define KVM_PSCI_0_2_FN64_CPU_ON       KVM_PSCI_0_2_FN64(3)
> +#define KVM_PSCI_0_2_FN64_AFFINITY_INFO        KVM_PSCI_0_2_FN64(4)
> +#define KVM_PSCI_0_2_FN64_MIGRATE      KVM_PSCI_0_2_FN64(5)
> +#define KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU \
> +                                       KVM_PSCI_0_2_FN64(7)
> +
> +/* PSCI return values */
>  #define KVM_PSCI_RET_SUCCESS           0
>  #define KVM_PSCI_RET_NI                        ((unsigned long)-1)
>  #define KVM_PSCI_RET_INVAL             ((unsigned long)-2)
>  #define KVM_PSCI_RET_DENIED            ((unsigned long)-3)
> +#define KVM_PSCI_RET_ALREADY_ON                ((unsigned long)-4)
> +#define KVM_PSCI_RET_ON_PENDING                ((unsigned long)-5)
> +#define KVM_PSCI_RET_INTERNAL_FAILURE  ((unsigned long)-6)
> +#define KVM_PSCI_RET_NOT_PRESENT       ((unsigned long)-7)
> +#define KVM_PSCI_RET_DISABLED          ((unsigned long)-8)

These definitions are common across arm and arm64, baremetal and kvm
in the kernel, and the kernel and qemu. Soon they will also be needed
in qemu for system emulation support of PSCI. We need these in a
common header to share.

Rob

From: anup.patel@linaro.org (Anup Patel)
Date: Wed, 3 Jul 2013 14:16:23 +0530
Subject: [PATCH] arm64: KVM: Support Cortex-A57 guest CPU on APM X-Gene
 host
In-Reply-To: <1372840923-12808-1-git-send-email-anup.patel@linaro.org>
References: <1372840923-12808-1-git-send-email-anup.patel@linaro.org>
Message-ID: <CALrVBkssu1_swS6rYocVDtXZxBvriiMqK6x211-MLRKXvQtEOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 July 2013 14:12, Anup Patel <anup.patel@linaro.org> wrote:
> Update kvm_target_cpu() to allow Cortex-A57 guest CPU on APM X-Gene.
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm64/kvm/guest.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 2c3ff67..765f56f 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -207,8 +207,13 @@ int __attribute_const__ kvm_target_cpu(void)
>         unsigned long implementor = read_cpuid_implementor();
>         unsigned long part_number = read_cpuid_part_number();
>
> -       if (implementor != ARM_CPU_IMP_ARM)
> -               return -EINVAL;
> +       switch (implementor) {
> +       case ARM_CPU_IMP_ARM:
> +       case ARM_CPU_IMP_APM:
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
>
>         switch (part_number) {
>         case ARM_CPU_PART_AEM_V8:
> @@ -216,6 +221,7 @@ int __attribute_const__ kvm_target_cpu(void)
>         case ARM_CPU_PART_FOUNDATION:
>                 return KVM_ARM_TARGET_FOUNDATION_V8;
>         case ARM_CPU_PART_CORTEX_A57:
> +       case APM_CPU_PART_POTENZA:
>                 /* Currently handled by the generic backend */
>                 return KVM_ARM_TARGET_CORTEX_A57;
>         default:
> --
> 1.7.9.5
>

Hi Catalin/Marc,

This patch depends on the patch titled "arm64: Add defines
for APM ARMv8 implementation" from Vinyak Kale.

Regards,
Anup

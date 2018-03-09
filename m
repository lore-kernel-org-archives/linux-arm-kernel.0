From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 9 Mar 2018 15:55:34 +0000
Subject: [PATCH] arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery
In-Reply-To: <20180309154050.30656-1-marc.zyngier@arm.com>
References: <20180309154050.30656-1-marc.zyngier@arm.com>
Message-ID: <CAKv+Gu9vhS-CmyCMm8arYE0rgAPwKqXHnG7JDmSzW=vhwAYDMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 March 2018 at 15:40, Marc Zyngier <marc.zyngier@arm.com> wrote:
> A recent update to the ARM SMCCC ARCH_WORKAROUND_1 specification
> allows firmware to return a non zero, positive value to describe
> that although the mitigation is implemented at the higher exception
> level, the CPU on which the call is made is not affected.
>
> Let's relax the check on the return value from ARCH_WORKAROUND_1
> so that we only error out if the returned value is negative.
>
> Fixes: b092201e0020 ("arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

OK, so this means the current code running on new firmware will
erroneously assume that the mitigation is not implemented or needed if
it, say, happens to run on the A53 cluster on Juno?

> ---
>  arch/arm64/kernel/cpu_errata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 07823595b7f0..91428426bf26 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -178,7 +178,7 @@ static int enable_smccc_arch_workaround_1(void *data)
>         case PSCI_CONDUIT_HVC:
>                 arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>                                   ARM_SMCCC_ARCH_WORKAROUND_1, &res);
> -               if (res.a0)
> +               if ((int)res.a0 < 0)
>                         return 0;
>                 cb = call_hvc_arch_workaround_1;
>                 smccc_start = __smccc_workaround_1_hvc_start;
> @@ -188,7 +188,7 @@ static int enable_smccc_arch_workaround_1(void *data)
>         case PSCI_CONDUIT_SMC:
>                 arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>                                   ARM_SMCCC_ARCH_WORKAROUND_1, &res);
> -               if (res.a0)
> +               if ((int)res.a0 < 0)
>                         return 0;
>                 cb = call_smc_arch_workaround_1;
>                 smccc_start = __smccc_workaround_1_smc_start;
> --
> 2.14.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

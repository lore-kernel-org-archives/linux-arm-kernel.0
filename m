From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 13 Oct 2017 09:16:52 -0500
Subject: [PATCH 2/3] arm64: cpuinfo: add human readable CPU names to
 /proc/cpuinfo
In-Reply-To: <20170926222324.17409-3-ahs3@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170926222324.17409-3-ahs3@redhat.com>
Message-ID: <CAOZdJXX6te8We+REi2uqTLdx_Vn12ezu5xjgq4m7mBGQ8TaKcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 5:23 PM, Al Stone <ahs3@redhat.com> wrote:
> In the interest of making things easier for humans to use, add a
> "CPU name" line to /proc/cpuinfo for each CPU that uses plain old
> words instead of hex values.  For example, instead of printing only
> CPU implementer 0x43 and CPU part 0x0A1, print also "CPU name :
> Cavium ThunderX".
>
> Note that this is not meant to be an exhaustive list of all possible
> implementers or CPUs (I'm not even sure that is knowable); this patch
> is intentionally limited to only those willing to provide info in
> arch/arm64/include/asm/cputype.h
>
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/cpuinfo.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index e505007138eb..0b4261884862 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -75,6 +75,61 @@ static const char *const hwcap_str[] = {
>         NULL
>  };
>
> +struct hw_part {
> +       u16     id;
> +       char    *name;

const char *name ?

> +};
> +
> +static const struct hw_part arm_hw_part[] = {
> +       { ARM_CPU_PART_AEM_V8,          "AEMv8 Model" },

AEMv8?

> +       { ARM_CPU_PART_FOUNDATION,      "Foundation Model" },
> +       { ARM_CPU_PART_CORTEX_A57,      "Cortex A57" },
> +       { ARM_CPU_PART_CORTEX_A53,      "Cortex A53" },
> +       { ARM_CPU_PART_CORTEX_A73,      "Cortex A73" },
> +       { (-1), "unknown" }             /* Potenza == 0, unfortunately */

Since Potenza is an Applied Micro CPU, why is this comment here?

> +static const struct hw_part apm_hw_part[] = {
> +       { APM_CPU_PART_POTENZA,         "Potenza" },
> +       { (-1), "unknown" }             /* Potenza == 0, unfortunately */
> +};
> +
> +static const struct hw_part brcm_hw_part[] = {
> +       { BRCM_CPU_PART_VULCAN,         "Vulcan" },
> +       { (-1), "unknown" }             /* Potenza == 0, unfortunately */
> +};
> +
> +static const struct hw_part cavium_hw_part[] = {
> +       { CAVIUM_CPU_PART_THUNDERX,      "ThunderX" },
> +       { CAVIUM_CPU_PART_THUNDERX_81XX, "ThunderX 81XX" },
> +       { CAVIUM_CPU_PART_THUNDERX_83XX, "ThunderX 83XX" },
> +       { (-1), "unknown" }             /* Potenza == 0, unfortunately */
> +};
> +
> +static const struct hw_part qcom_hw_part[] = {
> +       { QCOM_CPU_PART_FALKOR_V1,      "Falkor v1" },

I guess we should upstream our other part IDs.

> +               impl = (u8) MIDR_IMPLEMENTOR(midr);
> +               for (j = 0; hw_implementer[j].id != 0; j++) {
> +                       if (hw_implementer[j].id == impl) {
> +                               seq_printf(m, "CPU name\t: %s ",
> +                                          hw_implementer[j].name);
> +                               parts = hw_implementer[j].parts;
> +                               break;
> +                       }
> +               }
> +               if (hw_implementer[j].id == 0) {
> +                       seq_printf(m, "CPU name\t: %s ",
> +                                  hw_implementer[j].name);
> +                       parts = hw_implementer[j].parts;
> +               }

Is this intended to handle Potenza?  I don't understand why a part ID
of 0 is such a problem.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

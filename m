From: will.deacon@arm.com (Will Deacon)
Date: Tue, 08 Mar 2011 14:52:37 +0000
Subject: [PATCH v2 2/3] [ARM] perfevents: Add support for Scorpion
	performance monitors
In-Reply-To: <1299534463-25802-1-git-send-email-sheetals@codeaurora.org>
References: <1299534463-25802-1-git-send-email-sheetals@codeaurora.org>
Message-ID: <1299595957.6872.7.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello Sheetal,


On Mon, 2011-03-07 at 21:47 +0000, Sheetal Sahasrabudhe wrote:
> This commit adds support for performance monitors provided by
> Qualcomm Scorpion and ScorpionMP processor to perfevents.
> 
> Signed-off-by: Sheetal Sahasrabudhe <sheetals@codeaurora.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/perf_event.h |    2 +
>  arch/arm/kernel/perf_event.c      |   11 +
>  arch/arm/kernel/perf_event_msm.c  |  665 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 678 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/kernel/perf_event_msm.c
> 
[...]

> +static DEFINE_PER_CPU(u32, venum_orig_val);
> +static DEFINE_PER_CPU(u32, fp_orig_val);
> +
> +static void scorpion_pre_vlpm(void)
> +{
> +       u32 venum_new_val;
> +       u32 fp_new_val;
> +       /* CPACR Enable CP10 access*/
> +       asm volatile("mrc p15, 0, %0, c1, c0, 2" : "=r" (venum_orig_val));
> +       venum_new_val = venum_orig_val | 0x00100000;
> +       asm volatile("mcr p15, 0, %0, c1, c0, 2" : : "r" (venum_new_val));
> +       isb();
> +       /* Enable FPEXC */
> +       fp_orig_val = fmrx(FPEXC);
> +       fp_new_val = fp_orig_val | FPEXC_EN;
> +       fmxr(FPEXC, fp_new_val);
> +}
> +

When I looked at this originally, I thought it would be nice to have
some functions or macros for poking with the CPACR and planned to submit
that as a separate patch...

... well it turns out we already have this! Please can you update this
bit of code to use the {get,set}_copro_access functions in asm/system.h?
You can use the CPACC_SVC macro to generate the access mask too instead
of hardcoding the 0x00100000.

Cheers,

Will

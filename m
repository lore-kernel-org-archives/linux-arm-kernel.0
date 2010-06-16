From: jpihet@mvista.com (Jean Pihet)
Date: Wed, 16 Jun 2010 10:29:35 +0200
Subject: [PATCH] OMAP3: pmu: make CPU_HAS_PMU dependent on OMAP3_EMU
In-Reply-To: <1274972448-10721-1-git-send-email-will.deacon@arm.com>
References: <1274972448-10721-1-git-send-email-will.deacon@arm.com>
Message-ID: <AANLkTikIiLybBr-wV_SRWFNLkZn892gwsWHCxsIYenFJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Sorry for the late reply. Here below are the test results.
Re-sending in plain text only, sorry for the inconvenience.

On Thu, May 27, 2010 at 17:00, Will Deacon <will.deacon@arm.com> wrote:
> CPU performance event counters on v7 cores will only operate
> if either the NIDEN or DBGEN signals are driven high.
>
> For the OMAP3 platform, these signals are driven low by default [i.e.
> when a JTAG debugger is not connected] but DBGEN can be asserted in
> software by selecting the OMAP3_EMU Kconfig option, which enables the
> virtual clock for hardware debugging peripherals.
>
> This patch makes CPU_HAS_PMU depend on OMAP3_EMU for OMAP3 platforms.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jean Pihet <jpihet@mvista.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>
> Since I don't have an OMAP3 board to test this on I would appreciate
> it if somebody with some hardware could (a) confirm that this problem
> exists and (b) validate that this patch solves the issue. Thanks!
>
>  arch/arm/Kconfig |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1f254bd..98922f7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -955,7 +955,8 @@ config XSCALE_PMU
>        default y
>
>  config CPU_HAS_PMU
> -       depends on CPU_V6 || CPU_V7 || XSCALE_PMU
> +       depends on (CPU_V6 || CPU_V7 || XSCALE_PMU) && \
> +                  (!ARCH_OMAP3 || OMAP3_EMU)
>        default y
>        bool
>
> --
> 1.6.3.3
>
>

The patch nicely fixes the issue. Tested with Oprofile on OMAP3530
EVM. RETention and OFF power modes succesfully tested.

Acked-by: Jean Pihet <jpihet@mvista.com>

Regards,
Jean

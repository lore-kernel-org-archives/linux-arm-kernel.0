From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 7 Mar 2017 21:25:17 +0800
Subject: [PATCH 07/17] arm64: arch_timer: Rework the set_next_event
 workarounds
In-Reply-To: <20170306112622.13853-8-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
 <20170306112622.13853-8-marc.zyngier@arm.com>
Message-ID: <a4b24777-a0e7-bb0b-8fa7-2ebe696c8bf0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/3/6 19:26, Marc Zyngier wrote:
> The way we work around errata affecting set_next_event is not very
> nice, at it imposes this workaround on errata that do not need it.
>
> Add new workaround hooks and let the existing workarounds use them.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/arch_timer.h  |  4 ++++
>  drivers/clocksource/arm_arch_timer.c | 32 ++++++++++++++++++++++++++------
>  2 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index f841e08a0dfc..a5ed4cd2e972 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -43,6 +43,8 @@ enum arch_timer_erratum_match_type {
>  	ate_match_local_cap_id,
>  };
>
> +struct clock_event_device;
> +
>  struct arch_timer_erratum_workaround {
>  	enum arch_timer_erratum_match_type match_type;
>  	const void *id;		/* Indicate the Erratum ID */
> @@ -50,6 +52,8 @@ struct arch_timer_erratum_workaround {
>  	u32 (*read_cntp_tval_el0)(void);
>  	u32 (*read_cntv_tval_el0)(void);
>  	u64 (*read_cntvct_el0)(void);
> +	int (*set_next_event_phys)(unsigned long, struct clock_event_device *);
> +	int (*set_next_event_virt)(unsigned long, struct clock_event_device *);
>  };
>
>  extern const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround;
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 3e5f9539c0c0..ac0ddb380d3a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -282,6 +282,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
>  		.read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
>  		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
> +		.set_next_event_phys = erratum_set_next_event_tval_phys,
> +		.set_next_event_virt = erratum_set_next_event_tval_virt,
>  	},
>  #endif
>  #ifdef CONFIG_HISILICON_ERRATUM_161010101
> @@ -292,6 +294,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
>  		.read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
>  		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
> +		.set_next_event_phys = erratum_set_next_event_tval_phys,
> +		.set_next_event_virt = erratum_set_next_event_tval_virt,
>  	},
>  #endif
>  };
> @@ -384,10 +388,22 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
>  		local ? "local" : "global", wa->desc_str);
>  }
>
> +#define erratum_handler(fn, r, ...)					\
> +({									\
> +  	bool __val;		

Just noticed spaces before bool.

Thanks
Hanjun

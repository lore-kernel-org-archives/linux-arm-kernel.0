From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Mar 2017 13:51:58 +0000
Subject: [PATCH 01/17] arm64: arch_timer: Add infrastructure for multiple
 erratum detection methods
In-Reply-To: <20170306112622.13853-2-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
 <20170306112622.13853-2-marc.zyngier@arm.com>
Message-ID: <20170320135158.GC31213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 06, 2017 at 11:26:06AM +0000, Marc Zyngier wrote:
> We're currently stuck with DT when it comes to handling errata, which
> is pretty restrictive. In order to make things more flexible, let's
> introduce an infrastructure that could support alternative discovery
> methods. No change in functionnality.

Nit: functionality

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/arch_timer.h  |  7 +++-
>  drivers/clocksource/arm_arch_timer.c | 80 +++++++++++++++++++++++++++++++-----
>  2 files changed, 75 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index b4b34004a21e..1c92d52619a6 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -37,9 +37,14 @@ extern struct static_key_false arch_timer_read_ool_enabled;
>  #define needs_unstable_timer_counter_workaround()  false
>  #endif
>  
> +enum arch_timer_erratum_match_type {
> +	ate_match_dt,
> +};
>  
>  struct arch_timer_erratum_workaround {
> -	const char *id;		/* Indicate the Erratum ID */
> +	enum arch_timer_erratum_match_type match_type;
> +	const void *id;		/* Indicate the Erratum ID */

This comment isn't much help. Can we drop it?

Either that, or expand on what it is in each case, e.g.

	/*
	 * Data specific to the match_type.
	 *
	 * For ate_match_dt, this is a DT property name to look for.
	 */
	const void *id;

> +	const char *desc_str;

Elesewhere we just the name desc for strings like this.

Can we s/desc_str/desc/, please?

Thanks,
Mark.

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 3 Jun 2015 16:44:27 -0700
Subject: [PATCH 5/5] [RFC] ARM: timer-sp: Use of_clk_get_parent_count()
 instead of open coding
In-Reply-To: <1432891549-23295-6-git-send-email-geert+renesas@glider.be>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
 <1432891549-23295-6-git-send-email-geert+renesas@glider.be>
Message-ID: <20150603234426.GB490@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is an RFC, as it depends on "[RFC] clk: Provide dummy
> of_clk_get_parent_count() for !OF/!CCF".
> ---
>  arch/arm/common/timer-sp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
> index 19211324772f387c..be87a5d480ffb655 100644
> --- a/arch/arm/common/timer-sp.c
> +++ b/arch/arm/common/timer-sp.c
> @@ -21,6 +21,7 @@
>  #include <linux/clk.h>
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
> +#include <linux/clk-provider.h>

This looks weird. This is not a clock provider.

>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -234,7 +235,7 @@ static void __init sp804_of_init(struct device_node *np)
>  		clk1 = NULL;
>  
>  	/* Get the 2nd clock if the timer has 3 timer clocks */
> -	if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
> +	if (of_clk_get_parent_count(np) == 3) {

So maybe it means if we want to expose of_clk_get_parent_count()
we should move it to some other header file (of_clk.h?). And then
maybe we should always compile said helpers if OF=y and
HAVE_CLK=y.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

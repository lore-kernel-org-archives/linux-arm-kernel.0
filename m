From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Oct 2013 15:05:43 +0100
Subject: [RESEND PATCH v2 4/6] clocksource: kona: Add basic use of
 external clock
In-Reply-To: <1381960030-1640-5-git-send-email-tim.kryger@linaro.org>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
 <1381960030-1640-5-git-send-email-tim.kryger@linaro.org>
Message-ID: <20131017140542.GE24056@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 10:47:08PM +0100, Tim Kryger wrote:
> When an clock handle is specified in the device tree, enable it and use
> it to determine the external clock frequency.

I'd drop handle here and just say "When a clock is specified".

This will need a binding document update.

> 
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  drivers/clocksource/bcm_kona_timer.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
> index 0d7d8c3..fd11f96 100644
> --- a/drivers/clocksource/bcm_kona_timer.c
> +++ b/drivers/clocksource/bcm_kona_timer.c
> @@ -17,6 +17,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/clockchips.h>
>  #include <linux/types.h>
> +#include <linux/clk.h>
>  
>  #include <linux/io.h>
>  #include <asm/mach/time.h>
> @@ -107,11 +108,18 @@ static const struct of_device_id bcm_timer_ids[] __initconst = {
>  static void __init kona_timers_init(struct device_node *node)
>  {
>  	u32 freq;
> +	struct clk *external_clk;
>  
> -	if (!of_property_read_u32(node, "clock-frequency", &freq))
> +	external_clk = of_clk_get_by_name(node, NULL);

Is there only a single external clock input to the kona timer, or is
only one relevant here?

Are there any other inputs currently not modelled (e.g. regulators)?

> +
> +	if (!IS_ERR(external_clk)) {
> +		arch_timer_rate = clk_get_rate(external_clk);
> +		clk_prepare_enable(external_clk);
> +	} else if (!of_property_read_u32(node, "clock-frequency", &freq)) {
>  		arch_timer_rate = freq;
> -	else
> -		panic("clock-frequency not set in the .dts file");
> +	} else {
> +		panic("neither clock-frequency or clocks handle in .dts file");

Nit: it's not a handle, it's a phandle+args pair.

Why not just "Unable to determine clock frequency"?

Do we need to panic here? Might a system have other clocks it could use
to continue?

Thanks,
Mark.

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jul 2016 09:30:05 +0200
Subject: [PATCH 7/9] clk: sunxi-ng: mux: Add clk notifier functions
In-Reply-To: <1469516671-19377-8-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-8-git-send-email-wens@csie.org>
Message-ID: <20160727073005.GG6560@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 03:04:29PM +0800, Chen-Yu Tsai wrote:
> On sunxi we support cpufreq by changing the clock rate of PLL-CPU.
> It's possible the clock output of the PLL goes out of the CPU's
> operational limits when the PLL's multipliers / dividers are changed
> and it hasn't stabilized yet. This would result in the CPU hanging.
> 
> To circumvent this, we temporarily switch the CPU mux clock to another
> stable clock before the rate change, and switch it back after the PLL
> stabilizes. This is done with clk notifiers registered on the PLL.
> 
> This patch adds common functions for notifiers to reparent mux clocks.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/ccu_mux.c | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_mux.h | 14 ++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
> index f96eabb5d1f3..8a6e9065cb85 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -8,7 +8,9 @@
>   * the License, or (at your option) any later version.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  
>  #include "ccu_gate.h"
>  #include "ccu_mux.h"
> @@ -199,3 +201,37 @@ const struct clk_ops ccu_mux_ops = {
>  	.determine_rate	= __clk_mux_determine_rate,
>  	.recalc_rate	= ccu_mux_recalc_rate,
>  };
> +
> +/*
> + * This clock notifier is called when the frequency of the of the parent
> + * PLL clock is to be changed. The idea is to switch the parent to a
> + * stable clock, such as the main oscillator, while the PLL frequency
> + * stabilizes.
> + */
> +static int ccu_mux_notifier_cb(struct notifier_block *nb,
> +			       unsigned long event, void *data)
> +{
> +	struct ccu_mux_nb *mux = to_ccu_mux_nb(nb);
> +	int ret = 0;
> +
> +	if (event == PRE_RATE_CHANGE) {
> +		mux->original_index = ccu_mux_helper_get_parent(mux->common,
> +								mux->cm);
> +		ret = ccu_mux_helper_set_parent(mux->common, mux->cm,
> +						mux->bypass_index);
> +	} else if (event == POST_RATE_CHANGE) {
> +		ret = ccu_mux_helper_set_parent(mux->common, mux->cm,
> +						mux->original_index);
> +	}
> +
> +	udelay(mux->delay_us);

Are you sure we need that delay?

set_rate will end and notify you once the PLL rate is stable, so it
looks redundant.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160727/f8cbc9f5/attachment.sig>

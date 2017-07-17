From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jul 2017 11:17:47 +0200
Subject: [PATCH 05/11] mmc: sunxi: Support controllers that can use both
 old and new timings
In-Reply-To: <20170714064302.20383-6-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-6-wens@csie.org>
Message-ID: <20170717091747.kcrlifbp7meihszm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 14, 2017 at 02:42:56PM +0800, Chen-Yu Tsai wrote:
> On the SoCs that introduced the new timing mode for MMC controllers,
> both the old (where the clock delays are set in the CCU) and new
> (where the clock delays are set in the MMC controller) timing modes
> are available, and we have to support them both. However there are
> two bits that control which mode is active. One is in the CCU, the
> other is in the MMC controller. The settings on both sides must be
> the same, or nothing will work.
> 
> The CCU's get/set_phase callbacks return -ENOTSUPP when the new
> timing mode is active. This provides a way to know which mode is
> active on that side, and we can set the bit on the MMC controller
> side accordingly.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 0fb4e4c119e1..56e45c65b52d 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -22,6 +22,7 @@
>  #include <linux/err.h>
>  
>  #include <linux/clk.h>
> +#include <linux/clk/sunxi-ng.h>
>  #include <linux/gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> @@ -259,7 +260,7 @@ struct sunxi_mmc_cfg {
>  	/* Does DATA0 needs to be masked while the clock is updated */
>  	bool mask_data0;
>  
> -	bool needs_new_timings;
> +	bool has_new_timings;

I think we should have both, it's a bit different. Newer SoCs like the
A64 can only operate using new timings, while the older ones can
operate in both modes.

In one case, we're forced to use it, in the other one it's a
policy. We should differentiate both cases.

Looks good otherwise, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/3fff9c9f/attachment.sig>

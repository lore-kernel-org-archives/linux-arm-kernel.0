From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 17 Mar 2011 21:55:19 +0100
Subject: [PATCH V6 3/4] mmc: sdhci-esdhc: make the writel/readl as the
	general APIs
In-Reply-To: <1300343647-15735-3-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300343647-15735-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1300343647-15735-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110317205519.GA29231@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Thu, Mar 17, 2011 at 02:34:06PM +0800, Richard Zhu wrote:
> Add one flag to indicate the GPIO CD/WP is enabled or not
> on imx platforms, and reuse the writel/readl as the general
> APIs for imx SOCs.
> 
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   43 ++++++++++++++++++++++++++++++------
>  drivers/mmc/host/sdhci-pltfm.h     |    2 +-
>  2 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 3b52485..5768e06 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/gpio.h>
> +#include <linux/slab.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sdhci-pltfm.h>
>  #include <mach/hardware.h>
> @@ -24,6 +25,13 @@
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>  
> +#define IMX_GPIO_CD_WP			(1 << 0)

Hmm, that sounds like a macro for a gpio-number. What about
ESDHC_FLAG_GPIO_FOR_CD_WP or something like that?

> +
> +struct pltfm_imx_data {
> +	int flags;
> +	u32 mod_val;

Maybe 'scratchpad' was not the best name, but 'mod_val' seems worse to me.

Those are minor things, but there is one thing which needs respinning IMHO:
While it looks functionally OK, I'll tell you (once again) that you cast too
much. Please be careful about that in the future!

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110317/322ddb87/attachment.sig>

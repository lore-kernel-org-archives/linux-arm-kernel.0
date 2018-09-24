From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Sep 2018 12:17:04 -0700
Subject: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
In-Reply-To: <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
Message-ID: <a8d06d0a-b13b-384c-ade6-b0a3b0ee61f6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2018 12:04 PM, Corentin Labbe wrote:
> This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> index c5979569fd60..abcf65588576 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> @@ -23,6 +23,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/stmmac.h>
> +#include <linux/setbits.h>
>  
>  #include "stmmac_platform.h"
>  
> @@ -75,18 +76,6 @@ struct meson8b_dwmac_clk_configs {
>  	struct clk_gate		rgmii_tx_en;
>  };
>  
> -static void meson8b_dwmac_mask_bits(struct meson8b_dwmac *dwmac, u32 reg,
> -				    u32 mask, u32 value)
> -{
> -	u32 data;
> -
> -	data = readl(dwmac->regs + reg);
> -	data &= ~mask;
> -	data |= (value & mask);
> -
> -	writel(data, dwmac->regs + reg);
> -}

Why not make mseon8b_dwmac_mask_bits() a wrapper around
clrsetbits_le32() whose purpose is only to dereference dwmac->regs and
pass it to clrsetbits_le32()? That would be far less changes to review
and audit for correctness, same goes with every other patch in this
series touching the meson drivers.
-- 
Florian

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 19 Jun 2016 21:37:17 +0200
Subject: [PATCH v5 2/2] mtd: nand: sunxi: add reset line support
In-Reply-To: <20160619161435.50404-2-icenowy@aosc.xyz>
References: <20160619161435.50404-1-icenowy@aosc.xyz>
 <20160619161435.50404-2-icenowy@aosc.xyz>
Message-ID: <20160619193717.GE26668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 12:14:35AM +0800, Icenowy Zheng wrote:
> The NAND controller on some sun8i chips needs its reset line to be
> deasserted before they can enter working state.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v2:
>   - Corrected the error checking code of reset line.
> 
> Changes in v3:
>   - Corrected a more serious error brought in the "fix" of v2.
> 
> Changes in v4:
>   - Removed unneeded code block after "else".
> 
> Changes in v5:
>   - Added reassertion code in case of initialization error and device
>     remove.
> 
>  drivers/mtd/nand/sunxi_nand.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index a83a690..3b40186 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -39,6 +39,7 @@
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> +#include <linux/reset.h>
>  
>  #define NFC_REG_CTL		0x0000
>  #define NFC_REG_ST		0x0004
> @@ -269,6 +270,7 @@ struct sunxi_nfc {
>  	void __iomem *regs;
>  	struct clk *ahb_clk;
>  	struct clk *mod_clk;
> +	struct reset_control *reset;
>  	unsigned long assigned_cs;
>  	unsigned long clk_rate;
>  	struct list_head chips;
> @@ -1871,26 +1873,41 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_ahb_clk_unprepare;
>  
> +	nfc->reset = devm_reset_control_get_optional(dev, "ahb");
> +
> +	if (!IS_ERR(nfc->reset)) {
> +		ret = reset_control_deassert(nfc->reset);
> +		if (ret) {
> +			dev_err(dev, "reset err %d\n", ret);
> +			goto out_mod_clk_unprepare;
> +		}
> +	} else if (PTR_ERR(nfc->reset) != -ENOENT) {
> +		return PTR_ERR(nfc->reset);

You're leaking all the resources here. Please use a goto.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160619/15675bec/attachment-0001.sig>

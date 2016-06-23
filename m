From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 23 Jun 2016 18:01:08 +0200
Subject: [PATCH v6 2/2] mtd: nand: sunxi: add reset line support
In-Reply-To: <20160620044838.56904-2-icenowy@aosc.xyz>
References: <20160620044838.56904-1-icenowy@aosc.xyz>
 <20160620044838.56904-2-icenowy@aosc.xyz>
Message-ID: <20160623180108.382bbaae@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2016 12:48:38 +0800
Icenowy Zheng <icenowy@aosc.xyz> wrote:

> The NAND controller on some sun8i chips needs its reset line to be
> deasserted before they can enter working state.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  ?Changes in v2:
>  ???- Corrected the error checking code of reset line.
> 
>  ?Changes in v3:
>  ???- Corrected a more serious error brought in the "fix" of v2.
> 
>  ?Changes in v4:
>  ???- Removed unneeded code block after "else".
> 
>  ?Changes in v5:
>  ???- Added reassertion code in case of initialization error and device
>  ?????remove.
> 
>   Changes in v6:
>     - Fixed a resource leak by not using goto to exit in case of error.
> 
>  drivers/mtd/nand/sunxi_nand.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index a83a690..08d5e88 100644
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
> @@ -1871,26 +1873,42 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
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
> +		ret = PTR_ERR(nfc->reset);

You should return -EDEFER_PROBE here.

And can you please rebase this series on top of nand/next [1]?

[1]https://github.com/linux-nand/linux/tree/nand/next

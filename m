From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Apr 2014 14:46:43 +0200
Subject: [PATCH v2 4/5] pinctrl: sunxi: add reset control support
In-Reply-To: <1397132747-13917-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397132747-13917-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140410124643.GS28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 02:25:46PM +0200, Boris BREZILLON wrote:
> The A31 SoC define a reset line for the R_PIO block which needs to be
> deasserted for the pin controller to be usable.
> 
> Try to retrieve a reset line and deassert if one was found.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/pinctrl/pinctrl-sunxi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
> index ee62027..b752495 100644
> --- a/drivers/pinctrl/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/pinctrl-sunxi.c
> @@ -26,6 +26,7 @@
>  #include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/pinctrl/pinmux.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  
>  #include "core.h"
> @@ -792,6 +793,7 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
>  	const struct of_device_id *device;
>  	struct pinctrl_pin_desc *pins;
>  	struct sunxi_pinctrl *pctl;
> +	struct reset_control *rstc;
>  	int i, ret, last_pin;
>  	struct clk *clk;
>  
> @@ -885,6 +887,13 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
>  
>  	clk_prepare_enable(clk);
>  
> +	rstc = devm_reset_control_get(&pdev->dev, NULL);

You should use devm_reset_control_get_optional here.

> +	if (!IS_ERR(rstc)) {
> +		ret = reset_control_deassert(rstc);
> +		if (ret)
> +			goto gpiochip_error;
> +	}
> +

It would be good to put back the device in reset if probe fails later
on.

Thanks
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/7fe806cf/attachment-0001.sig>

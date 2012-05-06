From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 6 May 2012 21:47:17 +0800
Subject: [PATCH 1/5] tty: serial: imx: adopt pinctrl API
In-Reply-To: <1336309094-18517-2-git-send-email-shawn.guo@linaro.org>
References: <1336309094-18517-1-git-send-email-shawn.guo@linaro.org>
 <1336309094-18517-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120506134715.GB19389@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2012 at 08:58:10PM +0800, Shawn Guo wrote:
> Cc: Greg Kroah-Hartman <gregkh@suse.de>

Corrected to "Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>".

Regards,
Shawn

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/tty/serial/imx.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index e7fecee..ec20673 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -47,6 +47,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <asm/io.h>
>  #include <asm/irq.h>
> @@ -1464,6 +1465,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	int ret = 0;
>  	struct resource *res;
> +	struct pinctrl *pinctrl;
>  
>  	sport = kzalloc(sizeof(*sport), GFP_KERNEL);
>  	if (!sport)
> @@ -1503,6 +1505,12 @@ static int serial_imx_probe(struct platform_device *pdev)
>  	sport->timer.function = imx_timeout;
>  	sport->timer.data     = (unsigned long)sport;
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl)) {
> +		ret = PTR_ERR(pinctrl);
> +		goto unmap;
> +	}
> +
>  	sport->clk = clk_get(&pdev->dev, "uart");
>  	if (IS_ERR(sport->clk)) {
>  		ret = PTR_ERR(sport->clk);
> -- 
> 1.7.5.4
> 

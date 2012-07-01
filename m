From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 02 Jul 2012 00:49:37 +0200
Subject: [PATCH RESEND 3/5] can: flexcan: adopt pinctrl support
In-Reply-To: <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
 <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <4FF0D401.4050101@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2012 02:53 AM, Shawn Guo wrote:
> Cc: linux-can at vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/net/can/flexcan.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 1efb083..38c0690 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -35,6 +35,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #define DRV_NAME			"flexcan"
>  
> @@ -927,11 +928,16 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
>  	struct flexcan_priv *priv;
>  	struct resource *mem;
>  	struct clk *clk = NULL;
> +	struct pinctrl *pinctrl;
>  	void __iomem *base;
>  	resource_size_t mem_size;
>  	int err, irq;
>  	u32 clock_freq = 0;
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		return PTR_ERR(pinctrl);
> +
>  	if (pdev->dev.of_node) {
>  		const u32 *clock_freq_p;

I'm on mx28 and trying to load the flexcan driver via DT, but
devm_pinctrl_get_select_default fails with -19.

What am I doing wrong? Will this fail with the same error on non DT
platforms?

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/bf197aab/attachment.sig>

From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 11 Jun 2010 11:35:20 +0200
Subject: [PATCH 01/11] USB: s3c_hsotg: Add support for external USB clock
In-Reply-To: <1276244457-4072-2-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
	<1276244457-4072-2-git-send-email-ben-linux@fluff.org>
Message-ID: <006a01cb0949$6c7e7300$457b5900$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, June 11, 2010 10:21 AM Ben Dooks wrote:

> From: Maurus Cuelenaere <mcuelenaere@gmail.com>
> 
> The PLL that drives the USB clock supports 3 input clocks: 12, 24 and 48Mhz.
> This patch adds support to the USB driver for setting the correct register
> bit
> according to the given clock.
> 
> This depends on the following patch:
> [PATCH] ARM: S3C64XX: Add USB external clock definition
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/usb/gadget/s3c-hsotg.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-
> hsotg.c
> index 26193ec..6a303ce 100644
> --- a/drivers/usb/gadget/s3c-hsotg.c
> +++ b/drivers/usb/gadget/s3c-hsotg.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/clk.h>
> 
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> @@ -2753,6 +2754,7 @@ static void __devinit s3c_hsotg_initep(struct
> s3c_hsotg *hsotg,
>   */
>  static void s3c_hsotg_otgreset(struct s3c_hsotg *hsotg)
>  {
> +	struct clk *xusbxti;
>  	u32 osc;
> 
>  	writel(0, S3C_PHYPWR);
> @@ -2760,6 +2762,23 @@ static void s3c_hsotg_otgreset(struct s3c_hsotg
> *hsotg)
> 
>  	osc = hsotg->plat->is_osc ? S3C_PHYCLK_EXT_OSC : 0;
> 
> +	xusbxti = clk_get(hsotg->dev, "xusbxti");
> +	if (xusbxti && !IS_ERR(xusbxti)) {
> +		switch (clk_get_rate(xusbxti)) {
> +		case 12000000:
> +		    osc |= S3C_PHYCLK_CLKSEL_12M;
> +		    break;
> +		case 24000000:
> +		    osc |= S3C_PHYCLK_CLKSEL_24M;
> +		    break;
> +		default:
> +		case 48000000:
> +		    /* default reference clock */
> +		    break;

One quick style issue: there is some tabs-vs-spaces mess in the above
code.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center

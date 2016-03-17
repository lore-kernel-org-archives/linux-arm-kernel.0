From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 17 Mar 2016 16:11:37 +0300
Subject: [PATCH v2 11/11] usb: musb: da8xx: Remove mach code
In-Reply-To: <1458181615-27782-12-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-12-git-send-email-david@lechnology.com>
Message-ID: <56EAAD09.3080600@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2016 5:26 AM, David Lechner wrote:

> Use the new phy-da8xx-usb driver to take the place of the mach code that
> pokes CFGCHIP2 in the da8xx musb glue driver.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>
> v2 changes: This is part of a previous patch that was split. This version uses
> the new phy driver instead of a second clock. It also gets rid of more mach
> code.
>
>
>   drivers/usb/musb/da8xx.c | 126 ++++++++++++-----------------------------------
>   1 file changed, 31 insertions(+), 95 deletions(-)
>
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index 50f07a5..1d51711 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -30,13 +30,11 @@
>   #include <linux/clk.h>
>   #include <linux/err.h>
>   #include <linux/io.h>
> +#include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/usb/usb_phy_generic.h>
>
> -#include <mach/da8xx.h>
> -#include <linux/platform_data/usb-davinci.h>

    I guess we can move this header back into mach/ now?

[...]
> @@ -383,31 +335,18 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
>   	return ret;
>   }
>
> +extern int da8xx_usb20_phy_set_mode(struct phy *phy, enum musb_mode mode);
> +

    You now need to select your new PHY driver since otherwise the kernel 
won't build.
    You can remove "depends on BROKEN" as well since your patch is un-breaking 
it. :-)

[...]
> @@ -425,19 +364,24 @@ static int da8xx_musb_init(struct musb *musb)
[...]
>   	/* Start the on-chip PHY and its PLL. */
> -	phy_on();
> +	phy_power_on(glue->phy);

    What about phy_init()?

> @@ -448,9 +392,12 @@ fail:
>
>   static int da8xx_musb_exit(struct musb *musb)
>   {
> +	struct da8xx_glue *glue = dev_get_drvdata(musb->controller->parent);
> +
>   	del_timer_sync(&otg_workaround);
>
> -	phy_off();
> +	phy_power_off(glue->phy);

    phy_exit()?

[...]
> @@ -503,19 +450,19 @@ static int da8xx_probe(struct platform_device *pdev)
[...]
>
>   	glue->dev			= &pdev->dev;
>   	pdata->platform_ops		= &da8xx_ops;
>
> -	glue->phy = usb_phy_generic_register();
> -	if (IS_ERR(glue->phy)) {
> -		ret = PTR_ERR(glue->phy);
> -		goto err5;
> +	glue->usb_phy = usb_phy_generic_register();

    Hm, do we still need the USB PHY? It does nothing IIRC...

[...]

MBR, Sergei

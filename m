From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 10 Jan 2013 21:06:28 +0300
Subject: [PATCH 04/14] usb: phy: nop: Handle power supply regulator for
 the PHY
In-Reply-To: <1357836694-30788-5-git-send-email-rogerq@ti.com>
References: <1357836694-30788-1-git-send-email-rogerq@ti.com>
 <1357836694-30788-5-git-send-email-rogerq@ti.com>
Message-ID: <50EF0324.9060004@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/10/2013 07:51 PM, Roger Quadros wrote:

> We use "vcc" as the supply name for the PHY's power supply.
> The power supply will be enabled during .init() and disabled
> during .shutdown()

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/otg/nop-usb-xceiv.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)

> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
> index 163f972..1c6db10 100644
> --- a/drivers/usb/otg/nop-usb-xceiv.c
> +++ b/drivers/usb/otg/nop-usb-xceiv.c
[...]
> @@ -70,6 +72,11 @@ static int nop_init(struct usb_phy *phy)
>  {
>  	struct nop_usb_xceiv *nop = dev_get_drvdata(phy->dev);
>  
> +	if (nop->vcc) {
> +		if (regulator_enable(nop->vcc))
> +			dev_err(phy->dev, "Failed to enable power\n");
> +	}

   Could be collapsed into single *if*.

> +
>  	if (nop->clk)
>  		clk_enable(nop->clk);
>  
> @@ -82,6 +89,11 @@ static void nop_shutdown(struct usb_phy *phy)
>  
>  	if (nop->clk)
>  		clk_disable(nop->clk);
> +
> +	if (nop->vcc) {
> +		if (regulator_disable(nop->vcc))
> +			dev_err(phy->dev, "Failed to disable power\n");
> +	}

   Same here.

WBR, Sergei

From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 05 Feb 2013 15:45:12 +0400
Subject: [PATCH 9/9] USB chipidea i.MX: use devm_usb_get_phy_by_phandle
 to get phy
In-Reply-To: <1359984275-24646-10-git-send-email-s.hauer@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-10-git-send-email-s.hauer@pengutronix.de>
Message-ID: <5110F0C8.7040408@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-02-2013 17:24, Sascha Hauer wrote:

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   drivers/usb/chipidea/ci13xxx_imx.c |   39 +++++++++++++++++-------------------
>   1 file changed, 18 insertions(+), 21 deletions(-)

> diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> index b598bb8f..136869b 100644
> --- a/drivers/usb/chipidea/ci13xxx_imx.c
> +++ b/drivers/usb/chipidea/ci13xxx_imx.c
[...]
> @@ -147,19 +146,21 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>
> +	phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
> +

    No need for emoty line here. Keep the style as it was please.

> +	if (PTR_ERR(phy) == -EPROBE_DEFER) {

    Is it valid to call PTR_ERR() on non-error pointer? Isn't it better to do 
this check under *else* clause below the next *if*.

> +		ret = -EPROBE_DEFER;
> +		goto err_clk;
> +	}
> +

    This empty line is also not needed, I think.

> +	if (!IS_ERR(phy)) {
> +		ret = usb_phy_init(phy);
> +		if (ret) {
> +			dev_err(&pdev->dev, "unable to init phy: %d\n", ret);
> +			goto err_clk;
>   		}
> +
> +		data->phy = phy;
>   	}
>
>   	/* we only support host now, so enable vbus here */

WBR, Sergei

From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Mar 2013 12:11:46 +0200
Subject: [PATCH v11 8/9] usb: chipidea: imx: add getting vbus regulator
 code
In-Reply-To: <1362563800-16673-9-git-send-email-peter.chen@freescale.com>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-9-git-send-email-peter.chen@freescale.com>
Message-ID: <20130306101146.GM28587@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 06, 2013 at 05:56:39PM +0800, Peter Chen wrote:
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/chipidea/ci13xxx_imx.c |   28 +++++-----------------------
>  1 files changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> index 3ed119e..b2d8350 100644
> --- a/drivers/usb/chipidea/ci13xxx_imx.c
> +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> @@ -33,7 +33,6 @@ struct ci13xxx_imx_data {
>  	struct usb_phy *phy;
>  	struct platform_device *ci_pdev;
>  	struct clk *clk;
> -	struct regulator *reg_vbus;
>  };
>  
>  static const struct usbmisc_ops *usbmisc_ops;
> @@ -163,20 +162,9 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
>  		data->phy = phy;
>  	}
>  
> -	/* we only support host now, so enable vbus here */
>  	reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> -	if (!IS_ERR(reg_vbus)) {
> -		ret = regulator_enable(reg_vbus);
> -		if (ret) {
> -			dev_err(&pdev->dev,
> -				"Failed to enable vbus regulator, err=%d\n",
> -				ret);
> -			goto err_clk;
> -		}
> -		data->reg_vbus = reg_vbus;
> -	} else {
> -		reg_vbus = NULL;
> -	}
> +	if (!IS_ERR(reg_vbus))
> +		pdata->reg_vbus = reg_vbus;

what you're doing here is wrong. chipidea core should be the one calling
devm_regulator_get().

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/14b1c271/attachment.sig>

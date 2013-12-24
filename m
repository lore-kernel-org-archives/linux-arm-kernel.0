From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Dec 2013 10:08:28 +0800
Subject: [PATCH v7 10/14] usb: phy-mxs: add controller id
In-Reply-To: <1387525930-27313-11-git-send-email-peter.chen@freescale.com>
References: <1387525930-27313-1-git-send-email-peter.chen@freescale.com>
 <1387525930-27313-11-git-send-email-peter.chen@freescale.com>
Message-ID: <20131224020826.GC1128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 03:52:06PM +0800, Peter Chen wrote:
> It is used to access un-regulator registers according to
> different controllers.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index f28bdd8..09ece2b 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -111,6 +111,7 @@ struct mxs_phy {
>  	struct clk *clk;
>  	const struct mxs_phy_data *data;
>  	struct regmap *regmap_anatop;
> +	int port_id;
>  };
>  
>  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> @@ -237,6 +238,13 @@ static int mxs_phy_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	ret = of_alias_get_id(np, "usbphy");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> +		return ret;
> +	}

It has the same compatibility issue with an old DTB.  In case the alias
is not found, we should keep driver work in the existing way rather than
failing out.

Shawn

> +	mxs_phy->port_id = ret;
> +
>  	mxs_phy->phy.io_priv		= base;
>  	mxs_phy->phy.dev		= &pdev->dev;
>  	mxs_phy->phy.label		= DRIVER_NAME;
> -- 
> 1.7.8
> 
> 

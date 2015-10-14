From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 14 Oct 2015 10:07:59 +0200
Subject: [PATCH v4 2/2] usb: chipidea: imx: refine clock operations to
 adapt for all platforms
In-Reply-To: <1444787859-31509-1-git-send-email-peter.chen@freescale.com>
References: <1444787859-31509-1-git-send-email-peter.chen@freescale.com>
Message-ID: <561E0D5F.8030003@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 03:57 AM, Peter Chen wrote:
> Some i.mx platforms need three clocks to let controller work, but
> others only need one, refine clock operation to adapt for all
> platforms, it fixes a regression found at i.mx27.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: <stable@vger.kernel.org> #v4.1+
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 132 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 114 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 6ccbf60..82b1dfe 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -84,6 +84,12 @@ struct ci_hdrc_imx_data {
>  	struct imx_usbmisc_data *usbmisc_data;
>  	bool supports_runtime_pm;
>  	bool in_lpm;
> +	/* SoC before i.mx6 (except imx23/imx28) needs three clks */
> +	bool need_three_clks;
> +	struct clk *clk_ipg;
> +	struct clk *clk_ahb;
> +	struct clk *clk_per;
> +	/* --------------------------------- */
>  };
>  
>  /* Common functions shared by usbmisc drivers */
> @@ -135,6 +141,103 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
>  }
>  
>  /* End of common functions shared by usbmisc drivers*/
> +static int imx_get_clks(struct device *dev)
> +{
> +	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	data->clk_ipg = devm_clk_get(dev, "ipg");
> +	if (IS_ERR(data->clk_ipg)) {
> +		/* If the platform only needs one clocks */
> +		data->clk = devm_clk_get(dev, NULL);
> +		if (IS_ERR(data->clk)) {
> +			ret = PTR_ERR(data->clk);
> +			dev_err(dev,
> +				"Failed to get clock, err=%d\n", ret);
> +			dev_err(dev,
> +				"Failed to get ipg clock, err=%d\n", ret);

Nitpick, one error message should be enough.

> +			return ret;
> +		}
> +		return ret;
> +	}
> +
> +	data->clk_ahb = devm_clk_get(dev, "ahb");
> +	if (IS_ERR(data->clk_ahb)) {
> +		ret = PTR_ERR(data->clk_ahb);
> +		dev_err(dev,
> +			"Failed to get ahb clock, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	data->clk_per = devm_clk_get(dev, "per");
> +	if (IS_ERR(data->clk_per)) {
> +		ret = PTR_ERR(data->clk_per);
> +		dev_err(dev,
> +			"Failed to get per clock, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	data->need_three_clks = true;
> +	return ret;
> +}
> +
> +static int imx_prepare_enable_clks(struct device *dev)
> +{
> +	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (data->need_three_clks) {
> +		ret = clk_prepare_enable(data->clk_ipg);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to prepare/enable ipg clk, err=%d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		ret = clk_prepare_enable(data->clk_ahb);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to prepare/enable ahb clk, err=%d\n",
> +				ret);
> +			clk_disable_unprepare(data->clk_ipg);
> +			return ret;
> +		}
> +
> +		ret = clk_prepare_enable(data->clk_per);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to prepare/enable per clk, err=%d\n",
> +				ret);
> +			clk_disable_unprepare(data->clk_ahb);
> +			clk_disable_unprepare(data->clk_ipg);
> +			return ret;
> +		}
> +	} else {
> +		ret = clk_prepare_enable(data->clk);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to prepare/enable clk, err=%d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void imx_disable_unprepare_clks(struct device *dev)
> +{
> +	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
> +
> +	if (data->need_three_clks) {
> +		clk_disable_unprepare(data->clk_per);
> +		clk_disable_unprepare(data->clk_ipg);
> +		clk_disable_unprepare(data->clk_ahb);

nit: you enable in this order: ipg, ahb, per. Disabling should be inverse.

> +	} else {
> +		clk_disable_unprepare(data->clk);
> +	}
> +}

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
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151014/fc7695f3/attachment-0001.sig>

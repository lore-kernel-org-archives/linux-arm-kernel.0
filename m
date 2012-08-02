From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 2 Aug 2012 14:20:34 -0600 (MDT)
Subject: [PATCH 1/2] net: davinci_mdio: enable and disable clock
In-Reply-To: <1343936616-29318-1-git-send-email-zonque@gmail.com>
References: <1343936616-29318-1-git-send-email-zonque@gmail.com>
Message-ID: <alpine.DEB.2.00.1208021416550.18867@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 2 Aug 2012, Daniel Mack wrote:

> Make the driver control the device clocks. Appearantly, the Davinci
> platform probes this driver with the clock all powered up, but on OMAP,
> this isn't the case.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

> ---
>  drivers/net/ethernet/ti/davinci_mdio.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> index cd7ee20..b4b6015 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -332,6 +332,8 @@ static int __devinit davinci_mdio_probe(struct platform_device *pdev)
>  		goto bail_out;
>  	}
>  
> +	clk_enable(data->clk);
> +

This doesn't look right.  This clock should be enabled by the
pm_runtime_get_sync() call just above this.  It shouldn't be necessary
to enable it again unless something isn't right with the integration
data. Likewise the pm_runtime_put_sync() calls should be superfluous.

What hwmod data/device tree file are you using with this?


- Paul

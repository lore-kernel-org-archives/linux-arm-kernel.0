From: jason@lakedaemon.net (Jason)
Date: Tue, 6 Mar 2012 14:01:39 -0500
Subject: [RFC 09/14] MV SATA: Add per channel clk/clkdev support.
In-Reply-To: <1331015471-28872-10-git-send-email-andrew@lunn.ch>
References: <1331015471-28872-1-git-send-email-andrew@lunn.ch>
 <1331015471-28872-10-git-send-email-andrew@lunn.ch>
Message-ID: <20120306190139.GW5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 07:31:05AM +0100, Andrew Lunn wrote:
> The Orion kirkwood chips have a gatable clock per SATA channel. Add
> code to get and enable this clk if it exists.
> 
> Signed-of-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-kirkwood/common.c           |    3 ++
>  arch/arm/plat-orion/common.c              |    4 +-
>  arch/arm/plat-orion/include/plat/common.h |    3 ++
>  drivers/ata/sata_mv.c                     |   43 +++++++++++++++++++++++++---
>  4 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 7588812..855540a 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -244,6 +244,9 @@ void __init kirkwood_sata_init(struct mv_sata_platform_data *sata_data)
>  	if (sata_data->n_ports > 1)
>  		kirkwood_clk_ctrl |= CGC_SATA1;
>  
> +	orion_clkdev_add("0", "sata_mv.0", &clk_sata0);
> +	orion_clkdev_add("1", "sata_mv.0", &clk_sata1);
> +

This is a problem for devicetree.  With devicetree, neither
kirkwood_sata_init(), nor orion_sata_init() are ever called.  The same
is true for all the other drivers as well.

Could this be moved into the driver's _probe() function?

thx,

Jason.

>  	orion_sata_init(sata_data, SATA_PHYS_BASE, IRQ_KIRKWOOD_SATA);
>  }
>  
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index 05f078a..06f1e7a 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -23,8 +23,8 @@
>  #include <plat/ehci-orion.h>
>  
>  /* Create a clkdev entry for a given device/clk */
> -static void orion_clkdev_add(const char *con_id, const char *dev_id,
> -			     struct clk *clk)
> +void orion_clkdev_add(const char *con_id, const char *dev_id,
> +		      struct clk *clk)
>  {
>  	struct clk_lookup *cl;
>  
> diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
> index a70976e..b739343 100644
> --- a/arch/arm/plat-orion/include/plat/common.h
> +++ b/arch/arm/plat-orion/include/plat/common.h
> @@ -107,4 +107,7 @@ void __init orion_crypto_init(unsigned long mapbase,
>  			      unsigned long srambase,
>  			      unsigned long sram_size,
>  			      unsigned long irq);
> +
> +void orion_clkdev_add(const char *con_id, const char *dev_id,
> +		      struct clk *clk);
>  #endif
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 38950ea..0f4a7e9 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -553,6 +553,7 @@ struct mv_host_priv {
>  
>  #if defined(CONFIG_HAVE_CLK)
>  	struct clk		*clk;
> +	struct clk              **port_clks;
>  #endif
>  	/*
>  	 * These consistent DMA memory pools give us guaranteed
> @@ -4026,6 +4027,9 @@ static int mv_platform_probe(struct platform_device *pdev)
>  	struct mv_host_priv *hpriv;
>  	struct resource *res;
>  	int n_ports, rc;
> +#if defined(CONFIG_HAVE_CLK)
> +	int port;
> +#endif
>  
>  	ata_print_version_once(&pdev->dev, DRV_VERSION);
>  
> @@ -4053,6 +4057,13 @@ static int mv_platform_probe(struct platform_device *pdev)
>  
>  	if (!host || !hpriv)
>  		return -ENOMEM;
> +#if defined(CONFIG_HAVE_CLK)
> +	hpriv->port_clks = devm_kzalloc(&pdev->dev,
> +					sizeof(struct clk *) * n_ports,
> +					GFP_KERNEL);
> +	if (!hpriv->port_clks)
> +		return -ENOMEM;
> +#endif
>  	host->private_data = hpriv;
>  	hpriv->n_ports = n_ports;
>  	hpriv->board_idx = chip_soc;
> @@ -4065,9 +4076,18 @@ static int mv_platform_probe(struct platform_device *pdev)
>  #if defined(CONFIG_HAVE_CLK)
>  	hpriv->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(hpriv->clk))
> -		dev_notice(&pdev->dev, "cannot get clkdev\n");
> -	else
> -		clk_enable(hpriv->clk);
> +		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
> +	else {
> +		clk_prepare_enable(hpriv->clk);
> +	}
> +	for (port = 0; port < n_ports; port++) {
> +		char port_number[16];
> +		sprintf(port_number, "%d", port);
> +		hpriv->port_clks[port] = clk_get(&pdev->dev, port_number);
> +		if (!IS_ERR(hpriv->port_clks[port])) {
> +			clk_prepare_enable(hpriv->port_clks[port]);
> +		}
> +	}
>  #endif
>  
>  	/*
> @@ -4097,9 +4117,15 @@ static int mv_platform_probe(struct platform_device *pdev)
>  err:
>  #if defined(CONFIG_HAVE_CLK)
>  	if (!IS_ERR(hpriv->clk)) {
> -		clk_disable(hpriv->clk);
> +		clk_disable_unprepare(hpriv->clk);
>  		clk_put(hpriv->clk);
>  	}
> +	for (port = 0; port < n_ports; port++) {
> +		if (!IS_ERR(hpriv->port_clks[port])) {
> +			clk_disable_unprepare(hpriv->port_clks[port]);
> +			clk_put(hpriv->port_clks[port]);
> +		}
> +	}
>  #endif
>  
>  	return rc;
> @@ -4118,14 +4144,21 @@ static int __devexit mv_platform_remove(struct platform_device *pdev)
>  	struct ata_host *host = platform_get_drvdata(pdev);
>  #if defined(CONFIG_HAVE_CLK)
>  	struct mv_host_priv *hpriv = host->private_data;
> +	int port;
>  #endif
>  	ata_host_detach(host);
>  
>  #if defined(CONFIG_HAVE_CLK)
>  	if (!IS_ERR(hpriv->clk)) {
> -		clk_disable(hpriv->clk);
> +		clk_disable_unprepare(hpriv->clk);
>  		clk_put(hpriv->clk);
>  	}
> +	for (port = 0; port < host->n_ports; port++) {
> +		if (!IS_ERR(hpriv->port_clks[port])) {
> +			clk_disable_unprepare(hpriv->port_clks[port]);
> +			clk_put(hpriv->port_clks[port]);
> +		}
> +	}
>  #endif
>  	return 0;
>  }
> -- 
> 1.7.9.1
> 

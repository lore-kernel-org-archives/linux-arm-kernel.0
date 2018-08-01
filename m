From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 1 Aug 2018 11:40:33 -0700
Subject: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2018 10:56 AM, Arun Parameswaran wrote:
> Add support to configure the internal rate adjust register based on the
> core clock supplied through device tree in the Broadcom iProc mdio mux.
> 
> The operating frequency of the mdio mux block is 11MHz. This is derrived
> by dividing the clock to the mdio mux with the rate adjust register.
> 
> In some SoC's the default values of the rate adjust register do not yield
> 11MHz. These SoC's are required to specify the clock via the device tree
> for proper operation.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---

[snip]

>  static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
> @@ -204,6 +225,20 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(md->core_clk)) {
> +		if (PTR_ERR(md->core_clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		md->core_clk = NULL;

I would simplify this a bit:

	if (IS_ERR(md->core_clk) && PTR_ERR(md->core_clk) == -EPROBE_DEFER)
		return PTR_ERR(md->core_clk);
	else
		md->core_clk = NULL;

	rc = clk_prepare_enable(md->core_clk);

and continue that way.

> +	} else {
> +		rc = clk_prepare_enable(md->core_clk);
> +		if (rc) {
> +			dev_err(&pdev->dev, "failed to enable core clk\n");
> +			return rc;
> +		}
> +	}
> +
>  	bus = md->mii_bus;
>  	bus->priv = md;
>  	bus->name = "iProc MDIO mux bus";
> @@ -217,7 +252,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  	rc = mdiobus_register(bus);
>  	if (rc) {
>  		dev_err(&pdev->dev, "mdiomux registration failed\n");
> -		return rc;
> +		goto out_clk;
>  	}
>  
>  	platform_set_drvdata(pdev, md);
> @@ -237,6 +272,8 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  
>  out_register:
>  	mdiobus_unregister(bus);
> +out_clk:
> +	clk_disable_unprepare(md->core_clk);
>  	return rc;
>  }
>  
> @@ -246,6 +283,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
>  
>  	mdio_mux_uninit(md->mux_handle);
>  	mdiobus_unregister(md->mii_bus);
> +	clk_disable_unprepare(md->core_clk);
>  	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
> 


-- 
Florian

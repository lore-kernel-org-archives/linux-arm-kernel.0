From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Jul 2018 23:22:24 +0200
Subject: [PATCH v2 6/7] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180728212224.GF4792@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -198,10 +219,22 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  		return PTR_ERR(md->base);
>  	}
>  
> +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(md->core_clk)) {
> +		md->core_clk = NULL;
> +	} else {
> +		rc = clk_prepare_enable(md->core_clk);
> +		if (rc) {
> +			dev_err(&pdev->dev, "failed to enable core clk\n");
> +			return rc;
> +		}
> +	}
> +
>  	md->mii_bus = mdiobus_alloc();
>  	if (!md->mii_bus) {
>  		dev_err(&pdev->dev, "mdiomux bus alloc failed\n");
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto out;

Hi Arun

There is a devm_mdiobus_alloc() which could make the cleanup on error
simple.

>  	}
>  
>  	bus = md->mii_bus;
> @@ -217,7 +250,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  	rc = mdiobus_register(bus);
>  	if (rc) {
>  		dev_err(&pdev->dev, "mdiomux registration failed\n");
> -		goto out;
> +		goto out_alloc;
>  	}
>  
>  	platform_set_drvdata(pdev, md);
> @@ -236,8 +269,11 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  
>  out_register:
>  	mdiobus_unregister(bus);
> -out:
> +out_alloc:
>  	mdiobus_free(bus);
> +out:
> +	if (md->core_clk)
> +		clk_disable_unprepare(md->core_clk);
>  	return rc;
>  }

   Andrew

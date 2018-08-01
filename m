From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 1 Aug 2018 11:37:56 -0700
Subject: [PATCH v3 5/8] net: phy: Use devm api for mdio bus allocation in
 bcm iproc mdio mux
In-Reply-To: <1533146186-8374-6-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-6-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <e1adee03-3ee0-300c-af3e-32e52ef2965d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2018 10:56 AM, Arun Parameswaran wrote:
> Use devm_mdiobus_alloc() instead of mdiobus_alloc() in the Broadcom
> iProc mdio mux driver.
> 
> Also, clear the driver data on error from probe or when remove() is
> called.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  drivers/net/phy/mdio-mux-bcm-iproc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
> index c36ce4b..5640d78 100644
> --- a/drivers/net/phy/mdio-mux-bcm-iproc.c
> +++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
> @@ -198,7 +198,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  		return PTR_ERR(md->base);
>  	}
>  
> -	md->mii_bus = mdiobus_alloc();
> +	md->mii_bus = devm_mdiobus_alloc(&pdev->dev);
>  	if (!md->mii_bus) {
>  		dev_err(&pdev->dev, "mdiomux bus alloc failed\n");
>  		return -ENOMEM;
> @@ -217,7 +217,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  	rc = mdiobus_register(bus);
>  	if (rc) {
>  		dev_err(&pdev->dev, "mdiomux registration failed\n");
> -		goto out;
> +		return rc;
>  	}
>  
>  	platform_set_drvdata(pdev, md);
> @@ -226,6 +226,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  			   &md->mux_handle, md, md->mii_bus);
>  	if (rc) {
>  		dev_info(md->dev, "mdiomux initialization failed\n");
> +		platform_set_drvdata(pdev, NULL);

This is minor, but I don't think this is necessary, the core device
driver layer does that already.

>  		goto out_register;
>  	}
>  
> @@ -236,8 +237,6 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  
>  out_register:
>  	mdiobus_unregister(bus);
> -out:
> -	mdiobus_free(bus);
>  	return rc;
>  }
>  
> @@ -247,7 +246,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
>  
>  	mdio_mux_uninit(md->mux_handle);
>  	mdiobus_unregister(md->mii_bus);
> -	mdiobus_free(md->mii_bus);
> +	platform_set_drvdata(pdev, NULL);

Likewise.

>  
>  	return 0;
>  }
> 


-- 
Florian

From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Dec 2011 10:42:43 -0600
Subject: [PATCH v3 02/11] i2c: OMAP: Add DT support for i2c controller
In-Reply-To: <1324398444-23296-3-git-send-email-b-cousson@ti.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
 <1324398444-23296-3-git-send-email-b-cousson@ti.com>
Message-ID: <4EF0BB03.6040906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2011 10:27 AM, Benoit Cousson wrote:
> Add initial DT support to retrieve the frequency using a
> DT attribute instead of the pdata pointer if of_node exist.
> 
> Add documentation for omap i2c controller binding.
> 
> Based on original patches from Manju and Grant.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kevin Hilman <khilman@ti.com>

One issue below, otherwise:

Reviewed-by: Rob Herring <rob.herring@calxeda.com>


> @@ -1001,15 +1019,24 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_release_region;
>  	}
>  
> -	if (pdata != NULL) {
> -		speed = pdata->clkrate;
> +	match = of_match_device(omap_i2c_of_match, &pdev->dev);
> +	if (match) {
> +		u32 freq = 100000; /* default to 100000 Hz */
> +
> +		pdata = match->data;
> +		dev->dtrev = pdata->rev;
> +		dev->flags = pdata->flags;
> +
> +		of_property_read_u32(node, "clock-frequency", &freq);
> +		/* convert DT freq value in Hz into kHz for speed */
> +		dev->speed = freq / 1000;
> +	} else if (pdata != NULL) {
> +		dev->speed = pdata->clkrate;
> +		dev->flags = pdata->flags;
>  		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> -	} else {
> -		speed = 100;	/* Default speed */
> -		dev->set_mpu_wkup_lat = NULL;
> +		dev->dtrev = pdata->rev;

If you get here, pdata is NULL.

Rob

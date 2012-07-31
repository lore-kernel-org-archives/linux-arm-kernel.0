From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 31 Jul 2012 09:14:54 +0200
Subject: [PATCH 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
 (Ian Molton's message of "Mon, 30 Jul 2012 16:15:56 +0100")
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <87obmw5rm9.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ian Molton <ian.molton@codethink.co.uk> writes:
Hi,

[...]

> @@ -2873,7 +2913,31 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int err;
>  
> -	pd = pdev->dev.platform_data;
> +	if (pdev->dev.of_node) {
> +		struct device_node *np = NULL;
> +
> +		/* when all users of this driver use FDT, we can remove this */
> +		pd = kzalloc(sizeof(*pd), GFP_ATOMIC);
> +		if (!pd) {
> +			dev_dbg(&pdev->dev, "Could not allocate platform data\n");
> +			return -ENOMEM;
> +		}
> +
> +		of_property_read_u32(pdev->dev.of_node,
> +			"port_number", &pd->port_number);
> +		of_property_read_u32(pdev->dev.of_node,
> +			"phy_addr", &pd->phy_addr);

I guess we need something for tx_csum_limit in the device tree too. It's
important for kirkwood and dove.

Arnaud

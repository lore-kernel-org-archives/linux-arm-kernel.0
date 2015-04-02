From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 2 Apr 2015 10:21:46 -0400 (EDT)
Subject: [PATCH v1 2/3] usb: ehci-platform: Use devm_of_phy_get_by_index
In-Reply-To: <1427921349-18173-3-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <Pine.LNX.4.44L0.1504021005390.1576-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Apr 2015, Arun Ramamurthy wrote:

> Getting phys by index instead of phy names so that we do
> not have to create a naming scheme when multiple phys
> are present
> 
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>


> @@ -204,36 +197,23 @@ static int ehci_platform_probe(struct platform_device *dev)
>  
>  		priv->num_phys = of_count_phandle_with_args(dev->dev.of_node,
>  				"phys", "#phy-cells");
> -		priv->num_phys = priv->num_phys > 0 ? priv->num_phys : 1;
>  
> -		priv->phys = devm_kcalloc(&dev->dev, priv->num_phys,
> -				sizeof(struct phy *), GFP_KERNEL);
> -		if (!priv->phys)
> -			return -ENOMEM;
> +		if (priv->num_phys > 0) {
> +			priv->phys = devm_kcalloc(&dev->dev, priv->num_phys,
> +					    sizeof(struct phy *), GFP_KERNEL);
> +			if (!priv->phys)
> +				return -ENOMEM;
> +		} else
> +			priv->num_phys = 0;

This last line isn't needed.  A negative value for priv->num_phys will
work just as well as 0.

> +			priv->phys[phy_num] = devm_of_phy_get_by_index(&dev->dev
> +						, dev->dev.of_node
> +						, phy_num);

What's with the funny placement of the commas?  Are you trying to avoid 
breaking the 80-column rule?  It should look like this:

			priv->phys[phy_num] = devm_of_phy_get_by_index(
					&dev->dev, dev->dev.of_node, phy_num);

When you fix this, you can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

The same comments apply to your 3/3 patch.

Alan Stern

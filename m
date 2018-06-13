From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 13 Jun 2018 09:29:05 +0200
Subject: [PATCH 4/4] net: emaclite: Remove xemaclite_mdio_setup return
 check
In-Reply-To: <1528871719-1681-5-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528871719-1681-5-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <20180613072905.GE24314@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 12:05:19PM +0530, Radhey Shyam Pandey wrote:
> Errors are already reported in xemaclite_mdio_setup so avoid
> reporting it again.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> index ec4608e..2a0c06e 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> @@ -1143,9 +1143,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
>  	xemaclite_update_address(lp, ndev->dev_addr);
>  
>  	lp->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
> -	rc = xemaclite_mdio_setup(lp, &ofdev->dev);
> -	if (rc)
> -		dev_warn(&ofdev->dev, "error registering MDIO bus\n");
> +	xemaclite_mdio_setup(lp, &ofdev->dev);
>  
>  	dev_info(dev, "MAC address is now %pM\n", ndev->dev_addr);

The patch itself is O.K. 

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

However, do you want to keep going if the MDIO bus fails? Maybe you
should failed the probe?

    Andrew

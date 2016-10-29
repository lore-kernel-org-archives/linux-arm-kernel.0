From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 29 Oct 2016 10:18:39 +0200
Subject: [PATCH v2 2/6] net: phy: broadcom: Add BCM54810 PHY entry
In-Reply-To: <1477688219-3871-3-git-send-email-jon.mason@broadcom.com>
References: <1477688219-3871-1-git-send-email-jon.mason@broadcom.com>
 <1477688219-3871-3-git-send-email-jon.mason@broadcom.com>
Message-ID: <20161029081839.GA32579@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 04:56:55PM -0400, Jon Mason wrote:
> The BCM54810 PHY requires some semi-unique configuration, which results
> in some additional configuration in addition to the standard config.
> Also, some users of the BCM54810 require the PHY lanes to be swapped.
> Since there is no way to detect this, add a device tree query to see if
> it is applicable.
> 
> Inspired-by: Vikas Soni <vsoni@broadcom.com>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  drivers/net/phy/Kconfig    |  2 +-
>  drivers/net/phy/broadcom.c | 58 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/brcmphy.h    | 10 ++++++++

Hi Jon

The binding documentation is missing.

> +	if (of_property_read_bool(np, "brcm,enet-phy-lane-swap")) {
> +		/* Lane Swap - Undocumented register...magic! */
> +		ret = bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_SEL_ER + 0x9,
> +					0x11B);
> +		if (ret < 0)
> +			return ret;
> +	}
> +

I wounder if this property could be made generic? What exactly are you
swapping? Rx and Tx lanes? Maybe we should add it to phy.txt?

	  Andrew

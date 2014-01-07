From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 7 Jan 2014 15:01:02 +0530
Subject: [PATCH 1/2] phy-core: Don't print an error on probe deferral
 or nodata
In-Reply-To: <1388963189-13556-1-git-send-email-hdegoede@redhat.com>
References: <1388963189-13556-1-git-send-email-hdegoede@redhat.com>
Message-ID: <52CBC956.6050106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 06 January 2014 04:36 AM, Hans de Goede wrote:
> Printing an error on probe-deferral clearly is not the right thing to do.
> While at it I've also silenced the error in case of -ENODATA, so that
> devm_phy_get can be used to get an optional phy without causing errors to

What do you mean by optional phy here?

Thanks
Kishon

> be printed. Alternatively a new devm_phy_get_optional method could be
> added for this.
> 
> While at it also factor the error handling out of the if ... else ..., as it
> is identical in both branches.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/phy/phy-core.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 58e0e97..d7b992e 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -371,16 +371,14 @@ struct phy *phy_get(struct device *dev, const char *string)
>  		index = of_property_match_string(dev->of_node, "phy-names",
>  			string);
>  		phy = of_phy_get(dev, index);
> -		if (IS_ERR(phy)) {
> -			dev_err(dev, "unable to find phy\n");
> -			return phy;
> -		}
>  	} else {
>  		phy = phy_lookup(dev, string);
> -		if (IS_ERR(phy)) {
> -			dev_err(dev, "unable to find phy\n");
> -			return phy;
> -		}
> +	}
> +	if (IS_ERR(phy)) {
> +		int err = PTR_ERR(phy);
> +		if (err != -EPROBE_DEFER && err != -ENODATA)
> +			dev_err(dev, "unable to get phy\n");
> +		return phy;
>  	}
>  
>  	if (!try_module_get(phy->ops->owner))
> 

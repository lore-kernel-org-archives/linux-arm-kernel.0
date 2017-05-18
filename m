From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 18 May 2017 15:19:58 -0700
Subject: [PATCH v2 net-next 1/2] include: linux: Add helper function to
 check phy interface mode
In-Reply-To: <1495145624-29463-2-git-send-email-isubramanian@apm.com>
References: <1495145624-29463-1-git-send-email-isubramanian@apm.com>
 <1495145624-29463-2-git-send-email-isubramanian@apm.com>
Message-ID: <0c55a097-564d-58ea-8e64-d642a1d8fad7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2017 03:13 PM, Iyappan Subramanian wrote:
> Added helper function that checks phy_mode is RGMII (all variants)
> 'bool phy_interface_mode_is_rgmii(phy_interface_t mode)'
> 
> Changed the following function, to use the above.
> 'bool phy_interface_is_rgmii(struct phy_device *phydev)'
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>

Not sure why you have chosen include: linux as the subject since all
changes done to that file typically had the "phy: " prefix, but the code
changes are fine, thanks!

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  include/linux/phy.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 54ef458..5a808a2 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -716,14 +716,24 @@ static inline bool phy_is_internal(struct phy_device *phydev)
>  }
>  
>  /**
> + * phy_interface_mode_is_rgmii - Convenience function for testing if a
> + * PHY interface mode is RGMII (all variants)
> + * @mode: the phy_interface_t enum
> + */
> +static inline bool phy_interface_mode_is_rgmii(phy_interface_t mode)
> +{
> +	return mode >= PHY_INTERFACE_MODE_RGMII &&
> +		mode <= PHY_INTERFACE_MODE_RGMII_TXID;
> +};
> +
> +/**
>   * phy_interface_is_rgmii - Convenience function for testing if a PHY interface
>   * is RGMII (all variants)
>   * @phydev: the phy_device struct
>   */
>  static inline bool phy_interface_is_rgmii(struct phy_device *phydev)
>  {
> -	return phydev->interface >= PHY_INTERFACE_MODE_RGMII &&
> -		phydev->interface <= PHY_INTERFACE_MODE_RGMII_TXID;
> +	return phy_interface_mode_is_rgmii(phydev->interface);
>  };
>  
>  /*
> 


-- 
Florian

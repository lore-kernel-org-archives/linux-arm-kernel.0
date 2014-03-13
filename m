From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 13 Mar 2014 21:37:56 +0800
Subject: [PATCH][next] phy: core: make NULL a valid phy reference if
 !CONFIG_GENERIC_PHY
In-Reply-To: <1394709073-1980-1-git-send-email-grygorii.strashko@ti.com>
References: <1394709073-1980-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <5321B4B4.9010806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 March 2014 07:11 PM, Strashko, Grygorii wrote:
> This fixes a regression on Keystone 2 platforms caused by patch
> 57303488cd37da58263e842de134dc65f7c626d5
> "usb: dwc3: adapt dwc3 core to use Generic PHY Framework" which adds
> optional support of generic phy in DWC3 core.
> 
> On Keystone 2 platforms the USB is not working now because
> CONFIG_GENERIC_PHY isn't set and, as result, Generic PHY APIs stubs
> return -ENOSYS always. The log shows:
>  dwc3 2690000.dwc3: failed to initialize core
>  dwc3: probe of 2690000.dwc3 failed with error -38
> 
> Hence, fix it by making NULL a valid phy reference in Generic PHY
> APIs stubs in the same way as it was done by the patch
> 04c2facad8fee66c981a51852806d8923336f362 "drivers: phy: Make NULL
> a valid phy reference".
> 
> CC: Kishon Vijay Abraham I <kishon@ti.com>
> CC: Felipe Balbi <balbi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
This fixes the regression seen in Linux next and patch seems
reasonable to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Felipe, Kishon,
Can you guys pick this fix if you are ok by it. Thanks


>  include/linux/phy/phy.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index e2f5ca9..5a9b193 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -204,21 +204,29 @@ static inline void phy_pm_runtime_forbid(struct phy *phy)
>  
>  static inline int phy_init(struct phy *phy)
>  {
> +	if (!phy)
> +		return 0;
>  	return -ENOSYS;
>  }
>  
>  static inline int phy_exit(struct phy *phy)
>  {
> +	if (!phy)
> +		return 0;
>  	return -ENOSYS;
>  }
>  
>  static inline int phy_power_on(struct phy *phy)
>  {
> +	if (!phy)
> +		return 0;
>  	return -ENOSYS;
>  }
>  
>  static inline int phy_power_off(struct phy *phy)
>  {
> +	if (!phy)
> +		return 0;
>  	return -ENOSYS;
>  }
>  
> 

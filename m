From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 14 Apr 2016 18:02:15 +0530
Subject: [PATCH v2 06/11] phy: da8xx-usb: new driver for DA8XX SoC USB PHY
In-Reply-To: <570EB143.4060309@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-7-git-send-email-david@lechnology.com>
 <56FE74AC.6080303@ti.com> <570EB143.4060309@lechnology.com>
Message-ID: <570F8DCF.2000402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 14 April 2016 02:21 AM, David Lechner wrote:
> On 04/01/2016 08:16 AM, Kishon Vijay Abraham I wrote:
> 
>>> +EXPORT_SYMBOL_GPL(da8xx_usb20_phy_set_mode);
>>
>> Don't prefer export symbols from PHY driver. That'll create unnecessary
>> dependencies between the controller and the PHY.
>>
>> I think it'll be better to create a new attribute and use it?
>>
> 
> Just having an attribute that keeps track of state does not work. I need a
> callback to poke registers. Would this be acceptable instead?
> 
> -----8<------
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index e7e574d..a13c7e4 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -342,6 +342,36 @@ int phy_power_off(struct phy *phy)
>  }
>  EXPORT_SYMBOL_GPL(phy_power_off);
> 
> +int phy_get_mode(struct phy *phy, enum phy_mode *mode)
> +{
> +       int ret;
> +
> +       if (!phy || !phy->ops->get_mode)
> +               return 0;
> +
> +       mutex_lock(&phy->mutex);
> +       ret = phy->ops->get_mode(phy, mode);
> +       mutex_unlock(&phy->mutex);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_get_mode);

'ops' for get_mode doesn't make much sense.
> +
> +int phy_set_mode(struct phy *phy, enum phy_mode mode)
> +{
> +       int ret;
> +
> +       if (!phy || !phy->ops->set_mode)
> +               return 0;
> +
> +       mutex_lock(&phy->mutex);
> +       ret = phy->ops->set_mode(phy, mode);
> +       mutex_unlock(&phy->mutex);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_set_mode);

this should be fine.

Thanks
Kishon

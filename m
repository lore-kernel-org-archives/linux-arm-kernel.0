From: lyz@rock-chips.com (Yunzhi Li)
Date: Thu, 11 Dec 2014 21:45:11 +0800
Subject: [PATCH v6 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <548971AF.1020506@ti.com>
References: <1418291722-25448-1-git-send-email-lyz@rock-chips.com>
 <1418291722-25448-2-git-send-email-lyz@rock-chips.com>
 <548971AF.1020506@ti.com>
Message-ID: <54899FE7.7050808@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon:

On 2014/12/11 18:27, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Thursday 11 December 2014 03:25 PM, Yunzhi Li wrote:
>> +
>> +static struct phy *rockchip_usb_phy_xlate(struct device *dev,
>> +					struct of_phandle_args *args)
>> +{
>> +	struct rockchip_usb_phy_priv *priv = dev_get_drvdata(dev);
>> +	unsigned int phy_id = args->args[0];
>> +
>> +	if (WARN_ON(phy_id < 0 || phy_id >= priv->nphys))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	return priv->phys[phy_id].phy;
> I didn't mean that. You can get rid of this entire xlate stuff if you use
> something like below
>
> phy at xxx {
> 	compatible = "";
> 	phy1:usb_phy {
> 	}
> 	phy2:usb_phy {
> 	};
> };
>
>
> usb at xx {
> 	compatible = "";
> 	phys = <&phy1>; //doesn't need xlate
> 	/* this needs xlate
> 	   phys = <&phy 1>;
> 	*/
> 	phy-names = "phy";
> };

Thank you so much for your suggestion, but still have a question:
I have to add the #phy-cells property in each phy sub-node, otherwise 
devm_get_phy() will fail and I get log info like
"/usb at ff500000: could not get #phy-cells for /phy/usbp-phy1". So can the 
#phy-cells property defines in patent node
also valid for it's child nodes like #address-cells ?

---
Yunzhi Li @ rockchip

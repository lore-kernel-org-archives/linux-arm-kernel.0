From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Tue, 20 Feb 2018 10:53:07 +0000
Subject: [PATCH] usb: host: ehci-platform: add support for optional
 external vbus supply
In-Reply-To: <9f1f49a0-4afd-a7f1-53bd-18f72abd4753@ti.com>
References: <1519117905-12095-1-git-send-email-amelie.delaunay@st.com>
 <9f1f49a0-4afd-a7f1-53bd-18f72abd4753@ti.com>
Message-ID: <82affeaf-c42b-9e85-1b84-a2b25eb83bd0@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/20/2018 10:27 AM, Roger Quadros wrote:
> Hi,
> 
> On 20/02/18 11:11, Amelie Delaunay wrote:
>> On some boards, especially when vbus supply requires large current,
>> and the charge pump on the PHY isn't enough, an external vbus power switch
>> may be used.
>> Add support for this optional external vbus supply in ehci-platform.
> 
> Isn't this generic enough to be done for all *hci-platform drivers?
> 

I can only test ehci-platform on my setup.

> And if this is a VBUS supply to the port, the root hub driver should be controlling it
> based on port power on/off commands to the port right?
> 

You're right.
This means to overload platform_overrides with
.port_power = ehci_platform_port_power,

and manage vbus_supply enable/disable in this function instead of 
ehci_platform_power_on/off.

>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
>>   drivers/usb/host/ehci-platform.c                   | 23 ++++++++++++++++++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> index 3efde12..fc480cd 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> @@ -19,6 +19,7 @@ Optional properties:
>>    - phys : phandle + phy specifier pair
>>    - phy-names : "usb"
>>    - resets : phandle + reset specifier pair
>> + - vbus-supply : phandle of regulator supplying vbus
>>   
>>   Example (Sequoia 440EPx):
>>       ehci at e0000300 {
>> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
>> index b065a96..76cc781 100644
>> --- a/drivers/usb/host/ehci-platform.c
>> +++ b/drivers/usb/host/ehci-platform.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/of.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <linux/reset.h>
>>   #include <linux/usb.h>
>>   #include <linux/usb/hcd.h>
>> @@ -46,6 +47,7 @@ struct ehci_platform_priv {
>>   	struct reset_control *rsts;
>>   	struct phy **phys;
>>   	int num_phys;
>> +	struct regulator *vbus_supply;
>>   	bool reset_on_resume;
>>   };
>>   
>> @@ -99,6 +101,15 @@ static int ehci_platform_power_on(struct platform_device *dev)
>>   		}
>>   	}
>>   
>> +	if (priv->vbus_supply) {
>> +		ret = regulator_enable(priv->vbus_supply);
>> +		if (ret) {
>> +			dev_err(&dev->dev,
>> +				"failed to enable vbus supply: %d\n", ret);
>> +			goto err_exit_phy;
>> +		}
>> +	}
>> +
>>   	return 0;
>>   
>>   err_exit_phy:
>> @@ -119,6 +130,9 @@ static void ehci_platform_power_off(struct platform_device *dev)
>>   	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
>>   	int clk, phy_num;
>>   
>> +	if (priv->vbus_supply)
>> +		regulator_disable(priv->vbus_supply);
>> +
> 
> If we disable the VBUS here, which is being called during ehci_platform_suspend(),
> how can we expect remote wakeup to work?
> This is unconditionally powering down the port.
> 

Sure. With .port_power, it will be OK.

Thanks for review,
Amelie

>>   	for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
>>   		phy_power_off(priv->phys[phy_num]);
>>   		phy_exit(priv->phys[phy_num]);
>> @@ -247,6 +261,15 @@ static int ehci_platform_probe(struct platform_device *dev)
>>   	if (err)
>>   		goto err_put_clks;
>>   
>> +	priv->vbus_supply = devm_regulator_get_optional(&dev->dev, "vbus");
>> +	if (IS_ERR(priv->vbus_supply)) {
>> +		err = PTR_ERR(priv->vbus_supply);
>> +		if (err == -ENODEV)
>> +			priv->vbus_supply = NULL;
>> +		else
>> +			goto err_reset;
>> +	}
>> +
>>   	if (pdata->big_endian_desc)
>>   		ehci->big_endian_desc = 1;
>>   	if (pdata->big_endian_mmio)
>>
> 

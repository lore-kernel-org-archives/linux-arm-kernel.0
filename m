From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Wed, 25 Mar 2015 17:06:11 -0700
Subject: [PATCH v1 3/3] phy: cygnus-usbphy: Add Broadcom Cygnus USB phy
 driver
In-Reply-To: <55134C3E.4060400@ti.com>
References: <1426886727-537-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1426886727-537-4-git-send-email-arun.ramamurthy@broadcom.com>
 <551336A2.1050704@ti.com> <20150325224253.GA16950@dtor-ws>
 <55134C3E.4060400@ti.com>
Message-ID: <55134D73.7060507@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15-03-25 05:01 PM, Kishon Vijay Abraham I wrote:
>
>
> On Thursday 26 March 2015 04:12 AM, Dmitry Torokhov wrote:
>> Hi Kishon,
>>
>> On Thu, Mar 26, 2015 at 03:58:50AM +0530, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Saturday 21 March 2015 02:55 AM, Arun Ramamurthy wrote:
>>>> +struct bcm_phy_driver {
>>>> +	void __iomem *usbphy_regs;
>>>> +	void __iomem *usb2h_idm_regs;
>>>> +	void __iomem *usb2d_idm_regs;
>>>> +	struct bcm_phy_instance *ports[MAX_PHY_PORTS];
>>>
>>> er.. can't we allocate this dynamically?
>>
>> The chip has support for only 3 phys, so I believe allocating array of 3
>> pointers is simplest.
>>
>> [...]
>>
>>>> +
>>>> +static struct phy *bcm_usb_phy_xlate(struct device *dev,
>>>> +				     struct of_phandle_args *args)
>>>> +{
>>>> +	struct bcm_phy_driver *phy_driver = dev_get_drvdata(dev);
>>>> +	struct bcm_phy_instance *port = NULL;
>>>> +	int i;
>>>> +
>>>> +	if (!phy_driver)
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	if (WARN_ON(args->args_count != 1))
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	if (WARN_ON(args->args[0] < 0 || args->args[0] > 1))
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	for (i = 0; i < ARRAY_SIZE(phy_driver->ports); i++) {
>>>> +		struct bcm_phy_instance *p = phy_driver->ports[i];
>>>> +
>>>> +		if (p && p->generic_phy->dev.of_node == args->np) {
>>>> +			port = p;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (!port) {
>>>> +		dev_err(dev, "Failed to locate phy %s\n", args->np->name);
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	}
>>>> +
>>>> +	port->host_mode = args->args[0];
>>>> +
>>>> +	return port->generic_phy;
>>>> +}
>>>
>>> The xlate function here shouldn't be needed at all. Use of_phy_simple_xlate
>>> instead.
>>
>> of_phy_simple_xlate() will not allow specifying host vs device mode when
>> requesting phy though...
>
> indeed!
>
Kishon, to confirm , are the xlate function and the MAX_PHY_PORTS ok or 
are you recommending changes? Thanks
>

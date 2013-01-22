From: kishon@ti.com (kishon)
Date: Tue, 22 Jan 2013 19:43:44 +0530
Subject: [PATCH v1 2/6] usb: otg: utils: add facilities in phy lib to
 support multiple PHYs of same type
In-Reply-To: <50FE9D1E.3010800@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com>
 <1358848694-20145-3-git-send-email-kishon@ti.com> <50FE9D1E.3010800@ti.com>
Message-ID: <50FE9E98.3080905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 22 January 2013 07:37 PM, Roger Quadros wrote:
> On 01/22/2013 11:58 AM, Kishon Vijay Abraham I wrote:
>> In order to add support for multipe PHY's of the same type, new API's
>> for adding PHY and getting PHY has been added. Now the binding
>> information for the PHY and controller should be done in platform file
>> using usb_bind_phy API. And for getting a PHY, the device pointer of the
>> USB controller and an index should be passed. Based on the binding
>> information that is added in the platform file, usb_get_phy_dev will return the
>> appropriate PHY.
>> Already existing API's to add and get phy by type is not removed. These
>> API's are deprecated and will be removed once all the platforms start to
>> use the new API.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   drivers/usb/otg/otg.c   |  114 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/usb/phy.h |   13 ++++++
>>   2 files changed, 126 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
>> index 492ba2f..1f30b22 100644
>> --- a/drivers/usb/otg/otg.c
>> +++ b/drivers/usb/otg/otg.c
>> @@ -36,6 +36,20 @@ static struct usb_phy *__usb_find_phy(struct list_head *list,
>>   	return ERR_PTR(-ENODEV);
>>   }
>>
>> +static struct usb_phy *__usb_find_phy_dev(struct device *dev,
>> +	struct list_head *list, u8 index)
>> +{
>> +	struct usb_phy_bind *phy_bind = NULL;
>> +
>> +	list_for_each_entry(phy_bind, list, list) {
>> +		if (!(strcmp(phy_bind->dev_name, dev_name(dev))) &&
>> +				phy_bind->index == index)
>> +			return phy_bind->phy;
>
> If the PHY driver has not yet called usb_add_phy_dev() (e.g. driver not yet loaeded)
> then this will return NULL.
>
>> +	}
>> +
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>>   static void devm_usb_phy_release(struct device *dev, void *res)
>>   {
>>   	struct usb_phy *phy = *(struct usb_phy **)res;
>> @@ -112,6 +126,69 @@ err0:
>>   EXPORT_SYMBOL(usb_get_phy);
>>
>>   /**
>> + * usb_get_phy_dev - find the USB PHY
>> + * @dev - device that requests this phy
>> + * @index - the index of the phy
>> + *
>> + * Returns the phy driver, after getting a refcount to it; or
>> + * -ENODEV if there is no such phy.  The caller is responsible for
>> + * calling usb_put_phy() to release that count.
>> + *
>> + * For use by USB host and peripheral drivers.
>> + */
>> +struct usb_phy *usb_get_phy_dev(struct device *dev, u8 index)
>> +{
>> +	struct usb_phy	*phy = NULL;
>> +	unsigned long	flags;
>> +
>> +	spin_lock_irqsave(&phy_lock, flags);
>> +
>> +	phy = __usb_find_phy_dev(dev, &phy_bind_list, index);
>> +	if (IS_ERR(phy)) {
>> +		pr_err("unable to find transceiver\n");
>> +		goto err0;
>> +	}
>
> Since NULL is not IS_ERR(), you will do a NULL pointer reference below.
>
> In such cases we would want to use the deferred probe mechanism. So should we return
> -EPROBE_DEFER?

Good catch. I'll update the patch.

Thanks
Kishon

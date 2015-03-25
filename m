From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 26 Mar 2015 03:33:33 +0530
Subject: [PATCH 1/3] phy: core: Add devm_of_phy_get_by_index to phy-core
In-Reply-To: <550C9134.9020003@broadcom.com>
References: <1426885630-32429-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1426885630-32429-2-git-send-email-arun.ramamurthy@broadcom.com>
 <20150320212645.GA25405@dtor-ws> <550C9134.9020003@broadcom.com>
Message-ID: <551330B5.6030901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 21 March 2015 02:59 AM, Arun Ramamurthy wrote:
> 
> 
> On 15-03-20 02:26 PM, Dmitry Torokhov wrote:
>> Hi Arun,
>>
>> On Fri, Mar 20, 2015 at 02:07:08PM -0700, Arun Ramamurthy wrote:
>>> Adding devm_of_phy_get_by_index to get phys by supplying an index
>>> and not a phy name when multiple phys are declared

I think a bit more explanation on why get_by_index is needed here.
>>>
>>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
>>> ---
>>>   drivers/phy/phy-core.c  | 30 ++++++++++++++++++++++++++++++
>>>   include/linux/phy/phy.h |  2 ++
>>>   2 files changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>> index a12d353..0c03876 100644
>>> --- a/drivers/phy/phy-core.c
>>> +++ b/drivers/phy/phy-core.c
>>> @@ -622,6 +622,36 @@ struct phy *devm_of_phy_get(struct device *dev, struct
>>> device_node *np,
>>>   EXPORT_SYMBOL_GPL(devm_of_phy_get);
>>>
>>>   /**
>>> + * devm_of_phy_get_by_index() - lookup and obtain a reference to a phy by
>>> index.
>>> + * @dev: device that requests this phy
>>> + * @np: node containing the phy
>>> + * @index: index of the phy
>>> + *
>>> + * Gets the phy using _of_phy_get(), and associates a device with it using
>>> + * devres. On driver detach, release function is invoked on the devres data,
>>> + * then, devres data is freed.
>>> + *
>>> + */
>>> +struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node
>>> *np,
>>> +                     int index)
>>> +{
>>> +    struct phy **ptr, *phy;
>>> +
>>> +    ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
>>> +    if (!ptr)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    phy = _of_phy_get(np, index);
>>> +    if (!IS_ERR(phy)) {
>>> +        *ptr = phy;
>>> +        devres_add(dev, ptr);
>>> +    } else {
>>> +        devres_free(ptr);
>>> +    }
>>> +
>>> +    return phy;
>>> +}
>>
>> You want EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index); here.

Also update the Documentation/phy.txt.

-Kishon

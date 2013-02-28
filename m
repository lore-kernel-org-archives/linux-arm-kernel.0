From: kishon@ti.com (kishon)
Date: Thu, 28 Feb 2013 11:38:30 +0530
Subject: [PATCH] USB otg: use try_module_get in all usb_get_phy functions
 and add missing module_put
In-Reply-To: <20130228004135.GA3886@kroah.com>
References: <1361974273-17087-1-git-send-email-mkl@pengutronix.de>
 <1361974273-17087-2-git-send-email-mkl@pengutronix.de>
 <20130227162146.GE21645@kroah.com> <512E3547.2000607@pengutronix.de>
 <20130228004135.GA3886@kroah.com>
Message-ID: <512EF45E.3070409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 28 February 2013 06:11 AM, Greg KH wrote:
> On Wed, Feb 27, 2013 at 05:33:11PM +0100, Marc Kleine-Budde wrote:
>> On 02/27/2013 05:21 PM, Greg KH wrote:
>>> On Wed, Feb 27, 2013 at 03:11:13PM +0100, Marc Kleine-Budde wrote:
>>>> In patch "5d3c28b usb: otg: add device tree support to otg library"
>>>> devm_usb_get_phy_by_phandle() was added. It uses try_module_get() to lock the
>>>> phy driver in memory. The corresponding module_put() is missing in that patch.
>>>>
>>>> This patch adds try_module_get() to usb_get_phy() and usb_get_phy_dev().
>>>> Further the missing module_put() is added to usb_put_phy().
>>>>
>>>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Acked-by: Felipe Balbi <balbi@ti.com>
>>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>> ---
>>>>   drivers/usb/otg/otg.c |   10 +++++++---
>>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
>>>> index e181439..2bd03d2 100644
>>>> --- a/drivers/usb/otg/otg.c
>>>> +++ b/drivers/usb/otg/otg.c
>>>> @@ -130,7 +130,7 @@ struct usb_phy *usb_get_phy(enum usb_phy_type type)
>>>>   	spin_lock_irqsave(&phy_lock, flags);
>>>>
>>>>   	phy = __usb_find_phy(&phy_list, type);
>>>> -	if (IS_ERR(phy)) {
>>>> +	if (IS_ERR(phy) || !try_module_get(phy->dev->driver->owner)) {
>>>
>>> Ugh, really?  We really are trying this type of module locking mess?
>>>
>>> Why?  What is it solving?  What's wrong with having the module be able
>>
>> Without this patch, you can unload the phy module, while it is in use.
>> As the phy framework doesn't use any existing abstraction to handle phy
>> <-> user of phy pairing/unpairing (it's all open coded), any subsequent
>> use of the phy's callback will result in deref'ing bogus pointers.
>
> Then perhaps we should fix the open-coded-ness of the phy layer?
>
>>> to be unloaded whenever it wants to?  No one should be doing that and
>>> expecting that their hardware would still work properly, right?
>>
>> Yes, but it should not result in an kernel oops.
>
> Agreed.
>
>>> I really don't like this type of thing, sorry.
>>
>> Can you point Kishon and me to a better implementation?
>
> Wasn't someone working on a "generic" phy layer for the kernel?  That
> should probably resolve this issue there.

Even in the generic PHY layer, we use *try_module_get* to avoid 
dereferencing bogus pointers.

Thanks
Kishon

From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 04 Feb 2013 15:10:57 +0100
Subject: [PATCH 1/9] usb: otg: use try_module_get in all usb_get_phy
 functions and add missing module_put
In-Reply-To: <510FBEB6.7060906@ti.com>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-2-git-send-email-s.hauer@pengutronix.de>
 <510FBEB6.7060906@ti.com>
Message-ID: <510FC171.3090708@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2013 02:59 PM, Roger Quadros wrote:
> On 02/04/2013 03:24 PM, Sascha Hauer wrote:
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> In patch "5d3c28b usb: otg: add device tree support to otg library"
>> devm_usb_get_phy_by_phandle() was added. It uses try_module_get() to lock the
>> phy driver in memory. The corresponding module_put() is missing in that patch.
>>
>> This patch adds try_module_get() to usb_get_phy() and usb_get_phy_dev().
>> Further the missing module_put() is added to usb_put_phy().
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>  drivers/usb/otg/otg.c |   10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
>> index e181439..2bd03d2 100644
>> --- a/drivers/usb/otg/otg.c
>> +++ b/drivers/usb/otg/otg.c
>> @@ -130,7 +130,7 @@ struct usb_phy *usb_get_phy(enum usb_phy_type type)
>>  	spin_lock_irqsave(&phy_lock, flags);
>>  
>>  	phy = __usb_find_phy(&phy_list, type);
>> -	if (IS_ERR(phy)) {
>> +	if (IS_ERR(phy) || !try_module_get(phy->dev->driver->owner)) {
>>  		pr_err("unable to find transceiver of type %s\n",
>>  			usb_phy_type_string(type));
>>  		goto err0;
> 
> There are 2 problems with this.
> 
> - If phy was found but try_module_get failed you are not returning error code.

Correct - but....

> - If phy was found and try_module_get fails we would want to use deferred probing,
> since this case is possible if the phy module is not yet loaded and alive but can be in
> the future.

...this should not happen, as the phy list is protected by the
spin_lock. If a phy driver module has added a the phy to the
infrastructure, but has been rmmod'ed without removing the phy. The phy
driver is broken anyway.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/5aac1207/attachment-0001.sig>

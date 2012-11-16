From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 16 Nov 2012 15:32:21 +0100
Subject: [PATCH 5/9] usb: add phy connection by phy-mode
In-Reply-To: <20121116134116.GA18527@arwen.pp.htv.fi>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-6-git-send-email-m.grzeschik@pengutronix.de>
 <20121116113149.GC17793@arwen.pp.htv.fi> <50A62713.5070407@pengutronix.de>
 <20121116134116.GA18527@arwen.pp.htv.fi>
Message-ID: <50A64E75.4060209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 02:41 PM, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Nov 16, 2012 at 12:44:19PM +0100, Marc Kleine-Budde wrote:
>>>> diff --git a/drivers/of/of_usbphy.c b/drivers/of/of_usbphy.c
>>>> new file mode 100644
>>>> index 0000000..2e71f7b
>>>> --- /dev/null
>>>> +++ b/drivers/of/of_usbphy.c
>>>> @@ -0,0 +1,49 @@
>>>> +/*
>>>> + * OF helpers for network devices.
>>>> + *
>>>> + * This file is released under the GPLv2
>>>> + *
>>>> + * Initially copied out of drivers/of/of_net.c
>>>> + */
>>>> +#include <linux/etherdevice.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/of_usbphy.h>
>>>> +#include <linux/usb/phy.h>
>>>> +#include <linux/export.h>
>>>> +
>>>> +/**
>>>> + * It maps 'enum usb_phy_interface' found in include/linux/usb/phy.h
>>>> + * into the device tree binding of 'phy-mode', so that USB
>>>> + * device driver can get phy interface from device tree.
>>>> + */
>>>
>>> provide proper kernel-doc
>>>
>>>> +static const char *usbphy_modes[] = {
>>>> +	[USBPHY_INTERFACE_MODE_NA]	= "",
>>>> +	[USBPHY_INTERFACE_MODE_UTMI]	= "utmi",
>>>> +	[USBPHY_INTERFACE_MODE_UTMIW]	= "utmiw",
>>>> +	[USBPHY_INTERFACE_MODE_ULPI]	= "ulpi",
>>>> +	[USBPHY_INTERFACE_MODE_SERIAL]	= "fsls",
>>>> +};
>>>
>>> In fact, these would be better off as constants:
>>>
>>> #define USBPHY_INTERFACE_MODE_UTMI	1
>>> #define USBPHY_INTERFACE_MODE_UTMIW	2
>>> ...
>>
>> Why are defines better than an enum? BTW: this code is a copy of the
> 
> because with enums can change value if you add another one in the middle
> and it's really easy to miss that sort of thing during review and cause
> regressions to many DTS files.

Now I get it, you want to use integers instead of strings in the DT. Why
do you want to have Integers in the DT? It seems to work with strings
pretty well for the Ethernet phys, why invent a new concept here?

>> ethernet phy of-helper code.
> 
> so ?

reviewed core, proven to work, if the concept works for Ethernet phys it
should work with USB phys, too.

> 
>>>> +/**
>>>> + * of_get_phy_mode - Get phy mode for given device_node
>>>> + * @np:	Pointer to the given device_node
>>>> + *
>>>> + * The function gets phy interface string from property 'phy-mode',
>>>> + * and return its index in phy_modes table, or errno in error case.
>>>> + */
>>>
>>> why do you pass a string instead of passing an Integer ? This makes no
>>> sense to me.
>>
>> This code returns an integer or rather an enum....see header file below.
> 
> I mean through DT, should've been more explicit. The dts files should
> pass an integer, not a string. Then you don't need this silly conversion
> helper.

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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/4a6c9851/attachment.sig>

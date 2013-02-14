From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 14 Feb 2013 11:11:55 +0100
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130214095822.GD15275@arwen.pp.htv.fi>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-4-git-send-email-s.hauer@pengutronix.de>
 <87fw0zb5kk.fsf@ashishki-desk.ger.corp.intel.com>
 <511CB338.8070204@pengutronix.de> <20130214095822.GD15275@arwen.pp.htv.fi>
Message-ID: <511CB86B.3070504@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 10:58 AM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 14, 2013 at 10:49:44AM +0100, Marc Kleine-Budde wrote:
>>>> diff --git a/drivers/usb/usb-common.c b/drivers/usb/usb-common.c
>>>> index d29503e..ad4d87d 100644
>>>> --- a/drivers/usb/usb-common.c
>>>> +++ b/drivers/usb/usb-common.c
>>>> @@ -14,6 +14,9 @@
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/usb/ch9.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/usb/of.h>
>>>> +#include <linux/usb/otg.h>
>>>>  
>>>>  const char *usb_speed_string(enum usb_device_speed speed)
>>>>  {
>>>> @@ -32,4 +35,37 @@ const char *usb_speed_string(enum usb_device_speed speed)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(usb_speed_string);
>>>>  
>>>> +#ifdef CONFIG_OF
>>>> +static const char *usb_dr_modes[] = {
>>>> +	[USB_DR_MODE_UNKNOWN]		= "",
>>>> +	[USB_DR_MODE_HOST]		= "host",
>>>> +	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
>>>> +	[USB_DR_MODE_OTG]		= "otg",
>>>> +};
>>>
>>> It turns out this is a problem, especially since this is generic usb
>>> code: we have a chipidea controller (a patchset just arrived) that does
>>> both host and peripheral, but not otg. And I'm told now that dwc3
>>> controller can be synthesized like that too.
> 
> I wonder if this part is really necessary. Usually you would read it
> from HW's registers. For dwc3, it's quite recently that we allowed the
> driver to be built with host-only, device-only or DRD functionality.

The imx25 USB version of the chipidea IP Core get's really confused if
you read from the CAP_DCCPARAMS register on the host only port. In
freescale's documentation the register is marked as reserved. The host
port will not work then.

> Also, this is likely to create troubles if not done correctly. Imagine
> user compiles a host-only driver and board passes dr_mode = peripheral ?

Use dev_err() and inform the user.

> Maybe we can ignore dr_mode in host-only and device-only builds and only
> look at it for DRD builds ?
> 
>> You mean a single instance of the controller (i.e. USB port) is host and
>> peripheral but has no otg registers. This means the mode of the port is
>> configured by userspace via the debugfs file? Is this possible?
> 
> yes, it is possible. Dual-Role doesn't imply OTG, but OTG implies
> Dual-Role.

Thanks for the info. Then we need a fourth value for the helper code.
What's a sensible sting: "dual-role", "dr"?

>> The above property describes a single port not the whole controller. If
>> there is a controller with one host and one peripheral port the code in
>> this patch should be sufficient, as you have a property in the DT for
>> each port.
> 
> I don't think you can have a single controller like that, but good that
> it supports.

The DT binding is per USB port, so that's a by product of good
abstraction :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130214/2e0c3ad9/attachment.sig>

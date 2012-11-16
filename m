From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 16 Nov 2012 12:55:13 +0100
Subject: [PATCH 4/9] usb: chipidea: ci13xxx-imx: add "dr_mode" property
 to device tree bindings
In-Reply-To: <878va17oii.fsf@ashishki-desk.ger.corp.intel.com>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-5-git-send-email-m.grzeschik@pengutronix.de>
 <878va17oii.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <50A629A1.1010202@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 12:53 PM, Alexander Shishkin wrote:
> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> 
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> Its necessary to limit a hostonly soc to its single role, since
>> debugging has shown that reading on the "CAP_DCCPARAMS" register inside
>> a host-only port, what ci_hdrc_gadget_init does, can lead to an
>> instable behaviour of the IC.
> 
> Probably typos: should be "it's" and "unstable".
> 
> [snip]
> 
>> --- a/drivers/usb/chipidea/ci13xxx_imx.c
>> +++ b/drivers/usb/chipidea/ci13xxx_imx.c
>> @@ -237,6 +237,8 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> +	ci13xxx_get_dr_mode(pdev->dev.of_node, pdata);
>> +
>>  	plat_ci = ci13xxx_add_device(&pdev->dev,
>>  				pdev->resource, pdev->num_resources,
>>  				pdata);
>> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
>> index b50b77a..3e3e159 100644
>> --- a/drivers/usb/chipidea/core.c
>> +++ b/drivers/usb/chipidea/core.c
>> @@ -63,6 +63,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/slab.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/of_platform.h>
>>  #include <linux/usb/ch9.h>
>>  #include <linux/usb/gadget.h>
>>  #include <linux/usb/otg.h>
>> @@ -521,6 +522,23 @@ void ci13xxx_remove_device(struct platform_device *pdev)
>>  }
>>  EXPORT_SYMBOL_GPL(ci13xxx_remove_device);
>>  
>> +void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata)
>> +{
>> +	const unsigned char *dr_mode;
>> +
>> +	dr_mode = of_get_property(of_node, "dr_mode", NULL);
>> +	if (!dr_mode)
>> +		return;
>> +
>> +	if (!strcmp(dr_mode, "host"))
>> +		pdata->flags |= CI13XXX_DR_MODE_HOST;
>> +	else if (!strcmp(dr_mode, "peripheral"))
>> +		pdata->flags |= CI13XXX_DR_MODE_PERIPHERAL;
>> +	else if (!strcmp(dr_mode, "otg"))
>> +		pdata->flags |= CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_PERIPHERAL;
>> +}
>> +EXPORT_SYMBOL_GPL(ci13xxx_get_dr_mode);
>> +
> 
> I'd prefer this function to live in ci13xxx_imx, since that's where it's
> used and it doesn't really need anything from core.c anyway. Or maybe it
> would make sense to make it even more generic (for other devitetree
> users), since you're saying that other drivers are using this already.

+1

Move it next to the phy-mode and make it work the same way (i.e. return
an enum).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/f54165f8/attachment-0001.sig>

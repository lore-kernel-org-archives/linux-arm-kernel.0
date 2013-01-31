From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Thu, 31 Jan 2013 10:15:54 +0100
Subject: [PATCH 4/6] usb: chipidea: add PTW and PTS handling
In-Reply-To: <20130130193327.GA1906@pengutronix.de>
References: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
 <1359559782-14552-5-git-send-email-s.hauer@pengutronix.de>
 <5109505E.7040204@parrot.com> <20130130193327.GA1906@pengutronix.de>
Message-ID: <510A364A.4020209@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer a ?crit :
> On Wed, Jan 30, 2013 at 05:54:54PM +0100, Matthieu CASTET wrote:
>>> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
>>> index 57cae1f..dcb650f 100644
>>> --- a/drivers/usb/chipidea/core.c
>>> +++ b/drivers/usb/chipidea/core.c
>>> @@ -67,6 +67,8 @@
>>>  #include <linux/usb/gadget.h>
>>>  #include <linux/usb/otg.h>
>>>  #include <linux/usb/chipidea.h>
>>> +#include <linux/usb/of.h>
>>> +#include <linux/phy.h>
>>>  
>>>  #include "ci.h"
>>>  #include "udc.h"
>>> @@ -211,6 +213,42 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
>>>  	return 0;
>>>  }
>>>  
>>> +static void hw_phymode_configure(struct ci13xxx *ci)
>>> +{
>>> +	u32 portsc;
>>> +
>>> +	/*
>>> +	 * The lpm version has the corresponding bits in the devlc register.
>>> +	 * Currently not implemented.
>>> +	 */
>>> +	if (ci->hw_bank.lpm)
>>> +		return;
>> Why you don't implement it ?
>>
>> If you don't implement it, I believe you should add a warning in order to catch
>> it when used with lpm devices.
> 
> I'm against adding a warning because current users seem to go well
> without this setting. Adding a warning would lead to more confusion than
> it would help.
> 
> I could try and implement it, though I'm unsure about the register
> layout.
> 
> What I know from an earlier post from you is this:
> 
> #define LPM_PTS(d)  (((d)>>29)&7)
> #define LPM_STS     BIT(28) /* serial transceiver select */
> #define LPM_PTW     BIT(27) /* parallel transceiver width */
> 
> Do you also know how LPM_PTS is decoded?

I will say the same as not lpm device :

PTS is  made up from PORTSCx bits 25, 30 and 31.

PTS is  made up from devlc bits 31, 30 and 29.


Also in my datasheet, they give a way to check if the bits are read only or read
write [1]. I don't know if it is worth the trouble to check it.


Matthieu


[1]
PTS
This register bit pair is used in conjunction with the configuration constant
VUSB_HS_PHY_TYPE to control which parallel transceiver interface is selected. If
VUSB_HS_PHY_TYPE is set for 0, 1, 2, 3, 8 or 10 then this bit is read only. If
VUSB_HS_PHY_TYPE is 4, 5, 6, 7, 9 or 11 then this bit is read/write.

This field is reset to:
'000b' if VUSB_HS_PHY_TYPE = 0, 4 ? UTMI/UTMI+
'001b' if VUSB_HS_PHY_TYPE = 1, 5 ? ULPI DDR
'010b' if VUSB_HS_PHY_TYPE = 2, 6 ? ULPI
'011b' if VUSB_HS_PHY_TYPE = 3, 7, 8, 9 ? Serial/1.1 PHY/IC_USB (FS Only)
'100b' if VUSB_HS_PHY_TYPE = 10, 11 ? UTMI for HSIC PHY

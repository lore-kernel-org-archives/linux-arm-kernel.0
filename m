From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 04 Jul 2014 02:39:53 +0400
Subject: [PATCH 2/4] usb: host: xhci-plat: Add support to get PHYs
In-Reply-To: <CAFp+6iGYZdRL17UqPhskyDDhfD++His3mO2v7uzG5OF1Hd3TrQ@mail.gmail.com>
References: <1402056736-12674-1-git-send-email-gautam.vivek@samsung.com>	<1402056736-12674-3-git-send-email-gautam.vivek@samsung.com>	<CAODwPW-2tbDht8P=KsTyTyeBivFtFMiyCpxd0QFa-cUSRTpJjQ@mail.gmail.com>	<53A9FCDB.6060805@cogentembedded.com>
 <CAFp+6iGYZdRL17UqPhskyDDhfD++His3mO2v7uzG5OF1Hd3TrQ@mail.gmail.com>
Message-ID: <53B5DBB9.3080202@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/25/2014 12:44 PM, Vivek Gautam wrote:

>>>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>>>> index 9ffecd5..453d89e 100644
>>>> --- a/drivers/usb/host/xhci.h
>>>> +++ b/drivers/usb/host/xhci.h
>>>> @@ -1582,6 +1582,9 @@ struct xhci_hcd {
>>>>           u32                     port_status_u0;
>>>>    /* Compliance Mode Timer Triggered every 2 seconds */
>>>>    #define COMP_MODE_RCVRY_MSECS 2000
>>>> +       /* phys for the controller */
>>>> +       struct phy              *phy2_gen;
>>>> +       struct phy              *phy3_gen;
>>>>    };

>>> I don't think adding new variables here and restricting most of this
>>> logic to xhci-plat.c (in the next patch) is the best way to do it.

>>     Indeed.

    Actually, I haven't given enough thought to this...

>>> There's no conceptual reason why other host controllers (e.g. xhci-pci
>>> or even EHCI) could not have a similar need to tune their PHY after
>>> reset. PHYs are universal to all host controllers.

>>> There is already a 'phy' member in struct usb_hcd which I think is
>>> mostly unused right now. I think it would be much less
>>> confusing/redundant to reuse that member for this purpose (you could
>>> still set it up from xhci_plat_probe(), and then call it from
>>> hcd_bus_resume() or something like that).

>>     That member has type 'struct usb_phy *' while here we have 'struct phy *'
>> -- feel the difference.
>>     I have already tried adding 'struct phy *gen_phy' to 'struct usb_hcd',

> So the 'struct phy *' available in the usb_hcd is requested in usb_add_hcd().
> This is requested with the constant string 'usb' :
>             struct phy *phy = phy_get(hcd->self.controller, "usb");

> This can get the phy with string 'usb' only if, either the host
> controller has a device node wherein the phys are given.

    Yes, that was the plan. Currently, the PHY driver for which this was 
written can be probed from the device tree only.

> Even in this case one can't give same constant string for two
> different phys, UTMI+ and PIPE3 phy, isn't it ?

    Yes, you're right. I didn't really consider the case of some host needing 
2 distinct PHY.

> Or, the other way can be when host gets a lookup table to look into to
> find the relevant phys, something like
> Heikki has suggested:
> usb: dwc3: host: convey the PHYs to xhci
> (https://lkml.org/lkml/2014/6/5/585) and related patch series.

    Well, AFAIK the look-up table method is already provided by the current 
PHY core for non-DT use cases; this doesn't seem to have changed with that 
patch set, does it?

> So if we use this second approach, we would need to override the
> 'phy_get()' that has been done in usb_add_hcd()
> in xhci_plat_probe(), and then use them in later operations.

    I guess it'd probably be simpler to ignore the 'gen_phy' member of 'struct 
usb_hcd' in your case (if it gets eventually added).

WBR, Sergei

From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 25 Jun 2014 14:14:42 +0530
Subject: [PATCH 2/4] usb: host: xhci-plat: Add support to get PHYs
In-Reply-To: <53A9FCDB.6060805@cogentembedded.com>
References: <1402056736-12674-1-git-send-email-gautam.vivek@samsung.com>
 <1402056736-12674-3-git-send-email-gautam.vivek@samsung.com>
 <CAODwPW-2tbDht8P=KsTyTyeBivFtFMiyCpxd0QFa-cUSRTpJjQ@mail.gmail.com>
 <53A9FCDB.6060805@cogentembedded.com>
Message-ID: <CAFp+6iGYZdRL17UqPhskyDDhfD++His3mO2v7uzG5OF1Hd3TrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Wed, Jun 25, 2014 at 4:04 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 06/10/2014 12:22 AM, Julius Werner wrote:
>
>>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>>> index 9ffecd5..453d89e 100644
>>> --- a/drivers/usb/host/xhci.h
>>> +++ b/drivers/usb/host/xhci.h
>>> @@ -1582,6 +1582,9 @@ struct xhci_hcd {
>>>          u32                     port_status_u0;
>>>   /* Compliance Mode Timer Triggered every 2 seconds */
>>>   #define COMP_MODE_RCVRY_MSECS 2000
>>> +       /* phys for the controller */
>>> +       struct phy              *phy2_gen;
>>> +       struct phy              *phy3_gen;
>>>   };
>
>
>> I don't think adding new variables here and restricting most of this
>> logic to xhci-plat.c (in the next patch) is the best way to do it.
>
>
>    Indeed.
>
>
>> There's no conceptual reason why other host controllers (e.g. xhci-pci
>> or even EHCI) could not have a similar need to tune their PHY after
>> reset. PHYs are universal to all host controllers.
>
>
>> There is already a 'phy' member in struct usb_hcd which I think is
>> mostly unused right now. I think it would be much less
>> confusing/redundant to reuse that member for this purpose (you could
>> still set it up from xhci_plat_probe(), and then call it from
>> hcd_bus_resume() or something like that).
>
>
>    That member has type 'struct usb_phy *' while here we have 'struct phy *'
> -- feel the difference.
>    I have already tried adding 'struct phy *gen_phy' to 'struct usb_hcd',

So the 'struct phy *' available in the usb_hcd is requested in usb_add_hcd().
This is requested with the constant string 'usb' :
           struct phy *phy = phy_get(hcd->self.controller, "usb");

This can get the phy with string 'usb' only if, either the host
controller has a device node wherein the phys are given.
Even in this case one can't give same constant string for two
different phys, UTMI+ and PIPE3 phy, isn't it ?

Or, the other way can be when host gets a lookup table to look into to
find the relevant phys, something like
Heikki has suggested:
usb: dwc3: host: convey the PHYs to xhci
(https://lkml.org/lkml/2014/6/5/585) and related patch series.

So if we use this second approach, we would need to override the
'phy_get()' that has been done in usb_add_hcd()
in xhci_plat_probe(), and then use them in later operations.

am i getting the things correctly ?



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India

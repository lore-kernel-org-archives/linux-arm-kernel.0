From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 25 Jun 2014 02:34:03 +0400
Subject: [PATCH 2/4] usb: host: xhci-plat: Add support to get PHYs
In-Reply-To: <CAODwPW-2tbDht8P=KsTyTyeBivFtFMiyCpxd0QFa-cUSRTpJjQ@mail.gmail.com>
References: <1402056736-12674-1-git-send-email-gautam.vivek@samsung.com>	<1402056736-12674-3-git-send-email-gautam.vivek@samsung.com>
 <CAODwPW-2tbDht8P=KsTyTyeBivFtFMiyCpxd0QFa-cUSRTpJjQ@mail.gmail.com>
Message-ID: <53A9FCDB.6060805@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/10/2014 12:22 AM, Julius Werner wrote:

>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> index 9ffecd5..453d89e 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1582,6 +1582,9 @@ struct xhci_hcd {
>>          u32                     port_status_u0;
>>   /* Compliance Mode Timer Triggered every 2 seconds */
>>   #define COMP_MODE_RCVRY_MSECS 2000
>> +       /* phys for the controller */
>> +       struct phy              *phy2_gen;
>> +       struct phy              *phy3_gen;
>>   };

> I don't think adding new variables here and restricting most of this
> logic to xhci-plat.c (in the next patch) is the best way to do it.

    Indeed.

> There's no conceptual reason why other host controllers (e.g. xhci-pci
> or even EHCI) could not have a similar need to tune their PHY after
> reset. PHYs are universal to all host controllers.

> There is already a 'phy' member in struct usb_hcd which I think is
> mostly unused right now. I think it would be much less
> confusing/redundant to reuse that member for this purpose (you could
> still set it up from xhci_plat_probe(), and then call it from
> hcd_bus_resume() or something like that).

    That member has type 'struct usb_phy *' while here we have 'struct phy *' 
-- feel the difference.
    I have already tried adding 'struct phy *gen_phy' to 'struct usb_hcd', 
however Greg wasn't eager to pick that up so far. Here's the last posting of 
my patch:

http://marc.info/?l=linux-usb&m=140145917506582

WBR, Sergei

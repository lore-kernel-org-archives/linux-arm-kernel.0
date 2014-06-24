From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue, 24 Jun 2014 11:40:07 +0530
Subject: [PATCH 2/4] usb: host: xhci-plat: Add support to get PHYs
In-Reply-To: <CAODwPW-2tbDht8P=KsTyTyeBivFtFMiyCpxd0QFa-cUSRTpJjQ@mail.gmail.com>
References: <1402056736-12674-1-git-send-email-gautam.vivek@samsung.com>
 <1402056736-12674-3-git-send-email-gautam.vivek@samsung.com>
 <CAODwPW-2tbDht8P=KsTyTyeBivFtFMiyCpxd0QFa-cUSRTpJjQ@mail.gmail.com>
Message-ID: <CAFp+6iHUX0jn0xW6ijXmRpgXodp43_mBtVxnCcOb2H6duHvigQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Tue, Jun 10, 2014 at 1:52 AM, Julius Werner <jwerner@chromium.org> wrote:
>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> index 9ffecd5..453d89e 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1582,6 +1582,9 @@ struct xhci_hcd {
>>         u32                     port_status_u0;
>>  /* Compliance Mode Timer Triggered every 2 seconds */
>>  #define COMP_MODE_RCVRY_MSECS 2000
>> +       /* phys for the controller */
>> +       struct phy              *phy2_gen;
>> +       struct phy              *phy3_gen;
>>  };
>
> I don't think adding new variables here and restricting most of this
> logic to xhci-plat.c (in the next patch) is the best way to do it.
> There's no conceptual reason why other host controllers (e.g. xhci-pci
> or even EHCI) could not have a similar need to tune their PHY after
> reset. PHYs are universal to all host controllers.
>
> There is already a 'phy' member in struct usb_hcd which I think is
> mostly unused right now. I think it would be much less
> confusing/redundant to reuse that member for this purpose (you could
> still set it up from xhci_plat_probe(), and then call it from
> hcd_bus_resume() or something like that). Since XHCI host controllers
> already conveniently have two struct usb_hcd (one for 2.0 and one for
> 3.0), you can cleanly store references to your two PHYs in there.

Ok, i will look into the suggested approach, and raise flag in case i
have doubts.



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India

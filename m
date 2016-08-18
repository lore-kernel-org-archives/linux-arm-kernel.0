From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Thu, 18 Aug 2016 13:17:59 +0300
Subject: [PATCH v2 4/7] phy-sun4i-usb: Add support for phy_set_mode
In-Reply-To: <bf40c95d-ae2e-8980-90c9-f68415b06461@redhat.com>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
 <1471288892-21702-5-git-send-email-hdegoede@redhat.com>
 <6058a676-1e2c-0301-6edd-eee64b515b51@cogentembedded.com>
 <93bda5ac-4548-9e92-742c-baba7ed52849@redhat.com>
 <877fbe5xuk.fsf@linux.intel.com>
 <bf40c95d-ae2e-8980-90c9-f68415b06461@redhat.com>
Message-ID: <871t1m5qjs.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Hans de Goede <hdegoede@redhat.com> writes:

[...]

>>>>>  void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
>>>>>  {
>>>>>      struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
>>>> [...]
>>>>
>>>> $ scripts/checkpatch.pl ~/patches/phy-sun4i-usb-Add-support-for-phy_set_mode.patch
>>>> ERROR: trailing statements should be on next line
>>>> #29: FILE: drivers/phy/phy-sun4i-usb.c:439:
>>>> +    case PHY_MODE_USB_HOST:   data->dr_mode = USB_DR_MODE_HOST; break;
>>>>
>>>> ERROR: trailing statements should be on next line
>>>> #30: FILE: drivers/phy/phy-sun4i-usb.c:440:
>>>> +    case PHY_MODE_USB_DEVICE: data->dr_mode = USB_DR_MODE_PERIPHERAL; break;
>>>>
>>>> ERROR: trailing statements should be on next line
>>>> #31: FILE: drivers/phy/phy-sun4i-usb.c:441:
>>>> +    case PHY_MODE_USB_OTG:    data->dr_mode = USB_DR_MODE_OTG; break;
>>>
>>> This is normal codeing style for a switch-case assigning a single value per case,
>>> but checkpatch does not know this.
>>
>> I don't see that in CodingStyle
>
> It is an exception to the rule as such it is not listed, but this
> really is quite a normal thing to do in C code.
>
>> and it's quite ugly.
>
> So this is ugly:
>
>      switch (mode) {
>      case PHY_MODE_USB_HOST:   data->dr_mode = USB_DR_MODE_HOST; break;
>      case PHY_MODE_USB_DEVICE: data->dr_mode = USB_DR_MODE_PERIPHERAL; break;
>      case PHY_MODE_USB_OTG:    data->dr_mode = USB_DR_MODE_OTG; break;
>      default:
>          return -EINVAL;
>      }
>
> Where as this is not:
>
>      switch (mode) {
>      case PHY_MODE_USB_HOST:
>          data->dr_mode = USB_DR_MODE_HOST;
>          break;
>      case PHY_MODE_USB_DEVICE:
>          data->dr_mode = USB_DR_MODE_PERIPHERAL;
>          break;
>      case PHY_MODE_USB_OTG:
>          data->dr_mode = USB_DR_MODE_OTG;
>          break;
>      default:
>          return -EINVAL;
>      }
>
> ???
>
> IMHO the original version is much easier to read / makes it much
> clearer what the code is doing.
>
> But if you insist I can do a v3 changing the coding style to
> the (IMHO) uglier version.
>
> Also note that the real ugliness is that we've 3 different enums
> for host / device / dual-role. For some reason the musb code has
> 2 all of its own and then there is "enum phy_mode".
>
> Anyways let me know if you want a v3 with check-patch warnings
> fixed.

I see it's somewhat common even in drivers/usb:

$ git grep -ce "case \w+:.*break;" -- drivers/usb/ 
drivers/usb/gadget/udc/net2272.c:4
drivers/usb/host/ehci-hcd.c:3
drivers/usb/host/isp116x.h:2
drivers/usb/host/ohci-dbg.c:14
drivers/usb/host/sl811-hcd.c:7
drivers/usb/host/uhci-debug.c:8
drivers/usb/image/microtek.c:64
drivers/usb/mon/mon_text.c:6
drivers/usb/musb/musb_gadget.c:2
drivers/usb/serial/digi_acceleport.c:23
drivers/usb/serial/ftdi_sio.c:10
drivers/usb/serial/mct_u232.c:10
drivers/usb/serial/spcp8x5.c:17
drivers/usb/serial/whiteheat.c:4
drivers/usb/storage/debug.c:86

so I'm okay either way. Kishon has the final say here since he's
drivers/phy/ maintainer.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160818/83f1464c/attachment.sig>

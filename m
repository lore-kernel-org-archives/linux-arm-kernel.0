From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Fri, 07 Aug 2015 10:45:53 +0200
Subject: [linux-sunxi] [PATCH] musb: sunxi: Ignore VBus errors in host-only
 mode
In-Reply-To: <55C3709C.4080609@redhat.com>
References: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
 <55C31963.2010701@schinagl.nl> <55C3709C.4080609@redhat.com>
Message-ID: <55C47041.3000603@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Hans,

On 06-08-15 16:35, Hans de Goede wrote:
> Hi,
>
> On 06-08-15 10:22, Olliver Schinagl wrote:
>> Hey Hans,
>>
>> I've tried getting your musb stuff working on a cubietruck, but i 
>> don't seem to see this patch on your linux-sunxi/sunxi-wip branch on 
>> github? Is your github branch fully functional at the moment?
>>
>> What I have done so far, is build the kernel using sunxi_defconfig 
>> and enabled USB_MUSB_SUNXI with its dependancies (musb isn't enabled 
>> there by default): USB_SUPPORT [=y] && USB_MUSB_HDRC [=y] && 
>> ARCH_SUNXI [=y] && NOP_USB_XCEIV [=y] && PHY_SUN4I_USB [=y] && EXTCON 
>> [=y] && GENERIC_PHY [=y]  Selects: SUNXI_SRAM [=y]
>>
>> I changed the dts from dr_mode='otg' to dr_mode='host', a) we only 
>> need host mode anyway (the id pin isn't properly connected)
>
> If you change the dr_mode to host then you _must_ also remove any 
> id_det and vbus_det
> gpio settings from the usb_phy node in the dts, as the sun4i phy code 
> detects
> host vs otg mode by checking for the presence of these.
Yes, this fixes it and makes it work. Thanks.

Also I apologize for not noticing this patch in your queue before :) 
Looks like everything is all ready in your WIP branch.

Now, I see that Chen-Yu found the same problems here:
http://permalink.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/17843

So far, with your mentioned changes to remove the id and vbus gpio's you 
can have my

Tested-by: Olliver Schinagl <o.schinagl@ultimaker.com>

>
> > and b) I got an error about an known dr_mode before and this was the 
> quick and easy way.
>>
>> Dmesg produces the following related to musb.
>>
>> [    1.691062] usb_phy_generic.0.auto supply vcc not found, using 
>> dummy regulator
>> [    1.691445] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk 
>> combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
>> [    1.691453] musb-hdrc: MHDRC RTL version 0.0
>> [    1.691467] musb-hdrc: 11/11 max ep, 5184/8192 memory
>> [    1.691543] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
>> [    1.691553] musb-hdrc musb-hdrc.1.auto: new USB bus registered, 
>> assigned bus number 5
>> [    1.692470] hub 5-0:1.0: USB hub found
>> [    1.692529] hub 5-0:1.0: 1 port detected
>> [    1.699956] sunxi-rtc 1c20d00.rtc: setting system clock to 
>> 2015-08-06 07:59:08 UTC (1438847948)
>> [    1.704733] usb0-vbus: disabling
>> [    1.765695] ldo4: disabling
>> [    1.808351] ldo3: disabling
>> [    1.848769] vcc5v0: disabling
>> [    1.848774] vcc3v0: disabling
>>
>> The usb_phy_generic missing shouldn't be too bad? But the usb0-vbus 
>> being disabled obviously might be related to the musb port not working?
>
> Correct.
>
> For starters I would try the dts changes I suggested above.
Yep that fixed it.
>
> Regards,
>
> Hans

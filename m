From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Jan 2018 00:32:57 +0100
Subject: [PATCH] usb: dwc2: Fix endless deferral probe
In-Reply-To: <7ef21b99-67c8-b246-cc9a-b7202264a7a0@i2se.com>
References: <1515526134-2148-1-git-send-email-stefan.wahren@i2se.com>
 <CAK8P3a3eggC=XWLxr-A+pdaXj-0kMZ4aoX3hRyg5tLUknoDeBA@mail.gmail.com>
 <7ef21b99-67c8-b246-cc9a-b7202264a7a0@i2se.com>
Message-ID: <CAK8P3a3GdHvBBPR3D_qO5+Zjr1CUBMLOAvjTiMQEMO1NtKjb3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 1:15 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Arnd,
>
>
> Am 09.01.2018 um 22:33 schrieb Arnd Bergmann:
>>
>> On Tue, Jan 9, 2018 at 8:28 PM, Stefan Wahren <stefan.wahren@i2se.com>
>> wrote:
>>>
>>> The dwc2 USB driver tries to find a generic PHY first and then look
>>> for an old style USB PHY. In case of a valid generic PHY node without
>>> a PHY driver, the PHY layer will return -EPROBE_DEFER forever. So dwc2
>>> will never tries for an USB PHY.
>>>
>>> Fix this issue by finding a generic PHY and an old style USB PHY
>>> at once.
>>
>> This would fix only one of the USB controllers (dwc2), but not the others
>> that are affected. As I wrote in my suggested patch, dwc3 appears to be
>> affected the same way, and all other host drivers that call usb_add_hcd()
>> without first setting hcd->phy would suffer from this as well.
>>
>> If we go down the route of addressing it here in the hcd drivers, we
>> should
>> at least change all three of those, and hope this doesn't regress in
>> another way.
>>
>>         Arnd
>
>
> i fully unterstand. But we leaving the path of "fixing a critical issue on
> BCM2835" and go to "fixing multiple USB host controller". I do this all in
> my spare time and don't have any of the other USB controller available. So
> before i proceed with any other patch i like so see some feedback from John,
> Greg or Felipe.
>
> After finalizing this patch i think the chance is little that this would be
> applied to 4.15. So i seems to me that we still revert my DT clean up patch.

Could you confirm that this simpler patch fixes the problem for  you?
My feeling right now is that this would be the least invasive variant.
This is obviously a critical regression for BCM2835, but I'm fairly sure
it's just as critical for a lot of other SoCs that haven't done as much
testing on linux-next.

Hans has already verified the earlier (more complex) version, but my
analysis today has made it very likely that this one is fully sufficient
to fix all affected platforms.

Reverting all nine patches that add #phy-cells would still be an option,
but seems way more invasive at this point.

       Arnd

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b4964b067aec..93b55fb71d54 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -410,6 +410,10 @@ static struct phy *_of_phy_get(struct device_node
*np, int index)
        if (ret)
                return ERR_PTR(-ENODEV);

+       /* This phy type handled by the usb-phy subsystem for now */
+       if (of_device_is_compatible(np, "usb-nop-xceiv"))
+               return ERR_PTR(-ENODEV);
+
        mutex_lock(&phy_provider_mutex);
        phy_provider = of_phy_provider_lookup(args.np);
        if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {

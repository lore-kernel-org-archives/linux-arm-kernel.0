From: rogerq@ti.com (Roger Quadros)
Date: Tue, 2 Jun 2015 07:00:46 +0300
Subject: [PATCH 3/6] xhci: probe phy before add usb_hcd
In-Reply-To: <556C7770.70506@intel.com>
References: <1432727283-20303-1-git-send-email-chunfeng.yun@mediatek.com>	
 <1432727283-20303-4-git-send-email-chunfeng.yun@mediatek.com>	
 <20150527121843.GA8611@saruman.tx.rr.com>
 <1433170337.12128.18.camel@mtksdaap41> <556C7770.70506@intel.com>
Message-ID: <556D2A6E.4070802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathias.

On 01/06/15 18:17, Mathias Nyman wrote:
> On 01.06.2015 17:52, Yingjoe Chen wrote:
>> On Wed, 2015-05-27 at 07:18 -0500, Felipe Balbi wrote:
>>> On Wed, May 27, 2015 at 07:48:00PM +0800, chunfeng.yun at mediatek.com wrote:
>>>> From: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>>>
>>>> find the phy driver before add primary usb_hcd to avoid acessing
>>>> xHCI register which may hangup the system when the phy is not loaded
>>>> yet and the related powers or clocks put in phy driver are not
>>>> enabled.
>>>
>>> it seems like the same clock is needed by PHY and XHCI. This patch looks
>>> incorrect.
>>
>>
>> Hi,
>>
>> I agree that the driver should enable clock it used by itself and not
>> depends on init order. This should be fixed.
>>
>> But in general, I think it make sense to only add hcd after all required
>> resource are ready. At least it remove unnecessary calls to
>> usb_add_hcd/usb_remove_hcd. Is it better if the commit message is
>> changed to something like the below?
>>
>> Currently xhci_plat_probe() call usb_add_hcd before trying to init the
>> phy. However if the phy is not ready at the moment, it have to remove
>> the hcd and probe again later
>>
>> Change the init order so we only add hcd when all required resource are
>> ready.
>>
> Hi
>
> Rogers Quadros patchseries that changes how HCDs are created and added for
> xhci-plat was just sent forward. It first creates both HCDs, then adds them.
>
> Doesn't usb_add_hcd() as it's first task take care of the PHYs?
> I'm hoping to remove that part completely from xhci-plat.c but haven't
> looked into it properly yet.
>

usb_add_hcd() does

         if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->usb_phy) {
                 struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller, 0);
...
         if (IS_ENABLED(CONFIG_GENERIC_PHY) && !hcd->phy) {
                 struct phy *phy = phy_get(hcd->self.controller, "usb");
...

but xhci-plat.c does
	hcd->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);


So there needs to be some alignment.

cheers,
-roger

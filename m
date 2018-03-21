From: rogerq@ti.com (Roger Quadros)
Date: Wed, 21 Mar 2018 14:27:41 +0200
Subject: [usb-next PATCH] usb: xhci: skip phys initialization of shared hcd
In-Reply-To: <1521633020.3717.128.camel@mhfsdcap03>
References: <1ece0d5508a00bca67d16e64310a071646b59c7d.1521612280.git.chunfeng.yun@mediatek.com>
 <ae71fdae-43aa-9df3-3f81-8a92460d61b9@ti.com>
 <1521633020.3717.128.camel@mhfsdcap03>
Message-ID: <99d5db89-0ba3-84df-5238-6edd6a3d99a1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/18 13:50, Chunfeng Yun wrote:
> Hi Roger,
> 
> On Wed, 2018-03-21 at 11:05 +0200, Roger Quadros wrote:
>> Hi Chunfeng,
>>
>> On 21/03/18 08:12, Chunfeng Yun wrote:
>>> The phys has already been initialized when add primary hcd,
>>> including usb2 phys and usb3 phys also if exist, so needn't
>>> re-parse "phys" property again.
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> ---
>>>  drivers/usb/host/xhci-mtk.c  | 1 +
>>>  drivers/usb/host/xhci-plat.c | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
>>> index 7334da9..6bb23fb 100644
>>> --- a/drivers/usb/host/xhci-mtk.c
>>> +++ b/drivers/usb/host/xhci-mtk.c
>>> @@ -554,6 +554,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>>>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>>>  		xhci->shared_hcd->can_do_streams = 1;
>>>  
>>> +	xhci->shared_hcd->skip_phy_initialization = 1;
>>>  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>>>  	if (ret)
>>>  		goto dealloc_usb2_hcd;
>>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>>> index 6700e5e..65a4294 100644
>>> --- a/drivers/usb/host/xhci-plat.c
>>> +++ b/drivers/usb/host/xhci-plat.c
>>> @@ -294,6 +294,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>>>  		xhci->shared_hcd->can_do_streams = 1;
>>>  
>>> +	xhci->shared_hcd->skip_phy_initialization = 1;
>>
>> I think this is unnecessary.
>> There aren't separate PHYs for the primary and shared HCDs right?
> Yes, the primary and shared HCDs will get the same PHYs provided by
> "phys" property.
> 
>>
>> Also how can you be sure that phy_init() has been done for all platform HCD users?
> Here I assume that "phys" and "usb-phy" properties are not used at the
> same time. There are two cases:
> 1. Using "usb-phy": no "phys" to be got by shared HCD.
> 2. Using "phys": the primary HCD will get those phys, so shared HCD can
> skip them.

Now I see the problem.
But the right fix should be in core/hcd.c

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 2884607..1d1da12 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2757,7 +2757,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		}
 	}
 
-	if (!hcd->skip_phy_initialization) {
+	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 		hcd->phy_roothub = usb_phy_roothub_init(hcd->self.sysdev);
 		if (IS_ERR(hcd->phy_roothub)) {
 			retval = PTR_ERR(hcd->phy_roothub);

> 
>>
>>>  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>>>  	if (ret)
>>>  		goto dealloc_usb2_hcd;
>>>
>>
> 
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

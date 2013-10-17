From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Oct 2013 09:54:26 -0500
Subject: [PATCH v2 1/7] usb: dwc3: get "usb_phy" only if the platform
 indicates the presence of PHY's
In-Reply-To: <525E943E.3080706@ti.com>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-2-git-send-email-kishon@ti.com>
 <525E8E93.9010503@ti.com> <525E9046.3090209@ti.com>
 <525E943E.3080706@ti.com>
Message-ID: <20131017145425.GE11611@gimli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 04:27:26PM +0300, Roger Quadros wrote:
> On 10/16/2013 04:10 PM, Kishon Vijay Abraham I wrote:
> > Hi roger,
> > 
> > On Wednesday 16 October 2013 06:33 PM, Roger Quadros wrote:
> >> Hi Kishon,
> >>
> >> On 10/15/2013 10:54 PM, Kishon Vijay Abraham I wrote:
> >>> There can be systems which does not have a external usb_phy, so get
> >>> usb_phy only if dt data indicates the presence of PHY in the case of dt boot or
> >>> if platform_data indicates the presence of PHY. Also remove checking if
> >>> return value is -ENXIO since it's now changed to always enable usb_phy layer.
> >>>
> >>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>> ---
> >>> In usb_get_phy_by_phandle, index 0 always refers to usb2 phy and index 1 always
> >>> refers to usb3 phy. Since we've lived so long with this, this patch will make
> >>> an assumption that if only one entry is populated in *usb-phy* property, it will
> >>> be usb2 phy and the next entry will be usb3 phy.
> >>>
> >>>  drivers/usb/dwc3/Kconfig         |    1 +
> >>>  drivers/usb/dwc3/core.c          |   72 ++++++++++++++++++++------------------
> >>>  drivers/usb/dwc3/platform_data.h |    2 ++
> >>>  3 files changed, 41 insertions(+), 34 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> >>> index 70fc430..8e385b4 100644
> >>> --- a/drivers/usb/dwc3/Kconfig
> >>> +++ b/drivers/usb/dwc3/Kconfig
> >>> @@ -1,6 +1,7 @@
> >>>  config USB_DWC3
> >>>  	tristate "DesignWare USB3 DRD Core Support"
> >>>  	depends on (USB || USB_GADGET) && HAS_DMA
> >>> +	select USB_PHY
> >>>  	select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
> >>>  	help
> >>>  	  Say Y or M here if your system has a Dual Role SuperSpeed
> >>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> >>> index 474162e..cb91d70 100644
> >>> --- a/drivers/usb/dwc3/core.c
> >>> +++ b/drivers/usb/dwc3/core.c
> >>> @@ -354,6 +354,7 @@ static int dwc3_probe(struct platform_device *pdev)
> >>>  	struct device_node	*node = dev->of_node;
> >>>  	struct resource		*res;
> >>>  	struct dwc3		*dwc;
> >>> +	int			count;
> >>>  
> >>>  	int			ret = -ENOMEM;
> >>>  
> >>> @@ -387,16 +388,49 @@ static int dwc3_probe(struct platform_device *pdev)
> >>>  	if (node) {
> >>>  		dwc->maximum_speed = of_usb_get_maximum_speed(node);
> >>>  
> >>> -		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
> >>> -		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
> >>> +		count = of_count_phandle_with_args(node, "usb-phy", NULL);
> >>> +		switch (count) {
> >>> +		case 2:
> >>> +			dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev,
> >>> +				"usb-phy", 1);
> >>> +			if (IS_ERR(dwc->usb3_phy)) {
> >>> +				dev_err(dev, "usb3 phy not found\n");
> >>> +				return PTR_ERR(dwc->usb3_phy);
> >>> +			}
> >>> +		case 1:
> >>> +			dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev,
> >>> +				"usb-phy", 0);
> >>> +			if (IS_ERR(dwc->usb2_phy)) {
> >>> +				dev_err(dev, "usb2 phy not found\n");
> >>> +				return PTR_ERR(dwc->usb2_phy);
> >>> +			}
> >>> +			break;
> >>
> >> In the Exynos case, there is only 1 phy and it is the USB3 phy. This code
> >> will wrongly treat it as usb2_phy.
> > 
> > That was the case even before this patch no? Unfortunately the old USB PHY
> > library doesn't have APIs to get PHYs in a better way. If we try modifying the
> > USB PHY library, it'll be kind of duplicating what is already there in the
> > Generic PHY library. I'd rather prefer Exynos guys to use the new framework.
> 
> OK. I agree with you.
> Do you know if there are users of dwc3 other than exynos5250 and omap5?
> If not, we should get rid of the old USB PHY altogether.

Intel's Baytrail, at least. But they don't use DT.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131017/e02c7e58/attachment-0001.sig>

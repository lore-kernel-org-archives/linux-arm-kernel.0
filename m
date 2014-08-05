From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 5 Aug 2014 10:11:48 -0400 (EDT)
Subject: [PATCH RESEND] usb: ehci/ohci-exynos: Fix PHY getting sequence
In-Reply-To: <1407235148-31790-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <Pine.LNX.4.44L0.1408051006570.1227-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Aug 2014, Vivek Gautam wrote:

> Since we want to keep support for both older usb-phys as well as the
> newer generic phys, lets first get the generic PHYs and fallback to
> older USB-PHYs only when we fail to get the former.
> This should fix the issue with ehci-exynos and ohci-exynos, wherein
> in the absence of SAMSUNG_USB2PHY config symbol, we end up getting
> the NOP_USB_XCEIV phy when the same is enabled. And thus the PHYs
> are not configured properly.
> 
> Reported-by: Sachin Kamat <sachin.kamat@samsung.com>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Jingoo Han <jg1.han@samsung.com>
> ---
> 
> Based on 'usb-next' branch.
> Resending it after adding 'Reported-by' tag.
> 
>  drivers/usb/host/ehci-exynos.c |   40 +++++++++++++++++-----------------
>  drivers/usb/host/ohci-exynos.c |   47 +++++++++++++++++++---------------------
>  2 files changed, 42 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> index cda0a2f..2eed9a4 100644
> --- a/drivers/usb/host/ehci-exynos.c
> +++ b/drivers/usb/host/ehci-exynos.c
> @@ -62,18 +62,6 @@ static int exynos_ehci_get_phy(struct device *dev,
>  	int phy_number;
>  	int ret = 0;
>  
> -	exynos_ehci->phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> -	if (IS_ERR(exynos_ehci->phy)) {
> -		ret = PTR_ERR(exynos_ehci->phy);
> -		if (ret != -ENXIO && ret != -ENODEV) {
> -			dev_err(dev, "no usb2 phy configured\n");
> -			return ret;
> -		}
> -		dev_dbg(dev, "Failed to get usb2 phy\n");
> -	} else {
> -		exynos_ehci->otg = exynos_ehci->phy->otg;
> -	}
> -
>  	for_each_available_child_of_node(dev->of_node, child) {
>  		ret = of_property_read_u32(child, "reg", &phy_number);
>  		if (ret) {
> @@ -90,15 +78,27 @@ static int exynos_ehci_get_phy(struct device *dev,

What about the code that you skipped here?  Suppose the 
of_property_read_32() call returns an error.  Do you then want to abort 
the whole thing, or should you go on to try the old usb_phy?

Alan Stern

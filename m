From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 27 Apr 2016 10:21:44 +0300
Subject: [RESEND PATCH v2 6/7] usb: xhci: plat: add generic PHY support
In-Reply-To: <20160427144649.67304003@xhacker>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-7-git-send-email-jszhang@marvell.com>
 <87eg9rpq9t.fsf@intel.com> <20160427144649.67304003@xhacker>
Message-ID: <874mano6t3.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Jisheng Zhang <jszhang@marvell.com> writes:
>> > +static void xhci_plat_phy_exit(struct usb_hcd *hcd)
>> > +{
>> > +	if (hcd->phy) {
>> > +		phy_power_off(hcd->phy);
>> > +		phy_exit(hcd->phy);
>> > +	} else {
>> > +		usb_phy_shutdown(hcd->usb_phy);
>> > +	}
>> > +}
>> > +
>> >  static int xhci_plat_probe(struct platform_device *pdev)
>> >  {
>> >  	struct device_node	*node = pdev->dev.of_node;
>> > @@ -145,6 +177,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>> >  	struct usb_hcd		*hcd;
>> >  	struct clk              *clk;
>> >  	struct usb_phy		*usb_phy;
>> > +	struct phy		*phy;  
>> 
>> so, one phy driver using USB PHY layer and another using generic PHY
>> layer ? Why ? I think the first thing your series should do would be to
>
> It's different platforms. E.g
> platform A may write the phy driver under usb phy layer, while platform B
> may have generic phy driver.

right, but both APIs should be supported with *two* PHYs for the time being.

> The questions are: when adding phy support to xhci-plat, the generic phy
> has existed for a long time, what's the reason to use the deprecated usb
> phy APIs.

I don't know, ask the author :-) Maybe the PHY driver was already
available on the USB PHY layer ? What we should do is push that PHY
driver to be moved over to generic PHY layer, then we can get rid of USB
PHY layer from xhci-plat.

> And per my check, it's only MVEBU platforms use this support? I'm not sure
> if we could remove usbphy code from xhci-plat first then add generic phy then
> adding MVEBU xhci phy support bak with the new code. So Cc mvebu maintainers

First the PHY driver(s) depending on that should be converted over.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/554d3060/attachment.sig>

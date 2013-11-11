From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 11 Nov 2013 09:47:32 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIHVzYjogY2hpcGlkZWE6IHVzYm1pc2M6IEFkZCBz?=
 =?UTF-8?B?dXBwb3J0IGZvciBpLk1YMjcvaS5NWDMxIENQVXM=?=
In-Reply-To: <52806C24.8040100@gtsys.com.hk>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <1384145140.400290349@f353.i.mail.ru>
 <52806C24.8040100@gtsys.com.hk>
Message-ID: <1384148852.19743495@f117.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Monday, November 11, 2013 12:45 PM, Alexander Shiyan wrote:
> >> Hi Alexander,
> >>
> >> On Sunday, November 10, 2013 03:18 PM, Alexander Shiyan wrote:
> >>> This adds i.MX27 and i.MX31 as the next user of the usbmisc driver.
> >>>
> >>> Signed-off-by: Alexander Shiyan<shc_work@mail.ru>
> >>> ---
> >>>    drivers/usb/chipidea/usbmisc_imx.c | 42 ++++++++++++++++++++++++++++++++++++++
> >>>    1 file changed, 42 insertions(+)
> >>>
> >>> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> > ...
> >>> +static int usbmisc_imx27_init(struct imx_usbmisc_data *data)
> >>> +{
> >>> +	unsigned long flags;
> >>> +	u32 val;
> >>> +
> >>> +	switch (data->index) {
> >>> +	case 0:
> >>> +		val = MX27_OTG_PM_BIT;
> >>> +		break;
> >>> +	case 1:
> >>> +		val = MX27_H1_PM_BIT;
> >>> +		break;
> >>> +	case 2:
> >>> +		val = MX27_H2_PM_BIT;
> >>> +		break;
> >>> +	default:
> >>> +		return -EINVAL;
> >>> +	};
> >>> +
> >>
> >>    From my understanding this can not work, the usbmisc->base not point into the
> >> usb control register (USB_CTRL). Reference manual 30.5.1.1 says
> >> BASE + 0x600
> >> you must add the offset to the readl instruction.
> >
> > Why not work?
> > usbotg: usb at 10024000
> > usbh1: usb at 10024200
> > usbh2: usb at 10024400
> > usbmisc: usbmisc at 10024600
> > So, offset to USB_CTRL should already be defined by DTS.
> 
> in the usbmisc_imx_probe() the base pointer is loaded from
> 
> res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> data->base = devm_ioremap_resource(&pdev->dev, res);
> 
> (and I did not see any of_ operations)

Yes, and this is an address of usbmisc node, not otg.

> usbmisc = data;
> 
>   base is set to 0x10024000
> 
> when I look around all other functions init functions did a offset calculation.

Can you point me on this?
For example, for i.MX5 CPUs we calculate only offset to PHY_CTRL_X register
relative to basic offset 0x800, which is already defined in DTS.

...

---

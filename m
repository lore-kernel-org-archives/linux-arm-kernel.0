From: balbi@ti.com (Felipe Balbi)
Date: Sat, 13 Sep 2014 21:24:52 -0500
Subject: [Patch v9 3/3] phy: Add Qualcomm DWC3 HS/SS PHY driver
In-Reply-To: <5413E829.8020804@ti.com>
References: <1410550088-8754-1-git-send-email-agross@codeaurora.org>
 <1410550088-8754-4-git-send-email-agross@codeaurora.org>
 <5413E829.8020804@ti.com>
Message-ID: <20140914022452.GA16652@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 13, 2014 at 12:16:01PM +0530, Kishon Vijay Abraham I wrote:
> On Saturday 13 September 2014 12:58 AM, Andy Gross wrote:
> > This patch adds a new driver for the Qualcomm USB 3.0 PHY that exists on some
> > Qualcomm platforms.  This driver uses the generic PHY framework and will
> > interact with the DWC3 controller.
> 
> Do you have dt documentation for this driver?

see patch 1

> > +static inline void qcom_dwc3_phy_write_readback(
> > +	struct qcom_dwc3_usb_phy *phy_dwc3, u32 offset,
> > +	const u32 mask, u32 val)
> > +{
> > +	u32 write_val, tmp = readl(phy_dwc3->base + offset);
> > +
> > +	tmp &= ~mask;		/* retain other bits */
> > +	write_val = tmp | val;
> > +
> > +	writel(write_val, phy_dwc3->base + offset);
> > +
> > +	/* Read back to see if val was written */
> 
> Does it fail sometime? I'm not sure if this should be present in the
> driver since this looks more of a debug code.

this was mentioned before. Silicon bug.

> > +	writel_relaxed(data | SSUSB_CTRL_SS_PHY_RESET,
> > +		phy_dwc3->base + SSUSB_PHY_CTRL_REG);
> > +	usleep_range(2000, 2200);
> 
> use msleep here..

why ? usleep_range() gives the scheduler oportunity to group timers.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/c5a41db9/attachment.sig>

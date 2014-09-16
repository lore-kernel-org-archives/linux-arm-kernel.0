From: agross@codeaurora.org (Andy Gross)
Date: Tue, 16 Sep 2014 15:39:52 -0500
Subject: [Patch v9 3/3] phy: Add Qualcomm DWC3 HS/SS PHY driver
In-Reply-To: <20140916182752.GB19101@usblab-sd-06.qualcomm.com>
References: <1410550088-8754-1-git-send-email-agross@codeaurora.org>
 <1410550088-8754-4-git-send-email-agross@codeaurora.org>
 <20140916182752.GB19101@usblab-sd-06.qualcomm.com>
Message-ID: <20140916203952.GA31819@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 11:27:52AM -0700, Jack Pham wrote:
> Hi Andy,
> 
> On Fri, Sep 12, 2014 at 02:28:08PM -0500, Andy Gross wrote:
> > +static int qcom_dwc3_hs_phy_init(struct qcom_dwc3_usb_phy *phy_dwc3)
> > +{
> > +	u32 val;
> > +
> > +	/*
> > +	 * HSPHY Initialization: Enable UTMI clock, select 19.2MHz fsel
> > +	 * enable clamping, and disable RETENTION (power-on default is ENABLED)
> > +	 */
> > +	val = HSUSB_CTRL_DPSEHV_CLAMP | HSUSB_CTRL_DMSEHV_CLAMP |
> > +		HSUSB_CTRL_RETENABLEN  | HSUSB_CTRL_COMMONONN |
> > +		HSUSB_CTRL_OTGSESSVLD_CLAMP | HSUSB_CTRL_ID_HV_CLAMP |
> > +		HSUSB_CTRL_DPSEHV_CLAMP | HSUSB_CTRL_UTMI_OTG_VBUS_VALID |
> > +		HSUSB_CTRL_UTMI_CLK_EN | HSUSB_CTRL_CLAMP_EN | 0x70;
> > +
> > +	/* use core clock if external reference is not present */
> > +	if (!phy_dwc3->xo_clk)
> > +		val |= HSUSB_CTRL_USE_CLKCORE;
> > +
> > +	writel(val, phy_dwc3->base + HSUSB_PHY_CTRL_REG);
> > +	usleep_range(2000, 2200);
> > +
> > +	/* Disable (bypass) VBUS and ID filters */
> > +	writel(HSUSB_GCFG_XHCI_REV, phy_dwc3->base + QSCRATCH_GENERAL_CFG);
> 
> Is this comment accurate? I believe this bit forces the IP to behave in
> XHCI rev 1.0. In which case, shouldn't it be done in the glue driver?

I'll double check.  I was taking the bit values and converting them to names.
If this is doing that, then I'll move it to the glue.


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

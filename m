From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Oct 2012 12:07:24 +0300
Subject: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
In-Reply-To: <508509C6.10708@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-9-git-send-email-t-kristo@ti.com>
 <20121018103334.GA1449@arwen.pp.htv.fi>
 <1350562684.2143.52.camel@sokoban>
 <20121018135352.GC2739@arwen.pp.htv.fi>
 <1350571199.2143.53.camel@sokoban> <508509C6.10708@ti.com>
Message-ID: <20121022090723.GE14033@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 02:24:30PM +0530, kishon wrote:
> Hi,
> 
> On Thursday 18 October 2012 08:09 PM, Tero Kristo wrote:
> >On Thu, 2012-10-18 at 16:53 +0300, Felipe Balbi wrote:
> >>hi,
> >>
> >>On Thu, Oct 18, 2012 at 03:18:04PM +0300, Tero Kristo wrote:
> >>>>>+static int __init omap4430_phy_power_down(void)
> >>>>>+{
> >>>>>+	void __iomem *ctrl_base;
> >>>>>+
> >>>>>+	if (!cpu_is_omap44xx())
> >>>>>+		return 0;
> >>>>>+
> >>>>>+	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
> >>>>>+	if (!ctrl_base) {
> >>>>>+		pr_err("control module ioremap failed\n");
> >>>>>+		return -ENOMEM;
> >>>>>+	}
> >>>>>+
> >>>>>+	/* Power down the phy */
> >>>>>+	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> >>>>>+
> >>>>>+	iounmap(ctrl_base);
> >>>>>+
> >>>>>+	return 0;
> >>>>>+}
> >>>>>+early_initcall(omap4430_phy_power_down);
> >>>>>+#endif
> >>>>
> >>>>I think you could do it even if the driver is enabled.
> >>>
> >>>Actually not at least now, it looks like the driver is not controlling
> >>>this bit at all, so the driver would fail if we do this.
> >>
> >>then we can consider that a bug in the driver. Kishon, I thought you had
> >>added SCM address space to PHY driver for this particular reason until
> >>we get SCM driver, wasn't it ??
> >
> >Yes, I would say its a bug in the driver.
> 
> No. It's done in the driver (omap_usb_phy_power() in
> drivers/usb/phy/omap-usb2.c). We explicitly power off the phy during
> probe in the driver.

so you also handle enabling the IP later when you need ? That's great,
it means we can do the above unconditionally, driver enabled or not.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121022/927ddcc6/attachment-0001.sig>

From: balbi@ti.com (Felipe Balbi)
Date: Thu, 18 Oct 2012 16:53:52 +0300
Subject: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
In-Reply-To: <1350562684.2143.52.camel@sokoban>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-9-git-send-email-t-kristo@ti.com>
 <20121018103334.GA1449@arwen.pp.htv.fi>
 <1350562684.2143.52.camel@sokoban>
Message-ID: <20121018135352.GC2739@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Thu, Oct 18, 2012 at 03:18:04PM +0300, Tero Kristo wrote:
> > > +static int __init omap4430_phy_power_down(void)
> > > +{
> > > +	void __iomem *ctrl_base;
> > > +
> > > +	if (!cpu_is_omap44xx())
> > > +		return 0;
> > > +
> > > +	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
> > > +	if (!ctrl_base) {
> > > +		pr_err("control module ioremap failed\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	/* Power down the phy */
> > > +	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> > > +
> > > +	iounmap(ctrl_base);
> > > +
> > > +	return 0;
> > > +}
> > > +early_initcall(omap4430_phy_power_down);
> > > +#endif
> > 
> > I think you could do it even if the driver is enabled.
> 
> Actually not at least now, it looks like the driver is not controlling
> this bit at all, so the driver would fail if we do this.

then we can consider that a bug in the driver. Kishon, I thought you had
added SCM address space to PHY driver for this particular reason until
we get SCM driver, wasn't it ??

> > Just to make sure I understand the issue right: is the PHY enabled by
> > default or did bootloader left this enabled ?
> 
> The reset value for the register is zero (at least according to TRM), so
> it is enabled from boot. Also, I couldn't find any code from the u-boot
> that would touch this bit with a quick look.

ok, so it looks like we must do this anyway, thanks ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121018/51556c03/attachment.sig>

From: w-kwok2@ti.com (Kwok, WingMan)
Date: Thu, 15 Oct 2015 20:08:32 +0000
Subject: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
In-Reply-To: <5192855.p6QLDWTiVi@wuerfel>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
 <1444919145-30845-2-git-send-email-w-kwok2@ti.com>
 <5192855.p6QLDWTiVi@wuerfel>
Message-ID: <230CBA6E4B6B6B418E8730AC28E6FC7E04228DB8@DFLE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, October 15, 2015 10:51 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Kwok, WingMan; robh+dt at kernel.org; pawel.moll at arm.com;
> mark.rutland at arm.com; ijc+devicetree at hellion.org.uk; galak at codeaurora.org;
> KISHON VIJAY ABRAHAM; Quadros, Roger; Karicheri, Muralidharan;
> bhelgaas at google.com; ssantosh at kernel.org; linux at arm.linux.org.uk;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> pci at vger.kernel.org
> Subject: Re: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and
> pcie
> 
> On Thursday 15 October 2015 10:25:44 WingMan Kwok wrote:
> > On TI's Keystone platforms, several peripherals such as the
> > gbe ethernet switch, 10gbe ethernet switch and PCIe controller
> > require the use of a SerDes for converting SoC parallel data into
> > serialized data that can be output over a high-speed electrical
> > interface, and also converting high-speed serial input data
> > into parallel data that can be processed by the SoC.  The
> > SerDeses used by those peripherals, though they may be different,
> > are largely similar in functionality and setup.
> >
> > This patch provides a SerDes phy driver implementation that can be
> > used by the above mentioned peripheral drivers to configure their
> > respective SerDeses.
> >
> > v1:
> > 	- see cover letter for review comments addressed.
> >
> > Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> > ---
> >  Documentation/devicetree/bindings/phy/ti-phy.txt |  278 +++
> >  drivers/phy/Kconfig                              |    8 +
> >  drivers/phy/Makefile                             |    1 +
> >  drivers/phy/phy-keystone-serdes.c                | 2373
> ++++++++++++++++++++++
> >  4 files changed, 2660 insertions(+)
> >  create mode 100644 drivers/phy/phy-keystone-serdes.c
> 
> This is quite a bit of code. Are you very sure that this PHY is
> not used on any other SoC family, and that it is not licensed
> from a third party? I would hate to see multiple copies of
> this getting merged into the kernel over time, so thename should
> be chosen carefully to let the next person know when they have
> related hardware.
> 
> > +
> > +gbe_serdes0: gbe_serdes at 232a000 {
> 
> 
> make that phy at 232a000, the name should be one of the usual identifiers,
> not specific to the instance.
> 

will change to something like gbe_serdes0: phy at 232a000 {};

> > +config PHY_TI_KEYSTONE_SERDES
> > +	tristate "TI Keystone SerDes PHY support"
> > +	depends on OF && ARCH_KEYSTONE
> > +	select GENERIC_PHY
> > +	help
> > +	  This option enables support for TI Keystone SerDes PHY found
> > +	  in peripherals GBE, 10GBE and PCIe.
> > +
> 
> (ARCH_KEYSTONE || COMPILE_TEST) ?
> 

will add COMPILE_TEST

> > + * Redistributions in binary form must reproduce the above copyright
> > + * notice, this list of conditions and the following disclaimer in the
> > + * documentation and/or other materials provided with the
> > + * distribution.
> 
> The current code does not do this when compiled, which might be a
> problem for distributors. Can you clarify the license?
> 

will investigate

> > +#define reg_rmw(addr, value, mask) \
> > +	__raw_writel(((__raw_readl(addr) & (~(mask))) | \
> > +			(value & (mask))), (addr))
> 
> not endian safe, and potentially racy.
> 

will change to 

#define reg_rmw(addr, value, mask) \
	writel(((readl(addr) & (~(mask))) | \
			(value & (mask))), (addr))

> > +static inline void _kserdes_reset_cdr(void __iomem *sregs, int lane)
> > +{
> > +	/* toggle signal detect */
> > +	_kserdes_force_signal_detect_low(sregs, lane);
> > +	mdelay(1);
> > +	_kserdes_force_signal_detect_high(sregs, lane);
> > +}
> 
> Can you change the code so you can use msleep(1) here?
> 

will replace delays with usleep_range()

> > +
> > +	do {
> > +		mdelay(10);
> > +		memset(lane_down, 0, sizeof(lane_down));
> > +
> > +		link_up = _kserdes_check_link_status(dev, sregs,
> > +						     pcsr_regmap, lanes,
> > +						     lanes_enable,
> > +						     current_state, lane_down);
> > +
> > +		/* if we did not get link up then wait 100ms
> > +		 * before calling it again
> > +		 */
> > +		if (link_up)
> > +			break;
> > +
> > +		for (i = 0; i < lanes; i++) {
> > +			if ((lanes_enable & (1 << i)) && lane_down[i])
> > +				dev_dbg(dev,
> > +					"XGE: detected lane down on lane %d\n",
> > +					i);
> > +		}
> > +
> > +		if (++retries > 100)
> > +			return -ETIMEDOUT;
> > +
> > +	} while (!link_up);
> 
> an more importantly here. Blocking the CPU for over one second is not good.
> 
> Any use of mdelay() should have a comment explaining why you cannot use
> msleep() in that instance.
> 

will replace delays with usleep_range()

> > +
> > +static int __init keystone_serdes_phy_init(void)
> > +{
> > +	return platform_driver_register(&kserdes_driver);
> > +}
> > +module_init(keystone_serdes_phy_init);
> > +
> > +static void __exit keystone_serdes_phy_exit(void)
> > +{
> > +	platform_driver_unregister(&kserdes_driver);
> > +}
> > +module_exit(keystone_serdes_phy_exit);
> 
> module_platform_driver()
> 	

will do.

> 	Arnd

Thanks,
WingMan

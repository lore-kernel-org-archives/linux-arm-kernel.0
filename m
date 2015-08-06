From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Aug 2015 08:19:18 +0200
Subject: [PATCH v3 5/8] ARM: mediatek: add smp bringup code for MT6580
In-Reply-To: <1801910.hz53dYUgta@ubix>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
 <1438696464-59858-6-git-send-email-scott.shu@mediatek.com>
 <1801910.hz53dYUgta@ubix>
Message-ID: <20150806061918.GK18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 06:47:03PM +0200, Matthias Brugger wrote:
> On Tuesday, August 04, 2015 09:54:21 PM Scott Shu wrote:
> > Add support for cpu enable-method "mediatek,mt6580-smp" for booting
> > secondary CPUs on MT6580.
> > 
> > Signed-off-by: Scott Shu <scott.shu@mediatek.com>
> > ---
> >  arch/arm/mach-mediatek/platsmp.c |  137
> > ++++++++++++++++++++++++++++++++++++++ 1 file changed, 137 insertions(+)
> > +
> > +static void __init mt6580_smp_prepare_cpus(unsigned int max_cpus)
> > +{
> > +	static void __iomem *infracfg_ao_base;
> > +
> > +	infracfg_ao_base = ioremap(MT6580_INFRACFG_AO, 0x1000);
> > +	if (!infracfg_ao_base) {
> > +		pr_err("%s: Unable to map I/O memory\n", __func__);
> > +		return;
> > +	}
> > +
> > +	/* Enable bootrom power down mode */
> > +	writel_relaxed(readl(infracfg_ao_base + 0x804) | SW_ROM_PD,
> > +		       infracfg_ao_base + 0x804);
> 
> Please use a define for the offset.
> I prefer to not cascade reads and writes but to use a temporary variable. But 
> if this is fine with the kernel coding style (I doubt, but I'm not sure) then 
> this is fine.

For what it's worth I also prefer

	val = readl(infracfg_ao_base + 0x804);
	val |= SW_ROM_PD:
	writel_relaxed(val, infracfg_ao_base + 0x804);

I find this better readable. I don't think though that there's common
agreement that this style is better.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

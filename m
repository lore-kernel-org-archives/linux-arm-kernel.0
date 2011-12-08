From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Dec 2011 15:41:39 +0000
Subject: [PATCH v4 3/6] ARM: vexpress: Add DT support for the motherboard
In-Reply-To: <1323340679.32116.26.camel@hornet.cambridge.arm.com>
References: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
 <47277884.EQ6QaTZjNt@wuerfel>
 <1323340679.32116.26.camel@hornet.cambridge.arm.com>
Message-ID: <201112081541.39263.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 December 2011, Pawel Moll wrote:
> On Wed, 2011-12-07 at 22:49 +0000, Arnd Bergmann wrote:
> > On Tuesday 06 December 2011 15:43:46 Pawel Moll wrote:
> > > +
> > > +static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
> > > +       OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash",
> > > +                       &v2m_flash_data),
> > > +       OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
> > > +       {}
> > > +};
> > 
> > One more thing I noticed. While I'm not familiar with the progress on
> > device driver conversion, 
> 
> I'm aware of these two last non-DT bits and actually already started
> working on them, but this won't happen this year (I'm on holiday
> starting next Friday without any access to Internet whatsoever :-)

Ok, fine with me. Let's make sure we get everything else ready for 3.3
then.

> > I think you should be using the physmap_of
> > driver instead of physmap, which will remove the need for the
> > platform data.
> 
> There's one bit missing in the physmap_of. The "set_vpp" handle which is
> used on VE:
> 
> static struct physmap_flash_data v2m_flash_data = {
>         .width          = 4,
>         .set_vpp        = v2m_flash_set_vpp,
> };      
> 
> My plan is to extend the physmap_of driver so it could operate VPP via
> gpio API and make the sysreg a gpio controller, having Flash VPP, CF &
> MMC card detects and DVI output control (that's for CLCD) as internal
> GPIO lines.
> 
> > For mmci, it should not be hard to do change the driver so it
> > understands the device tree, too. The easiest implementation for
> > that would be to add some code into mmci_probe and allocate
> > an mmci_platform_data structure that gets filled with the required
> > attributes.
> 
> I've started the implementation already, but it turned out much trickier
> that I was hoping... One thing is the "status" handle (card detect line
> "virtual gpio" I mentioned above), the second problem is the fact that
> mmci platform data can take generic caps MMC_CAP_* from
> include/linux/mmc/host.h (now even caps2 as well)... This issue was
> already briefly mentioned here:
> http://article.gmane.org/gmane.linux.kernel.samsung-soc/7639 and as
> there was no generic resolution my plan is to reuse as much properties
> from other MMC host controllers and forge the missing one (as a superset
> of ARM's and STE's cell implementations). But as I said, it's unlikely
> to happen this year...

I see. Thanks for the explanation.

	Arnd

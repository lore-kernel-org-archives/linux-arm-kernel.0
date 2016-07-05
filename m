From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jul 2016 10:09:09 +0200
Subject: [PATCH 1/6] ARM: NUC900: Add nuc970 machine support
In-Reply-To: <577B63EF.6030906@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <4806020.41AJ9s5VGu@wuerfel> <577B63EF.6030906@iommu.org>
Message-ID: <5195754.U9Bku6gEdi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 5, 2016 3:38:23 PM CEST Wan Zongshun wrote:
> On 2016?06?29? 23:19, Arnd Bergmann wrote:
> >> diff --git a/arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h b/arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h
> >> new file mode 100644
> >> index 0000000..e7eb653
> >> --- /dev/null
> >> +++ b/arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h
> >
> > Can you move the new headers to arch/arm/mach-w90x900/ directly?
> >
> >> +static int __init nuc900_restart_init(void)
> >> +{
> >> +	struct device_node *np;
> >> +
> >> +	np = of_find_compatible_node(NULL, NULL, "nuvoton,gcr");
> >> +	wtcr_addr = of_iomap(np, 0);
> >> +	if (!wtcr_addr)
> >> +		return -ENODEV;
> >> +
> >> +	of_node_put(np);
> >> +
> >> +	return 0;
> >> +}
> >
> > Is this a watchdog node? If it is, the restart logic should just
> > move into the watchdog driver.
> 
> It is not watchdog node, just be global System control register node.

Ok. Then I'd say it should go into drivers/power/reset/

If you make the the gcr a syscon node, you can probably use the
syscon-reboot driver directly, or as a reference.

> >> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
> >
> > We have actually moved away from using the soc_device as using the parent
> > for the other devices, just probe them separately. In fact the soc_device
> > could be handled by a driver in drivers/soc/nuvoton/
> 
> Do you think I should add nuc900 soc driver in this folder?

Yes.

> If I want to add nuc900 soc driver in drivers/soc/nuvoton/, can I keep 
> my current dts structure no change, or Must I add a new node name soc {}?
>
> I went through the code:soc-realview.c for reference, but I have no idea
> about how to re-structure my dts file to match this type soc driver.

You don't need to change the DT for this, all the driver needs to
do now is to find out the information about the soc and register it
as a soc_device so it shows up in sysfs.

> >> +static const char *nuc970_dt_compat[] __initconst = {
> >> +	"nuvoton,nuc970evb",
> >> +	NULL,
> >> +};
> >> +
> >> +void nuc970_restart(enum reboot_mode mode, const char *cmd)
> >> +{
> >> +	if (wtcr_addr) {
> >> +		while (__raw_readl(wtcr_addr + REG_WRPRTR) != 1) {
> >> +			__raw_writel(0x59, wtcr_addr + REG_WRPRTR);
> >> +			__raw_writel(0x16, wtcr_addr + REG_WRPRTR);
> >> +			__raw_writel(0x88, wtcr_addr + REG_WRPRTR);
> >> +		}
> >> +
> >> +		__raw_writel(1, wtcr_addr + REG_AHBIPRST);
> >> +	}
> >
> > Please use writel() instead of __raw_writel().
> 
> Does this change apply to all others drivers? or just machine file to 
> use writel()?

All drivers. You don't need to immediately change existing drivers, we
can clean them up some other day, but please use readl/writel for new code.

	Arnd

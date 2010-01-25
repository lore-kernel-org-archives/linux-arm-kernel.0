From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 25 Jan 2010 13:54:45 +0000
Subject: Default machine include placements
In-Reply-To: <20100125120454.GD16340@n2100.arm.linux.org.uk>
References: <20100125040255.GN26562@trinity.fluff.org>
	<20100125100546.GA16340@n2100.arm.linux.org.uk>
	<20100125103216.GB5772@digital-scurf.org>
	<20100125104425.GO26562@trinity.fluff.org>
	<20100125104959.GC5772@digital-scurf.org>
	<20100125105503.GQ26562@trinity.fluff.org>
	<20100125111940.GC16340@n2100.arm.linux.org.uk>
	<20100125115344.GS26562@trinity.fluff.org>
	<20100125120454.GD16340@n2100.arm.linux.org.uk>
Message-ID: <20100125135445.GU26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 12:04:54PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 25, 2010 at 11:53:44AM +0000, Ben Dooks wrote:
> > > I personally think that the proliferation of mach-s* directories for
> > > Samsung is becoming a problem in itself - some of these directories
> > > contain next to nothing, and others are duplications with minimal
> > > changes.
> > > 
> > > For example, the differences between s3c6400 and s3c6410 are minimal,
> > > yet they have most of the contained non-board code duplicated.
> > 
> > I would disagree on that, most of the common s3c6400 and s3c6410 is
> > contained in plat-s3c64xx with the machine directories containing the
> > cpu sepcific initialisation bits, such as the changes in the ARM CLKDIV
> > the VIC popuilation and the extra devices that the s3c6410 have.
> 
> You may disagree, but my comment was based upon diffing the two
> directories, and comparing mach-s3c6400/s3c6400.c with mach-s3c6410/cpu.c:
> 
> First, comparing the common files between the two directories:
> 
> -char *s3c6400_hsmmc_clksrcs[4] = {
> +char *s3c6410_hsmmc_clksrcs[4] = {
> ...
> -void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
> -                                 void __iomem *r,
> -                                 struct mmc_ios *ios,
> -                                 struct mmc_card *card)
> +
> +void s3c6410_setup_sdhci0_cfg_card(struct platform_device *dev,
> +                                   void __iomem *r,
> +                                   struct mmc_ios *ios,
> +                                   struct mmc_card *card)
> ...
> +       /* don't need to alter anything acording to card-type */
> +
> +       writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r + S3C64XX_SDHCI_CONTROL4);
> +
> 
> And s3c6400.c vs cpu.c, taking account of the different prefixes used
> for variables and function names (so s3c6410 -> s3c6400):
> 
> +#include <plat/s3c6400.h>
> +
> +/* Initial IO mappings */
> +
> +static struct map_desc s3c6400_iodesc[] __initdata = {
> +};
> +
> +/* s3c6400_map_io
> + *
> + * register the standard cpu IO areas
> +*/
> ...
> -       /* setup SDHCI */
> +       iotable_init(s3c6400_iodesc, ARRAY_SIZE(s3c6400_iodesc));

we should have probably culled the cpiu specific iotables
 
> +       /* initialise device information early */
> ...
> +       s3c_i2c1_setname("s3c2440-i2c");
> ...
> -       s3c6400_register_clocks(S3C6400_CLKDIV0_ARM_MASK);
> +       s3c6400_register_clocks(S3C6410_CLKDIV0_ARM_MASK);

yeah, the s3c6410 armdiv clock divider is larger.

> ...
> -       /* VIC0 does not have IRQS 5..7,
> -        * VIC1 is fully populated. */
> -       s3c64xx_init_irq(~0 & ~(0xf << 5), ~0);
> +       /* VIC0 is missing IRQ7, VIC1 is fully populated. */
> +       s3c64xx_init_irq(~0 & ~(1 << 7), ~0);
> ...
> -       printk("S3C6400: Initialising architecture\n");
> +       printk("S3C6410: Initialising architecture\n");
> 
> >From all that, the only material differences are:
> 
> 1. the VIC initialization
> 2. the sdhci drive strength
> 3. the presence of a second i2c port
> 4. the CLKDIV0_ARM_MASK
> 
> The rest of the non-board support code is identical in those two
> directories.
> 
> > It does however mean that mach-s3c6400 and mach-s3c6410 are not heavily
> > populated with machines, especially as the intended new Openmoko device
> > never appeared.
> 
> Given the above, and the "mass population" hasn't happened, maybe part
> of the solution to the duplicated header file problem is to start
> combining some of these directories?

For plat-s3c64xx/mach-s3c6400/mach-s3c6410 how about moving the
plat-s3c64xx in with the machine definitions, as it is quite clear
now that it is unlikely to have any friends to join it (dev work is
on s5p and onwards).

Either arch/arm/mach-s3c64xx and have all s3c6400 and s3c6410 machines
in there, or keep the two mach- directories... I think i'd prefer to
see the two directories culled into one.

For the s3c24xx case, it probably is the best case to merges s3c2440 and
s3c2442 into mach-s3c244x as they are pretty similar.

s3c2443 is on list of things to expand, it is a different beast to the
predecessors.

I'll try making patches for this tomorrow and see what people think?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 7 Jan 2015 14:45:47 +0100
Subject: [PATCH 1/4] mtd: nand: add NVIDIA Tegra NAND Flash controller
 driver
In-Reply-To: <1420590278.25483.14.camel@lynxeye.de>
References: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
 <54AC290B.5000606@vanguardiasur.com.ar>
 <1420590278.25483.14.camel@lynxeye.de>
Message-ID: <20150107134545.GC6988@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 01:24:38AM +0100, Lucas Stach wrote:
> Am Dienstag, den 06.01.2015, 15:27 -0300 schrieb Ezequiel Garcia:
> > On 01/04/2015 05:39 PM, Lucas Stach wrote:
[...]
> > > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> > > index 7d0150d..1eafd4e 100644
> > > --- a/drivers/mtd/nand/Kconfig
> > > +++ b/drivers/mtd/nand/Kconfig
> > > @@ -524,4 +524,10 @@ config MTD_NAND_SUNXI
> > >  	help
> > >  	  Enables support for NAND Flash chips on Allwinner SoCs.
> > >  
> > > +config MTD_NAND_TEGRA
> > > +	tristate "Support for NAND on NVIDIA Tegra"
> > > +	depends on ARCH_TEGRA || COMPILE_TEST

I think you're going to need a bunch more dependencies if you use
COMPILE_TEST. Otherwise we're going to get all kinds of build failure
reports.

> > > diff --git a/drivers/mtd/nand/tegra_nand.c b/drivers/mtd/nand/tegra_nand.c
[...]
> > > +struct tegra_nand {
> > > +	void __iomem *regs;
> > > +	int irq;
> > 
> > Seems like you don't need to store irq.
> > 
> > > +	struct clk *clk;
> > > +	struct reset_control *rst;
> > > +	int wp_gpio;
> > > +	int buswidth;
> > 
> > And also you don't seem to need either wp_gpio or buswidth stored
> > in the struct. You only use them at probe time.
> > 
> 
> I'll keep the wp_gpio, as I still hope to use this to WP the NAND when
> no write is pending. I'll fix the others.

Maybe use the gpiod_*() API since the old one is new deprecated?

> > > +static const struct of_device_id tegra_nand_of_match[] = {
> > > +	{ .compatible = "nvidia,tegra20-nand" },
> > > +	{ .compatible = "nvidia,tegra30-nand" },
> > 
> > AFAIK, having two compatible strings, but making no distinction between
> > them is typically frowned upon by devicetree maintainers.
> > 
> > Is the controller any different in tegra20 and tegra30?
> > 
> > If you are not sure about the controllers being different, you can
> > try the following approach. The devicetree is written like this:
> > 
> > nand at foo {
> >    compatible = "nvidia,tegra20-nand", "nvidia,tegra-nand";
> > };
> > 
> > So you only deal with "nvidia,tegra-nand" in the driver, yet the
> > devicetree files are prepared to deal with a difference.

I think it's been more common to have something like this:

	tegra20.dtsi:

		nand-controller at 70008000 {
			compatible = "nvidia,tegra20-nand";
			...
		};

	tegra30.dtsi:

		nand-controller at 70008000 {
			compatible = "nvidia,tegra30-nand", "nvidia,tegra20-nand";
			...
		};

The idea being that if the Tegra30 variant is indeed compatible with the
Tegra20 variant, the driver can match on "nvidia,tegra20-nand". But at
the same time the DTB has the more specific compatible in case the
driver ever needs to handle generation-specific quirks, or implement any
additional functionality added in Tegra30 that wasn't available in early
generations.

> I believe that tegra30-nand is actually a bit different from tegra20 (at
> least on more clock I know about), but obviously this driver doesn't
> handle those differences and I don't know if I ever get to see Tegra30
> hardware with NAND. Given that I think it's best to just remove the
> tegra30-nand compatible for now and add it back if someone has hardware
> to test with.

Yes, that sounds like the best option for now.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150107/e10768d1/attachment.sig>

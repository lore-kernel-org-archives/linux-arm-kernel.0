From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Aug 2013 21:08:38 +0200
Subject: [RFC v1 5/5] ARM: mvebu: add board init for Armada 1500
In-Reply-To: <20130816204831.GX13964@titan.lakedaemon.net>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-6-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130816204831.GX13964@titan.lakedaemon.net>
Message-ID: <201308172108.38824.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 August 2013, Jason Cooper wrote:
> > +
> > +#define ARMADA_1500_REG_BASE_VIRT	0xf6000000
> > +#define ARMADA_1500_REG_BASE_SIZE	0x03000000
> > +
> > +static struct map_desc armada_1500_io_desc[] __initdata = {
> > +	{
> > +		.virtual	= ARMADA_1500_REG_BASE_VIRT,
> > +		.pfn		= __phys_to_pfn(ARMADA_1500_REG_BASE_VIRT),
> > +		.length		= ARMADA_1500_REG_BASE_SIZE,
> > +		.type		= MT_DEVICE,
> > +	},
> > +};

You should really try to find out what driver uses this. If you have a requirement
that VIRT == PHYS here, the most likely explanation is that some driver accidentally
uses readl/writel on the physical address rather than on the result of ioremap.

You can try shrinking the area using bisection until you have found the offending
driver based on the address.

> > +static void __init armada_1500_timer_and_clk_init(void)
> > +{
> > +	of_clk_init(NULL);
> > +	clocksource_of_init();
> > +}
> > +
> > +static void __init armada_1500_dt_init(void)
> > +{
> > +	l2x0_of_init(0x70c00000, 0xfeffffff);

New platforms should call this as 'l2x0_of_init(0, 0);' and get the bits from DT.

Note that we should really change the common code to do both the of_clk_init()
and the l2x0_of_init() automatically, but that needs to be done with some care,
in order to not break any of the existing platforms. Would you be able to do
one of the two? We can then get the next person that wants to add a platform
to do the last one ;-)

	Arnd

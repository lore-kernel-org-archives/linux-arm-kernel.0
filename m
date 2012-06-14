From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Jun 2012 19:43:56 +0100
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <201206141227.48867.arnd@arndb.de>
References: <1339578251-15009-1-git-send-email-zhouqiao@marvell.com>
 <1339578251-15009-2-git-send-email-zhouqiao@marvell.com>
 <201206141227.48867.arnd@arndb.de>
Message-ID: <20120614184356.GC30185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 12:27:48PM +0000, Arnd Bergmann wrote:
> On Wednesday 13 June 2012, Qiao Zhou wrote:

> > +static struct mfd_cell onkey_devs[] = {
> > +	{
> > +	 .name = "88pm80x-onkey",
> > +	 .num_resources = 1,
> > +	 .resources = &onkey_resources[0],
> > +	 .id = -1,
> > +	 },
> > +};

> I wonder if it really makes sense to use the mfd_cell abstraction here, when each
> array only contains a single device. Why not just use
> platform_device_register_simple()? 

mfd_cell does some other stuff like let you pass in bases for the various
resource ranges when you register which looks to be being used here.

> > +static irqreturn_t pm805_irq(int irq, void *data)
> > +{
> > +	struct pm80x_chip *chip = data;
> > +	struct pm80x_subchip *pm805_chip = chip->pm805_chip;
> > +	struct pm80x_irq_data *irq_data;
> > +	struct i2c_client *i2c;
> > +	int i, read_reg = -1, value = 0;

> The functions for pm800 and pm805 look almost identical. Have you tried
> consolidating them so you can use the same irqchip and code with different
> init data structures?

Since you use regmap perhaps you can use regmap_irq and just convert
them into data?

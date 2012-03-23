From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Mar 2012 19:31:05 +0000
Subject: ioremap to a specific virtual address
In-Reply-To: <CAKON4OybXXwLEmg19NJnLsE5kB16U6Dm4ay3=XCUB57fRfz+ng@mail.gmail.com>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <201203231520.22588.arnd@arndb.de>
 <CAKON4OybXXwLEmg19NJnLsE5kB16U6Dm4ay3=XCUB57fRfz+ng@mail.gmail.com>
Message-ID: <201203231931.06376.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 March 2012, jonsmirl at gmail.com wrote:
> On Fri, Mar 23, 2012 at 11:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 23 March 2012, jonsmirl at gmail.com wrote:
> >> I will need to check how similar the chips actually are. NXP did not
> >> use primecells in the lpc31xx family.
> >>
> >> I'd be happy to have some help. My trees are here:
> >> https://github.com/jonsmirl
> >
> > I've taken a brief look at your tree, some comments:
> >
> > * Once you're done with the DT conversion, you should be able to
> >  completely remvoe the three board files. You probably know that already
> 
> Thanks for the feedback.
> 
> I don't think I can completely remove the board files. Some of the
> generic devices have board specific callbacks. DM9000 for example. I
> am setting up of_dev_auxdata for the boards so that I can pass these
> callbacks in.

There are some cases where it's not possible to avoid platform_data,
but in most cases there is another better solution.

If you end up having to use platform_data, the auxdata mechanism
is the way to go.

> # define DM_IO_DELAY()	do { gpio_get_value(GPIO_MNAND_RYBN3);} while(0)
> 
> static void dm9000_dumpblk(void __iomem *reg, int count)
> {
> 	int i;
> 	int tmp;
> 
> 	count = (count + 1) >> 1;
> 	for (i = 0; i < count; i++) {
> 		DM_IO_DELAY();
> 		tmp = readw(reg);
> 	}
> }
> 
> static void dm9000_inblk(void __iomem *reg, void *data, int count)
> {
> 	int i;
> 	u16* pdata = (u16*)data;
> 	count = (count + 1) >> 1;
> 	for (i = 0; i < count; i++) {
> 		DM_IO_DELAY();
> 		*pdata++ = readw(reg);
> 	}
> }
> 
> static struct dm9000_plat_data dm9000_platdata = {
> 	.flags		= DM9000_PLATF_16BITONLY | DM9000_PLATF_NO_EEPROM |
> DM9000_PLATF_SIMPLE_PHY,

The flags can become simple empty properties if necessary, so there is no
need to keep these.

> 	.dumpblk = dm9000_dumpblk,
> 	.inblk = dm9000_inblk,
> };

I can see two possible ways besides platform_data for the register access:

1. generalize the driver's accessors. Since your platform wants to read
a gpio pin before every access, you can provide a gpio line as the
property in the dm9000 device node and access that in the same place
in the common code if the gpio line is set, but skip the access otherwise.
No other platform in mainline actually needs to overrid the functions,
so there are hardly any disadvantages to this. 

2. convert the entire driver to use the "regmap" infrastructure to abstract
the registers, and implement a driver that implements the slow I/O. This
would be a rather complex solution and probably not worth it, compared
with the overhead of the first one or just staying with auxdata.

If any problem turns out to be really hard to convert over from
platform_data to device tree properties, auxdata is usually an acceptable
solution, or you could submit the port with more of those hacks when
there is reason to believe that you will fix them up later.

	Arnd

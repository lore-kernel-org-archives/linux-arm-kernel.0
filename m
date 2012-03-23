From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 23 Mar 2012 14:28:28 -0400
Subject: ioremap to a specific virtual address
In-Reply-To: <201203231520.22588.arnd@arndb.de>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <201203231407.00686.arnd@arndb.de>
 <CAKON4OzF9KV=51yAR2pVHJZNQsGDkXVhBwbn4njhZPRjeh=-dA@mail.gmail.com>
 <201203231520.22588.arnd@arndb.de>
Message-ID: <CAKON4OybXXwLEmg19NJnLsE5kB16U6Dm4ay3=XCUB57fRfz+ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 11:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 23 March 2012, jonsmirl at gmail.com wrote:
>> I will need to check how similar the chips actually are. NXP did not
>> use primecells in the lpc31xx family.
>>
>> I'd be happy to have some help. My trees are here:
>> https://github.com/jonsmirl
>
> I've taken a brief look at your tree, some comments:
>
> * Once you're done with the DT conversion, you should be able to
> ?completely remvoe the three board files. You probably know that already

Thanks for the feedback.

I don't think I can completely remove the board files. Some of the
generic devices have board specific callbacks. DM9000 for example. I
am setting up of_dev_auxdata for the boards so that I can pass these
callbacks in.

# define DM_IO_DELAY()	do { gpio_get_value(GPIO_MNAND_RYBN3);} while(0)

static void dm9000_dumpblk(void __iomem *reg, int count)
{
	int i;
	int tmp;

	count = (count + 1) >> 1;
	for (i = 0; i < count; i++) {
		DM_IO_DELAY();
		tmp = readw(reg);
	}
}

static void dm9000_inblk(void __iomem *reg, void *data, int count)
{
	int i;
	u16* pdata = (u16*)data;
	count = (count + 1) >> 1;
	for (i = 0; i < count; i++) {
		DM_IO_DELAY();
		*pdata++ = readw(reg);
	}
}

static struct dm9000_plat_data dm9000_platdata = {
	.flags		= DM9000_PLATF_16BITONLY | DM9000_PLATF_NO_EEPROM |
DM9000_PLATF_SIMPLE_PHY,
	.dumpblk = dm9000_dumpblk,
	.inblk = dm9000_inblk,
};

>
> * We're merging the new common clock framework in v3.4. Once that has
> ?matured, all new platforms will be required to use it. You should probably
> ?move to that already.
>
> * The dma driver uses a nonstandard interface and should be moved to
> ?drivers/dma, using the dmaengine API.
>
> * The __REG needs to be removed. All MMIO register accesses should go
> ?through readl/writel or readl_relaxed/writel_relaxed, using a pointer
> ?you get from ioremap.
>
> * gpio*.c should get moved to drivers/gpio/gpio-lpc31xx. If it's similar
> ?to the 32xx version, merge the two
>
> * i2c.c should no longer be needed with the device tree, but you might
> ?have to add stuff to i2c-pnx.c. That file is shared with pnx4008 and
> ?lpc32xx.
>
> * irq.c will eventually go to drivers/irqchip/. We have a plan to create
> ?that directory, but nobody has started moving drivers there.
>
> * Some of the header files have been removed on other platforms, you
> ?should do the same.
>
> * Regarding the static mappings, it certainly makes sense to map all of
> ?ABP01_PHYS and IO_APB2_PHYS using 1MB mappings, for performance reasons,
> ?and I guess you need INTC_PHYS to be mapped, too, for the interrupt
> ?controller code to work. However, none of the drivers should be aware
> ?of this and just call ioremap anyway, which will now return an address
> ?from the static mapping.
>
> ? ? ? ?Arnd



-- 
Jon Smirl
jonsmirl at gmail.com

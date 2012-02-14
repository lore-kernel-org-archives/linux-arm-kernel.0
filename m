From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 14 Feb 2012 09:58:46 +0800
Subject: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
In-Reply-To: <20120213194014.GG11077@ponder.secretlab.ca>
References: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
 <20120209152340.GB11249@ponder.secretlab.ca>
 <5EB3BFCD089AD643B9BB63439F5FD5E99CB93BC5@SHAASIEXM01.ASIA.ROOT.PRI>
 <20120213194014.GG11077@ponder.secretlab.ca>
Message-ID: <CAGsJ_4wLRzYQw8MZt1CpNY27ta7-CquLPVPxe0L5U0XL8bgeUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/14 Grant Likely <grant.likely@secretlab.ca>:
> On Fri, Feb 10, 2012 at 05:06:15AM +0000, Barry Song wrote:
>> Hi Grant,
>> > > +
>> > > +struct sirfsoc_spi {
>> > > + struct spi_bitbang bitbang;
>> > > + struct completion done;
>> > > +
>> > > + u32 irq;
>> >
>> > irq is set once and never used outside the probe function. ?Doesn't need
>> > to be here.
>>
>> ok
>> >
>> > > + void __iomem *base;
>> > > + u32 ctrl_freq; ?/* SPI controller clock speed */
>> > > + struct clk *clk;
>> > > + int bus_num;
>> >
>> > bus_num is unused
>>
>> Ok.
>>
>> > > +
>> > > +static void spi_sirfsoc_tasklet_tx(unsigned long arg)
>> > > +{
>> > > + struct sirfsoc_spi *sspi = (struct sirfsoc_spi *)arg;
>> > > +
>> > > + /* Fill Tx FIFO while there are left words to be transmitted */
>> > > + while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS) &
>> > > + ? ? ? ? ? ? ? ? SIRFSOC_SPI_FIFO_FULL)) &&
>> > > + ? ? ? ? ? ? ? ? sspi->left_tx_cnt)
>> > > + ? ? ? ? sspi->tx_word(sspi);
>> >
>> > Potential problem: if for any reason the device stalls and the FULL bit
>> > doesn't get cleared, then this function will be stuck in a tight loop. ?This
>> > may not be an issue, but it should be considered.
>>
>> Might timeout check.
>>
>> > > +
>> > > +static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
>> > > +{
>> > > + struct sirfsoc_spi *sspi = spi_master_get_devdata(spi->master);
>> > > + struct sirfsoc_spi_ctrldata *ctl_data = spi->controller_data;
>> >
>> > Where does controller_data come from? ?It is not set in the driver, and it is
>> > *not* something that the spi_device driver or the board code is allowed to set.
>> >
>> > If the driver needs controller_data, then it needs to be added to each spi
>> > device by the spi controller driver when the slave device is registered.
>> >
>> The controller_data is mainly for various kinds of chip selection. We might have a CS pin, a GPIO from prima2, or a GPIO from an extended MCU side by side with prima2.
>> It seems like you think this driver should handle all different kinds of chip selection support and implement those callbacks in it? And every spi client use DT to describe the CS pin?
>
> What I am saying is that controller_data should not be prepopulated at
> spi_device registration time. ?That pointer is 'owned' by the spi controller
> and if it is used, should be set by the spi_master.

 i think yes. in my case, actually spi controller driver only uses
controller data to differentiate three kinds of chip select:
1. one only HW pin in spi controller
2. gpio from prima2
3. gpio from another MCU connected with prima2

so no matter what the chip selections come from, they should belows to
spi controller driver. 2 and 3 are actually same because actually we
need a gpio driver for 3 as well. gpio from MCU should also be used
based on generic Linux APIs.
The only problem is how to differentiate 1 and 2/3, now in my patch
v4, spi controller data is deleted, if gpio is set to 0 in CS array of
DT, i think it as a CS pin from spi controller, otherwise it is gpio.
do you have any better idea about it?

>
> If the spi_master needs a controller_data pointer, then that data should
> either be passed to the spi_master via the spi_master's platform_data, or it
> should be decoded from the device tree. ?In either case, it is the
> responsibility of the spi_master driver to set the value of controller_data
> for each of its spi_device children.
>
> Does that make sense?
>
> g.

-barry

From: Ben.Whitten@lairdtech.com (Ben Whitten)
Date: Mon, 2 Jul 2018 20:43:55 +0000
Subject: [RFC net-next 15/15] net: lora: Add Semtech SX1301
In-Reply-To: <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
Message-ID: <BY1PR02MB111481D94EB0D68AD5FCA689E7430@BY1PR02MB1114.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
> 
> Hi Mark,
> 
> This driver is still evolving, there's newer code on my lora-next branch
> already: https://github.com/afaerber/linux/commits/lora-next
> 
> The reason you're in CC on this RFC is two-fold:
> 
> 1) You applied Ben's patch to associate "semtech,sx1301" with spidev,
> whereas I am now preparing a new driver for the same compatible.
> 
> 2) This SPI device is in turn exposing the two SPI masters that you
> already found below, and I didn't see a sane way to split that code out
> into drivers/spi/, so it's in drivers/net/lora/ here - has there been
> any precedence either way?

In my work in progress driver I just register one controller for the sx1301 with two chip selects and use the chip select information to choose the correct radio to send to, this is based on the DT reg information. No need to register two separate masters.

> More inline ...
> 
> Am 02.07.2018 um 18:12 schrieb Mark Brown:
> > On Sun, Jul 01, 2018 at 01:08:04PM +0200, Andreas F?rber wrote:
> >
> >> +static void sx1301_radio_spi_set_cs(struct spi_device *spi, bool enable)
> >> +{
> >> +	int ret;
> >> +
> >> +	dev_dbg(&spi->dev, "setting SPI CS to %s\n", enable ? "1" : "0");
> >> +
> >> +	if (enable)
> >> +		return;
> >> +
> >> +	ret = sx1301_radio_set_cs(spi->controller, enable);
> >> +	if (ret)
> >> +		dev_warn(&spi->dev, "failed to write CS (%d)\n", ret);
> >> +}
> >
> > So we never disable chip select?
> 
> Not here, I instead did that in transfer_one below.
> 
> Unfortunately there seems to be no documentation, only reference code:
> 
> https://github.com/Lora-
> net/lora_gateway/blob/master/libloragw/src/loragw_radio.c#L121
> https://github.com/Lora-
> net/lora_gateway/blob/master/libloragw/src/loragw_radio.c#L165
> 
> It sets CS to 0 before writing to address and data registers, then
> immediately sets CS to 1 and back to 0 before reading or ending the
> write transaction. I've tried to force the same behavior in this driver.
> My guess was that CS is high-active during the short 1-0 cycle, because
> if it's low-active during the register writes then why the heck is it
> set to 0 again in the end instead of keeping at 1... confusing.
> 
> Maybe the Semtech folks CC'ed can comment how these registers work?
> 
> >> +	if (tx_buf) {
> >> +		ret = sx1301_write(ssx->parent, ssx->regs +
> REG_RADIO_X_ADDR, tx_buf ? tx_buf[0] : 0);
> >
> > This looks confused.  We're in an if (tx_buf) block but there's a use of
> > the ternery operator that appears to be checking if we have a tx_buf?
> 
> Yeah, as mentioned this RFC is not ready for merging - checkpatch.pl
> will complain about lines too long, and TODOs are sprinkled all over or
> not even mentioned. It's a Proof of Concept that a net_device could work
> for a wide range of spi and serdev based drivers, and on top this device
> has more than one channel, which may influence network-level design
> discussions.
> 
> That said, I'll happily drop the second check. Thanks for spotting!
> 
> >> +		if (ret) {
> >> +			dev_err(&spi->dev, "SPI radio address write
> failed\n");
> >> +			return ret;
> >> +		}
> >> +
> >> +		ret = sx1301_write(ssx->parent, ssx->regs +
> REG_RADIO_X_DATA, (tx_buf && xfr->len >= 2) ? tx_buf[1] : 0);
> >> +		if (ret) {
> >> +			dev_err(&spi->dev, "SPI radio data write failed\n");
> >> +			return ret;
> >> +		}
> >
> > This looks awfully like you're coming in at the wrong abstraction layer
> > and the hardware actually implements a register abstraction rather than
> > a SPI one so you should be using regmap as the abstraction.
> 
> I don't understand. Ben has suggested using regmap for the SPI _device_
> that we're talking to, which may be a good idea. But this SX1301 device
> in turn has two SPI _masters_ talking to an SX125x slave each. I don't
> see how using regmap instead of my wrappers avoids this spi_controller?
> The whole point of this spi_controller is to abstract and separate the
> SX1255 vs. SX1257 vs. whatever-radio-attached into a separate driver,
> instead of mixing it into the SX1301 driver - to me that looks cleaner
> and more extensible. It also has the side-effect that we could configure
> the two radios via DT (frequencies, clk output, etc.).

You want an SPI controller in the SX1301 as the down stream radios are SPI and could be attached directly to a host SPI bus, makes sense to have one radio driver and talk through the SX1301.
But you should use the regmap to access the SX1301 master controller registers.
Example I use with one SPI master and some clock info:
eg:
	sx1301: sx1301 at 0 {
		compatible = "semtech,sx1301";
		reg = <0>;
		#address-cells = <1>;
		#size-cells = <0>;
		spi-max-frequency = <8000000>;
		gpios-reset = <&pioA 26 GPIO_ACTIVE_HIGH>;
		clocks = <&radio1 0>, <&clkhs 0>;
		clock-names = "clk32m", "clkhs";

		radio0: sx1257 at 0 {
			compatible = "semtech,sx125x";
			reg = <0>;
			spi-max-frequency = <8000000>;
			tx;
			clocks = <&tcxo 0>;
			clock-names = "tcxo";
		};

		radio1: sx1257 at 1 {
			compatible = "semtech,sx125x";
			reg = <1>;
			spi-max-frequency = <8000000>;
			#clock-cells = <0>;
			clocks = <&tcxo 0>;
			clock-names = "tcxo";
			clock-output-names = "clk32m";
		};
};


> You will find a datasheet with some diagrams mentioning "SPI" at:
> https://www.semtech.com/products/wireless-rf/lora-gateways/SX1301
> 
> >> +	if (rx_buf) {
> >> +		ret = sx1301_read(ssx->parent, ssx->regs +
> REG_RADIO_X_DATA_READBACK, &rx_buf[xfr->len - 1]);
> >> +		if (ret) {
> >> +			dev_err(&spi->dev, "SPI radio data read failed\n");
> >> +			return ret;
> >> +		}
> >> +	}
> >
> > For a read we never set an address?
> 
> To read, you first write the address via tx_buf, then either in the same
> transfer in the third byte or in a subsequent one-byte transfer as first
> byte you get the data.
> 
> If you have better ideas how to structure this, do let me know.
> 
> >> +static void sx1301_radio_setup(struct spi_controller *ctrl)
> >> +{
> >> +	ctrl->mode_bits = SPI_CS_HIGH | SPI_NO_CS;
> >
> > This controller has no chip select but we provided a set_cs operation?
> 
> Oops, I played around with those two options and was hoping SPI_NO_CS
> would avoid the undesired set_cs invocations, but it didn't work as
> expected and so I added the "if (enabled)" check above.
> 
> Thanks for your review,
> 
> Andreas
> 
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)

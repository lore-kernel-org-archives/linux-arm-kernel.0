From: sr@denx.de (Stefan Roese)
Date: Tue, 12 Apr 2016 13:43:27 +0200
Subject: [PATCH v3] spi: orion.c: Add direct access mode
In-Reply-To: <20160411105740.GB3351@sirena.org.uk>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk>
Message-ID: <570CDF5F.9070106@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.04.2016 12:57, Mark Brown wrote:
> On Thu, Apr 07, 2016 at 02:06:51PM +0200, Stefan Roese wrote:
> 
>> @@ -372,10 +383,44 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>>   {
>>   	unsigned int count;
>>   	int word_len;
>> +	struct orion_spi *orion_spi;
>> +	int cs = spi->chip_select;
>>   
>>   	word_len = spi->bits_per_word;
>>   	count = xfer->len;
>>   
>> +	orion_spi = spi_master_get_devdata(spi->master);
>> +
>> +	/* Use SPI direct access mode if base address is available */
>> +	if (orion_spi->direct_access[cs].vaddr) {
>> +		struct orion_direct_acc *da = &orion_spi->direct_access[cs];
>> +
>> +		if (count > da->size) {
>> +			dev_err(&spi->dev,
>> +				"max transfer size exceeded (%d > %d)\n",
>> +				count, da->size);
>> +			return 0;
>> +		}
> 
> This seems obviously broken, we're neither returning an error nor
> falling back to PIO here but instead silently ignoring the transfer.

Its not silently ignored (dev_err above) but I agree, we should be
able to fall back to PIO mode in this condition. I'll change this in
v4.

>  If
> we can't fall back then I'd expect the driver to be setting
> max_transfer_size but it isn't, it's probably a good idea from a
> performance point of view to set it even if we can fall back.

Okay, I'll add max_transfer_size() to v4.
 
>> +		if (xfer->tx_buf) {
>> +			/*
>> +			 * Send the tx-data to the SPI device via the direct
>> +			 * mapped address window
>> +			 */
>> +			memcpy(da->vaddr, xfer->tx_buf, count);
>> +		}
>> +
>> +		if (xfer->rx_buf) {
>> +			/*
>> +			 * Read the rx-data from the SPI device via the direct
>> +			 * mapped address window
>> +			 */
>> +			memcpy(xfer->rx_buf, da->vaddr, count);
>> +		}
> 
> Do bidirectional transfers work properly with this method (how much
> incoming data can we queue up, is there memory backing the whole
> region?), and are we guaranteed that the transfer finished by the time
> we return?

Frankly, I have no idea if bidirectional transfers work properly.
I have no means to test it. As stated in the commit text, this 
direct mode is only tested for TX as this is the mode that I'm using
for the FPGA bitstream programming. So its perhaps best to remove the
RX path completely from the direct mode for now. It can be added
once someone has a board / platform that can make use of this direct
RX mode.

>  I'm also not seeing anything here that handles word size so
> I suspect this will cause data corruption with anything other than 8 bit
> words and the driver does support 16 bit with PIO.  If only 8 bit words
> can be supported with direct access I'd expect to see the
> bits_per_word_mask updated.

'bits_per_word_mask' is controller specific. And one controller may
have PIO SPI devices connected additionally to direct mode
SPI devices. So restricting this controller to 8 bit in general
doesn't seem to be a good idea to me. I can add a check for 16bit
to the direct mode and fall back to PIO mode though.

>> +               spi->direct_access[cs].vaddr = devm_ioremap_resource(&pdev->dev,
>> +                                                                    r);
>> +               if (IS_ERR(spi->direct_access[cs].vaddr)) {
>> +                       status = PTR_ERR(spi->direct_access[cs].vaddr);
>> +                       goto out_rel_clk;
>> +               }
>> +
>> +               spi->direct_access[cs].size = resource_size(r);
>> +               dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
>> +       }
> 
> I seem to be missing where we configure the hardware to connect the
> windows to the chip selects.  We just seem to map the windows but never
> otherwise interact with the hardware.

The connection between the CS and the window is done in the DT. All
is now implemented as Arnd has suggested:

On 29.03.2016 14:39, Arnd Bergmann wrote:
<snip>
> What we really have though is additional registers that belong to
> the SPI controller and that are not part of internal-regs, so
> we need to move it up one level out of the internal-regs node in order
> to add more registers:
> 
>         soc {
>                 #address-cells = <2>;
>                 #size-cells = <1>;
>                spi0: spi at 10600 {
> 			compatible = "marvell,armada-370-spi";
>                        reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>, /* control */
> 			       <MBUS_ID(0x01, 0x1e) 0 0x100000>; /* CS0 */
> 			       <MBUS_ID(0x01, 0x5e) 0 0x100000>; /* CS1 */
> 			       <MBUS_ID(0x01, 0x9e) 0 0x100000>; /* CS2 */
> 			       <MBUS_ID(0x01, 0xee) 0 0x100000>; /* CS3 */
> 			       <MBUS_ID(0x01, 0x1f) 0 0x100000>; /* CS4 */
> 			       <MBUS_ID(0x01, 0x5f) 0 0x100000>; /* CS5 */
> 			       <MBUS_ID(0x01, 0x9f) 0 0x100000>; /* CS6 */
> 			       <MBUS_ID(0x01, 0xef) 0 0x100000>; /* CS7 */
>                        #address-cells = <1>;
>                        #size-cells = <0>;
> 		};
> 	};
> 
> This lists all the addresses as seen from the MBus, but doesn't put them
> into the CPU address space, which is then done by adding an entry in the
> 'ranges' property of the soc node:
> 
> 	soc {
> 		ranges = <MBUS_ID(0x01, 0x1e) 0  0xe0000000  0x20000>; /* SPI 0 CS0 128kb */
> 		...
> 	};

I've Cc'ed you on the Armada dts patches as well. The only board
currently enabling this direct mode via the 'ranges' property in the
'soc' node is an Armada XP based board that is still out-of-tree.
I'll send the patches for it at some later time.

Thanks,
Stefan

From: sr@denx.de (Stefan Roese)
Date: Thu, 14 Jan 2016 08:01:56 +0100
Subject: [PATCH RFC] spi: orion.c: Add direct write mode
In-Reply-To: <20160112101358.GY6588@sirena.org.uk>
References: <1452589339-21402-1-git-send-email-sr@denx.de>
 <20160112101358.GY6588@sirena.org.uk>
Message-ID: <569747E4.2080402@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.01.2016 11:13, Mark Brown wrote:
> On Tue, Jan 12, 2016 at 10:02:19AM +0100, Stefan Roese wrote:
>
>> +- direct-addr : The phandle to the node containing the base address
>> +                of the direct-mapped MBus window for this SPI device.
>
> Why are we not just making the MBus window a normal resource on the SPI
> controller and why do we need to use this only for a single device?  If
> we can program which device is used then we can just reconfigure
> whenever we change devices and use this optimisation for everything.

Interesting idea. It should be possible to add a dynamic MBus
window allocation / configuration, similar to what pci-mvebu.c
does. I'll give it a try to implement this dynamic MBus
configuration in the next version.

>> +		spidev at 1 {
>> +			compatible = "spidev";
>> +			direct-addr = <&spi0_cs1>;
>> +			reg = <1>;
>> +		};
>
> This is broken, spidev should never appear in a DT (and the driver will
> complain loudly if it does).  Describe the actual hardware.

Yes. This was meant just as an example - a quite bad one, I agree.
I'll change this.

>> +	/* Use SPI direct write mode if such an address is provided via DT */
>> +	orion_spi = spi_master_get_devdata(spi->master);
>> +	direct_addr = orion_spi->slave_direct_addr[spi->chip_select];
>> +	if (direct_addr && xfer->tx_buf) {
>> +		/* Deassert CS between the SPI transfers */
>> +		writel(0x00010000, spi_reg(orion_spi,
>> +					   SPI_DIRECT_WRITE_CONFIG_REG));
>
> This is badly broken, we should be asserting /CS over the entire message
> unless the individual transfer says otherwise.  I'm surprised this
> works.

It works, at least on the FPGA that I'm programming the bitstream into
right now. The reason for deasserting the CS after each SPI transfer
was, to work around potential problems with concurrent accesses to
other SPI devices connected to the same SPI controller. Like SPI NOR
flash devices using the "normal" indirect mode. Deasserting the CS
seemed like the "safe" way to me here.

>> +		/*
>> +		 * Send the tx-data to the SPI device via the direct mapped
>> +		 * address window
>> +		 */
>> +		memcpy(direct_addr, xfer->tx_buf, count);
>
> What if we are transferring more data than the window mapped in
> direct_addr

Right, a check is missing here.

> and what if the transfer is bidirectional?  It looks like we
> can only do this for transmit only transfers.

This patch only adds support for the direct write mode. As the main
purpose is to speed up the SPI TX throughput for FPGA bitstream
programming. It could be extended to support also the direct read
mode. But this would need more configuration options, like the
number of address-bytes to transfer in each read access. Not sure
how this should interact with the SPI flash driver from the MTD
subsystem.

I would prefer to not adding this direct read mode just yet. It
can be added later, if really needed.

Thanks,
Stefan

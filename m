From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jan 2016 10:52:11 +0000
Subject: [PATCH RFC] spi: orion.c: Add direct write mode
In-Reply-To: <569747E4.2080402@denx.de>
References: <1452589339-21402-1-git-send-email-sr@denx.de>
 <20160112101358.GY6588@sirena.org.uk> <569747E4.2080402@denx.de>
Message-ID: <20160114105211.GQ6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 08:01:56AM +0100, Stefan Roese wrote:
> On 12.01.2016 11:13, Mark Brown wrote:

> >>+	/* Use SPI direct write mode if such an address is provided via DT */
> >>+	orion_spi = spi_master_get_devdata(spi->master);
> >>+	direct_addr = orion_spi->slave_direct_addr[spi->chip_select];
> >>+	if (direct_addr && xfer->tx_buf) {
> >>+		/* Deassert CS between the SPI transfers */
> >>+		writel(0x00010000, spi_reg(orion_spi,
> >>+					   SPI_DIRECT_WRITE_CONFIG_REG));

> >This is badly broken, we should be asserting /CS over the entire message
> >unless the individual transfer says otherwise.  I'm surprised this
> >works.

> It works, at least on the FPGA that I'm programming the bitstream into
> right now. The reason for deasserting the CS after each SPI transfer
> was, to work around potential problems with concurrent accesses to
> other SPI devices connected to the same SPI controller. Like SPI NOR
> flash devices using the "normal" indirect mode. Deasserting the CS
> seemed like the "safe" way to me here.

No, this is not remotely safe - it is going to break any device where
the driver uses more than one transfer per message.  Instead of one
operation on the bus with /CS held over the entire operation the device
will see multiple operations.

> >and what if the transfer is bidirectional?  It looks like we
> >can only do this for transmit only transfers.

> This patch only adds support for the direct write mode. As the main
> purpose is to speed up the SPI TX throughput for FPGA bitstream
> programming. It could be extended to support also the direct read
> mode. But this would need more configuration options, like the
> number of address-bytes to transfer in each read access. Not sure
> how this should interact with the SPI flash driver from the MTD
> subsystem.

> I would prefer to not adding this direct read mode just yet. It
> can be added later, if really needed.

I can't see anything which will prevent trying to use direct write in
combination with a read which I'd not expect to work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160114/d0fc1ebc/attachment.sig>

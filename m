From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Jan 2016 10:13:58 +0000
Subject: [PATCH RFC] spi: orion.c: Add direct write mode
In-Reply-To: <1452589339-21402-1-git-send-email-sr@denx.de>
References: <1452589339-21402-1-git-send-email-sr@denx.de>
Message-ID: <20160112101358.GY6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 10:02:19AM +0100, Stefan Roese wrote:

> +- direct-addr : The phandle to the node containing the base address
> +                of the direct-mapped MBus window for this SPI device.

Why are we not just making the MBus window a normal resource on the SPI
controller and why do we need to use this only for a single device?  If
we can program which device is used then we can just reconfigure
whenever we change devices and use this optimisation for everything.

> +		spidev at 1 {
> +			compatible = "spidev";
> +			direct-addr = <&spi0_cs1>;
> +			reg = <1>;
> +		};

This is broken, spidev should never appear in a DT (and the driver will
complain loudly if it does).  Describe the actual hardware.

> +	/* Use SPI direct write mode if such an address is provided via DT */
> +	orion_spi = spi_master_get_devdata(spi->master);
> +	direct_addr = orion_spi->slave_direct_addr[spi->chip_select];
> +	if (direct_addr && xfer->tx_buf) {
> +		/* Deassert CS between the SPI transfers */
> +		writel(0x00010000, spi_reg(orion_spi,
> +					   SPI_DIRECT_WRITE_CONFIG_REG));

This is badly broken, we should be asserting /CS over the entire message
unless the individual transfer says otherwise.  I'm surprised this
works.

> +		/*
> +		 * Send the tx-data to the SPI device via the direct mapped
> +		 * address window
> +		 */
> +		memcpy(direct_addr, xfer->tx_buf, count);

What if we are transferring more data than the window mapped in
direct_addr and what if the transfer is bidirectional?  It looks like we
can only do this for transmit only transfers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/c6201ed0/attachment.sig>

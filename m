From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 12:51:55 +0200
Subject: [PATCH v5] spi: orion.c: Add direct access mode
In-Reply-To: <1460974417-32375-1-git-send-email-sr@denx.de>
References: <1460974417-32375-1-git-send-email-sr@denx.de>
Message-ID: <4437692.8jaX7AeWuo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 12:13:37 Stefan Roese wrote:
> This patch adds support for the direct access mode to the Orion SPI
> driver which is used on the Marvell Armada based SoCs. In this direct
> mode, all data written to (or read from) a specifically mapped MBus
> window (linked to one SPI chip-select on one of the SPI controllers)
> will be transferred directly to the SPI bus. Without the need to control
> the SPI registers in between. This can improve the SPI transfer rate in
> such cases.
> 
> Both, direct-read and -write mode are supported. But only the write
> mode has been tested. This mode especially benefits from the SPI direct
> mode, as the data bytes are written head-to-head to the SPI bus,
> without any additional addresses.
> 
> One use-case for this direct write mode is, programming a FPGA bitstream
> image into the FPGA connected to the SPI bus at maximum speed.
> 
> This mode is described in chapter "22.5.2 Direct Write to SPI" in the
> Marvell Armada XP Functional Spec Datasheet.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Brown <broonie@kernel.org>
> ---
> v5:
> - Added some documentation for the direct mode to the orion-spi DT
>   bindings document, including an example and a reference to the
>   mbus DT bindings documentation.

Thanks, looks good overall. A couple of minor points here:

> -- reg : offset and length of the register set for the device
> +- reg : offset and length of the register set for the device.
> +	This property can optionally have additional entries to configure
> +	the SPI direct access mode that some of the Marvell SoCs support
> +	additionally to the normal indirect access (PIO) mode. The values
> +	for the MBus "target" and "attribute" are defined in the Marvell
> +	SoC "Functional Specifications" Manual in the chapter "Marvell
> +	Core Processor Address Decoding".

While it might be obvious, I'd add something like

       The eight register sets following the control registers refer to
       chipselect lines 0 through 7 respectively.

>  - cell-index : Which of multiple SPI controllers is this.
>  Optional properties:
>  - interrupts : Is currently not used.
> @@ -23,3 +29,42 @@ Example:
>  	       interrupts = <23>;
>  	       status = "disabled";
>         };
> +
> +Example with SPI direct mode support (optionally):
> +	spi0: spi at 10600 {
> +		compatible = "marvell,orion-spi";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cell-index = <0>;
> +		reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28	/* control */
> +		       MBUS_ID(0x01, 0x1e) 0 0x100000	/* CS0 */
> +		       MBUS_ID(0x01, 0x5e) 0 0x100000	/* CS1 */
> +		       MBUS_ID(0x01, 0x9e) 0 0x100000	/* CS2 */
> +		       MBUS_ID(0x01, 0xde) 0 0x100000	/* CS3 */
> +		       MBUS_ID(0x01, 0x1f) 0 0x100000	/* CS4 */
> +		       MBUS_ID(0x01, 0x5f) 0 0x100000	/* CS5 */
> +		       MBUS_ID(0x01, 0x9f) 0 0x100000	/* CS6 */
> +		       MBUS_ID(0x01, 0xdf) 0 0x100000>;	/* CS7 */

I prefer writing this as

		reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,	/* control */
		      <MBUS_ID(0x01, 0x1e) 0 0x100000>,	/* CS0 */
		      <MBUS_ID(0x01, 0x5e) 0 0x100000>,	/* CS1 */
		      <MBUS_ID(0x01, 0x9e) 0 0x100000>,	/* CS2 */
		      <MBUS_ID(0x01, 0xde) 0 0x100000>,	/* CS3 */
		      <MBUS_ID(0x01, 0x1f) 0 0x100000>,	/* CS4 */
		      <MBUS_ID(0x01, 0x5f) 0 0x100000>,	/* CS5 */
		      <MBUS_ID(0x01, 0x9f) 0 0x100000>,	/* CS6 */
		      <MBUS_ID(0x01, 0xdf) 0 0x100000>;	/* CS7 */

Same for the ranges below.

Are you sure about the 1MB length for each one? I don't remember seeing this
limitation in the datasheet, so maybe the length should be specified as
0xffffffff (we can't use 0x10000000 unfortunately as that doesn't fit within
a 32-bit cell), to make it possible to map larger register areas.

> +To enable the direct mode, the board specific 'ranges' property in the
> +'soc' node needs to add the entries for the desired SPI controllers
> +and its chip-selects that are used in the direct mode instead of PIO
> +mode. Here an example for this (SPI controller 0, device 1 and SPI
> +controller 1, device 2 are used in direct mode. All other SPI device
> +are used in the default indirect (PIO) mode):
> +	soc {
> +		/*
> +		 * Enable the SPI direct access by configuring an entry
> +		 * here in the board-specific ranges property
> +		 */
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000	/* internal regs */
> +			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000	/* BootROM       */
> +			  MBUS_ID(0x01, 0x5e) 0 0 0xf1100000 0x100000	/* SPI0-DEV1     */
> +			  MBUS_ID(0x01, 0x9a) 0 0 0xf1200000 0x100000>;	/* SPI1-DEV2     */
> +
> +For further information on the MBus bindings, please see the MBus
> +DT documentation:
> +Documentation/devicetree/bindings/bus/mvebu-mbus.txt

This does however raise an interesting question about the size that we actually
want to map:

Your patch at the moment maps the entire register area that is listed for
a given CS, which simplifies the code, but it means that we can't easily
provide a smaller map in the mbus ranges when we know we don't need as
much address space. I had not considered that in my previous emails.

This is not a problem for the external bus because we can just map however
much space the attached device requires, but for SPI devices, the address
field in DT is just the CS number, not a range of addresses and the partitions
of e.g. an SPI NOR flash are then in a separate DT address space that does not
get translated into CPU addresses using 'ranges'.

This would be easier if have a conclusive proof that 1MB per CS always enough.
Is this something that is guaranteed in the SPI spec or the documentation for
this controller?

	Arnd

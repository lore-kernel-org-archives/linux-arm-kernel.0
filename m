From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 20 Apr 2016 13:58:47 +0200
Subject: [PATCH v6] spi: orion.c: Add direct access mode
In-Reply-To: <1461147068-4829-1-git-send-email-sr@denx.de> (Stefan Roese's
 message of "Wed, 20 Apr 2016 12:11:08 +0200")
References: <1461147068-4829-1-git-send-email-sr@denx.de>
Message-ID: <87k2jswky0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,
 
 On mer., avril 20 2016, Stefan Roese <sr@denx.de> wrote:

> This patch adds support for the direct write mode to the Orion SPI
> driver which is used on the Marvell Armada based SoCs. In this direct
> mode, all data written to (or read from) a specifically mapped MBus
> window (linked to one SPI chip-select on one of the SPI controllers)
> will be transferred directly to the SPI bus. Without the need to control
> the SPI registers in between. This can improve the SPI transfer rate in
> such cases.
>
> Currently only the direct write mode is supported. This mode especially
> benefits from the SPI direct mode, as the data bytes are written
> head-to-head to the SPI bus, without any additional addresses, that
> are also written in the direct read mode.
>
> One use-case for this direct write mode is, programming a FPGA bitstream
> image into the FPGA connected to the SPI bus at maximum speed.
>
> This mode is described in chapter "22.5.2 Direct Write to SPI" in the
> Marvell Armada XP Functional Spec Datasheet.
>
> It should be possible to support SPI-NOR and SPI-NAND devices via
> this direct access mode as well. But this needs further work, e.g.:
> - The mapping of the MBus window needs to get extended to span
>   the complete flash device size
> - The address / control data needs to get inserted into the SPI
>   controller registers

This patch looks really nice. And, from my point of view, especially
because I don't see how it could introduce a regression for the existing
boards :)

[...]

> diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
> index 98bc698..4f629cc 100644
> --- a/Documentation/devicetree/bindings/spi/spi-orion.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
> @@ -8,7 +8,15 @@ Required properties:
>      - "marvell,armada-380-spi", for the Armada 38x SoCs
>      - "marvell,armada-390-spi", for the Armada 39x SoCs
>      - "marvell,armada-xp-spi", for the Armada XP SoCs
> -- reg : offset and length of the register set for the device
> +- reg : offset and length of the register set for the device.
> +	This property can optionally have additional entries to configure
> +	the SPI direct access mode that some of the Marvell SoCs support
> +	additionally to the normal indirect access (PIO) mode. The values
> +	for the MBus "target" and "attribute" are defined in the Marvell
> +	SoC "Functional Specifications" Manual in the chapter "Marvell
> +	Core Processor Address Decoding".
> +	The eight register sets following the control registers refer to
> +	chip-select lines 0 through 7 respectively.
>  - cell-index : Which of multiple SPI controllers is this.
>  Optional properties:
>  - interrupts : Is currently not used.
> @@ -23,3 +31,42 @@ Example:
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
> +		reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>, /* control */
> +		      <MBUS_ID(0x01, 0x1e) 0 0xffffffff>, /* CS0 */
> +		      <MBUS_ID(0x01, 0x5e) 0 0xffffffff>, /* CS1 */
> +		      <MBUS_ID(0x01, 0x9e) 0 0xffffffff>, /* CS2 */
> +		      <MBUS_ID(0x01, 0xde) 0 0xffffffff>, /* CS3 */
> +		      <MBUS_ID(0x01, 0x1f) 0 0xffffffff>, /* CS4 */
> +		      <MBUS_ID(0x01, 0x5f) 0 0xffffffff>, /* CS5 */
> +		      <MBUS_ID(0x01, 0x9f) 0 0xffffffff>, /* CS6 */
> +		      <MBUS_ID(0x01, 0xdf) 0 0xffffffff>; /* CS7 */
> +		interrupts = <23>;
> +		status = "disabled";
> +	};
> +

As you don't submit any patch for the dtsi, I assume that you expect
that this part will be done at board level. In this case as I wrote
above we are sure that all the board continue working without any need
to test them.

[...]
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index a87cfd4..3e20afd 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/clk.h>
>  #include <linux/sizes.h>
> @@ -43,6 +44,9 @@
>  #define ORION_SPI_INT_CAUSE_REG		0x10
>  #define ORION_SPI_TIMING_PARAMS_REG	0x18
>  
> +/* Register for the "Direct Mode" */
> +#define SPI_DIRECT_WRITE_CONFIG_REG	0x20
> +
>  #define ORION_SPI_TMISO_SAMPLE_MASK	(0x3 << 6)
>  #define ORION_SPI_TMISO_SAMPLE_1	(1 << 6)
>  #define ORION_SPI_TMISO_SAMPLE_2	(2 << 6)
> @@ -78,11 +82,18 @@ struct orion_spi_dev {
>  	bool			is_errata_50mhz_ac;
>  };
>  
> +struct orion_direct_acc {
> +	void __iomem		*vaddr;
> +	u32			size;
> +};
> +
>  struct orion_spi {
>  	struct spi_master	*master;
>  	void __iomem		*base;
>  	struct clk              *clk;
>  	const struct orion_spi_dev *devdata;
> +
> +	struct orion_direct_acc	direct_access[ORION_NUM_CHIPSELECTS];
>  };
>  
>  static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
> @@ -372,10 +383,30 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>  {
>  	unsigned int count;
>  	int word_len;
> +	struct orion_spi *orion_spi;
> +	int cs = spi->chip_select;
>  
>  	word_len = spi->bits_per_word;
>  	count = xfer->len;
>  
> +	orion_spi = spi_master_get_devdata(spi->master);
> +
> +	/*
> +	 * Use SPI direct write mode if base address is available. Otherwise
> +	 * fall back to PIO mode for this transfer.
> +	 */

That means that once the direct write mode is set in the device tree you
can't go back to the PIO mode. So, if I understand well, once you have
programmed a FPGA bitstream image into the FPGA you won't use this SPI
for a more standard communication. However, I don't know how to switch
from a mode to another in an elegant way (without adding an ioctl
command).

> +	if ((orion_spi->direct_access[cs].vaddr) && (xfer->tx_buf) &&
> +	    (word_len == 8)) {
> +		/*
> +		 * Send the TX-data to the SPI device via the direct
> +		 * mapped address window
> +		 */
> +		writesl(orion_spi->direct_access[cs].vaddr, xfer->tx_buf,
> +			DIV_ROUND_UP(count, 4));
> +
> +		return count;
> +	}
> +
>  	if (word_len == 8) {
>  		const u8 *tx = xfer->tx_buf;
>  		u8 *rx = xfer->rx_buf;

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

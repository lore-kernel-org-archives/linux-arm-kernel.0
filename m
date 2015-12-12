From: plaes@plaes.org (Priit Laes)
Date: Sat, 12 Dec 2015 11:19:40 +0200
Subject: [linux-sunxi] [PATCH v2] spi: dts: sun4i: Add support for
 inter-word wait cycles using the SPI Wait Clock Register
In-Reply-To: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <1449911980.29015.7.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-12-11 at 23:45 +0100, Marcus Weseloh wrote:

[...]
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> index de827f5..d6c55fc 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> @@ -10,6 +10,10 @@ Required properties:
> ???- "mod": the parent module clock
> ?- clock-names: Must contain the clock names described just above
> ?
> +Optional properties for slave devices:
> +- sun4i,spi-word-wait-ns: hardware based delay in nanoseconds between
> +			??transmission of words

Should be 'allwinner,spi-word-wait-ns'

Vendor prefix do come from:
Documentation/devicetree/bindings/vendor-prefixes.txt

> +
> ?Example:
> ?
> ?spi1: spi at 01c06000 {
> @@ -21,4 +25,11 @@ spi1: spi at 01c06000 {
> ?	status = "disabled";
> ?	#address-cells = <1>;
> ?	#size-cells = <0>;
> +
> +	spi1_0 {
> +		compatible = "example,dummy";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		sun4i,spi-word-wait-ns = <12000>;
> +	};
> ?};
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index f60a6d6..8cfd96c 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -19,6 +19,7 @@
> ?#include 
> ?#include 
> ?#include 
> +#include 
> ?
> ?#include 
> ?
> @@ -173,6 +174,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
> ?	unsigned int tx_len = 0;
> ?	int ret = 0;
> ?	u32 reg;
> +	u32 wait_ns = 0;
> +	int wait_clk = 0;
> +	int clk_ns = 0;
> ?
> ?	/* We don't support transfer larger than the FIFO */
> ?	if (tfr->len > SUN4I_FIFO_DEPTH)
> @@ -261,6 +265,25 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
> ?
> ?	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
> ?
> +	/* Setup wait time beteen words */
typo

> +	of_property_read_u32(spi->dev.of_node, "sun4i,spi-word-wait-ns",
> +			?????&wait_ns);
> +	if (wait_ns) {
> +		/* The wait time is set in SPI_CLK cycles. The SPI hardware
> +		?* needs 3 additional cycles to setup the wait counter, so
> +		?* the minimum delay time is 4 cycles.
> +		?*/
> +		clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);
> +		wait_clk = DIV_ROUND_UP(wait_ns, clk_ns) - 3;
> +		if (wait_clk < 1) {
> +			wait_clk = 1;
> +			dev_info(&spi->dev,
> +				?"using minimum of 4 word wait cycles (%uns)",
> +				?4 * clk_ns);
> +		}
> +	}
> +	sun4i_spi_write(sspi, SUN4I_WAIT_REG, (u16)wait_clk);
> +
> ?	/* Setup the transfer now... */
> ?	if (sspi->tx_buf)
> ?		tx_len = tfr->len;
> --?
> 1.9.1
> 

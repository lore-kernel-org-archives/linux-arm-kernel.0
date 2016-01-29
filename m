From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 29 Jan 2016 14:29:54 +0100
Subject: [PATCH linux-next v2 10/14] mtd: spi-nor: configure the number of
 dummy clock cycles on Macronix memories
In-Reply-To: <caaf19555ae684e0a1ccdd79cd7326ee1fbf1197.1452268345.git.cyrille.pitchen@atmel.com>
References: <cover.1452268345.git.cyrille.pitchen@atmel.com>
 <caaf19555ae684e0a1ccdd79cd7326ee1fbf1197.1452268345.git.cyrille.pitchen@atmel.com>
Message-ID: <56AB6952.90701@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've found a small issue within this patch when I test with a Macronix
mx25l51245g (JEDEC ID C2201A so reported as "mx66l51235l" by spi-nor.c).
It deals with a wrong op code used when reading the Configuration Register.
See below for more details.

So I will send a new patch to fix this issue.

Otherwise, I tested on a sama5d2 xplained board and it works :)


Le 08/01/2016 17:02, Cyrille Pitchen a ?crit :
> The spi-nor framework currently expects all Fast Read operations to use 8
> dummy clock cycles. Especially some drivers like m25p80 can only support
> multiple of 8 dummy clock cycles.
> 
> On Macronix memories, the number of dummy clock cycles to be used by Fast
> Read commands can be safely set to 8 by updating the DC0 and DC1 volatile
> bits inside the Configuration Register.
> 
> According to the mx66l1g45g datasheet from Macronix, using 8 dummy clock
> cycles should be enough to set the SPI bus clock frequency up to:
> - 133 MHz for Fast Read 1-1-1, 1-1-2, 1-1-4 and 1-2-2 commands in Single
>   Transfer Rate (STR)
> - 104 MHz for Fast Read 1-4-4 (or 4-4-4 in QPI mode) commands (STR)
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
[...]
> +static int macronix_set_dummy_cycles(struct spi_nor *nor, u8 read_dummy)
> +{
> +	int ret, sr, cr, mask, val;
> +	u16 sr_cr;
> +	u8 dc;
> +
> +	/* Convert the number of dummy cycles into Macronix DC volatile bits */
> +	ret = macronix_dummy2code(nor->read_opcode, read_dummy, &dc);
> +	if (ret)
> +		return ret;
> +
> +	mask = GENMASK(7, 6);
> +	val = (dc << 6) & mask;
> +
> +	cr = read_cr(nor);
Macronix memories use the 0x15 op code (not 0x35) to read the Configuration Register.
The 0x35 op code is used to enter the QPI mode. So read_cr() cannot be used here.

> +	if (cr < 0) {
> +		dev_err(nor->dev, "error while reading the config register\n");
> +		return cr;
> +	}
> +
> +	if ((cr & mask) == val) {
> +		nor->read_dummy = read_dummy;
> +		return 0;
> +	}
> +
> +	sr = read_sr(nor);
> +	if (sr < 0) {
> +		dev_err(nor->dev, "error while reading the status register\n");
> +		return sr;
> +	}
> +
> +	cr = (cr & ~mask) | val;
> +	sr_cr = (sr & 0xff) | ((cr & 0xff) << 8);
> +	write_enable(nor);
> +	ret = write_sr_cr(nor, sr_cr);
> +	if (ret) {
> +		dev_err(nor->dev,
> +			"error while writing the SR and CR registers\n");
> +		return ret;
> +	}
> +
> +	ret = spi_nor_wait_till_ready(nor);
> +	if (ret)
> +		return ret;
> +
> +	cr = read_cr(nor);
Here again, we must use the 0x15 op code instead of 0x35.

> +	if (cr < 0 || (cr & mask) != val) {
> +		dev_err(nor->dev, "Macronix Dummy Cycle bits not updated\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Save the number of dummy cycles to use with Fast Read commands */
> +	nor->read_dummy = read_dummy;
> +	return 0;
> +}
> +

Best regards,

Cyrille

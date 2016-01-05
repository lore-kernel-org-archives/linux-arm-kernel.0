From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 05 Jan 2016 21:50:54 +0000
Subject: [PATCH v3 1/3] spi: atmel: add support for the internal
 chip-select of the spi controller
In-Reply-To: <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
 (Cyrille Pitchen's message of "Tue, 9 Jun 2015 13:53:52 +0200")
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
Message-ID: <yw1xvb771yrl.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cyrille Pitchen <cyrille.pitchen@atmel.com> writes:

> This patch relies on the CSAAT (Chip Select Active After Transfer) feature
> introduced by the version 2 of the spi controller. This new mode allows to
> use properly the internal chip-select output pin of the spi controller
> instead of using external gpios. Consequently, the "cs-gpios" device-tree
> property becomes optional.
>
> When the new CSAAT bit is set into the Chip Select Register, the internal
> chip-select output pin remains asserted till both the following conditions
> become true:
> - the LASTXFER bit is set into the Control Register (or the Transmit Data
>   Register)
> - the Transmit Data Register and its shift register are empty.
>
> WARNING: if the LASTXFER bit is set into the Control Register then new
> data are written into the Transmit Data Register fast enough to keep its
> shifter not empty, the chip-select output pin remains asserted. Only when
> the shifter becomes empty, the chip-select output pin is unasserted.
>
> When the CSAAT bit is clear in the Chip Select Register, the LASTXFER bit
> is ignored in both the Control Register and the Transmit Data Register.
> The internal chip-select output pin remains active as long as the Transmit
> Data Register or its shift register are not empty.
>
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/spi/spi-atmel.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)

[...]

> @@ -1338,6 +1350,13 @@ static int atmel_spi_probe(struct platform_device *pdev)
>
>  	atmel_get_caps(as);
>
> +	as->use_cs_gpios = true;
> +	if (atmel_spi_is_v2(as) &&
> +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
> +		as->use_cs_gpios = false;
> +		master->num_chipselect = 4;
> +	}

This part breaks the AVR32 boards and probably anything else that
doesn't use devicetree but does use GPIOs for chip select.

-- 
M?ns Rullg?rd

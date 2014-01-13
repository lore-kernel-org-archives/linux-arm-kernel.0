From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Jan 2014 12:08:44 +0000
Subject: [PATCH V3 4/9] spi: rspi: Add DT support
In-Reply-To: <1389525222-3482-5-git-send-email-geert@linux-m68k.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <1389525222-3482-5-git-send-email-geert@linux-m68k.org>
Message-ID: <20140113120844.GM29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 12:13:37PM +0100, Geert Uytterhoeven wrote:

> +Required properties:
> +- compatible       : For Renesas Serial Peripheral Interface on SH:
> +                     "renesas,rspi-<soctype>", "renesas,rspi-sh" as fallback.
> +		     For Renesas Serial Peripheral Interface on ARM:
> +                     "renesas,rspi-<soctype>", "renesas,rspi-rz" as fallback.
> +		     For Quad Serial Peripheral Interface:
> +		     "renesas,qspi-<soctype>", "renesas,qspi" as fallback.

This should specify what <soctype> is and ideally list the valid values
or at least the convention for writing them; perhaps a list of SoCs in
some common place would be useful for sharing between all the IPs.

> +- interrupts       : Up to 3 interrupts for RSPI (SPEI, SPRI, SPTI),
> +		     1 interrupt for QSPI

For multiple interrupts you need to say how they are identified - if
they're not named the order must be specified.

> +Pinctrl properties might be needed, too. See there.

Where?

> +static const struct of_device_id rspi_of_match[] = {
> +	/* RSPI on legacy SH */
> +	{ .compatible = "renesas,rspi-sh7757", .data = &rspi_sh_of_data },
> +	{ .compatible = "renesas,rspi-sh", .data = &rspi_sh_of_data },
> +	/* RSPI on RZ */
> +	{ .compatible = "renesas,rspi-r7s72100", .data = &rspi_rz_of_data },
> +	{ .compatible = "renesas,rspi-rz", .data = &rspi_rz_of_data },
> +	/* QSPI on R-Car Gen2 */
> +	{ .compatible = "renesas,qspi-r8a7790", .data = &qspi_of_data },
> +	{ .compatible = "renesas,qspi-r8a7791", .data = &qspi_of_data },
> +	{ .compatible = "renesas,qspi", .data = &qspi_of_data },
> +	{ /* sentinel */ }
> +};

No need to actually list the specific SoCs given that the fallback is
mandatory and the resulting data is identical, if you are going to do
that then I'd have the compatible set num_cs too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/22e31170/attachment.sig>

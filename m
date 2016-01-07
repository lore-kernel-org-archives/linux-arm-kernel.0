From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 07 Jan 2016 16:14:12 +0000
Subject: [PATCH v3 1/3] spi: atmel: add support for the internal
 chip-select of the spi controller
In-Reply-To: <20160107154024.GF6588@sirena.org.uk> (Mark Brown's message of
 "Thu, 7 Jan 2016 15:40:24 +0000")
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
 <yw1xvb771yrl.fsf@unicorn.mansr.com>
 <20160107154024.GF6588@sirena.org.uk>
Message-ID: <yw1xvb75z7sb.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Tue, Jan 05, 2016 at 09:50:54PM +0000, M?ns Rullg?rd wrote:
>> Cyrille Pitchen <cyrille.pitchen@atmel.com> writes:
>
>> > +	as->use_cs_gpios = true;
>> > +	if (atmel_spi_is_v2(as) &&
>> > +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>> > +		as->use_cs_gpios = false;
>> > +		master->num_chipselect = 4;
>> > +	}
>
>> This part breaks the AVR32 boards and probably anything else that
>> doesn't use devicetree but does use GPIOs for chip select.
>
> Shouldn't this just be setting defaults for the case where nothing is
> provided?

Traditionally the platform data included a GPIO number to use and that
was that.  At some point DT support was added wherein the platform data
is overridden by cs_gpio from struct spi_device if this is valid (it is
set to a negative value by default).  Thus far all was well.  Then came
this patch.  It assumes that everybody uses DT and treats a missing
cs-gpios property as indication that the controller's own pins should be
used.  It also assumes that if any device uses GPIO for CS all of them
do, even though the SPI core driver might provide a partial list
(probably since many boards don't use all the available chip selects,
but it doesn't prevent someone abusing this).

To work correctly in call cases, this driver should use, for each
peripheral, the following priority:

- spi->cs_gpio (filled from DT or -ENOENT)
- GPIO from platform data
- controller chip select pin

The trouble is that there is no way to reliably tell a valid GPIO number
of zero in the platform data from an unset value.  In practice, I
believe existing old boards using this driver all use a non-zero GPIO
(the AVR32 platform code requires this), so checking for a non-zero
number is probably sufficient.  I'll cook up a patch for this unless
someone objects.

-- 
M?ns Rullg?rd

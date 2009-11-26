From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 26 Nov 2009 17:03:39 +0000
Subject: [PATCH] add PATA host controller support for Cirrus Logic's
	EP93xx CPUs
In-Reply-To: <200911261651.40928.bzolnier@gmail.com>
References: <200911261651.40928.bzolnier@gmail.com>
Message-ID: <20091126170339.218f6674@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +static void pata_ep93xx_set_piomode(struct ata_port *ap,
> +				    struct ata_device *adev)
> +{
> +	void __iomem *base = ap->host->private_data;
> +	struct ata_device *pair = ata_dev_pair(adev);
> +	const struct ata_timing *t = ata_timing_find_mode(adev->pio_mode);
> +	const struct ata_timing *cmd_t = t;
> +	u32 reg = IDECFG_IDEEN | IDECFG_PIO;
> +	u8 pio = adev->pio_mode - XFER_PIO_0;
> +
> +	if (pair && pair->pio_mode < adev->pio_mode)
> +		cmd_t = ata_timing_find_mode(pair->pio_mode);
> +
> +	/*
> +	 * store the adequate PIO mode timings, to be used later
> +	 * by pata_ep93xx_{read,write}
> +	 */
> +	adev->private_data = (void *)t;
> +	ap->private_data = (void *)cmd_t;
> +
> +	/* reconfigure IDE controller according to PIO mode (?) */

This would probably be better in both drivers as a simple table. It would
then not be a switch but collapse the entire pile into a single

	writel(pio_timing[pio], base + IDECFG);


> +static u16 __pata_ep93xx_read(void __iomem *base, void *addr,
> +			      struct ata_timing *t)
> +{
> +	u32 reg;
> +
> +	reg = (unsigned long)addr | IDECTRL_DIORN | IDECTRL_DIOWN;
> +	writel(reg, base + IDECTRL);
> +	ndelay(t->setup);

This implies a bus with no posting, which seems to the case from the
other driver code.

> +	while (!pata_ep93xx_check_iordy(base))
> +		cpu_relax();

And if the drive was hot unplugged this is doom incorporated (plus we
might not be using an IORDY mode.

>
> +	while (!pata_ep93xx_check_iordy(base))
> +		cpu_relax();

Ditto


I don't see anything wrong in the conversion. 

The size thing is true - libata tried to abstract at a higher level which
in turn avoids lots of computed branches to one liners and lets the
compiler inline stuff better (eg all the private read/write methods into
a single call free tf_* etc). It could I guess provide an "awkward
case" skeleton tf_* and other sets of functions that were passed inb/outb
ops. One for Jeff to ponder ?



Alan

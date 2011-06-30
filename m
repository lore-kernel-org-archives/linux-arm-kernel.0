From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 30 Jun 2011 16:58:38 +0200
Subject: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for imx23/imx28
In-Reply-To: <201106301555.19440.arnd@arndb.de>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>
	<1309406028-2924-2-git-send-email-b32955@freescale.com>
	<201106301555.19440.arnd@arndb.de>
Message-ID: <19980.36638.134045.743619@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Arnd Bergmann writes:
> On Thursday 30 June 2011, Huang Shijie wrote:
> > add GPMI-NFC support for imx23 and imx28.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> 
[...]
> > +struct gpmi_nfc_platform_data {
> > +	/* SoC hardware information. */
> > +	int		(*platform_init)(void);
> > +	void		(*platform_exit)(void);
> > +
> > +	/* NAND Flash information. */
> > +	unsigned int	min_prop_delay_in_ns;
> > +	unsigned int	max_prop_delay_in_ns;
> > +	unsigned int	max_chip_count;
> > +
> > +	/* Medium information. */
> > +	struct mtd_partition *partitions;
> > +	unsigned	partition_count;
> > +};
> 
> When adding new infrastructure, always keep in mind how you want it to look
> after the device tree conversion. The partitions and min/max_* are easily covered
> with that, but the init/exit function pointers are somewhat problematic.
> 
> Fortunately, you don't really require these functions for this driver. The _exit
> function is completely unused, so just get rid of it.
> 
> The init function is used only to set up iomux, so the logical replacement is
> a pointer to the iomux data, and calling mxs_iomux_setup_multiple_pads
> directly from the driver.
> 
NO! I strongly object that. mxs_iomux_setup_multiple_pads() is a
platform specific function and has no business inside a device driver
that should be platform agnostic.
Consider the same controller being part of a different SoC that
requires you to call mxs_iomux_v2_setup_multiple_pads() instead. You
would then have to check for the SoC type inside the driver to find
the right function to call which is quite obscene.

I would rather live with the iomux statically configured in the
platform init code than having direct calls into platform specific
code from device drivers.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

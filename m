From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 30 Sep 2010 18:21:27 +0200
Subject: [PATCH] spi/pl022: compare bitwidth to enums
In-Reply-To: <AANLkTimGpfazBPYp3cc4pSFUJ_Q7GaPVxRtB2=YSM5YE@mail.gmail.com>
References: <1285840671-9567-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin6fPnDdSqQiWKH8kTnREV2g8p94HzQQcjcpKLs@mail.gmail.com>
	<AANLkTimGpfazBPYp3cc4pSFUJ_Q7GaPVxRtB2=YSM5YE@mail.gmail.com>
Message-ID: <083DF309106F364B939360100EC290F80B06721D75@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> The enums from <linux/amba/pl022.h> are actually off-by-one
> >> since bitwidth 4 is defined as 0x03, causing weirdness when
> >> we were trying out some 9-bit peripheral. Fix this by
> >> comparing to the enum values rather than hardcoded values
> >> and also fixing the enum to something reasonable.
> >>
> >> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> >> (...)
> >> - ? ? ? if (chip_info->data_size <= 8) {
> >> + ? ? ? if (chip_info->data_size <= SSP_DATA_BITS_8) {
> >> ? ? ? ? ? ? ? ?dev_dbg(&spi->dev, "1 <= n <=8 bits per word\n");
> >> ? ? ? ? ? ? ? ?chip->n_bytes = 1;
> >> ? ? ? ? ? ? ? ?chip->read = READING_U8;
> >> ? ? ? ? ? ? ? ?chip->write = WRITING_U8;
> >> - ? ? ? } else if (chip_info->data_size <= 16) {
> >> + ? ? ? } else if (chip_info->data_size <= SSP_DATA_BITS_16) {
> >
> > I just realized that Kevin Wells patch actually patch away this problem
> > so merge his patch and disregard this for the optimal solution.
> >
> >> ?enum ssp_data_size {
> >> - ? ? ? SSP_DATA_BITS_4 = 0x03, SSP_DATA_BITS_5, SSP_DATA_BITS_6,
> >> + ? ? ? SSP_DATA_BITS_4 = 0x04, SSP_DATA_BITS_5, SSP_DATA_BITS_6,
> >
> > This is not good because this is used for default register
> > settings too (I didn't notice, typical).
> 
> And it creates a 1:1 mapping of name to the same number.  Insane!
> Just use the integer number directly.  :-)

The spi->mode patch I submitted a few weeks ago actually removed the
data_size field from chip_info and uses spi->data_bus_bits instead.
The values passed into the dss field for the control0 register
subtracts 1 from the spi->data_bus_bits to get the correct value now.

Reference: 09/16/2010
[PATCH] spi: amba_pl022: Add spi->mode support to AMBA SPI driver

> 
> >
> > If anyone still wants a patch for older kernels I can provide a
> > patch against 2.6.36-rc6 with just the first two hunks.
> >
> > Yours,
> > Linus Walleij
> >
> 
> 
> 
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> 
> --------------------------------------------------------------------------
> ----
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing.
> http://p.sf.net/sfu/novell-sfdev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

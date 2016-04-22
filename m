From: yunhui.cui@nxp.com (Yunhui Cui)
Date: Fri, 22 Apr 2016 03:52:14 +0000
Subject: [PATCH 8/9] mtd: fsl-quadspi: disable AHB buffer prefetch
In-Reply-To: <DB5PR0401MB184588E6C33FD167783C1D57976E0@DB5PR0401MB1845.eurprd04.prod.outlook.com>
References: <1460605855-6689-1-git-send-email-B56489@freescale.com>,
 <1460605855-6689-9-git-send-email-B56489@freescale.com>
 <DB5PR0401MB18454AF685ADE37F1C39C088976D0@DB5PR0401MB1845.eurprd04.prod.outlook.com>,
 <DB5PR0401MB1912F866F920C71BF1A26F29946E0@DB5PR0401MB1912.eurprd04.prod.outlook.com>
 <DB5PR0401MB184588E6C33FD167783C1D57976E0@DB5PR0401MB1845.eurprd04.prod.outlook.com>
Message-ID: <DB5PR0401MB19129F49CF2709DBB3E9E8E9946F0@DB5PR0401MB1912.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Han Xu
> Sent: Thursday, April 21, 2016 11:48 PM
> To: Yunhui Cui; Yunhui Cui; dwmw2 at infradead.org;
> computersforpeace at gmail.com; han.xu at freescale.com
> Cc: linux-kernel at vger.kernel.org; linux-mtd at lists.infradead.org; linux-
> arm-kernel at lists.infradead.org; Yao Yuan
> Subject: Re: [PATCH 8/9] mtd: fsl-quadspi: disable AHB buffer prefetch
> 
> 
> 
> ________________________________________
> From: Yunhui Cui
> Sent: Thursday, April 21, 2016 3:41 AM
> To: Han Xu; Yunhui Cui; dwmw2 at infradead.org; computersforpeace at gmail.com;
> han.xu at freescale.com
> Cc: linux-kernel at vger.kernel.org; linux-mtd at lists.infradead.org; linux-
> arm-kernel at lists.infradead.org; Yao Yuan
> Subject: RE: [PATCH 8/9] mtd: fsl-quadspi: disable AHB buffer prefetch
> 
> On Thu, Apr 24, 2016 at 06:37:01 AM +0800, Han Xu wrote:
> > ________________________________________
> > From: Yunhui Cui <B56489@freescale.com>
> > Sent: Wednesday, April 13, 2016 9:50 PM
> > To: dwmw2 at infradead.org; computersforpeace at gmail.com;
> > han.xu at freescale.com
> > Cc: linux-kernel at vger.kernel.org; linux-mtd at lists.infradead.org;
> > linux- arm-kernel at lists.infradead.org; Yao Yuan; Yunhui Cui
> > Subject: [PATCH 8/9] mtd: fsl-quadspi: disable AHB buffer prefetch
> >
> > From: Yunhui Cui <yunhui.cui@nxp.com>
> >
> > A-009282: QuadSPI: QuadSPI data pre-fetch can result in incorrect data
> > Affects: QuadSPI
> > Description: With AHB buffer prefetch enabled, the QuadSPI may return
> > incorrect data on the AHB interface. The buffer pre-fetch is enabled
> > if the fetch size as configured either in the LUT or in the BUFxCR
> > register is greater than 8 bytes.
> > Impact: Only 64 bit read allowed.
> > Workaround: Keep the read data size to 64 bits (8 Bytes), which
> > disables the prefetch on the AHB buffer, and prevents this issue from
> occurring.
> >
> > Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
> > ---
> >  drivers/mtd/spi-nor/fsl-quadspi.c | 29 +++++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c
> > b/drivers/mtd/spi-nor/fsl- quadspi.c index fea18b6..d9f3e50 100644
> > --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> > +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> > @@ -752,19 +752,36 @@ static void fsl_qspi_init_abh_read(struct
> > fsl_qspi
> > *q)  {
> >         void __iomem *base = q->iobase;
> >         int seqid;
> > +       const struct fsl_qspi_devtype_data *devtype_data =
> > + q->devtype_data;
> >
> >         /* AHB configuration for access buffer 0/1/2 .*/
> >         qspi_writel(q, QUADSPI_BUFXCR_INVALID_MSTRID, base +
> > QUADSPI_BUF0CR);
> >         qspi_writel(q, QUADSPI_BUFXCR_INVALID_MSTRID, base +
> > QUADSPI_BUF1CR);
> >         qspi_writel(q, QUADSPI_BUFXCR_INVALID_MSTRID, base +
> > QUADSPI_BUF2CR);
> > +
> >         /*
> > -        * Set ADATSZ with the maximum AHB buffer size to improve the
> > -        * read performance.
> > +        * Errata: A-009282: QuadSPI data prefetch may result in
> > incorrect data
> > +        * Workaround: Keep the read data size to 64 bits (8 bytes).
> > +        * This disables the prefetch on the AHB buffer and
> > +        * prevents this issue from occurring.
> >          */
> > -       qspi_writel(q, QUADSPI_BUF3CR_ALLMST_MASK |
> > -                       ((q->devtype_data->ahb_buf_size / 8)
> > -                       << QUADSPI_BUF3CR_ADATSZ_SHIFT),
> > -                       base + QUADSPI_BUF3CR);
> > +       if (devtype_data->devtype == FSL_QUADSPI_LS2080A ||
> > +           devtype_data->devtype == FSL_QUADSPI_LS1021A) {
> >
> > Use QUIRK, not SoC name.
> [Yunhui] This is a SoC errata, we need distinguish according to the
> devtype_data->devtype
> 
> It's the same thing and we have already done that before.

> [Yunhui] your mean that I should add such as the following code:
	#define QUADSPI_QUIRK_ERRATA_9282         (1 << 4)
	static inline int has_errata_num_a009282(struct fsl_qspi *q)
	{
        	 return q->devtype_data->driver_data & QUADSPI_QUIRK_ERRATA_9282;
	}

> /*
>  * TKT253890, Controller needs driver to fill txfifo till 16 byte to
>  * trigger data transfer even though extra data will not transferred.
>  */
> #define QUADSPI_QUIRK_TKT253890         (1 << 2)
> /* Controller cannot wake up from wait mode, TKT245618 */
> #define QUADSPI_QUIRK_TKT245618         (1 << 3)
> 
> 
> > +
> > +               qspi_writel(q, QUADSPI_BUF3CR_ALLMST_MASK |
> > +                               (1 << QUADSPI_BUF3CR_ADATSZ_SHIFT),
> > +                               base + QUADSPI_BUF3CR);
> > +
> > +       } else {
> > +               /*
> > +                * Set ADATSZ with the maximum AHB buffer size to
> > + improve
> > the
> > +                * read performance.
> > +               */
> > +               qspi_writel(q, QUADSPI_BUF3CR_ALLMST_MASK |
> > +                               ((q->devtype_data->ahb_buf_size / 8)
> > +                               << QUADSPI_BUF3CR_ADATSZ_SHIFT),
> > +                               base + QUADSPI_BUF3CR);
> > +       }
> >
> >         /* We only use the buffer3 */
> >         qspi_writel(q, 0, base + QUADSPI_BUF0IND);
> > --
> > 2.1.0.27.g96db324

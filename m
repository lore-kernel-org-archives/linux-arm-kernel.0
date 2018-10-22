From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 22 Oct 2018 13:52:11 +0200
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
In-Reply-To: <VI1PR04MB1038E072BFFD09C7C19AD2F899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017090724.12f2cd79@bbrezillon>
 <20181017091045.124e0266@bbrezillon>
 <20181017092941.3658bd9a@bbrezillon>
 <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017115237.07310b74@bbrezillon>
 <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022111543.2a607efc@bbrezillon>
 <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022122659.0675942e@bbrezillon>
 <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022124627.2c6c3b93@bbrezillon>
 <20181022125259.42df83ea@bbrezillon>
 <VI1PR04MB1038C9C889185F2A700220F299F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022134324.2c1bd248@bbrezillon>
 <VI1PR04MB1038E072BFFD09C7C19AD2F899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <20181022135211.1978c25d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Oct 2018 11:46:55 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> > Sent: Monday, October 22, 2018 5:13 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: Cristian.Birsan at microchip.com; Tudor Ambarus
> > <tudor.ambarus@microchip.com>; richard at nod.at; Mark Brown
> > <broonie@kernel.org>; linux-kernel at vger.kernel.org;
> > nicolas.ferre at microchip.com; marek.vasut at gmail.com;
> > cyrille.pitchen at microchip.com; linux-mtd at lists.infradead.org; Cyrille Pitchen
> > <cyrille.pitchen@wedev4u.fr>; computersforpeace at gmail.com;
> > dwmw2 at infradead.org; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
> > NOR flash memories
> > 
> > On Mon, 22 Oct 2018 11:03:09 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >   
> > > Hi,
> > >  
> > > > -----Original Message-----
> > > > From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> > > > Sent: Monday, October 22, 2018 4:23 PM
> > > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> > > > Cristian.Birsan at microchip.com
> > > > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard at nod.at;
> > > > Mark Brown <broonie@kernel.org>; linux-kernel at vger.kernel.org;
> > > > nicolas.ferre at microchip.com; marek.vasut at gmail.com;
> > > > cyrille.pitchen at microchip.com; linux-mtd at lists.infradead.org;
> > > > Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>;
> > > > computersforpeace at gmail.com; dwmw2 at infradead.org;
> > > > linux-arm-kernel at lists.infradead.org
> > > > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform
> > > > SFDP SPI NOR flash memories
> > > >
> > > > On Mon, 22 Oct 2018 12:46:27 +0200
> > > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > >  
> > > > > On Mon, 22 Oct 2018 10:39:48 +0000 Yogesh Narayan Gaur
> > > > > <yogeshnarayan.gaur@nxp.com> wrote:
> > > > >  
> Patch used
> 
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2863,26 +2863,39 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)

>         /* Determine if there are any optional Detection Command Descriptors */
> -       while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> +       for (i = 0; i< smpt_len; i++) {

See, you should have i += 2 here, not i++.

> +               if ((smpt[i] & SMPT_DESC_TYPE_MAP))
> +                       break;
> +
>                 read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
>                 nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
> -               nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
> +               if (!nor->addr_width)
> +                       nor->addr_width = 3;
> +
> +               nor->read_dummy = 8; //spi_nor_smpt_read_dummy(nor, smpt[i]);
>                 nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
> +               pr_info("smpt[%d]=[addr_width:%08x, read_dumy:%08x, read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy, nor->read_opcode);
> +
>                 addr = smpt[i + 1];
> 
>                 err = spi_nor_read_raw(nor, addr, 1, &data_byte);

And add a trace here to print data_byte and addr.

Thanks,

Boris

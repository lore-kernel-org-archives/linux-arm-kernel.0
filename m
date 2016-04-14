From: yunhui.cui@nxp.com (Yunhui Cui)
Date: Thu, 14 Apr 2016 03:45:33 +0000
Subject: [PATCH v3 4/4] mtd: spi-nor: Disable Micron flash HW protection
In-Reply-To: <A765B125120D1346A63912DDE6D8B6310BF6B498@NTXXIAMBX02.xacn.micron.com>
References: <A765B125120D1346A63912DDE6D8B6310BF699D2@NTXXIAMBX02.xacn.micron.com>
 <DB5PR0401MB1912D5517CD6394B7EEE136A948C0@DB5PR0401MB1912.eurprd04.prod.outlook.com>
 <A765B125120D1346A63912DDE6D8B6310BF6B498@NTXXIAMBX02.xacn.micron.com>
Message-ID: <DB5PR0401MB1912374AA10D354B6D28837A94970@DB5PR0401MB1912.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I will send another patch set to replace this patch set. This patch set need not be reviewed more, Many thanks! 

Thanks
Yunhui

-----Original Message-----
From: Bean Huo ??? (beanhuo) [mailto:beanhuo at micron.com] 
Sent: Monday, March 21, 2016 10:56 AM
To: Yunhui Cui; Yunhui Cui
Cc: linux-mtd at lists.infradead.org; dwmw2 at infradead.org; computersforpeace at gmail.com; han.xu at freescale.com; linux-kernel at vger.kernel.org; linux-mtd at lists.infradead.org; linux-arm-kernel at lists.infradead.org; Yao Yuan
Subject: RE: [PATCH v3 4/4] mtd: spi-nor: Disable Micron flash HW protection

Hi, Yunhai
You mean that EVCR.bit7 cannot clear(enable quad mode) if not write SR.bit7 to 0?
They don't have any connection each other.

> -----Original Message-----
> From: Yunhui Cui [mailto:yunhui.cui at nxp.com]
> Sent: Friday, March 18, 2016 6:09 PM
> To: Bean Huo ??? (beanhuo); Yunhui Cui
> Cc: linux-mtd at lists.infradead.org; dwmw2 at infradead.org; 
> computersforpeace at gmail.com; han.xu at freescale.com; 
> linux-kernel at vger.kernel.org; linux-mtd at lists.infradead.org; 
> linux-arm-kernel at lists.infradead.org; Yao Yuan
> Subject: RE: [PATCH v3 4/4] mtd: spi-nor: Disable Micron flash HW 
> protection
> 
> Hi Bean,
> 
> Thanks for your suggestions very much.
> Yes, the flash N25Q128A status register write enable/disable bit is 
> disable in initial state.
> But, This patch aims to clear status registerV bit[7](write 
> enable/disable bit) to 0, which enables the bit.
> Frankly speaking, I also don't want to add this patch.
> The reason for this is that clear status register bit[7] to 0 is a 
> must to set quad mode to Enhanced Volatile Configuration Register 
> using command SPINOR_OP_WD_EVCR. Otherwise it will output "Micron EVCR 
> Quad bit not clear" in spi-nor.c I looked up the datasheet, but I 
> really don't find out any connection between status register 
> bit[7](write enable/disable bit) equals 0 and seting quad mode to Enhanced Volatile Configuration Register.
> 
> Just as I want to send the issue to Micron team , could you give me 
> some solutions ?
> 
> 
> Thanks
> Yunhui
> 
> -----Original Message-----
> From: Bean Huo ??? (beanhuo) [mailto:beanhuo at micron.com]
> Sent: Thursday, March 03, 2016 9:39 PM
> To: Yunhui Cui
> Cc: linux-mtd at lists.infradead.org; dwmw2 at infradead.org; 
> computersforpeace at gmail.com; han.xu at freescale.com; 
> linux-kernel at vger.kernel.org; linux-mtd at lists.infradead.org; 
> linux-arm-kernel at lists.infradead.org; Yao Yuan; Yunhui Cui
> Subject: Re: [PATCH v3 4/4] mtd: spi-nor: Disable Micron flash HW 
> protection
> 
> > From: Yunhui Cui <B56489@freescale.com>
> > To: <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
> > 	<han.xu@freescale.com>
> > Cc: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
> > 	<linux-arm-kernel@lists.infradead.org>, <yao.yuan@nxp.com>, Yunhui 
> > Cui
> > 	<yunhui.cui@nxp.com>
> > Subject: [PATCH v3 4/4] mtd: spi-nor: Disable Micron flash HW
> > 	protection
> > Message-ID:
> <1456988044-37061-4-git-send-email-B56489@freescale.com>
> > Content-Type: text/plain
> >
> > From: Yunhui Cui <yunhui.cui@nxp.com>
> >
> > For Micron family ,The status register write enable/disable bit, 
> > provides hardware data protection for the device.
> > When the enable/disable bit is set to 1, the status register 
> > nonvolatile bits become read-only and the WRITE STATUS REGISTER 
> > operation will not execute.
> >
> > Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c 
> > b/drivers/mtd/spi-nor/spi-nor.c index ed0c19c..917f814 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -39,6 +39,7 @@
> >
> >  #define SPI_NOR_MAX_ID_LEN	6
> >  #define SPI_NOR_MAX_ADDR_WIDTH	4
> > +#define SPI_NOR_MICRON_WRITE_ENABLE	0x7f
> >
> >  struct flash_info {
> >  	char		*name;
> > @@ -1238,6 +1239,14 @@ int spi_nor_scan(struct spi_nor *nor, const 
> > char *name, enum read_mode mode)
> >  		write_sr(nor, 0);
> >  	}
> >
> > +	if (JEDEC_MFR(info) == SNOR_MFR_MICRON) {
> > +		ret = read_sr(nor);
> > +		ret &= SPI_NOR_MICRON_WRITE_ENABLE;
> > +
> For Micron the status register write enable/disable bit, its 
> default/factory value is disable.
> Can here first check ,then program?
> > +		write_enable(nor);
> > +		write_sr(nor, ret);
> > +	}
> > +
> >  	if (!mtd->name)
> >  		mtd->name = dev_name(dev);
> >  	mtd->priv = nor;

From: jbe@pengutronix.de (Juergen Beisert)
Date: Tue, 8 Dec 2009 13:07:17 +0100
Subject: [PATCH] [NAND] S3C2410: Fix NFC clock enable/disable imbalance
In-Reply-To: <4B1E3815.9020901@ru.mvista.com>
References: <200912081056.40210.jbe@pengutronix.de>
	<4B1E3815.9020901@ru.mvista.com>
Message-ID: <200912081307.17955.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dienstag, 8. Dezember 2009, Sergei Shtylyov wrote:
> Hello.
>
> Juergen Beisert wrote:
> > When unmounting an mtd filesystem the s3c2410_nand_select_chip() function
> > gets called again with "chip == -1". In this case the current code
> > disables the NFC clock at least a second time, so it does not work
> > anymore. Clock disabling should only happen if it was really enabled.
> >
> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> >
> > ---
> >  drivers/mtd/nand/s3c2410.c |    8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > Index: linux-2.6.32/drivers/mtd/nand/s3c2410.c
> > ===================================================================
> > --- linux-2.6.32.orig/drivers/mtd/nand/s3c2410.c
> > +++ linux-2.6.32/drivers/mtd/nand/s3c2410.c
> > @@ -329,12 +329,16 @@ static void s3c2410_nand_select_chip(str
> >  	struct s3c2410_nand_mtd *nmtd;
> >  	struct nand_chip *this = mtd->priv;
> >  	unsigned long cur;
> > +	int clock_enabled;
>
>    Could be *bool*...

I'm not sure. When this function is called more than once to disable a NAND 
device chip select, who knows if it might be called more than once to enable 
it? Just an idea.

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |

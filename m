From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 3 Sep 2012 10:55:17 +0200
Subject: mxc_nand.c on mach-imx/imx53
In-Reply-To: <504098A1.4050208@antcom.de>
References: <5035F84E.3000901@antcom.de>
 <20120829074122.GV26594@pengutronix.de>
 <503E3331.8050203@antcom.de> <20120829172820.43bbe68e@eb-e6520>
 <50407E44.5080408@antcom.de> <504098A1.4050208@antcom.de>
Message-ID: <20120903085517.GE26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 12:57:37PM +0200, Roland Stigge wrote:
> On 08/31/2012 11:05 AM, Roland Stigge wrote:
> > I tried to port this on top of Sascha's patches for imx53, only for mxc v3 for now, as below.
> > 
> > Unfortunately, I still get:
> > 
> > ...
> > UnCorrectable RS-ECC Error
> > UnCorrectable RS-ECC Error
> > UnCorrectable RS-ECC Error
> > UnCorrectable RS-ECC Error
> > UnCorrectable RS-ECC Error

Have you written the data you are unable to read with this driver?

> > ...
> > 
> > from mxc_nand.c's mxc_nand_correct_data_v2_v3(). Maybe there's still sth. missing in the
> > error correction code?
> 
> With the below incremental fix, it works. :-)
> 
> Thanks,
> 
> Roland
> 
> PS: Will you prepare a patch for l2-mtd.git? I only have an imx53, can't test the v1/v2 etc.
> configs.
> 
> 
> --- linux-2.6.orig/drivers/mtd/nand/mxc_nand.c
> +++ linux-2.6/drivers/mtd/nand/mxc_nand.c
> @@ -1141,14 +1141,14 @@ static void mxc_nand_command(struct mtd_
>                 host->devtype_data->send_cmd(host, command, true);
>                 mxc_do_addr_cycle(mtd, column, page_addr);
>                 host->devtype_data->send_read_id(host);
> -               host->buf_start = column;
> +               host->buf_start = 0;
>                 break;
>  
>         case NAND_CMD_PARAM:
>                 host->devtype_data->send_cmd(host, command, true);
>                 mxc_do_addr_cycle(mtd, column, page_addr);
>                 host->devtype_data->send_read_param(host);
> -               host->buf_start = column;
> +               host->buf_start = 0;

On what tree are you working? I cannot find a handling of
NAND_CMD_PARAM in my tree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
